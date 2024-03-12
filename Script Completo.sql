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
    playlist_description VARCHAR(255),
    id_user INT NOT NULL,
    created_at DATETIME NOT NULL,
    private BOOL NOT NULL);
    
CREATE TABLE playlists_content (
	id INT PRIMARY KEY AUTO_INCREMENT,
    id_list INT NOT NULL,
    id_song INT NOT NULL,
    content_order INT NOT NULL);
    
CREATE TABLE media_history (
    id INT PRIMARY KEY AUTO_INCREMENT,
    id_user INT NOT NULL,
    id_song INT,
    listen_datetime DATETIME NOT NULL,
    listen_duration_sec INT NOT NULL);

CREATE TABLE notifications (
	id INT PRIMARY KEY AUTO_INCREMENT,
    id_user INT NOT NULL,
    id_template INT NOT NULL,
    notif_subject VARCHAR(255) NOT NULL,
    message VARCHAR(255) NOT NULL,
    notif_status VARCHAR(255) NOT NULL,
    sent_at DATETIME NOT NULL);
    
CREATE TABLE notification_template (
	id INT PRIMARY KEY AUTO_INCREMENT,
    notif_description VARCHAR(255) NOT NULL,
    notif_type  VARCHAR(255) NOT NULL,
    template VARCHAR(255) NOT NULL);
    
CREATE TABLE notification_preferences (
	id INT PRIMARY KEY AUTO_INCREMENT,
    id_user INT NOT NULL,
    id_channel INT NOT NULL,
    debt_enabled BOOLEAN NOT NULL,
    media_enabled BOOLEAN NOT NULL,
    events_enabled BOOLEAN NOT NULL,
    friends_enabled BOOLEAN NOT NULL,
    offers_enabled BOOLEAN NOT NULL,
    created_at DATETIME NOT NULL,
    updated_at DATETIME NOT NULL);
    
CREATE TABLE notification_channels (
	id INT PRIMARY KEY AUTO_INCREMENT,
    notif_channel VARCHAR(255) NOT NULL);

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

ALTER TABLE media_history
ADD CONSTRAINT fk_media_history_users
FOREIGN KEY (id_user) REFERENCES users (id);

ALTER TABLE media_history
ADD CONSTRAINT fk_media_history_songs
FOREIGN KEY (id_song) REFERENCES songs (id);

ALTER TABLE notifications
ADD CONSTRAINT fk_notifications_users
FOREIGN KEY (id_user) REFERENCES users (id);

ALTER TABLE notifications
ADD CONSTRAINT fk_notifications_templates
FOREIGN KEY (id_template) REFERENCES notification_template (id);

ALTER TABLE notification_preferences
ADD CONSTRAINT fk_notification_preferences_users
FOREIGN KEY (id_user) REFERENCES users (id);

ALTER TABLE notification_preferences
ADD CONSTRAINT fk_notification_preferences_channels
FOREIGN KEY (id_channel) REFERENCES notification_channels (id);

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
    ('Dante', 'Sparda', 3, '1856-06-06', 'Italia', 'demon_killer@dmc.com.it', 'PSK234CJW', '2024-01-22', '2024-01-23', 1),
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
    ('Nirvana', 2, 31958412, 'Estados Unidos'),
    ('Billie Eilish', 1, 66990026, 'Estados Unidos'),
    ('Fito Paez', 2, 4235752, 'Argentina'),
    ('Usher', 4, 45662134, 'Estados Unidos'),
	('Adele', 4, 45004213, 'Reino Unido'),
    ('Ed Sheeran', 4, 50004213, 'Reino Unido'),
    ('Taylor Swift', 1, 55007546, 'Estados Unidos'),
    ('Kanye West', 3, 35000845, 'Estados Unidos'),
    ('Beyoncé', 3, 60008464, 'Estados Unidos'),
    ('Bruno Mars', 1, 40004758, 'Estados Unidos'),
    ('Lady Gaga', 5, 35006345, 'Estados Unidos'),
    ('Justin Bieber', 1, 60007435, 'Canadá'),
    ('Coldplay', 2, 30003644, 'Reino Unido'),
    ('Drake', 3, 70000754, 'Canadá');
    
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
	('Smells Like Teen Spirit', 7, 301, '1991-09-10', 1000000000),
	('Come as You Are', 7, 219, '1991-09-24', 750000000),
	('Lithium', 7, 257, '1991-07-15', 500000000),
	('Heart-Shaped Box', 7, 267, '1993-08-30', 600000000),
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
    ('U Remind Me', 10, 215, '2001-05-21', 32000000),
    ('Hello', 1, 295, '2015-10-23', 250000000),
    ('Someone Like You', 1, 285, '2011-09-29', 350000000),
    ('Rolling in the Deep', 1, 228, '2010-11-29', 450000000),
    ('Set Fire to the Rain', 1, 242, '2011-01-04', 300000000),
    ('Shape of You', 2, 234, '2017-01-06', 500000000),
    ('Perfect', 2, 263, '2017-03-03', 400000000),
    ('Castle on the Hill', 2, 261, '2017-01-06', 350000000),
    ('Thinking Out Loud', 2, 281, '2014-06-20', 550000000),
    ('Love Story', 3, 231, '2008-09-12', 400000000),
    ('You Belong with Me', 3, 242, '2008-11-04', 300000000),
    ('Blank Space', 3, 231, '2014-08-18', 600000000),
    ('Shake It Off', 3, 219, '2014-08-18', 500000000),
    ('Stronger', 4, 195, '2007-02-19', 200000000),
    ('Gold Digger', 4, 207, '2005-07-17', 250000000),
    ('Heartless', 4, 233, '2008-11-04', 300000000),
    ('All of the Lights', 4, 300, '2010-11-22', 350000000),
    ('Halo', 5, 235, '2008-01-20', 350000000),
    ('Crazy in Love', 5, 220, '2003-05-14', 300000000),
    ('Irreplaceable', 5, 210, '2006-10-23', 400000000),
    ('Formation', 5, 263, '2016-04-23', 450000000),
    ('Locked Out of Heaven', 6, 233, '2012-10-01', 200000000),
    ('Just the Way You Are', 6, 221, '2010-07-20', 300000000),
    ('Grenade', 6, 223, '2010-09-28', 250000000),
    ('Uptown Funk', 6, 269, '2014-11-10', 600000000),
    ('Bad Romance', 7, 294, '2009-10-26', 400000000),
    ('Shallow', 7, 215, '2018-10-05', 600000000),
    ('Poker Face', 7, 223, '2008-09-26', 500000000),
    ('Born This Way', 7, 281, '2011-02-11', 550000000),
    ('Baby', 8, 214, '2010-01-18', 750000000),
    ('Sorry', 8, 200, '2015-10-22', 900000000),
    ('Love Yourself', 8, 233, '2015-11-09', 800000000),
    ('What Do You Mean?', 8, 204, '2015-08-28', 700000000),
    ('Viva la Vida', 9, 243, '2008-05-25', 150000000),
    ('Fix You', 9, 297, '2005-09-05', 180000000),
    ('Adventure of a Lifetime', 9, 273, '2015-11-06', 200000000),
    ('The Scientist', 9, 298, '2002-11-11', 100000000),
    ('In My Feelings', 10, 218, '2018-07-10', 800000000),
    ('God''s Plan', 10, 213, '2018-01-19', 900000000),
    ('Hotline Bling', 10, 267, '2015-07-31', 700000000),
    ('One Dance', 10, 174, '2016-04-05', 600000000);

INSERT INTO playlists (playlist_name, playlist_description, id_user, created_at, private)
VALUES
	('Trappers', 'Playlist para los que les gusta el trap de verdad', 1, '2024-01-01', 0),
    ('Rock&Roll', 'Rockeros, esta es su playlist', 7, '2023-01-17', 1),
    ('MisPopitos', 'Hola Toronjistas, vengan a mi playlist', 4, '2024-02-01', 0),
    ('Favoritos', 'Mis canciones favoritas', 1, '2023-05-12', 0),
    ('Chill', 'Melodías relajantes para un día tranquilo', 2, '2022-09-18', 1),
    ('Workout', 'Eleva tu energía con estos temas', 3, '2023-07-01', 0),
    ('Viajes', 'Canciones para viajar', 4, '2022-12-30', 0),
    ('Éxitos', 'Clásicos nostálgicos', 5, '2023-08-15', 1),
    ('Party Playlist', 'Para tu próxima fiesta', 6, '2022-11-20', 0),
    ('Música para Estudiar', 'Música para concentrarse', 7, '2023-03-05', 1);
    
INSERT INTO playlists_content (id_list, id_song, content_order)
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
    (3, 31, 8),
    (1, 1, 1),
    (1, 2, 2),
    (1, 3, 3),
    (1, 4, 4),
    (2, 5, 1),
    (2, 6, 2),
    (2, 7, 3),
    (2, 8, 4),
    (3, 9, 1),
    (3, 10, 2),
    (3, 11, 3),
    (3, 12, 4),
    (4, 13, 1),
    (4, 14, 2),
    (4, 15, 3),
    (4, 16, 4),
    (5, 17, 1),
    (5, 18, 2),
    (5, 19, 3),
    (5, 20, 4),
    (6, 21, 1),
    (6, 22, 2),
    (6, 23, 3),
    (6, 24, 4),
    (7, 25, 1),
    (7, 26, 2),
    (7, 27, 3),
    (7, 28, 4);
    
INSERT INTO media_history (id_user, id_song, listen_datetime, listen_duration_sec)
VALUES
	(1, 5, '2024-02-20 10:15:00', 181),
	(2, 12, '2024-02-20 11:30:00', 184),
	(3, 17, '2024-02-20 12:45:00', 199),
	(4, 22, '2024-02-20 14:00:00', 220),
	(5, 29, '2024-02-20 15:15:00', 190),
	(6, 4, '2024-02-20 16:30:00', 206),
	(7, 9, '2024-02-20 17:45:00', 207),
	(8, 14, '2024-02-20 19:00:00', 168),
	(9, 19, '2024-02-20 20:15:00', 197),
	(10, 24, '2024-02-20 21:30:00', 283),
	(1, 30, '2024-02-21 10:15:00', 186),
	(2, 3, '2024-02-21 11:30:00', 207),
	(3, 8, '2024-02-21 12:45:00', 206),
	(4, 13, '2024-02-21 14:00:00', 170),
	(5, 18, '2024-02-21 15:15:00', 175),
	(6, 23, '2024-02-21 16:30:00', 221),
	(7, 28, '2024-02-21 17:45:00', 182),
	(8, 2, '2024-02-21 19:00:00', 187),
	(9, 7, '2024-02-21 20:15:00', 192),
	(10, 12, '2024-02-21 21:30:00', 178),
	(1, 17, '2024-02-22 10:15:00', 191),
	(2, 22, '2024-02-22 11:30:00', 217),
	(3, 27, '2024-02-22 12:45:00', 260),
	(4, 4, '2024-02-22 14:00:00', 205),
	(5, 9, '2024-02-22 15:15:00', 206),
	(6, 14, '2024-02-22 16:30:00', 167),
	(7, 19, '2024-02-22 17:45:00', 198),
	(8, 24, '2024-02-22 19:00:00', 284),
	(9, 29, '2024-02-22 20:15:00', 197),
	(10, 1, '2024-02-22 21:30:00', 192),
	(1, 1, '2024-02-28 08:00:00', 194),
	(1, 5, '2024-02-28 08:30:00', 184),
	(1, 9, '2024-02-28 09:00:00', 200),
	(1, 13, '2024-02-28 09:30:00', 174),
	(1, 17, '2024-02-28 10:00:00', 199),
	(1, 21, '2024-02-28 10:30:00', 234),
	(1, 25, '2024-02-28 11:00:00', 219),
	(2, 2, '2024-02-28 08:00:00', 188),
	(2, 6, '2024-02-28 08:30:00', 196),
	(2, 10, '2024-02-28 09:00:00', 162),
	(2, 14, '2024-02-28 09:30:00', 164),
	(2, 18, '2024-02-28 10:00:00', 181),
	(2, 22, '2024-02-28 10:30:00', 220),
	(2, 26, '2024-02-28 11:00:00', 257),
	(3, 3, '2024-02-28 08:00:00', 207),
	(3, 7, '2024-02-28 08:30:00', 188),
	(3, 11, '2024-02-28 09:00:00', 192),
	(1, 5, '2023-12-12 10:15:00', 184),
	(2, 12, '2023-11-02 11:30:00', 175),
	(3, 17, '2023-10-20 12:45:00', 198),
	(4, 22, '2023-09-30 14:00:00', 213),
	(5, 29, '2023-10-08 15:15:00', 197),
	(6, 4, '2023-09-22 16:30:00', 201),
	(7, 9, '2023-11-15 17:45:00', 204),
	(8, 14, '2023-10-10 19:00:00', 162),
	(9, 19, '2023-10-05 20:15:00', 202),
	(10, 24, '2023-11-27 21:30:00', 290),
	(1, 30, '2023-10-17 10:15:00', 180),
	(2, 3, '2023-10-25 11:30:00', 205),
	(3, 8, '2023-11-12 12:45:00', 200),
	(4, 13, '2023-11-03 14:00:00', 171),
	(5, 18, '2023-11-18 15:15:00', 183),
	(6, 23, '2023-09-29 16:30:00', 218),
	(7, 28, '2023-10-24 17:45:00', 179),
	(8, 2, '2023-11-05 19:00:00', 185),
	(9, 7, '2023-11-14 20:15:00', 194),
	(10, 12, '2023-11-19 21:30:00', 175),
	(1, 17, '2023-10-21 10:15:00', 197),
	(2, 22, '2023-11-11 11:30:00', 216),
	(3, 27, '2023-10-29 12:45:00', 260),
	(4, 4, '2023-10-13 14:00:00', 207),
	(5, 9, '2023-11-22 15:15:00', 200),
	(6, 14, '2023-10-02 16:30:00', 161),
	(7, 19, '2023-09-24 17:45:00', 203),
	(8, 24, '2023-10-19 19:00:00', 280),
	(9, 29, '2023-11-06 20:15:00', 200),
	(10, 1, '2023-10-16 21:30:00', 200),
	(1, 1, '2023-11-28 08:00:00', 191),
	(1, 5, '2023-11-23 08:30:00', 183),
	(1, 9, '2023-09-28 09:00:00', 202),
	(1, 13, '2023-11-25 09:30:00', 178),
	(1, 17, '2023-11-30 10:00:00', 198),
	(1, 21, '2023-10-04 10:30:00', 230),
	(1, 25, '2023-11-14 11:00:00', 219),
	(2, 2, '2023-11-01 08:00:00', 192),
	(2, 6, '2023-12-10 08:30:00', 202),
	(2, 10, '2023-10-26 09:00:00', 170),
	(2, 14, '2023-10-15 09:30:00', 170),
	(2, 18, '2023-10-01 10:00:00', 183),
	(2, 22, '2023-10-28 10:30:00', 213),
	(2, 26, '2023-10-06 11:00:00', 257),
	(3, 3, '2023-11-09 08:00:00', 203),
	(3, 7, '2023-11-20 08:30:00', 192),
	(3, 11, '2023-11-12 09:00:00', 198);

INSERT INTO notification_template (notif_description, notif_type, template)
VALUES
    ('Recordatorio de pago', 'debt', '¡Hola {USER}! Te recordamos que tienes una deuda pendiente de ${DEBT}. Por favor, realiza el pago lo antes posible para evitar inconvenientes.'),
    ('Nuevo evento', 'event', '¡Hola {USER}! Te informamos que hay un nuevo evento próximo. No te lo pierdas.'),
    ('Recomendación amigos', 'friend', 'Hola {USER}, hemos encontrado a personas que pueden interesarte. ¿Quieres agregar nuevos amigos?'),
    ('Recomendación música', 'music', '{USER}, ¿escuchaste la nueva canción de tu artista favorito? ¡No te lo pierdas!');

INSERT INTO notifications (id_user, id_template, notif_subject, message, notif_status, sent_at)
VALUES
    (1, 1, 'Recordatorio de pago', '¡Hola Agustín! Te recordamos que tienes una deuda pendiente de $799. Por favor, realiza el pago lo antes posible para evitar inconvenientes.', 'Leído', '2023-01-01'),
    (8, 3, 'Recomendación amigos', 'Hola Leon S, hemos encontrado a personas que pueden interesarte. ¿Quieres agregar nuevos amigos?', 'Enviado', '2024-01-05'),
    (2, 4, 'Recomendación música', 'Blas Martin, ¿escuchaste la nueva canción de tu artista favorito? ¡No te lo pierdas!', 'Enviado', '2023-05-05'),
    (10, 2, 'Nuevo evento', '¡Hola Gerald! Te informamos que hay un nuevo evento próximo. No te lo pierdas.', 'Enviado', '2023-01-02 09:30:00'),
    (3, 3, 'Recomendación amigos', 'Hola Ian Ezequiel, hemos encontrado a personas que pueden interesarte. ¿Quieres agregar nuevos amigos?', 'Enviado', '2023-07-03 11:15:00'),
    (4, 4, 'Recomendación música', '¡Hola Victoria Celsa! ¿Escuchaste la nueva canción de tu artista favorito? ¡No te lo pierdas!', 'Leído', '2024-01-04 13:45:00'),
    (5, 1, 'Recordatorio de pago', '¡Hola Carolina Giselle! Te recordamos que tienes una deuda pendiente de $799. Por favor, realiza el pago lo antes posible para evitar inconvenientes.', 'Leído', '2024-01-05 15:20:00'),
    (6, 2, 'Nuevo evento', '¡Hola Tomas! Te informamos que hay un nuevo evento próximo. No te lo pierdas.', 'Leído', '2024-01-06 17:10:00'),
    (10, 3, 'Recomendación amigos', 'Hola Gerald, hemos encontrado a personas que pueden interesarte. ¿Quieres agregar nuevos amigos?', 'Recibido', '2024-01-07 19:00:00'),
    (5, 4, 'Recomendación música', '¡Hola Carolina Giselle! ¿Escuchaste la nueva canción de tu artista favorito? ¡No te lo pierdas!', 'Leído', '2024-01-08 20:45:00'),
    (9, 1, 'Nuevo evento', '¡Hola Jill! Te informamos que hay un nuevo evento próximo. No te lo pierdas.', 'Leído', '2024-01-06 17:10:00'),
    (10, 2, 'Nuevo evento', '¡Hola Gerald! Te informamos que hay un nuevo evento próximo. No te lo pierdas.', 'Enviado', '2023-01-10 08:15:00'),
    (1, 3, 'Recomendación amigos', 'Hola Agustín, hemos encontrado a personas que pueden interesarte. ¿Quieres agregar nuevos amigos?', 'Leído', '2024-01-11 10:00:00'),
    (10, 4, 'Recomendación música', '¡Hola Gerald! ¿Escuchaste la nueva canción de tu artista favorito? ¡No te lo pierdas!', 'Error', '2024-01-12 12:20:00'),
    (3, 1, 'Recordatorio de pago', '¡Hola Ian Ezequiel! Te recordamos que tienes una deuda pendiente de $329. Por favor, realiza el pago lo antes posible para evitar inconvenientes.', 'Leído', '2024-01-13 14:45:00'),
    (4, 2, 'Nuevo evento', '¡Hola Victoria Celsa! Te informamos que hay un nuevo evento próximo. No te lo pierdas.', 'Enviado', '2024-01-14 16:30:00'),
    (5, 3, 'Recomendación amigos', 'Hola Carolina Giselle, hemos encontrado a personas que pueden interesarte. ¿Quieres agregar nuevos amigos?', 'Enviado', '2024-01-15 18:15:00'),
    (6, 4, 'Recomendación música', '¡Hola Tomas! ¿Escuchaste la nueva canción de tu artista favorito? ¡No te lo pierdas!', 'Error', '2024-01-16 20:00:00'),
    (7, 1, 'Recordatorio de pago', '¡Hola Dante! Te recordamos que tienes una deuda pendiente de $599. Por favor, realiza el pago lo antes posible para evitar inconvenientes.', 'Enviado', '2024-01-01 22:30:00'),
    (5, 2, 'Nuevo evento', '¡Hola Carolina Giselle! Te informamos que hay un nuevo evento próximo. No te lo pierdas.', 'Enviado', '2024-01-18 08:45:00'),
    (9, 3, 'Recomendación amigos', 'Hola Jill, hemos encontrado a personas que pueden interesarte. ¿Quieres agregar nuevos amigos?', 'Leído', '2024-01-19 10:20:00'),
    (10, 4, 'Recomendación música', '¡Hola Gerald! ¿Escuchaste la nueva canción de tu artista favorito? ¡No te lo pierdas!', 'Leído', '2023-05-20 12:00:00');


INSERT INTO notification_channels (notif_channel)
VALUES
    ('email'),
    ('push'),
    ('email_push');

INSERT INTO notification_preferences (id_user, id_channel, debt_enabled, media_enabled, events_enabled, friends_enabled, offers_enabled, created_at, updated_at)
VALUES
    (1, 3, 1, 1, 1, 1, 1, '2022-01-01', NOW()),
    (2, 2, 1, 0, 1, 1, 1, '2022-05-12', NOW()),
    (3, 2, 1, 1, 0, 0, 0, '2022-11-27', NOW()),
    (4, 1, 1, 0, 0, 1, 1, '2023-04-08', NOW()),
    (5, 1, 1, 1, 0, 1, 1, '2022-01-01', NOW()),
    (6, 3, 1, 1, 1, 0, 1, '2024-11-22', NOW()),
    (7, 3, 1, 1, 0, 0, 1, '2023-08-18', NOW()),
    (8, 2, 1, 1, 1, 1, 0, '2023-08-18', NOW()),
    (9, 1, 1, 0, 0, 0, 1, '2023-09-11', NOW()),
    (10, 2, 1, 1, 1, 1, 1, '2022-03-04', NOW());

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
