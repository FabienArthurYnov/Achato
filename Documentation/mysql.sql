-- Création de la base de données (facultatif)
CREATE DATABASE IF NOT EXISTS achato;
USE achato;

-- Table users (utilisateurs)
CREATE TABLE users (
                       user_id INT AUTO_INCREMENT PRIMARY KEY,
                       firstname VARCHAR(80) NOT NULL,
                       lastname VARCHAR(80) NOT NULL,
                       phone INT,
                       email VARCHAR(80) NOT NULL UNIQUE,
                       password VARCHAR(80) NOT NULL,
                       role VARCHAR(80) NOT NULL DEFAULT 'user'
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

-- Table images (images des châteaux)
CREATE TABLE images (
                        image_id INT AUTO_INCREMENT PRIMARY KEY,
                        image_name VARCHAR(80) NOT NULL,
                        image_link VARCHAR(255) NOT NULL,
                        image_alt VARCHAR(80) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

-- Table chateaux (châteaux)
CREATE TABLE chateaux (
                          chateau_id INT AUTO_INCREMENT PRIMARY KEY,
                          name VARCHAR(80) NOT NULL,
                          price INT,
                          adresse VARCHAR(80),
                          size VARCHAR(80),
                          image_id INT,
                          FOREIGN KEY (image_id) REFERENCES images(image_id) ON DELETE SET NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

-- Table homes (maisons / propriétés de l'utilisateur)
CREATE TABLE homes (
                       home_id INT AUTO_INCREMENT PRIMARY KEY,
                       user_id INT NOT NULL,
                       chateau_id INT NOT NULL,
                       FOREIGN KEY (user_id) REFERENCES users(user_id) ON DELETE CASCADE,
                       FOREIGN KEY (chateau_id) REFERENCES chateaux(chateau_id) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

-- Table favorites (favoris de l'utilisateur)
CREATE TABLE favorites (
                           favorite_id INT AUTO_INCREMENT PRIMARY KEY,
                           user_id INT NOT NULL,
                           chateau_id INT NOT NULL,
                           FOREIGN KEY (user_id) REFERENCES users(user_id) ON DELETE CASCADE,
                           FOREIGN KEY (chateau_id) REFERENCES chateaux(chateau_id) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

-- Index pour performances
CREATE INDEX idx_user_id ON homes(user_id);
CREATE INDEX idx_chateau_id ON homes(chateau_id);
CREATE INDEX idx_user_fav ON favorites(user_id);
CREATE INDEX idx_chateau_fav ON favorites(chateau_id);

-- Insertion de données d'exemple

-- Utilisateurs
INSERT INTO users (firstname, lastname, phone, email, password, role) VALUES
                                                                          ('Thibaut', 'FGI', 612345678, 'thibaut@example.com', 'motdepasse123', 'admin'),
                                                                          ('Emma', 'Dupont', 698765432, 'emma@example.com', 'azerty', 'user'),
                                                                          ('Lucas', 'Martin', NULL, 'lucas@example.com', '123456', 'user'),
                                                                          ('Sophie', 'Leroy', 655443322, 'sophie@example.com', 'password', 'user'),
                                                                          ('Alex', 'Moreau', 677889900, 'alex@example.com', 'secret', 'user');

-- Images
INSERT INTO images (image_name, image_link, image_alt) VALUES
                                                           ('Chateau de Chenonceau', 'https://example.com/images/chenonceau.jpg', 'Château de Chenonceau au bord du Cher'),
                                                           ('Chateau de Chambord', 'https://example.com/images/chambord.jpg', 'Château de Chambord vu de face'),
                                                           ('Chateau de Versailles', 'https://example.com/images/versailles.jpg', 'Palais de Versailles et ses jardins'),
                                                           ('Chateau de Fontainebleau', 'https://example.com/images/fontainebleau.jpg', 'Château de Fontainebleau en forêt'),
                                                           ('Chateau de Pierrefonds', 'https://example.com/images/pierrefonds.jpg', 'Château de Pierrefonds restauré');

-- Chateaux
INSERT INTO chateaux (name, price, adresse, size, image_id) VALUES
                                                                ('Château de Chenonceau', 15, 'Chenonceaux, 37150', 'Medium', 1),
                                                                ('Château de Chambord', 16, 'Chambord, 41250', 'Large', 2),
                                                                ('Château de Versailles', 20, 'Versailles, 78000', 'Very Large', 3),
                                                                ('Château de Fontainebleau', 12, 'Fontainebleau, 77300', 'Medium', 4),
                                                                ('Château de Pierrefonds', 10, 'Pierrefonds, 60360', 'Small', 5);

-- Homes (maisons/propriétés de l'utilisateur)
INSERT INTO homes (user_id, chateau_id) VALUES
                                            (1, 1),  -- Thibaut possède Chenonceau
                                            (1, 3),  -- Thibaut possède Versailles
                                            (2, 2),  -- Emma possède Chambord
                                            (3, 4),  -- Lucas possède Fontainebleau
                                            (4, 5);  -- Sophie possède Pierrefonds

-- Favorites (favoris)
INSERT INTO favorites (user_id, chateau_id) VALUES
                                                (1, 2),  -- Thibaut a Chambord en favori
                                                (1, 4),  -- Thibaut a Fontainebleau en favori
                                                (2, 1),  -- Emma a Chenonceau en favori
                                                (3, 5),  -- Lucas a Pierrefonds en favori
                                                (5, 3);  -- Alex a Versailles en favori