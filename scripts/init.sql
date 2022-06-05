DROP DATABASE IF EXISTS smart_parking;
CREATE DATABASE smart_parking;

USE smart_parking;

DROP TABLE IF EXISTS places;
CREATE TABLE places ( id INT PRIMARY KEY AUTO_INCREMENT );

DROP TABLE IF EXISTS users;
CREATE TABLE users (
	id INT PRIMARY KEY AUTO_INCREMENT,
	cin VARCHAR(8) UNIQUE NOT NULL,
	name VARCHAR(50) NOT NULL,
	password TEXT NOT NULL,
	phoneNumber VARCHAR(12),
	role VARCHAR(10) NOT NULL DEFAULT 'user',
	created DATE DEFAULT CURRENT_TIMESTAMP()
);

DROP TABLE IF EXISTS reservations;
CREATE TABLE reservations (
	id INT PRIMARY KEY AUTO_INCREMENT,
	userId INT REFERENCES users (id),
	placeId INT REFERENCES places (id),
	matricule VARCHAR(12) NOT NULL,
	noHours INT,
	price FLOAT GENERATED ALWAYS AS (noHours * 1),
	created DATE DEFAULT CURRENT_TIMESTAMP()
);

DELIMITER ;;
CREATE PROCEDURE insert10Places()
BEGIN
DECLARE i INT;
SET i = 0;
WHILE i < 10 DO
	INSERT INTO places () VALUES ();
	SET i = i + 1;
END WHILE;
END;
;;
DELIMITER ;

CALL insert10Places();

INSERT INTO users (cin, name, password, role)
VALUES ('admin', 'Hassen Ben Douissa', 'admin', 'admin'),
('12345678', 'Ala Baganne', 'password', 'user'),
('87654321', 'Radwan Chaeib', 'password', 'user');

INSERT INTO reservations (userId, placeId, matricule, noHours)
VALUES (2, 1, '70 TUN 732870', 10),
(2, 2, '215 TUN 1234', 5),
(3, 3, '52 TUN 6060', 4),
(3, 4, '200 TUN 1420', 1),
(2, 5, '214 TUN 2526', 24);

-- verification
SELECT * FROM places;
SELECT * FROM users;
SELECT * FROM reservations;