-- GENERACIÓN DE VISTAS

CREATE VIEW v_premium_users AS
SELECT u.id AS "userId", 
	CONCAT(u.first_name, ' ', u.last_name) AS "Name", 
    u.email AS "Email",
    pm.membership AS "Membership", 
    pm.price AS "Price", 
    CASE WHEN pm.block_ads = 1 THEN 'X' ELSE NULL 
	END AS "Ad block",
    CASE WHEN pm.without_conection = 1 THEN 'X' ELSE NULL 
	END AS "Without conection",
    pm.allowed_users AS "Allowed users",
    CASE WHEN pm.parental_control = 1 THEN 'X' ELSE NULL 
	END AS "Parental control", 
    CASE WHEN pm.kids_mode = 1 THEN 'X' ELSE NULL 
	END AS "Kids mode",
    CASE WHEN pm.discount = 1 THEN 'X' ELSE NULL 
	END AS "Discount"
FROM users u
JOIN premium_users pu ON u.id = pu.id_user
JOIN premium_membership pm ON pu.id_membership = pm.id
WHERE pu.ended_at IS NULL;

CREATE VIEW v_popular_songs AS
SELECT a.artist_name AS "Artist", 
	s.song_name AS "Song", 
    s.views AS "Views"
FROM artists a
JOIN songs s ON a.id = s.id_artist
ORDER BY a.artist_name, s.views DESC;

CREATE VIEW v_public_playlists AS
SELECT p.id AS "Playlist id", 
	p.playlist_name AS "Playlist", 
    p.playlist_description AS "Description", 
    CONCAT(u.first_name, ' ', u.last_name) AS "User", 
    s.song_name AS "Song", 
    s.duration_sec AS "Duration"
FROM playlists p
JOIN users u ON p.id_user = u.id
JOIN playlists_content pc ON p.id = pc.id_list
JOIN songs s ON pc.id_song = s.id
WHERE p.private = 0;

CREATE VIEW v_artists_by_genre AS
SELECT g.genre_name AS "Genre", 
	a.artist_name AS "Artist", 
    a.monthly_listeners AS "Monthly listeners", 
    a.country AS "Country"
FROM genres g
JOIN artists a ON g.id = a.id_genre;

CREATE VIEW v_user_activity AS
SELECT u.id AS "User id", 
	CONCAT(u.first_name, ' ', u.last_name) AS "Name",
    MAX(up.updated_at) AS "Last profile update", 
    MAX(p.created_at) AS "Last playlist created"
FROM users u
LEFT JOIN user_profile up ON u.id = up.id_user
LEFT JOIN playlists p ON u.id = p.id_user
GROUP BY u.id;

CREATE VIEW v_songs_views AS
SELECT CONCAT(u.first_name, ' ', u.last_name) AS "User", 
    s.song_name AS "Song", 
    s.duration_sec AS "Duration", 
    mh.listen_datetime AS "Listened Date", 
    mh.listen_duration_sec AS "Listened Time"
FROM media_history mh
JOIN songs s ON mh.id_song = s.id
JOIN users u ON u.id = mh.id_user;


-- GENERACIÓN DE STORED PROCEDURES

DELIMITER //
CREATE PROCEDURE setup_user(
    IN p_first_name VARCHAR(255),
    IN p_last_name VARCHAR(255),
    IN p_user_name VARCHAR(255),
    IN p_gender VARCHAR(255),
    IN p_birthday DATE,
    IN p_country VARCHAR(255),
    IN p_email VARCHAR(255),
    IN p_pass VARCHAR(255))
BEGIN
	DECLARE p_id_gender INT;
	DECLARE p_id_user INT;
    
    SELECT id INTO p_id_gender 
    FROM gender
    WHERE gender_name = p_gender;

    INSERT INTO users (first_name, last_name, id_gender, birthday, country, email, pass, registered_at, updated_at, premium)
    VALUES (p_first_name, p_last_name, p_id_gender, p_birthday, p_country, p_email, p_pass, NOW(), NOW(), 0);
    
    SELECT id INTO p_id_user 
    FROM users
    WHERE email = p_email;
    
    INSERT INTO user_profile (id_user, username, updated_at)
    VALUES (p_id_user, p_user_name, NOW());
END; //

DELIMITER //
CREATE PROCEDURE set_premium_on(
    IN p_id_user INT,
    IN p_id_membership INT)
BEGIN
    INSERT INTO premium_users (id_user, id_membership, started_at)
    VALUES (p_id_user, p_id_membership, NOW());
    
    UPDATE users
    SET premium = TRUE
    WHERE id = p_id_user;
END; //

DELIMITER //
CREATE PROCEDURE set_premium_off(
	IN p_id_user INT)
BEGIN
	UPDATE premium_users
    SET ended_at = NOW()
    WHERE id_user = p_id_user
    AND ended_at IS NULL;
    
    UPDATE users
    SET premium = FALSE
    WHERE id = p_id_user;
END; //

DELIMITER //
CREATE PROCEDURE add_media_history(
    IN p_id_user INT,
    IN p_id_song INT,
    IN p_listen_duration_sec INT)
BEGIN
    DECLARE existing_row INT;

    SELECT COUNT(*) INTO existing_row
    FROM media_history
    WHERE id_song = p_id_song 
    AND id_user = p_id_user;
    
    IF existing_row = 0 THEN
        INSERT INTO media_history (id_user, id_song, listen_datetime, listen_duration_sec)
        VALUES (p_id_user, p_id_song, NOW(), p_listen_duration_sec);
    ELSE
        UPDATE media_history
        SET listen_datetime = NOW(),
			listen_duration_sec = p_listen_duration_sec
        WHERE id_song = p_id_song 
        AND id_user = p_id_user;
    END IF;
END; //

DELIMITER //
CREATE PROCEDURE send_notification (
    IN p_id_user INT, 
    IN p_id_template INT)
BEGIN
    DECLARE msg VARCHAR(255);
    DECLARE sbj VARCHAR(255);
    DECLARE usr VARCHAR(255);
    DECLARE dbt DECIMAL(10,2) DEFAULT 0;
    DECLARE exist INT;

    SELECT notif_description INTO sbj
    FROM notification_template
    WHERE id = p_id_template;

    SELECT template INTO msg
    FROM notification_template
    WHERE id = p_id_template;

    SELECT first_name INTO usr
    FROM users
    WHERE id = p_id_user;
    
    SELECT COUNT(*) INTO exist
    FROM premium_users
    WHERE id_user = p_id_user
    AND ended_at IS NULL;

	IF p_id_template = 1 AND exist = 0 THEN
		SIGNAL SQLSTATE '45000'
		SET MESSAGE_TEXT = 'El usuario no posee deudas ya que no posee una membresía activa.';
    END IF;
    
    IF p_id_template = 1 AND exist = 1 THEN
		SELECT price INTO dbt
		FROM premium_membership
		WHERE id IN (SELECT id_membership FROM premium_users WHERE id_user = p_id_user);
        
		INSERT INTO notifications (id_user, id_template, notif_subject, message, notif_status, sent_at)
		VALUES
			(p_id_user, p_id_template, sbj, REPLACE(REPLACE(msg, '{USER}', usr), '{DEBT}', dbt), 'Enviado', NOW());
	ELSE
		INSERT INTO notifications (id_user, id_template, notif_subject, message, notif_status, sent_at)
		VALUES
			(p_id_user, p_id_template, sbj, REPLACE(msg, '{USER}', usr), 'Enviado', NOW());
	END IF;
END;//

-- GENERACIÓN DE TRIGGERS

DELIMITER //
CREATE TRIGGER update_users
BEFORE UPDATE ON users
FOR EACH ROW
SET NEW.updated_at = NOW();
//

DELIMITER //
CREATE TRIGGER update_users_profile
BEFORE UPDATE ON user_profile
FOR EACH ROW
SET NEW.updated_at = NOW();
//

DELIMITER //
CREATE TRIGGER update_notification_preferences
BEFORE UPDATE ON notification_preferences
FOR EACH ROW
SET NEW.updated_at = NOW();
//

DELIMITER //
CREATE TRIGGER check_premium_user
BEFORE INSERT ON premium_users
FOR EACH ROW
BEGIN
    DECLARE exist_count INT;
    
    SELECT COUNT(*) INTO exist_count
    FROM premium_users
    WHERE id_user = NEW.id_user
    AND ended_at IS NULL;

    IF exist_count > 0 THEN
		SIGNAL SQLSTATE '45000'
		SET MESSAGE_TEXT = 'El usuario posee una membresía activa.';
    END IF;
END; //

DELIMITER //
CREATE TRIGGER check_exist_user
BEFORE INSERT ON users
FOR EACH ROW
BEGIN
    DECLARE email_count INT;

    SELECT COUNT(*) INTO email_count
    FROM users
    WHERE email = NEW.email;

    IF email_count > 0 THEN
        SIGNAL SQLSTATE '45000' 
        SET MESSAGE_TEXT = 'El usuario ya se encuentra registrado.';
    END IF;
END; //

DELIMITER //
CREATE TRIGGER up_insert_views
AFTER INSERT ON media_history
FOR EACH ROW
BEGIN
    UPDATE songs
    SET views = views + 1
    WHERE id = NEW.id_song;
END; //

DELIMITER //
CREATE TRIGGER up_update_views
AFTER UPDATE ON media_history
FOR EACH ROW
BEGIN
	UPDATE songs
    SET views = views + 1
    WHERE id = NEW.id_song;
END; //

DELIMITER //
CREATE TRIGGER check_insert_duration
BEFORE INSERT ON media_history
FOR EACH ROW
BEGIN
	DECLARE duration INT;
    
    SELECT duration_sec INTO duration
    FROM songs
    WHERE id = NEW.id_song;
    
    IF duration <= NEW.listen_duration_sec THEN
        SIGNAL SQLSTATE '45000' 
        SET MESSAGE_TEXT = 'La duración registrada es mayor a la duración de la canción en contexto.';
    END IF;
END; //

DELIMITER //
CREATE TRIGGER check_update_duration
BEFORE UPDATE ON media_history
FOR EACH ROW
BEGIN
	DECLARE duration INT;
    
    SELECT duration_sec INTO duration
    FROM songs
    WHERE id = NEW.id_song;
    
    IF duration <= NEW.listen_duration_sec THEN
        SIGNAL SQLSTATE '45000' 
        SET MESSAGE_TEXT = 'La duración registrada es mayor a la duración de la canción en contexto.';
    END IF;
END; //

-- GENERACIÓN DE FUNCIONES

DELIMITER //
CREATE FUNCTION playlist_duration(f_id_list INT) RETURNS INT
DETERMINISTIC
BEGIN
    DECLARE total_duration INT;
    
    SELECT SUM(s.duration_sec) INTO total_duration
    FROM songs s
    JOIN playlists_content pc ON s.id = pc.id_song
    WHERE pc.id_list = id_list;
    
    RETURN total_duration;
END; //

DELIMITER //
CREATE FUNCTION premium_active_days(f_id_user INT) RETURNS INT
DETERMINISTIC
BEGIN	
    DECLARE days_premium INT;

    SELECT DATEDIFF(NOW(), started_at) INTO days_premium
    FROM premium_users
    WHERE id_user = f_id_user
    AND ended_at IS NULL;
        
	IF days_premium IS NULL THEN
        SIGNAL SQLSTATE '45000' 
        SET MESSAGE_TEXT = 'El usuario ingresado no posee una suscripción activa';
    END IF;
    
    RETURN days_premium;
END; //

DELIMITER //
CREATE FUNCTION premium_inactive_days(f_id_user INT, suscripcion INT) RETURNS INT
DETERMINISTIC
BEGIN
    DECLARE days_premium INT;
    SET suscripcion = suscripcion - 1;

	SELECT DATEDIFF(ended_at, started_at) INTO days_premium
	FROM premium_users
	WHERE id_user = f_id_user
	AND ended_at IS NOT NULL
	ORDER BY ended_at DESC
	LIMIT suscripcion, 1;
    
    RETURN days_premium;
END; //

DELIMITER //
CREATE FUNCTION age(f_id_user INT) RETURNS INT
DETERMINISTIC
BEGIN
    DECLARE years INT;

	SELECT TIMESTAMPDIFF(YEAR, birthday, NOW()) INTO years
	FROM users
	WHERE id = f_id_user;
    
    RETURN years;
END; //

DELIMITER //
CREATE FUNCTION active_suscription(f_id_user INT) RETURNS VARCHAR(50)
DETERMINISTIC
BEGIN
	DECLARE f_value INT;
	DECLARE f_premium VARCHAR(50);
    
	SELECT COUNT(id) INTO f_value
    FROM premium_users
    WHERE id_user = f_id_user
    AND ended_at IS NULL;
    
    IF f_value = 1 THEN
		SET f_premium = 'Usuario Premium';
	ELSE 
		SET f_premium = 'Usuario No Premium';
	END IF;
    
	RETURN f_premium;
END; //

DELIMITER //
CREATE FUNCTION notification_count(f_id_user INT) RETURNS INT
DETERMINISTIC
BEGIN
    DECLARE count INT;
    
    SELECT COUNT(id) INTO count
    FROM notifications
    WHERE id_user = f_id_user;
    
    RETURN count;
END;//
