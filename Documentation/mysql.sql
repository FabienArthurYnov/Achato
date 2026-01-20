-- Création de la base de données
CREATE DATABASE IF NOT EXISTS achato;
USE achato;

-- Table users (utilisateurs)
CREATE TABLE users (
                       User_Id INT AUTO_INCREMENT PRIMARY KEY,
                       User_FirstName VARCHAR(80) NOT NULL,
                       User_LastName VARCHAR(80) NOT NULL,
                       User_Phone VARCHAR(80) NOT NULL,
                       User_Email VARCHAR(80) NOT NULL UNIQUE,
                       User_Password VARCHAR(80) NOT NULL,
                       User_Role VARCHAR(80) NOT NULL DEFAULT 'user'
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

-- Table images (images des châteaux)
CREATE TABLE images (
                        Image_Id INT AUTO_INCREMENT PRIMARY KEY,
                        Image_Name VARCHAR(80) NOT NULL,
                        Image_Link VARCHAR(255) NOT NULL,
                        Image_Alt VARCHAR(80) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

-- Table chateaux (châteaux)
CREATE TABLE chateaux (
                          Chateau_Id INT AUTO_INCREMENT PRIMARY KEY,
                          Chateau_Name VARCHAR(80) NOT NULL,
                          Chateau_Price INT,
                          Chateau_Adresse VARCHAR(80),
                          Chateau_Size VARCHAR(80),
                          Chateau_Rate VARCHAR(80),
                          Image_Id INT,
                          User_Id INT NOT NULL,
                          FOREIGN KEY (User_Id) REFERENCES users(User_Id) ON DELETE CASCADE,
                          FOREIGN KEY (Image_Id) REFERENCES images(Image_Id) ON DELETE SET NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

-- Table homes (maisons / propriétés de l'utilisateur)
CREATE TABLE homes (
                       Home_Id INT AUTO_INCREMENT PRIMARY KEY,
                       User_Id INT NOT NULL,
                       Chateau_Id INT NOT NULL,
                       FOREIGN KEY (User_Id) REFERENCES users(User_Id) ON DELETE CASCADE,
                       FOREIGN KEY (Chateau_Id) REFERENCES chateaux(Chateau_Id) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

-- Table favorites (favoris de l'utilisateur)
CREATE TABLE favorites (
                           Favorite_Id INT AUTO_INCREMENT PRIMARY KEY,
                           User_Id INT NOT NULL,
                           Chateau_Id INT NOT NULL,
                           FOREIGN KEY (User_Id) REFERENCES users(User_Id) ON DELETE CASCADE,
                           FOREIGN KEY (Chateau_Id) REFERENCES chateaux(Chateau_Id) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

-- Index pour performances
CREATE INDEX idx_user_id ON homes(User_Id);
CREATE INDEX idx_chateau_id ON homes(Chateau_Id);
CREATE INDEX idx_user_fav ON favorites(User_Id);
CREATE INDEX idx_chateau_fav ON favorites(Chateau_Id);

-- Insertion de données d'exemple

-- Utilisateurs
INSERT INTO users (User_FirstName, User_LastName, User_Phone, User_Email, User_Password, User_Role) VALUES
                                                                                                        ('Thibaut', 'FGI', '0612345678', 'thibaut@example.com', 'motdepasse123', 'admin'),
                                                                                                        ('Emma', 'Dupont', '0698765432', 'emma@example.com', 'azerty456', 'user'),
                                                                                                        ('Lucas', 'Martin', '0655443322', 'lucas@example.com', 'qwerty789', 'user'),
                                                                                                        ('Sophie', 'Leroy', '0677889900', 'sophie@example.com', 'secret101', 'user'),
                                                                                                        ('Alex', 'Moreau', '0622334455', 'alex@example.com', 'pass2025', 'user');

-- Images
INSERT INTO images (Image_Name, Image_Link, Image_Alt) VALUES
                                                           ('Château de Chenonceau', 'https://example.com/images/chenonceau.jpg', 'Château de Chenonceau au bord du Cher'),
                                                           ('Château de Chambord', 'https://example.com/images/chambord.jpg', 'Château de Chambord vu de face'),
                                                           ('Château de Versailles', 'https://example.com/images/versailles.jpg', 'Palais de Versailles et ses jardins'),
                                                           ('Château de Fontainebleau', 'https://example.com/images/fontainebleau.jpg', 'Château de Fontainebleau en forêt'),
                                                           ('Château de Pierrefonds', 'https://example.com/images/pierrefonds.jpg', 'Château de Pierrefonds restauré');

-- Châteaux
INSERT INTO chateaux (Chateau_Name, Chateau_Price, Chateau_Adresse, Chateau_Size, Chateau_Rate, Image_Id, User_Id) VALUES
                                                                                                                       ('Château de Chenonceau', 15, 'Chenonceaux, 37150', 'Medium', '4.8/5', 1, 1),
                                                                                                                       ('Château de Chambord', 16, 'Chambord, 41250', 'Large', '4.9/5', 2, 2),
                                                                                                                       ('Château de Versailles', 20, 'Versailles, 78000', 'Very Large', '5.0/5', 3, 1),
                                                                                                                       ('Château de Fontainebleau', 12, 'Fontainebleau, 77300', 'Medium', '4.7/5', 4, 3),
                                                                                                                       ('Château de Pierrefonds', 10, 'Pierrefonds, 60360', 'Small', '4.6/5', 5, 4);

-- Homes (maisons / propriétés de l'utilisateur)
INSERT INTO homes (User_Id, Chateau_Id) VALUES
                                            (1, 1),  -- Thibaut possède Chenonceau
                                            (1, 3),  -- Thibaut possède Versailles
                                            (2, 2),  -- Emma possède Chambord
                                            (3, 4),  -- Lucas possède Fontainebleau
                                            (4, 5);  -- Sophie possède Pierrefonds

-- Favorites (favoris)
INSERT INTO favorites (User_Id, Chateau_Id) VALUES
                                                (1, 2),  -- Thibaut a Chambord en favori
                                                (1, 4),  -- Thibaut a Fontainebleau en favori
                                                (2, 1),  -- Emma a Chenonceau en favori
                                                (3, 5),  -- Lucas a Pierrefonds en favori
                                                (5, 3);  -- Alex a Versailles en favori