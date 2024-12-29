-- MySQL Workbench Forward Engineering

SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0;
SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0;
SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION';

-- -----------------------------------------------------
-- Schema LittleLemonDM
-- -----------------------------------------------------

-- -----------------------------------------------------
-- Schema LittleLemonDM
-- -----------------------------------------------------
CREATE SCHEMA IF NOT EXISTS `LittleLemonDM` DEFAULT CHARACTER SET utf8 ;
USE `LittleLemonDM` ;

-- -----------------------------------------------------
-- Table `LittleLemonDM`.`MenuItems`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `LittleLemonDM`.`MenuItems` (
  `MenuItemsID` VARCHAR(50) NOT NULL,
  `CourseName` VARCHAR(255) NOT NULL,
  `StarterName` VARCHAR(255) NOT NULL,
  `DesertName` VARCHAR(255) NOT NULL,
  PRIMARY KEY (`MenuItemsID`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `LittleLemonDM`.`Menus`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `LittleLemonDM`.`Menus` (
  `MenuID` VARCHAR(100) NOT NULL,
  `MenuItemsID` VARCHAR(50) NOT NULL,
  `MenuName` VARCHAR(255) NOT NULL,
  `Price` DECIMAL(10,2) NOT NULL,
  PRIMARY KEY (`MenuID`),
  INDEX `MenuItemID_idx` (`MenuItemsID` ASC) VISIBLE,
  CONSTRAINT `MenuItemsID`
    FOREIGN KEY (`MenuItemsID`)
    REFERENCES `LittleLemonDM`.`MenuItems` (`MenuItemsID`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `LittleLemonDM`.`Staff`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `LittleLemonDM`.`Staff` (
  `EmployeeID` INT NOT NULL AUTO_INCREMENT,
  `Name` VARCHAR(255) NOT NULL,
  `Role` VARCHAR(100) NOT NULL,
  `Address` VARCHAR(255) NOT NULL,
  `Contact_Number` INT NOT NULL,
  `Email` VARCHAR(255) NOT NULL,
  `Annual_Salary` VARCHAR(100) NOT NULL,
  PRIMARY KEY (`EmployeeID`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `LittleLemonDM`.`Customers`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `LittleLemonDM`.`Customers` (
  `CustomerID` INT NOT NULL AUTO_INCREMENT,
  `FullName` VARCHAR(255) NOT NULL,
  `ContactNumber` INT NOT NULL,
  PRIMARY KEY (`CustomerID`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `LittleLemonDM`.`Bookings`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `LittleLemonDM`.`Bookings` (
  `BookingID` INT NOT NULL AUTO_INCREMENT,
  `TableNo` INT NOT NULL,
  `CustomerID` INT NOT NULL,
  `BookingSlot` DATETIME NOT NULL,
  `EmployeeID` INT NOT NULL,
  PRIMARY KEY (`BookingID`),
  INDEX `EmployeeID_idx` (`EmployeeID` ASC) VISIBLE,
  INDEX `CustomerID_idx` (`CustomerID` ASC) VISIBLE,
  CONSTRAINT `EmployeeID`
    FOREIGN KEY (`EmployeeID`)
    REFERENCES `LittleLemonDM`.`Staff` (`EmployeeID`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `Bookings.CustomerID`
    FOREIGN KEY (`CustomerID`)
    REFERENCES `LittleLemonDM`.`Customers` (`CustomerID`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `LittleLemonDM`.`Orders`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `LittleLemonDM`.`Orders` (
  `OrderID` INT NOT NULL AUTO_INCREMENT,
  `TableNo` INT NOT NULL,
  `CustomerID` INT NOT NULL,
  `MenuID` VARCHAR(100) NOT NULL,
  `TotalCost` DECIMAL(10,2) NOT NULL,
  `Quantity` INT NOT NULL,
  PRIMARY KEY (`OrderID`),
  INDEX `MenuID_idx` (`MenuID` ASC) VISIBLE,
  INDEX `CustomerID_idx` (`CustomerID` ASC) VISIBLE,
  CONSTRAINT `CustomerID_fk`
    FOREIGN KEY (`CustomerID`)
    REFERENCES `LittleLemonDM`.`Customers` (`CustomerID`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `MenuID`
    FOREIGN KEY (`MenuID`)
    REFERENCES `LittleLemonDM`.`Menus` (`MenuID`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `LittleLemonDM`.`DeliveryStatus`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `LittleLemonDM`.`DeliveryStatus` (
  `DeliveryID` INT NOT NULL AUTO_INCREMENT,
  `CustomerID` INT NOT NULL,
  `DeliveryStatus` VARCHAR(255) NOT NULL,
  `DeliveryDate` DATETIME NOT NULL,
  PRIMARY KEY (`DeliveryID`),
  INDEX `CustomerID_FK_idx` (`CustomerID` ASC) VISIBLE,
  CONSTRAINT `DeliveryStatus.CustomerID`
    FOREIGN KEY (`CustomerID`)
    REFERENCES `LittleLemonDM`.`Customers` (`CustomerID`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


SET SQL_MODE=@OLD_SQL_MODE;
SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS;
SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS;
