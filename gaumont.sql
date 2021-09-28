-- Create database
CREATE DATABASE IF NOT EXISTS gaumont CHARACTER SET utf8mb4;

-- Switch to gaumont database
USE gaumont;

-- Create table theaters
CREATE TABLE theaters (
  id INT NOT NULL AUTO_INCREMENT PRIMARY KEY,
  name VARCHAR(60) NOT NULL,
  address VARCHAR(255) NOT NULL
) ENGINE=InnoDB CHARACTER SET=utf8mb4;

-- Create table rooms
CREATE TABLE rooms (
  id INT NOT NULL AUTO_INCREMENT PRIMARY KEY,
  chairs_count SMALLINT UNSIGNED NOT NULL,
  theater_id INT NOT NULL,
  FOREIGN KEY (theater_id) REFERENCES theaters(id) ON DELETE CASCADE
) ENGINE=InnoDB CHARACTER SET=utf8mb4;

-- Create table movies
CREATE TABLE movies (
  id INT NOT NULL AUTO_INCREMENT PRIMARY KEY,
  title VARCHAR(255) NOT NULL
) ENGINE=InnoDB CHARACTER SET=utf8mb4;

-- Create table shows
CREATE TABLE shows (
  id INT NOT NULL AUTO_INCREMENT PRIMARY KEY,
  scheduled_at DATETIME NOT NULL,
  movie_id INT NOT NULL,
  room_id INT NOT NULL,
  FOREIGN KEY (movie_id) REFERENCES movies(id),
  FOREIGN KEY (room_id) REFERENCES rooms(id) ON DELETE CASCADE
) ENGINE=InnoDB CHARACTER SET=utf8mb4;

-- Create table rates
CREATE TABLE rates (
  id INT NOT NULL AUTO_INCREMENT PRIMARY KEY,
  description VARCHAR(50) NOT NULL,
  price INT NOT NULL
) ENGINE=InnoDB CHARACTER SET=utf8mb4;

-- Create table users
CREATE TABLE users (
  id INT NOT NULL AUTO_INCREMENT PRIMARY KEY,
  firstname VARCHAR(50) NOT NULL,
  lastname VARCHAR(50) NOT NULL,
  birthdate DATE NOT NULL,
  gender VARCHAR(6) NOT NULL,
  address VARCHAR(255) NOT NULL,
  email VARCHAR(255) NOT NULL,
  created_at DATETIME DEFAULT CURRENT_TIMESTAMP
) ENGINE=InnoDB CHARACTER SET=utf8mb4;

-- Create table employees
CREATE TABLE employees (
  user_id INT NOT NULL PRIMARY KEY,
  badge CHAR(10) NOT NULL,
  password CHAR(60) NOT NULL,
  FOREIGN KEY (user_id) REFERENCES users(id)
) ENGINE=InnoDB CHARACTER SET=utf8mb4;

-- Create table administrators
CREATE TABLE administrators (
  employee_id INT NOT NULL PRIMARY KEY,
  FOREIGN KEY (employee_id) REFERENCES employees(user_id)
) ENGINE=InnoDB CHARACTER SET=utf8mb4;

-- Create table customers
CREATE TABLE customers (
  user_id INT NOT NULL PRIMARY KEY,
  card CHAR(10) NULL,
  FOREIGN KEY (user_id) REFERENCES users(id)
) ENGINE=InnoDB CHARACTER SET=utf8mb4;

-- Create table receipts
CREATE TABLE receipts (
  id INT NOT NULL AUTO_INCREMENT PRIMARY KEY,
  paid_from VARCHAR(50) NOT NULL,
  paid_at DATETIME DEFAULT CURRENT_TIMESTAMP,
  user_id INT NOT NULL,
  rate_id INT NOT NULL,
  show_id INT,
  FOREIGN KEY (user_id) REFERENCES users(id),
  FOREIGN KEY (rate_id) REFERENCES rates(id),
  FOREIGN KEY (show_id) REFERENCES shows(id) ON DELETE SET NULL
) ENGINE=InnoDB CHARACTER SET=utf8mb4;

-- INSERT theaters
INSERT INTO theaters
VALUES 
(NULL, 'Gaumont Alésia', '73 avenue du Général Leclerc - 75014 Paris'),
(NULL, 'Gaumont Aquaboulevard', '8 rue du Colonel Pierre Avia - 75015 Paris'),
(NULL, 'Gaumont Convention', '29 rue Alain Chartier - 75015 Paris');

-- INSERT rooms
INSERT INTO rooms
VALUES 
(NULL, 477, 1), 
(NULL, 386, 2), 
(NULL, 207, 2), 
(NULL, 252, 3);

-- INSERT movies
INSERT INTO movies
VALUES 
(NULL, 'Dune'),
(NULL, 'Boîte noire'),
(NULL, 'Stillwater');

-- INSERT shows
INSERT INTO shows
VALUES 
(NULL, '2021-10-14 19:30:00', 1, 2),
(NULL, '2021-10-17 07:00:00', 2, 1),
(NULL, '2021-10-24 17:15:00', 3, 1),
(NULL, '2021-10-22 09:00:00', 2, 1),
(NULL, '2021-10-24 14:30:00', 3, 3);

-- INSERT users
INSERT INTO users
VALUES
(NULL, 'Théodore', 'Lacharité', '1946-04-13', 'male', '23, Rue Roussy 84100 ORANGE', 'theo@example.fr', NOW()),
(NULL, 'Anastasie', 'Sauvé', '1958-12-16', 'female', '92, Place de la Gare 92700 COLOMBES', 'anastasies@example.com', NOW()),
(NULL, 'Fabien', 'Faubert', '1974-10-18', 'female', '92, Place de la Gare 92700 COLOMBES', 'fabfau@example.com', NOW()),
(NULL, 'Patricia', 'Mothé', '2002-06-29', 'female', '92, Place de la Gare 92700 COLOMBES', 'mothe.p@example.com', NOW()),
(NULL, 'Perrin', 'Busque', '1980-01-30', 'male', '45, Rue Joseph Vernet 84000 AVIGNON', 'busqueperrin@example.com', NOW()),
(NULL, 'Roslyn', 'Dostie', '1971-05-17', 'female', '68, rue Clement Marot 93380 PIERREFITTE-SUR-SEINE', 'doros@example.com', NOW()),
(NULL, 'Patrick', 'Rocher', '1986-06-18', 'male', '22, rue du Gue Jacquet 92290 CHÂTENAY-MALABRY', 'rocherpat@example.com', NOW()),
(NULL, 'Capucine', 'Corbeil', '1984-08-06', 'female', '79, rue de la Mare aux Carats 93100 MONTREUIL', 'capucor@example.com', NOW()),
(NULL, 'Gilbert', 'DeGrasse', '2000-08-24', 'male', '83, rue Jean Vilar 24100 BERGERAC', 'rocherpat@example.com', NOW()),
(NULL, 'Christian', 'Chabot', '1987-06-15', 'male', '1, avenue de Provence 26000 VALENCE', 'chabotchristian@example.com', NOW());

-- INSERT customers
INSERT INTO customers
VALUES
(1, '9493988314'),
(3, '3483234680'),
(4, '6299205086'),
(7, '1822060348'),
(8, '5829355990');

-- INSERT employees
INSERT INTO employees
VALUES
(2, '8756932145', '$2y$10$eF4VUFn.A2INu1v0.y4TF.XK9XnqaMzDWHD.KJn.BzhZdrnNYJk3S'),
(5, '9875641256', '$2y$10$dPqznmEkceN3bXLOBThDMOSuXp.nOaalpYulXbtgQI1BHLNnWCHQO'),
(6, '1234896578', '$2y$10$aCmFqKFqQ7oVmyGPC8AXQuOh0apGvA3V5HUaiPkC13t5XLr.5CVY2'),
(9, '2564789563', '$2y$10$9PuDYgl8.9npMiGs8rUSpuFotLw6E6D2nNjMO6QF0xvfS3ftaeMou'),
(10, '6541257896', '$2y$10$9.hGbxYZlWCDIs6Qylz3w.WBQOPXxl1ZdaYalFdg48fNLBhQjVLHC');

-- INSERT administrators
INSERT INTO administrators 
VALUES (5), (9), (6);

-- INSERT administrators
INSERT INTO rates 
VALUES 
(NULL, 'full', 920),
(NULL, 'regular', 760),
(NULL, 'kid', 590),
(NULL, 'discount', 290);

-- INSERT receipts
INSERT INTO receipts 
VALUES 
(NULL, 'shop', '2021-10-09 14:41:32', 1, 1, 5),
(NULL, 'web', '2021-10-10 19:32:51', 2, 2, 4),
(NULL, 'web', '2021-10-10 19:32:51', 2, 3, 4),
(NULL, 'web', '2021-10-14 16:19:21', 4, 1, 2),
(NULL, 'shop', '2021-10-15 09:27:38', 5, 2, 4);