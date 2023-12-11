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

INSERT INTO artist (id, stage_name, biography) VALUES
(1, 'StarArtist1', 'Passionate artist with a love for music and creativity. Ready to share my talent with the world.'),
(3, 'MusicMaestro', 'Dedicated to creating soul-stirring melodies that resonate with the audience. Music is my life.'),
(5, 'ColorfulPainter', 'Expressing emotions through vibrant colors and unique strokes. Every painting tells a story.'),
(7, 'DanceProdigy', 'Breaking boundaries through dance. Movement is my language, and the stage is my canvas.'),
(9, 'DigitalDreamer', 'Transforming visions into digital art. Pushing the boundaries of imagination and technology.'),
(11, 'PoetryScribe', 'Crafting words into verses that touch the heart. Poetry is the rhythm of my soul.'),
(13, 'SculptureWizard', 'Molding raw materials into sculptures that capture the essence of beauty and form.'),
(15, 'PhotographyGuru', 'Freezing moments in time through the lens. Every photo is a story waiting to be discovered.'),
(17, 'FashionFusionist', 'Creating fashion that blurs the lines between art and style. Wearable expressions of creativity.'),
(19, 'TheaterMagician', 'Weaving tales on the stage with passion and drama. Every performance is a journey into imagination.'),
(21, 'CulinaryArtist', 'Turning ingredients into culinary masterpieces. Flavor is my palette, and the kitchen is my studio.'),
(23, 'DesignMaven', "Shaping spaces with a keen eye for aesthetics. Design is not just about appearance; it's about experience."),
(25, 'FilmVisionary', 'Capturing stories on celluloid with a vision that transcends the screen. Film is my medium of expression.'),
(2, 'JazzJourneyman', 'Navigating the world of jazz with a saxophone in hand. Improvisation is the heart of my music.'),
(4, 'GraffitiGuru', 'Spraying the streets with colors and messages. Graffiti is my way of speaking to the urban canvas.'),
(6, 'FloralFantasia', 'Arranging blooms into living artworks. Each petal tells a story of nature’s beauty.'),
(8, 'DigitalDance', 'Fusing technology and dance to create mesmerizing performances. Pixels and motion in harmony.'),
(10, 'AbstractArchitect', 'Designing structures that challenge conventions. Architecture is the intersection of art and functionality.'),
(12, 'FilmScoreSorcerer', 'Crafting musical scores that elevate cinematic experiences. The magic is in the music.'),
(14, 'MuralMaestro', 'Transforming walls into canvases of inspiration. Murals that speak to the spirit of the city.'),
(16, 'RockRebel', 'Shredding guitars and breaking musical norms. Rock and roll is the anthem of my rebellion.'),
(18, 'FiberFusionist', 'Weaving threads into textile masterpieces. Fabrics that tell stories of culture and tradition.'),
(20, 'TechArtisan', 'Melding traditional craftsmanship with modern technology. Innovation meets tradition in my creations.'),
(22, 'AcousticAlchemist', 'Alchemy of sound through acoustic instruments. Creating harmony from strings and wood.'),
(24, 'StreetStyleSculptor', 'Carving sculptures from discarded urban materials. Beauty found in the unexpected.'),
(26, 'NeonNebula', 'Illuminating the night with neon art. The city lights are my palette for expression.');