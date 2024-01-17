USE uber_project;

DROP TABLE IF EXISTS reviews;-- 1
DROP TABLE IF EXISTS trips;-- 2
DROP TABLE IF EXISTS favs;-- 3
DROP TABLE IF EXISTS payments;-- 4
DROP TABLE IF EXISTS methods;-- 5
DROP TABLE IF EXISTS statuses;-- 6
DROP TABLE IF EXISTS vehicles;-- 7
DROP TABLE IF EXISTS drivers;-- 8
DROP TABLE IF EXISTS users;-- 9

CREATE TABLE users (
	id INT PRIMARY KEY AUTO_INCREMENT,
    first_name VARCHAR(255) NOT NULL,
    last_name VARCHAR(255) NOT NULL,
    email VARCHAR(255) NOT NULL,
    pass VARCHAR(255) NOT NULL,
    phone INT,
    registered_at TIMESTAMP NOT NULL,
    cash DECIMAL(10,2));
    
CREATE TABLE drivers (
	id INT PRIMARY KEY AUTO_INCREMENT,
    first_name VARCHAR(255) NOT NULL,
    last_name VARCHAR(255) NOT NULL,
    email VARCHAR(255) NOT NULL,
    pass VARCHAR(255) NOT NULL,
    phone INT,
    registered_at TIMESTAMP NOT NULL,
    avaliable BOOL);

CREATE TABLE statuses (
	id INT PRIMARY KEY AUTO_INCREMENT,
    status_name VARCHAR(255) NOT NULL);
    
CREATE TABLE methods (
	id INT PRIMARY KEY AUTO_INCREMENT,
    method VARCHAR(255) NOT NULL);

CREATE TABLE payments (
	id INT PRIMARY KEY AUTO_INCREMENT,
    amount DECIMAL(10,2),
    id_method INT,
    created_at TIMESTAMP NOT NULL,
    FOREIGN KEY (id_method) REFERENCES methods(id));
    
CREATE TABLE trips (
	id INT PRIMARY KEY AUTO_INCREMENT,
    id_user INT,
    id_driver INT,
    origin VARCHAR(255) NOT NULL,
    destination VARCHAR(255) NOT NULL,
    started_at TIMESTAMP,
    ended_at TIMESTAMP,
    id_payment INT,
    id_status INT,
    updated_at TIMESTAMP NOT NULL,
	FOREIGN KEY (id_user) REFERENCES users(id),
	FOREIGN KEY (id_driver) REFERENCES drivers(id),
    FOREIGN KEY (id_payment) REFERENCES payments(id),
    FOREIGN KEY (id_status) REFERENCES statuses(id));

CREATE TABLE vehicles (
	id INT PRIMARY KEY AUTO_INCREMENT,
    id_driver INT,
    model VARCHAR(255) NOT NULL,
    patent VARCHAR(255) NOT NULL,
    year INT NOT NULL,
    color VARCHAR(255) NOT NULL,
	FOREIGN KEY (id_driver) REFERENCES drivers(id));
    
CREATE TABLE reviews (
	id INT PRIMARY KEY AUTO_INCREMENT,
	id_user INT,
	id_trip INT,
    review INT,
    comments VARCHAR(255) NOT NULL,
    FOREIGN KEY (id_user) REFERENCES users(id),
    FOREIGN KEY (id_trip) REFERENCES trips(id));

CREATE TABLE favs (
	id INT PRIMARY KEY AUTO_INCREMENT,
	id_user INT,
    address VARCHAR(255) NOT NULL,
    alias VARCHAR(255),
    FOREIGN KEY (id_user) REFERENCES users(id));

INSERT INTO users (first_name, last_name, email, pass, phone, registered_at, cash) VALUES ('Emma', 'Smith', 'emma.smith@gmail.com', 'gLu4yOu0', 1196939120, '2023-01-05', 1234.56);
INSERT INTO drivers (first_name, last_name, email, pass, phone, registered_at, avaliable) VALUES ('Ethan', 'Smith', 'ethan.smith@gmail.com', 'dXh7dUx7', 1123030348, '2023-01-05', 0);
INSERT INTO statuses (status_name) VALUES ('Solicitado'), ('Confirmado'), ('Cancelado'), ('Rechazado'), ('En Curso'), ('Finalizado');
INSERT INTO methods (method) VALUES ('Efectivo'), ('Debito'), ('Credito'), ('Mercado Pago'), ('Apple Pay'), ('Uber Cash');
INSERT INTO payments (amount, id_method, created_at) VALUES (1234.56, 6, '2023-01-01 10:15:00');
INSERT INTO trips (id_user, id_driver, origin, destination, started_at, ended_at, id_payment, id_status, updated_at) VALUES (1, 1, '123 Main St, Springfield, IL 62704', '987 Spruce Ave, Meadowlands, NM 87101', '2023-01-01 8:30:00', '2023-01-01 10:15:00', 1, 5, '2023-01-01 10:15:00');
INSERT INTO vehicles (id_driver, model, patent, year, color) VALUES (1, 'Quantum QX200', 'HQ 420 DZ', 2033, 'Amarillo');
INSERT INTO favs (id_user, address, alias) VALUES (1, '123 Main St, Springfield, IL 62704', 'Casa');
INSERT INTO reviews (id_user, id_trip, review, comments) VALUES (1, 1, 5, 'xxxxxxxxxxxxxxxxxxxxxxxxx');
