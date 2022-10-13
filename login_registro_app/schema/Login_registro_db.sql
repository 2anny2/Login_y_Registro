-- MySQL Workbench Forward Engineering

SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0;
SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0;
SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION';

-- -----------------------------------------------------
-- Schema Login_registro
-- -----------------------------------------------------
DROP SCHEMA IF EXISTS `Login_registro` ;

-- -----------------------------------------------------
-- Schema Login_registro
-- -----------------------------------------------------
CREATE SCHEMA IF NOT EXISTS `Login_registro` DEFAULT CHARACTER SET utf8 ;
-- -----------------------------------------------------
-- Schema login_registro
-- -----------------------------------------------------
DROP SCHEMA IF EXISTS `login_registro` ;

-- -----------------------------------------------------
-- Schema login_registro
-- -----------------------------------------------------
CREATE SCHEMA IF NOT EXISTS `login_registro` DEFAULT CHARACTER SET utf8mb3 ;
USE `Login_registro` ;

-- -----------------------------------------------------
-- Table `Login_registro`.`users`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `Login_registro`.`users` (
  `id` INT NOT NULL AUTO_INCREMENT,
  `first_name` VARCHAR(45) NULL,
  `last_name` VARCHAR(45) NULL,
  `email` VARCHAR(255) NULL,
  `password` VARCHAR(255) NULL,
  `confirm_password` VARCHAR(255) NULL,
  `created_at` DATETIME NULL DEFAULT NOW(),
  `updated_at` DATETIME NULL DEFAULT NOW(),
  PRIMARY KEY (`id`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `Login_registro`.`logins`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `Login_registro`.`logins` (
  `id` INT NOT NULL AUTO_INCREMENT,
  `user_id` INT NOT NULL,
  PRIMARY KEY (`id`),
  INDEX `fk_logins_users_idx` (`user_id` ASC) VISIBLE,
  CONSTRAINT `fk_logins_users`
    FOREIGN KEY (`user_id`)
    REFERENCES `Login_registro`.`users` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;

USE `login_registro` ;

-- -----------------------------------------------------
-- Table `login_registro`.`users`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `login_registro`.`users` (
  `id` INT NOT NULL AUTO_INCREMENT,
  `first_name` VARCHAR(45) NULL DEFAULT NULL,
  `last_name` VARCHAR(45) NULL DEFAULT NULL,
  `email` VARCHAR(255) NULL DEFAULT NULL,
  `password` VARCHAR(255) NULL DEFAULT NULL,
  `confirm_password` VARCHAR(255) NULL DEFAULT NULL,
  `created_at` DATETIME NULL DEFAULT CURRENT_TIMESTAMP,
  `updated_at` DATETIME NULL DEFAULT CURRENT_TIMESTAMP,
  PRIMARY KEY (`id`))
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8mb3;


-- -----------------------------------------------------
-- Table `login_registro`.`logins`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `login_registro`.`logins` (
  `id` INT NOT NULL AUTO_INCREMENT,
  `user_id` INT NOT NULL,
  PRIMARY KEY (`id`),
  INDEX `fk_logins_users_idx` (`user_id` ASC) VISIBLE,
  CONSTRAINT `fk_logins_users`
    FOREIGN KEY (`user_id`)
    REFERENCES `login_registro`.`users` (`id`))
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8mb3;


SET SQL_MODE=@OLD_SQL_MODE;
SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS;
SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS;
