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
FOREIGN KEY (id_gender) references gender (id);

ALTER TABLE user_profile
ADD CONSTRAINT fk_users_profile_users
FOREIGN KEY (id_user) references users (id);

ALTER TABLE premium_users
ADD CONSTRAINT fk_premium_users_users
FOREIGN KEY (id_user) references users (id);

ALTER TABLE premium_users
ADD CONSTRAINT fk_premium_users_premium_membership
FOREIGN KEY (id_membership) references premium_membership (id);

ALTER TABLE artists
ADD CONSTRAINT fk_artists_genre
FOREIGN KEY (id_genre) references genres (id);

ALTER TABLE songs
ADD CONSTRAINT fk_songs_artists
FOREIGN KEY (id_artist) references artists (id);

ALTER TABLE playlists_content
ADD CONSTRAINT fk_playlists_content_playlists
FOREIGN KEY (id_list) references playlists (id);

ALTER TABLE playlists_content
ADD CONSTRAINT fk_playlists_content_songs
FOREIGN KEY (id_song) references songs (id);
