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
	('Blas Martin', 'Urbanas', 1, '2003-05-31', 'Argentina', 'supersaiyangoto@nani.com.jp', 'DJN672JDN', '2022-05-12', '2022-05-12', 1),
    ('Ian Ezequiel', 'Urbanas', 1, '1998-07-29', 'Argentina', 'elseñordelanoche@uwuonichan.com.ru', 'OLP235GEF', '2022-11-27', '2022-11-30', 1),
    ('Victoria Celsa', 'Rinaldi', 2, '1998-05-18', 'Argentina', 'lacorrecorre@tuneleada.com', 'NKS249NDF', '2023-04-08', '2023-04-08', 1),
    ('Carolina Giselle', 'Ramos Sosoniuk', 2, '1995-10-12', 'Argentina', 'lareina@gmail.com', 'KLP218CSF', '2022-01-01', '2022-01-02', 1),
    ('Tomas', 'Rencz', 1, '1999-04-12', 'Argentina', 'totornz@gmail.com', 'PCJ234BCJ', '2023-06-13', '2023-06-13', 0),
    ('Dante', 'Sparda', 3, '1856-06-06', 'Italia', 'demon_killer@dmc.com.it', 'PSK234CJW', '2024-11-22', '2024-11-23', 1),
    ('Leon S', 'Kennedy', 1, '1977-09-09', 'Estados Unidos', 'lskennedy@gmail.com', 'PLD252NCJ', '2023-08-18', '2023-08-18', 0),
	('Jill', 'Valentine', 2, '1971-02-14', 'Estados Unidos', 'jill_v@gmail.com', 'YHU276KJS', '2023-09-11', '2023-09-11', 0),
	('Gerald', 'de Rivia', 5, '1967-05-10', 'Polonia', 'elbrujodelrio@gmail.com.pl', 'WYI726CUJ', '2022-03-04', '2022-06-04', 0);

INSERT INTO user_profile (id_user, username, profile_img, updated_at)
VALUES
	(1, 'Wolfy', NULL, '2022-01-01'),
    (2, 'Blasters', NULL, '2022-05-12'),
    (3, 'O homem da noite', NULL, '2022-11-27'),
    (4, 'ToririUWU', NULL, '2023-04-08'),
    (5, 'Messirve', NULL, '2022-01-01'),
    (6, 'Tomate', NULL, '2023-06-13'),
    (7, 'Rebellion', NULL, '2024-11-22'),
    (8, 'LSK', NULL, '2023-08-18'),
    (9, 'Jilly', NULL, '2023-09-11'),
    (10, 'Witcher', NULL, '2022-03-04');

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