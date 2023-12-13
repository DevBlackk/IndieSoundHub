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

INSERT INTO copyright_information (music_id, copyright_holder_id, percentage) VALUES
(1, 2, 20.00),
(3, 4, 15.50),
(5, 6, 25.75),
(7, 8, 18.25),
(9, 10, 22.50),
(11, 12, 17.00),
(13, 14, 16.25),
(15, 16, 21.00),
(17, 18, 19.75),
(19, 20, 23.50),
(21, 22, 14.75),
(23, 24, 24.00),
(2, 4, 19.50),
(4, 6, 20.75),
(6, 8, 15.00),
(8, 10, 21.25),
(10, 12, 23.25),
(12, 14, 16.75),
(14, 16, 18.50),
(16, 18, 20.25),
(18, 20, 14.25),
(20, 22, 17.50),
(22, 24, 22.75),
(24, 26, 19.00),
(26, 2, 25.00);

INSERT INTO music (title, duration, release_date) VALUES
('Harmony of the Soul', '04:30:00', '2023-01-15'),
('Eternal Echoes', '03:45:00', '2023-01-15'),
('Rhythmic Waves', '05:12:00', '2023-02-28'),
('Melodic Journey', '03:20:00', '2023-02-28'),
('Colorful Canvas', '02:58:00', '2023-04-10'),
('Vibrant Visions', '04:45:00', '2023-04-10'),
('Dance of the Elements', '06:10:00', '2023-05-22'),
('Celestial Symphony', '04:02:00', '2023-05-22'),
('Digital Dreams', '03:30:00', '2023-07-05'),
('Techno Fusion', '05:25:00', '2023-07-05'),
('Verses of the Heart', '03:15:00', '2023-08-18'),
('Poetic Reflections', '04:50:00', '2023-08-18'),
('Sculpted Serenity', '05:55:00', '2023-10-01'),
('Mystical Masterpieces', '03:40:00', '2023-10-01'),
('Captured Moments', '04:28:00', '2023-11-12'),
('Emotional Elegance', '03:10:00', '2023-11-12'),
('Fashionable Beats', '05:03:00', '2024-01-02'),
('Runway Rhythms', '03:35:00', '2024-01-02'),
('Dramatic Dialogues', '04:45:00', '2024-02-15'),
('Theatrical Tales', '03:18:00', '2024-02-15'),
('Culinary Crescendo', '06:20:00', '2024-04-01'),
('Flavors of Music', '04:15:00', '2024-04-01'),
('Designing Harmony', '03:48:00', '2024-05-15'),
('Architectural Anthem', '05:10:00', '2024-05-15');

INSERT INTO album (title, duration, release_date) VALUES
('Harmony Journey', '00:45:00', '2022-01-15'),
('Epic Melodies', '00:38:00', '2022-04-05'),
('Urban Beats', '00:52:00', '2022-07-20'),
('City Lights Symphony', '00:42:00', '2022-10-10'),
('Abstract Canvas', '00:49:00', '2023-01-25'),
('Vivid Colors', '00:33:00', '2023-05-05'),
('Elements of Dance', '00:55:00', '2023-08-15'),
('Celestial Harmony', '00:41:00', '2023-11-01'),
('Digital Dreamscape', '00:48:00', '2024-02-14'),
('Techno Odyssey', '00:50:00', '2024-05-30'),
('Heartfelt Verses', '00:35:00', '2024-09-10'),
('Poetic Echoes', '00:47:00', '2025-01-20'),
('Sculpted Serenity', '00:58:00', '2025-05-05'),
('Mystical Moments', '00:36:00', '2025-09-20'),
('Captured Emotions', '00:44:00', '2026-01-01'),
('Elegant Expressions', '00:31:00', '2026-05-15'),
('Fashionable Beats', '00:53:00', '2026-09-30'),
('Runway Rhythms', '00:37:00', '2027-02-10'),
('Dramatic Dialogues', '00:49:00', '2027-06-25'),
('Theatrical Tales', '00:34:00', '2027-11-09'),
('Culinary Crescendo', '00:56:00', '2028-03-25'),
('Flavors of Music', '00:39:00', '2028-08-08'),
('Designing Harmony', '00:42:00', '2028-12-22'),
('Architectural Anthem', '00:51:00', '2029-05-08');

INSERT INTO streaming_history (user_id, music_id, timestamp) VALUES
(1, 2, '2023-01-15 10:30:00'),
(2, 4, '2023-02-28 14:45:00'),
(3, 6, '2023-04-10 18:20:00'),
(4, 8, '2023-05-22 22:05:00'),
(5, 10, '2023-07-05 09:40:00'),
(6, 12, '2023-08-18 13:15:00'),
(7, 14, '2023-10-01 17:50:00'),
(8, 16, '2023-11-12 21:25:00'),
(9, 18, '2024-01-02 08:00:00'),
(10, 20, '2024-02-15 12:35:00'),
(11, 22, '2024-04-01 16:10:00'),
(12, 24, '2024-05-15 19:45:00'),
(13, 2, '2024-06-30 23:20:00'),
(14, 4, '2024-08-15 03:55:00'),
(15, 6, '2024-09-30 07:30:00'),
(16, 8, '2024-11-15 11:05:00'),
(17, 10, '2025-01-01 14:40:00'),
(18, 12, '2025-02-15 18:15:00'),
(19, 14, '2025-04-01 21:50:00'),
(20, 16, '2025-05-15 01:25:00'),
(21, 18, '2025-06-30 05:00:00'),
(22, 20, '2025-08-15 08:35:00'),
(23, 22, '2025-09-30 12:10:00'),
(24, 24, '2025-11-15 15:45:00'),
(25, 26, '2026-01-01 19:20:00');

INSERT INTO streaming_service (service_name, subscribe_fee) VALUES
('MusicWave', 9.99),
('SoundSculpt', 12.99),
('GrooveHub', 8.99),
('MelodyMinds', 14.99),
('BeatBox', 10.99),
('RhythmRealm', 11.99),
('HarmonyHub', 13.99),
('AudioVista', 9.49),
('TuneTrance', 15.99),
('SonicSculpture', 10.49),
('MusicMingle', 11.49),
('RiffRide', 14.49),
('SymphonySync', 12.49),
('BeatBlend', 9.99),
('AudiophileAxis', 13.49),
('SonicSurge', 11.99),
('TuneTopia', 14.99),
('SoundSphere', 10.99),
('HarmonicHorizon', 12.99),
('AuralAura', 13.99),
('GrooveGarden', 8.49),
('AudioAlchemy', 15.49),
('RhythmRapture', 11.49),
('SonicSculptor', 14.99),
('MelodicMuse', 10.99);

