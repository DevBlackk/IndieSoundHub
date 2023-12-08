CREATE DATABASE IndieSoundHub;

USE IndieSoundHub;

-- Criação das Tabelas

CREATE TABLE user (
  id INT AUTO_INCREMENT PRIMARY KEY,
  username VARCHAR(50),
  email VARCHAR(50),
  password VARCHAR(50),
  user_type ENUM('Artist', 'Listener')
);

