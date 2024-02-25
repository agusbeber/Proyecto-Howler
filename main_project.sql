-- CREACIÓN Y SELECCIÓN DE ESQUEMA

CREATE SCHEMA howler;

USE howler;

-- CREACIÓN DE TABLAS

CREATE TABLE users (
	id INT PRIMARY KEY AUTO_INCREMENT,
    first_name VARCHAR(255) NOT NULL,
    last_name VARCHAR(255) NOT NULL,
    id_gender INT NOT NULL,
    birthday DATE NOT NULL,
    country VARCHAR(255) NOT NULL,
    email VARCHAR(255) NOT NULL,
    pass VARCHAR(255) NOT NULL,
    registered_at TIMESTAMP NOT NULL,
    updated_at TIMESTAMP NOT NULL,
    premium BOOL NOT NULL);
    
CREATE TABLE gender (
	id INT PRIMARY KEY AUTO_INCREMENT,
    gender_name VARCHAR(255) NOT NULL);

CREATE TABLE user_profile (
	id INT PRIMARY KEY AUTO_INCREMENT,
    id_user INT NOT NULL,
    username VARCHAR(255),
    profile_img VARCHAR(255),
    updated_at DATETIME NOT NULL);
    
CREATE TABLE premium_membership (
	id INT PRIMARY KEY AUTO_INCREMENT,
    membership VARCHAR(255) NOT NULL,
    price DECIMAL(10,2) NOT NULL,
    block_ads BOOL NOT NULL,
    without_conection BOOL NOT NULL,
    allowed_users INT NOT NULL,
    parental_control BOOL NOT NULL,
    kids_mode BOOL NOT NULL,
    discount BOOL NOT NULL);
    
CREATE TABLE premium_users (
	id INT PRIMARY KEY AUTO_INCREMENT,
    id_user INT NOT NULL,
    id_membership INT NOT NULL,
    started_at DATETIME NOT NULL,
    ended_at DATETIME);
    
CREATE TABLE genres (
	id INT PRIMARY KEY AUTO_INCREMENT,
    genre_name VARCHAR(255) NOT NULL);

CREATE TABLE artists (
	id INT PRIMARY KEY AUTO_INCREMENT,
    artist_name VARCHAR(255) NOT NULL,
    id_genre INT NOT NULL,
    monthly_listeners INT NOT NULL,
    country VARCHAR(255) NOT NULL);
    
CREATE TABLE songs (
	id INT PRIMARY KEY AUTO_INCREMENT,
    song_name VARCHAR(255) NOT NULL,
    id_artist INT NOT NULL,
    duration_sec INT NOT NULL,
    released_at DATE NOT NULL,
    views INT NOT NULL);
    
CREATE TABLE playlists (
	id INT PRIMARY KEY AUTO_INCREMENT,
    playlist_name VARCHAR(255) NOT NULL,
    pl_description VARCHAR(255),
    id_user INT NOT NULL,
    created_at DATETIME NOT NULL,
    private BOOL NOT NULL);
    
CREATE TABLE playlists_content (
	id INT PRIMARY KEY AUTO_INCREMENT,
    id_list INT NOT NULL,
    id_song INT NOT NULL,
    pl_order INT NOT NULL);

-- GENERACIÓN DE VINCULACIONES FK
    
ALTER TABLE users
ADD CONSTRAINT fk_users_gender
FOREIGN KEY (id_gender) REFERENCES gender (id);

ALTER TABLE user_profile
ADD CONSTRAINT fk_users_profile_users
FOREIGN KEY (id_user) REFERENCES users (id);

ALTER TABLE premium_users
ADD CONSTRAINT fk_premium_users_users
FOREIGN KEY (id_user) REFERENCES users (id);

ALTER TABLE premium_users
ADD CONSTRAINT fk_premium_users_premium_membership
FOREIGN KEY (id_membership) REFERENCES premium_membership (id);

ALTER TABLE artists
ADD CONSTRAINT fk_artists_genre
FOREIGN KEY (id_genre) REFERENCES genres (id);

ALTER TABLE songs
ADD CONSTRAINT fk_songs_artists
FOREIGN KEY (id_artist) REFERENCES artists (id);

ALTER TABLE playlists
ADD CONSTRAINT fk_playlists_users
FOREIGN KEY (id_user) REFERENCES users (id);

ALTER TABLE playlists_content
ADD CONSTRAINT fk_playlists_content_playlists
FOREIGN KEY (id_list) REFERENCES playlists (id);

ALTER TABLE playlists_content
ADD CONSTRAINT fk_playlists_content_songs
FOREIGN KEY (id_song) REFERENCES songs (id);

-- INSERCIÓN DE DATOS

INSERT INTO gender (gender_name)
VALUES 
	('Masculino'),
	('Femenino'),
	('Prefiero no aclararlo'),
	('No binario'),
	('Otro');
        
INSERT INTO users (first_name, last_name, id_gender, birthday, country, email, pass, registered_at, updated_at, premium)
VALUES 
	('Agustin', 'Beber', 1, '1998-10-30', 'Argentina', 'agustinbeber1998@gmail.com', 'NUI432NBD', '2022-01-01', '2022-01-02', 1),
	('Blas Martin', 'Urbanas', 1, '2003-05-31', 'Japon', 'supersaiyangoto@nani.com.jp', 'DJN672JDN', '2022-05-12', '2022-05-12', 1),
    ('Ian Ezequiel', 'Urbanas', 1, '1998-07-29', 'Rusia', 'elseñordelanoche@uwuonichan.com.ru', 'OLP235GEF', '2022-11-27', '2022-11-30', 1),
    ('Victoria Celsa', 'Rinaldi', 2, '1998-05-18', 'Argentina', 'lacorrecorre@tuneleada.com', 'NKS249NDF', '2023-04-08', '2023-04-08', 1),
    ('Carolina Giselle', 'Ramos Sosoniuk', 2, '1995-10-12', 'Argentina', 'lareina@gmail.com', 'KLP218CSF', '2022-01-01', '2022-01-02', 1),
    ('Tomas', 'Rencz', 1, '1999-04-12', 'Argentina', 'totornz@gmail.com', 'PCJ234BCJ', '2023-06-13', '2023-06-13', 0),
    ('Dante', 'Sparda', 3, '1856-06-06', 'Italia', 'demon_killer@dmc.com.it', 'PSK234CJW', '2024-11-22', '2024-11-23', 1),
    ('Leon S', 'Kennedy', 1, '1977-09-09', 'Estados Unidos', 'lskennedy@gmail.com', 'PLD252NCJ', '2023-08-18', '2023-08-18', 0),
	('Jill', 'Valentine', 2, '1971-02-14', 'Estados Unidos', 'jill_v@gmail.com', 'YHU276KJS', '2023-09-11', '2023-09-11', 0),
	('Gerald', 'de Rivia', 5, '1967-05-10', 'Polonia', 'elbrujodelrio@gmail.com.pl', 'WYI726CUJ', '2022-03-04', '2022-06-04', 0);

INSERT INTO user_profile (id_user, username, profile_img, updated_at)
VALUES
	(1, 'Wolfy', 'https://wallpaperaccess.com/full/2812458.jpg', '2022-01-01'),
    (2, 'Blasters', 'https://lh3.googleusercontent.com/proxy/3pCFO68LCDFFpCp0vBLVFrTU7cPVt538SUXduP5mle2rzveM7-zX0Jd2kke0BRPKodZGMVertI4U_GDgyP-k0k3uLZ29W3HpnTtd2xFinNyUQ3tIkMwqcYirOYbpNvyAHnW5btGxBWjsyfpZs2Ox', '2022-05-12'),
    (3, 'O homem da noite', 'https://i.pinimg.com/originals/95/84/d2/9584d2af48173963b7e5eaf9164a7893.jpg', '2022-11-27'),
    (4, 'ToririUWU', 'https://e1.pxfuel.com/desktop-wallpaper/763/181/desktop-wallpaper-victoria-de-angelis-r-celebritytongues2-victoria-de-angelis-thumbnail.jpg', '2023-04-08'),
    (5, 'Messirve', 'https://i.pinimg.com/736x/96/ff/cf/96ffcf5ccea9fc39275b035c0474d379.jpg', '2022-01-01'),
    (6, 'Tomate', 'https://c4.wallpaperflare.com/wallpaper/411/11/741/soccer-boca-juniors-emblem-logo-hd-wallpaper-preview.jpg', '2023-06-13'),
    (7, 'Rebellion', 'https://w0.peakpx.com/wallpaper/976/389/HD-wallpaper-devil-may-cry-devil-may-cry-5-dante-devil-may-cry.jpg', '2024-11-22'),
    (8, 'LSK', 'https://motionbgs.com/media/1205/leon-s-kennedy.jpg', '2023-08-18'),
    (9, 'Jilly', 'https://wallpapers.com/images/hd/jill-valentine-in-action-iavcmo3hhq118rlg.jpg', '2023-09-11'),
    (10, 'Witcher', 'https://wallpapercosmos.com/w/full/8/5/d/197-3840x2160-desktop-4k-the-witcher-game-background-photo.jpg', '2022-03-04');

INSERT INTO premium_membership (membership, price, block_ads, without_conection, allowed_users, parental_control, kids_mode, discount)
VALUES
	('Individual', '599', 1, 1, 1, 0, 0, 0),
    ('Duo', '799', 1, 1, 2, 0, 0, 0),
    ('Familiar', '999', 1, 1, 6, 1, 1, 0),
    ('Estudiantes', '329', 1, 1, 1, 0, 0, 1);
    
INSERT INTO premium_users (id_user, id_membership, started_at, ended_at)
VALUES
	(1, 2, '2022-01-02', NULL),
    (5, 2, '2022-01-02', NULL),
    (2, 4, '2022-05-12', NULL),
    (3, 4, '2022-11-30', NULL),
    (4, 4, '2023-04-08', NULL),
    (7, 1, '2024-11-23', NULL),
    (10, 1,'2022-03-04', '2022-04-04'),
    (10, 4, '2022-04-06', '2022-06-04');
    
INSERT INTO genres (genre_name)
VALUES
	('Pop'),
    ('Rock'),
    ('Hip Hop'),
    ('R&B'),
    ('Electrónica'),
    ('Indie'),
    ('Country'),
    ('Jazz'),
    ('Reguae'),
    ('Clásica');

INSERT INTO artists (artist_name, id_genre, monthly_listeners, country)
VALUES
	('Dua Lipa', 1, 72563321, 'Reino Unido'),
    ('YSY A', 3, 7275438, 'Argentina'),
    ('Maneskin', 2, 21171294, 'Italia'),
    ('MGK', 2, 12839652, 'Estados Unidos'),
    ('Meduza', 5, 19755048, 'Italia'),
    ('Sheryl Crow', 7, 7634196, 'Estados Unidos'),
    ('Mozart', 10, 1051448, 'Austria'),
    ('Billie Eilish', 1, 66990026, 'Estados Unidos'),
    ('Fito Paez', 2, 4235752, 'Argentina'),
    ('Usher', 4, 45662134, 'Estados Unidos');
    
INSERT INTO songs (song_name, id_artist, duration_sec, released_at, views)
VALUES
    ('Levitating', 1, 210, '2020-10-01', 10000000),
    ('Dont Start Now', 1, 203, '2019-10-31', 20000000),
    ('Break My Heart', 1, 221, '2020-03-25', 12000000),
    ('New Rules', 1, 218, '2017-07-07', 25000000),
    ('Copenhague', 2, 195, '2023-11-11', 5000000),
    ('No da mas', 2, 213, '2023-11-11', 3000000),
    ('Toda la vida', 2, 205, '2023-11-11', 3500000),
    ('Asesino', 2, 220, '2023-11-11', 6000000),
    ('Beggin', 3, 218, '2017-12-03', 8000000),
    ('I Wanna Be Your Slave', 3, 180, '2021-03-17', 12000000),
    ('Zitti e buoni', 3, 210, '2021-02-15', 10000000),
    ('Mamma mia', 3, 195, '2018-09-21', 9000000),
    ('Bloody Valentine', 4, 190, '2020-05-01', 7000000),
    ("My Ex's Best Friend", 4, 180, '2020-08-07', 6000000),
    ('Kiss Kiss', 4, 205, '2021-11-12', 7500000),
    ('Papercuts', 4, 210, '2021-07-09', 8500000),
    ('Piece Of Your Heart', 5, 210, '2019-02-01', 12000000),
    ('Lose Control', 5, 195, '2019-10-04', 10000000),
    ('Tell It To My Heart', 5, 215, '2021-04-23', 13000000),
    ('Born To Love', 5, 190, '2022-01-07', 9000000),
    ('If It Makes You Happy', 6, 245, '1996-09-03', 14000000),
    ('Soak Up The Sun', 6, 230, '2002-03-25', 16000000),
    ('Everyday Is A Winding Road', 6, 235, '1996-12-02', 17000000),
    ('Eine kleine Nachtmusik', 7, 300, '1787-08-10', 2000000),
    ('Symphony No. 40', 7, 420, '1788-07-25', 1800000),
    ('Requiem', 7, 360, '1791-01-02', 2100000),
    ('Rondo Alla Turca', 7, 280, '1784-01-26', 1900000),
    ('Bad Guy', 8, 194, '2019-03-29', 30000000),
    ('Therefore I Am', 8, 210, '2020-11-12', 25000000),
    ('Ocean Eyes', 8, 200, '2016-11-18', 28000000),
    ('My Future', 8, 205, '2020-07-30', 26000000),
    ('11 y 6', 9, 235, '1987-06-01', 4000000),
    ('El amor después del amor', 9, 245, '1992-09-08', 3500000),
    ('Mariposa Technicolor', 9, 220, '1999-03-16', 4500000),
    ('Dar es Dar', 9, 210, '2010-05-10', 5000000),
    ('Yeah!', 10, 250, '2004-01-27', 40000000),
    ('Burn', 10, 245, '2004-03-21', 35000000),
    ('Confessions Part II', 10, 230, '2004-06-01', 38000000),
    ('U Remind Me', 10, 215, '2001-05-21', 32000000);

INSERT INTO playlists (playlist_name, pl_description, id_user, created_at, private)
VALUES
	('Trappers', 'Playlist para los que les gusta el trap de verdad', 1, '2024-01-01', 0),
    ('Rock&Roll', 'Rockeros, esta es su playlist', 7, '2023-01-17', 1),
    ('MisPopitos', 'Hola Toronjistas, vengan a mi playlist', 4, '2024-02-01', 0);
    
INSERT INTO playlists_content (id_list, id_song, pl_order)
VALUES
	(1, 5, 1),
    (1, 6, 2),
    (1, 7, 3),
    (1, 8, 4),
    (1, 36, 5),
    (1, 37, 6),
    (1, 38, 7),
    (1, 39, 8),
	(2, 9, 1),
    (2, 10, 2),
    (2, 11, 3),
    (2, 12, 4),
    (2, 32, 5),
    (2, 33, 6),
    (2, 34, 7),
    (2, 35, 8),
	(3, 1, 1),
    (3, 2, 2),
    (3, 3, 3),
    (3, 4, 4),
    (3, 28, 5),
    (3, 29, 6),
    (3, 30, 7),
    (3, 31, 8);

-- GENERACIÓN DE VISTAS

CREATE VIEW v_premium_users AS
SELECT u.id AS "User id", 
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
    p.pl_description AS "Description", 
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
    
    RETURN days_premium;
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
