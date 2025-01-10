-- MySQL Workbench Forward Engineering

SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0;
SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0;
SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION';

-- -----------------------------------------------------
-- Schema mydb
-- -----------------------------------------------------
-- -----------------------------------------------------
-- Schema mini_books_schema
-- -----------------------------------------------------

-- -----------------------------------------------------
-- Schema mini_books_schema
-- -----------------------------------------------------
CREATE SCHEMA IF NOT EXISTS `mini_books_schema` ;
USE `mini_books_schema` ;

-- -----------------------------------------------------
-- Table `mini_books_schema`.`household`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `mini_books_schema`.`household` (
  `id` INT NOT NULL AUTO_INCREMENT,
  `name` VARCHAR(225) NOT NULL,
  `address` VARCHAR(225) NULL,
  PRIMARY KEY (`id`),
  UNIQUE INDEX `id_UNIQUE` (`id` ASC) VISIBLE,
  UNIQUE INDEX `name_UNIQUE` (`name` ASC) VISIBLE,
  UNIQUE INDEX `address_UNIQUE` (`address` ASC) VISIBLE)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `mini_books_schema`.`user`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `mini_books_schema`.`user` (
  `id` INT NOT NULL AUTO_INCREMENT,
  `name` VARCHAR(100) NOT NULL,
  `email` VARCHAR(100) NOT NULL,
  `password_hash` VARCHAR(225) NOT NULL,
  `household_id` INT NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE INDEX `iduser_UNIQUE` (`id` ASC) VISIBLE,
  UNIQUE INDEX `email_UNIQUE` (`email` ASC) VISIBLE,
  INDEX `fk_user_household_idx` (`household_id` ASC) VISIBLE,
  CONSTRAINT `fk_user_household`
    FOREIGN KEY (`household_id`)
    REFERENCES `mini_books_schema`.`household` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `mini_books_schema`.`report_parameter`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `mini_books_schema`.`report_parameter` (
  `id` INT NOT NULL AUTO_INCREMENT,
  `start_date` DATE NULL,
  `end_date` DATE NULL,
  `transaction_type` VARCHAR(45) NULL,
  `description` VARCHAR(100) NULL,
  `min_amount` DOUBLE NULL,
  `max_amount` DOUBLE NULL,
  PRIMARY KEY (`id`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `mini_books_schema`.`report`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `mini_books_schema`.`report` (
  `idreport` INT NOT NULL AUTO_INCREMENT,
  `private` TINYINT NOT NULL,
  `household_id` INT NOT NULL,
  `user_id` INT NOT NULL,
  `report_parameter_id` INT NOT NULL,
  PRIMARY KEY (`idreport`),
  INDEX `fk_report_household1_idx` (`household_id` ASC) VISIBLE,
  INDEX `fk_report_user1_idx` (`user_id` ASC) VISIBLE,
  INDEX `fk_report_report_parameter1_idx` (`report_parameter_id` ASC) VISIBLE,
  CONSTRAINT `fk_report_household1`
    FOREIGN KEY (`household_id`)
    REFERENCES `mini_books_schema`.`household` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_report_user1`
    FOREIGN KEY (`user_id`)
    REFERENCES `mini_books_schema`.`user` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_report_report_parameter1`
    FOREIGN KEY (`report_parameter_id`)
    REFERENCES `mini_books_schema`.`report_parameter` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `mini_books_schema`.`transaction`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `mini_books_schema`.`transaction` (
  `idtransaction` INT NOT NULL AUTO_INCREMENT,
  `name` VARCHAR(100) NOT NULL,
  `timestamp` DATETIME NOT NULL,
  `description` VARCHAR(100) NOT NULL,
  `amount` DOUBLE NOT NULL,
  `type` VARCHAR(45) NOT NULL,
  `household_id` INT NOT NULL,
  `report_id` INT NOT NULL,
  PRIMARY KEY (`idtransaction`),
  INDEX `fk_transaction_household1_idx` (`household_id` ASC) VISIBLE,
  INDEX `fk_transaction_report1_idx` (`report_id` ASC) VISIBLE,
  CONSTRAINT `fk_transaction_household1`
    FOREIGN KEY (`household_id`)
    REFERENCES `mini_books_schema`.`household` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_transaction_report1`
    FOREIGN KEY (`report_id`)
    REFERENCES `mini_books_schema`.`report` (`idreport`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


SET SQL_MODE=@OLD_SQL_MODE;
SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS;
SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS;
