CREATE DATABASE IndieSoundHub;

USE IndieSoundHub;

-- MySQL Workbench Forward Engineering

SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0;
SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0;
SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION';

-- -----------------------------------------------------
-- Schema mydb
-- -----------------------------------------------------
-- -----------------------------------------------------
-- Schema IndieSoundHub
-- -----------------------------------------------------

-- -----------------------------------------------------
-- Schema IndieSoundHub
-- -----------------------------------------------------
CREATE SCHEMA IF NOT EXISTS `IndieSoundHub` DEFAULT CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci ;
USE `IndieSoundHub` ;

-- -----------------------------------------------------
-- Table `IndieSoundHub`.`album`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `IndieSoundHub`.`album` (
  `id` INT NOT NULL AUTO_INCREMENT,
  `title` VARCHAR(50) NULL DEFAULT NULL,
  `duration` TIME NULL DEFAULT NULL,
  `release_date` DATE NULL DEFAULT NULL,
  PRIMARY KEY (`id`))
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8mb4
COLLATE = utf8mb4_0900_ai_ci;


-- -----------------------------------------------------
-- Table `IndieSoundHub`.`user`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `IndieSoundHub`.`user` (
  `id` INT NOT NULL AUTO_INCREMENT,
  `username` VARCHAR(50) NULL DEFAULT NULL,
  `email` VARCHAR(50) NULL DEFAULT NULL,
  `password` VARCHAR(50) NULL DEFAULT NULL,
  `user_type` ENUM('Artist', 'Listener') NULL DEFAULT NULL,
  PRIMARY KEY (`id`))
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8mb4
COLLATE = utf8mb4_0900_ai_ci;


-- -----------------------------------------------------
-- Table `IndieSoundHub`.`artist`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `IndieSoundHub`.`artist` (
  `id` INT NOT NULL AUTO_INCREMENT,
  `stage_name` VARCHAR(50) NULL DEFAULT NULL,
  `biography` TEXT NULL DEFAULT NULL,
  PRIMARY KEY (`id`),
  CONSTRAINT `fk_artist_3`
    FOREIGN KEY (`id`)
    REFERENCES `IndieSoundHub`.`user` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8mb4
COLLATE = utf8mb4_0900_ai_ci;


-- -----------------------------------------------------
-- Table `IndieSoundHub`.`copyright_holder`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `IndieSoundHub`.`copyright_holder` (
  `id` INT NOT NULL AUTO_INCREMENT,
  `name` VARCHAR(100) NULL DEFAULT NULL,
  `identifier` VARCHAR(50) NULL DEFAULT NULL,
  PRIMARY KEY (`id`))
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8mb4
COLLATE = utf8mb4_0900_ai_ci;


-- -----------------------------------------------------
-- Table `IndieSoundHub`.`contract`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `IndieSoundHub`.`contract` (
  `id` INT NOT NULL AUTO_INCREMENT,
  `artist_id` INT NULL DEFAULT NULL,
  `copyright_holder_id` INT NULL DEFAULT NULL,
  `start_date` DATE NULL DEFAULT NULL,
  `end_date` DATE NULL DEFAULT NULL,
  `revenue_share_percentage` DECIMAL(5,2) NULL DEFAULT NULL,
  PRIMARY KEY (`id`),
  INDEX `fk_artist_idx` (`artist_id` ASC) VISIBLE,
  INDEX `fk_copyrigth_holder_idx` (`copyright_holder_id` ASC) VISIBLE,
  CONSTRAINT `fk_artist_1`
    FOREIGN KEY (`artist_id`)
    REFERENCES `IndieSoundHub`.`artist` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_copyrigth_holder_1`
    FOREIGN KEY (`copyright_holder_id`)
    REFERENCES `IndieSoundHub`.`copyright_holder` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8mb4
COLLATE = utf8mb4_0900_ai_ci;


-- -----------------------------------------------------
-- Table `IndieSoundHub`.`music`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `IndieSoundHub`.`music` (
  `id` INT NOT NULL AUTO_INCREMENT,
  `title` VARCHAR(255) NULL DEFAULT NULL,
  `duration` TIME NULL DEFAULT NULL,
  `release_date` DATE NULL DEFAULT NULL,
  PRIMARY KEY (`id`))
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8mb4
COLLATE = utf8mb4_0900_ai_ci;


-- -----------------------------------------------------
-- Table `IndieSoundHub`.`copyright_information`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `IndieSoundHub`.`copyright_information` (
  `id` INT NOT NULL AUTO_INCREMENT,
  `music_id` INT NULL DEFAULT NULL,
  `copyright_holder_id` INT NULL DEFAULT NULL,
  `percentage` DECIMAL(5,2) NULL DEFAULT NULL,
  PRIMARY KEY (`id`),
  INDEX `fk_music_idx` (`music_id` ASC) VISIBLE,
  INDEX `fk_copyrigth_holder_idx` (`copyright_holder_id` ASC) VISIBLE,
  CONSTRAINT `fk_music_2`
    FOREIGN KEY (`music_id`)
    REFERENCES `IndieSoundHub`.`music` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_copyrigth_holder_2`
    FOREIGN KEY (`copyright_holder_id`)
    REFERENCES `IndieSoundHub`.`copyright_holder` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8mb4
COLLATE = utf8mb4_0900_ai_ci;


-- -----------------------------------------------------
-- Table `IndieSoundHub`.`streaming_service`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `IndieSoundHub`.`streaming_service` (
  `id` INT NOT NULL AUTO_INCREMENT,
  `service_name` VARCHAR(50) NULL DEFAULT NULL,
  `subscribe_fee` DECIMAL(10,2) NULL DEFAULT NULL,
  PRIMARY KEY (`id`))
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8mb4
COLLATE = utf8mb4_0900_ai_ci;


-- -----------------------------------------------------
-- Table `IndieSoundHub`.`revenue_distribution`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `IndieSoundHub`.`revenue_distribution` (
  `id` INT NOT NULL AUTO_INCREMENT,
  `music_id` INT NULL DEFAULT NULL,
  `streaming_service_id` INT NULL DEFAULT NULL,
  `revenue_share_percentage` DECIMAL(5,2) NULL DEFAULT NULL,
  PRIMARY KEY (`id`),
  INDEX `fk_music_idx` (`music_id` ASC) VISIBLE,
  INDEX `fk_streaming_service_idx` (`streaming_service_id` ASC) VISIBLE,
  CONSTRAINT `fk_music_1`
    FOREIGN KEY (`music_id`)
    REFERENCES `IndieSoundHub`.`music` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_streaming_service`
    FOREIGN KEY (`streaming_service_id`)
    REFERENCES `IndieSoundHub`.`streaming_service` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8mb4
COLLATE = utf8mb4_0900_ai_ci;


-- -----------------------------------------------------
-- Table `IndieSoundHub`.`streaming_history`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `IndieSoundHub`.`streaming_history` (
  `id` INT NOT NULL AUTO_INCREMENT,
  `user_id` INT NULL DEFAULT NULL,
  `music_id` INT NULL DEFAULT NULL,
  `timestamp` DATETIME NULL DEFAULT NULL,
  PRIMARY KEY (`id`),
  INDEX `fk_user_idx` (`user_id` ASC) VISIBLE,
  INDEX `fk_music_idx` (`music_id` ASC) VISIBLE,
  CONSTRAINT `fk_music_5`
    FOREIGN KEY (`music_id`)
    REFERENCES `IndieSoundHub`.`music` (`id`),
  CONSTRAINT `fk_user`
    FOREIGN KEY (`user_id`)
    REFERENCES `IndieSoundHub`.`user` (`id`))
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8mb4
COLLATE = utf8mb4_0900_ai_ci;


-- -----------------------------------------------------
-- Table `IndieSoundHub`.`album_music`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `IndieSoundHub`.`album_music` (
  `id` INT NOT NULL,
  `album_id` INT NULL,
  `music_id` INT NULL,
  PRIMARY KEY (`id`),
  INDEX `fk_music_idx` (`music_id` ASC) VISIBLE,
  INDEX `fk_album_idx` (`album_id` ASC) VISIBLE,
  CONSTRAINT `fk_music_3`
    FOREIGN KEY (`music_id`)
    REFERENCES `IndieSoundHub`.`music` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_album_1`
    FOREIGN KEY (`album_id`)
    REFERENCES `IndieSoundHub`.`album` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `IndieSoundHub`.`music_artist`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `IndieSoundHub`.`music_artist` (
  `id` INT NOT NULL,
  `artist_id` INT NULL,
  `music_id` INT NULL,
  PRIMARY KEY (`id`),
  INDEX `fk_artist_idx` (`artist_id` ASC) VISIBLE,
  INDEX `fk_music_idx` (`music_id` ASC) VISIBLE,
  CONSTRAINT `fk_artist_2`
    FOREIGN KEY (`artist_id`)
    REFERENCES `IndieSoundHub`.`artist` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_music_4`
    FOREIGN KEY (`music_id`)
    REFERENCES `IndieSoundHub`.`music` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


SET SQL_MODE=@OLD_SQL_MODE;
SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS;
SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS;

INSERT INTO user (username, email, password, user_type) VALUES
('Alice123', 'alice@email.com', 'password123', 'Artist'),
('Bob456', 'bob@email.com', 'pass456', 'Listener'),
('Charlie789', 'charlie@email.com', 'securepass', 'Artist'),
('David1', 'david@email.com', 'davidpass', 'Listener'),
('Eva22', 'eva@email.com', 'evapass', 'Artist'),
('Frank87', 'frank@email.com', 'frankpass', 'Listener'),
('Grace34', 'grace@email.com', 'gracepass', 'Artist'),
('Henry99', 'henry@email.com', 'henrypass', 'Listener'),
('Isabel55', 'isabel@email.com', 'isabelpass', 'Artist'),
('Jack66', 'jack@email.com', 'jackpass', 'Listener'),
('Katie11', 'katie@email.com', 'katiepass', 'Artist'),
('Leo78', 'leo@email.com', 'leopass', 'Listener'),
('Mia44', 'mia@email.com', 'miapass', 'Artist'),
('Noah77', 'noah@email.com', 'noahpass', 'Listener'),
('Olivia88', 'olivia@email.com', 'oliviapass', 'Artist'),
('Peter23', 'peter@email.com', 'peterpass', 'Listener'),
('Quinn90', 'quinn@email.com', 'quinnpass', 'Artist'),
('Ryan65', 'ryan@email.com', 'ryanpass', 'Listener'),
('Sofia12', 'sofia@email.com', 'sofiapass', 'Artist'),
('Tyler45', 'tyler@email.com', 'tylerpass', 'Listener'),
('Uma56', 'uma@email.com', 'umapass', 'Artist'),
('Vince32', 'vince@email.com', 'vincepass', 'Listener'),
('Wendy21', 'wendy@email.com', 'wendypass', 'Artist'),
('Xavier89', 'xavier@email.com', 'xavierpass', 'Listener'),
('Yara76', 'yara@email.com', 'yarapass', 'Artist');
INSERT INTO contract (artist_id, copyright_holder_id, start_date, end_date, revenue_share_percentage) VALUES
(1, 2, '2023-01-01', '2024-01-01', 15.50),
(3, 4, '2023-02-15', '2024-02-15', 20.25),
(5, 6, '2023-03-10', '2024-03-10', 18.75),
(7, 8, '2023-04-05', '2024-04-05', 12.00),
(9, 10, '2023-05-20', '2024-05-20', 22.00),
(11, 12, '2023-06-15', '2024-06-15', 17.50),
(13, 14, '2023-07-01', '2024-07-01', 16.00),
(15, 16, '2023-08-15', '2024-08-15', 14.75),
(17, 18, '2023-09-10', '2024-09-10', 21.00),
(19, 20, '2023-10-05', '2024-10-05', 19.25),
(21, 22, '2023-11-20', '2024-11-20', 13.50),
(23, 24, '2023-12-15', '2024-12-15', 23.00),
(2, 4, '2024-01-01', '2025-01-01', 16.75),
(4, 6, '2024-02-15', '2025-02-15', 19.00),
(6, 8, '2024-03-10', '2025-03-10', 14.50),
(8, 10, '2024-04-05', '2025-04-05', 18.25),
(10, 12, '2024-05-20', '2025-05-20', 20.50),
(12, 14, '2024-06-15', '2025-06-15', 15.75),
(14, 16, '2024-07-01', '2025-07-01', 17.00),
(16, 18, '2024-08-15', '2025-08-15', 19.75),
(18, 20, '2024-09-10', '2025-09-10', 14.00),
(20, 22, '2024-10-05', '2025-10-05', 16.25),
(22, 24, '2024-11-20', '2025-11-20', 21.50),
(24, 26, '2024-12-15', '2025-12-15', 18.00),
(26, 2, '2025-01-01', '2026-01-01', 22.75);

INSERT INTO copyright_holder (name, identifier) VALUES
('Global Records', 'GR-001'),
('Creative Arts Agency', 'CAA-101'),
('Visionary Publishing', 'VP-202'),
('Innovative Creations', 'IC-003'),
('Digital Harmony', 'DH-004'),
('Artistic Ventures', 'AV-005'),
('Epic Productions', 'EP-006'),
('Inspiration Media', 'IM-007'),
('Lyrical Innovations', 'LI-008'),
('Abstract Expressions', 'AE-009'),
('Muse Music Group', 'MMG-010'),
('Timeless Publishing', 'TP-011'),
('Urban Canvas Studios', 'UCS-012'),
('Imaginary Realms', 'IR-013'),
('Sculpted Sounds', 'SS-014'),
('Eclectic Editions', 'EE-015'),
('Cinematic Synthesis', 'CS-016'),
('Fashion Fusion', 'FF-017'),
('Dramatic Arts Agency', 'DAA-018'),
('Floral Fantasia', 'FFA-019'),
('Tech Artistry', 'TA-020'),
('Magnetic Melodies', 'MM-021'),
('Graffiti Galleries', 'GG-022'),
('Digital Dreamscape', 'DD-023'),
('Neon Nostalgia', 'NN-024'),
('Boundless Creativity', 'BC-025');
