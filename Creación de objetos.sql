-- GENERACIÓN DE VISTAS

CREATE VIEW v_premium_users AS
SELECT u.id AS user_id, 
	CONCAT(u.first_name, ' ', u.last_name) AS "name", 
    u.email, pm.membership, 
    pm.price, pm.block_ads, 
    pm.without_conection, 
    pm.allowed_users, 
    pm.parental_control, 
    pm.kids_mode, 
    pm.discount
FROM users u
JOIN premium_users pu ON u.id = pu.id_user
JOIN premium_membership pm ON pu.id_membership = pm.id;

CREATE VIEW v_popular_songs AS
SELECT a.artist_name, 
	s.song_name, 
    s.views
FROM artists a
JOIN songs s ON a.id = s.id_artist
ORDER BY a.artist_name, s.views DESC;

CREATE VIEW v_public_playlists AS
SELECT p.id AS playlist_id, 
	p.playlist_name, 
    p.pl_description, 
    CONCAT(u.first_name, ' ', u.last_name) AS "name", 
    s.song_name, 
    s.duration_sec
FROM playlists p
JOIN users u ON p.id_user = u.id
JOIN playlists_content pc ON p.id = pc.id_list
JOIN songs s ON pc.id_song = s.id
WHERE p.private = 0;

CREATE VIEW v_artists_by_genre AS
SELECT g.genre_name, 
	a.artist_name, 
    a.monthly_listeners, 
    a.country
FROM genres g
JOIN artists a ON g.id = a.id_genre;

CREATE VIEW v_user_activity AS
SELECT u.id AS user_id, 
	CONCAT(u.first_name, ' ', u.last_name) AS "name",
    MAX(up.updated_at) AS last_profile_update, 
    MAX(p.created_at) AS last_playlist_created
FROM users u
LEFT JOIN user_profile up ON u.id = up.id_user
LEFT JOIN playlists p ON u.id = p.id_user
GROUP BY u.id;

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
END //

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
END //

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
END //

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
END //

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
END //

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
END //

DELIMITER //
CREATE FUNCTION premium_active_days(f_id_user INT) RETURNS INT
DETERMINISTIC
BEGIN	
    DECLARE days_premium INT;

    SELECT DATEDIFF(NOW(), started_at) INTO days_premium
    FROM premium_users
    WHERE id_user = f_id_user
    AND ended_at IS NULL;
    
    RETURN days_premium;
END //

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
END //

DELIMITER //
CREATE FUNCTION age(f_id_user INT) RETURNS INT
DETERMINISTIC
BEGIN
    DECLARE years INT;

	SELECT TIMESTAMPDIFF(YEAR, birthday, NOW()) INTO years
	FROM users
	WHERE id = f_id_user;
    
    RETURN years;
END //
