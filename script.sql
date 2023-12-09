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

