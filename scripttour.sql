-- MySQL Workbench Forward Engineering

SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0;
SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0;
SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION';

-- -----------------------------------------------------
-- Schema mydb
-- -----------------------------------------------------

-- -----------------------------------------------------
-- Schema mydb
-- -----------------------------------------------------
CREATE SCHEMA IF NOT EXISTS `mydb` DEFAULT CHARACTER SET utf8 ;
USE `mydb` ;

-- -----------------------------------------------------
-- Table `mydb`.`tour`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `mydb`.`tour` (
  `tourid` INT NOT NULL AUTO_INCREMENT,
  `tourname` VARCHAR(45) NULL,
  `destination` VARCHAR(45) NULL,
  `category` VARCHAR(45) NULL,
  `price` DECIMAL(2,2) NULL,
  PRIMARY KEY (`tourid`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `mydb`.`driver`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `mydb`.`driver` (
  `driverid` INT NOT NULL AUTO_INCREMENT,
  `firstname` VARCHAR(45) NULL,
  `lastname` VARCHAR(45) NULL,
  `dateofbirth` DATE NULL,
  `contact` VARCHAR(45) NULL,
  `email` VARCHAR(45) NULL,
  `licencenumber` VARCHAR(45) NULL,
  PRIMARY KEY (`driverid`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `mydb`.`vehicle`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `mydb`.`vehicle` (
  `licencenumber` VARCHAR(10) NOT NULL,
  `vehiclename` VARCHAR(45) NULL,
  `tour_tourid` INT NOT NULL,
  `driver_driverid` INT NOT NULL,
  PRIMARY KEY (`licencenumber`, `tour_tourid`, `driver_driverid`),
  INDEX `fk_vehicle_tour1_idx` (`tour_tourid` ASC) VISIBLE,
  INDEX `fk_vehicle_driver1_idx` (`driver_driverid` ASC) VISIBLE,
  CONSTRAINT `fk_vehicle_tour1`
    FOREIGN KEY (`tour_tourid`)
    REFERENCES `mydb`.`tour` (`tourid`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_vehicle_driver1`
    FOREIGN KEY (`driver_driverid`)
    REFERENCES `mydb`.`driver` (`driverid`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `mydb`.`country`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `mydb`.`country` (
  `countryid` INT(3) NOT NULL AUTO_INCREMENT,
  `countryName` VARCHAR(45) NULL,
  `continent` VARCHAR(45) NULL,
  PRIMARY KEY (`countryid`),
  UNIQUE INDEX `countryName_UNIQUE` (`countryName` ASC) VISIBLE)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `mydb`.`city`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `mydb`.`city` (
  `cityid` INT NOT NULL AUTO_INCREMENT,
  `cityname` VARCHAR(45) NULL,
  `country_countryid` INT(3) NOT NULL,
  PRIMARY KEY (`cityid`, `country_countryid`),
  INDEX `fk_city_country1_idx` (`country_countryid` ASC) VISIBLE,
  CONSTRAINT `fk_city_country1`
    FOREIGN KEY (`country_countryid`)
    REFERENCES `mydb`.`country` (`countryid`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `mydb`.`Hotel`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `mydb`.`Hotel` (
  `idHotel` INT NOT NULL AUTO_INCREMENT,
  `HotelName` VARCHAR(45) NULL,
  `city_cityid` INT NOT NULL,
  PRIMARY KEY (`idHotel`, `city_cityid`),
  INDEX `fk_Hotel_city1_idx` (`city_cityid` ASC) VISIBLE,
  CONSTRAINT `fk_Hotel_city1`
    FOREIGN KEY (`city_cityid`)
    REFERENCES `mydb`.`city` (`cityid`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `mydb`.`Room`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `mydb`.`Room` (
  `idRoom` INT NOT NULL AUTO_INCREMENT,
  `RoomName` VARCHAR(45) NULL,
  `Price` DECIMAL(2,2) NULL,
  `Hotel_idHotel` INT NOT NULL,
  PRIMARY KEY (`idRoom`, `Hotel_idHotel`),
  INDEX `fk_Room_Hotel1_idx` (`Hotel_idHotel` ASC) VISIBLE,
  CONSTRAINT `fk_Room_Hotel1`
    FOREIGN KEY (`Hotel_idHotel`)
    REFERENCES `mydb`.`Hotel` (`idHotel`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `mydb`.`tourist_detail`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `mydb`.`tourist_detail` (
  `touristid` INT NOT NULL AUTO_INCREMENT,
  `firstname` VARCHAR(45) NULL,
  `lastname` VARCHAR(50) NULL,
  `username` VARCHAR(50) NULL,
  `email` VARCHAR(100) NULL,
  `contact` VARCHAR(15) NULL,
  `dateofbirth` DATETIME NULL,
  `age` INT NULL,
  `country` VARCHAR(45) NULL,
  `city` VARCHAR(45) NULL,
  `password` CHAR(10) NULL,
  PRIMARY KEY (`touristid`),
  UNIQUE INDEX `username_UNIQUE` (`username` ASC) VISIBLE)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `mydb`.`flight`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `mydb`.`flight` (
  `flightid` INT NOT NULL AUTO_INCREMENT,
  `flightname` VARCHAR(45) NULL,
  `destiname` VARCHAR(45) NULL,
  `departureplace` VARCHAR(45) NULL,
  `departuretime` DATE NULL,
  `arrivaldatetime` DATE NULL,
  `price` DECIMAL(2,2) NULL,
  PRIMARY KEY (`flightid`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `mydb`.`promotions`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `mydb`.`promotions` (
  `promotionid` INT NOT NULL AUTO_INCREMENT,
  `promotioname` VARCHAR(45) NULL,
  `decription` VARCHAR(45) NULL,
  `discount` DECIMAL(2,2) NULL,
  `endDate` DATE NULL,
  PRIMARY KEY (`promotionid`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `mydb`.`booking`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `mydb`.`booking` (
  `bookingid` INT NOT NULL AUTO_INCREMENT,
  `bookingname` VARCHAR(45) NULL,
  `bookeddate` DATETIME NULL DEFAULT now(),
  `tourist_detail_touristid` INT NOT NULL,
  `Room_idRoom` INT NOT NULL,
  `tour_tourid` INT NOT NULL,
  `flight_flightid` INT NOT NULL,
  `promotions_promotionid` INT NOT NULL,
  PRIMARY KEY (`bookingid`, `tourist_detail_touristid`, `Room_idRoom`, `tour_tourid`, `flight_flightid`, `promotions_promotionid`),
  INDEX `fk_booking_tourist_detail1_idx` (`tourist_detail_touristid` ASC) VISIBLE,
  INDEX `fk_booking_Room1_idx` (`Room_idRoom` ASC) VISIBLE,
  INDEX `fk_booking_tour1_idx` (`tour_tourid` ASC) VISIBLE,
  INDEX `fk_booking_flight1_idx` (`flight_flightid` ASC) VISIBLE,
  INDEX `fk_booking_promotions1_idx` (`promotions_promotionid` ASC) VISIBLE,
  CONSTRAINT `fk_booking_tourist_detail1`
    FOREIGN KEY (`tourist_detail_touristid`)
    REFERENCES `mydb`.`tourist_detail` (`touristid`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_booking_Room1`
    FOREIGN KEY (`Room_idRoom`)
    REFERENCES `mydb`.`Room` (`idRoom`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_booking_tour1`
    FOREIGN KEY (`tour_tourid`)
    REFERENCES `mydb`.`tour` (`tourid`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_booking_flight1`
    FOREIGN KEY (`flight_flightid`)
    REFERENCES `mydb`.`flight` (`flightid`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_booking_promotions1`
    FOREIGN KEY (`promotions_promotionid`)
    REFERENCES `mydb`.`promotions` (`promotionid`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `mydb`.`invoice`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `mydb`.`invoice` (
  `invoiceid` INT NOT NULL AUTO_INCREMENT,
  `datecreated` DATETIME NULL DEFAULT now(),
  `amount_paid` DECIMAL(10,2) NULL,
  `amount_due_to_pay` DECIMAL(10,2) NULL,
  `Total_amount` DECIMAL(10,2) NULL,
  `booking_bookingid` INT NOT NULL,
  PRIMARY KEY (`invoiceid`, `booking_bookingid`),
  INDEX `fk_invoice_booking_idx` (`booking_bookingid` ASC) VISIBLE,
  CONSTRAINT `fk_invoice_booking`
    FOREIGN KEY (`booking_bookingid`)
    REFERENCES `mydb`.`booking` (`bookingid`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `mydb`.`paymentMethod`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `mydb`.`paymentMethod` (
  `paymentMethodID` INT NOT NULL AUTO_INCREMENT,
  `paymenntMethod_name` VARCHAR(45) NULL,
  PRIMARY KEY (`paymentMethodID`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `mydb`.`payment`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `mydb`.`payment` (
  `paymentid` INT NOT NULL AUTO_INCREMENT,
  `paymentdate` DATETIME NULL,
  `amount_paid` INT NULL,
  `balance` INT NULL,
  `payment_made_by` VARCHAR(45) NULL,
  `invoice_invoiceid` INT NOT NULL,
  `invoice_booking_bookingid` INT NOT NULL,
  `paymentMethod_paymentMethodID` INT NOT NULL,
  PRIMARY KEY (`paymentid`, `invoice_invoiceid`, `invoice_booking_bookingid`, `paymentMethod_paymentMethodID`),
  INDEX `fk_payment_invoice1_idx` (`invoice_invoiceid` ASC, `invoice_booking_bookingid` ASC) VISIBLE,
  INDEX `fk_payment_paymentMethod1_idx` (`paymentMethod_paymentMethodID` ASC) VISIBLE,
  CONSTRAINT `fk_payment_invoice1`
    FOREIGN KEY (`invoice_invoiceid` , `invoice_booking_bookingid`)
    REFERENCES `mydb`.`invoice` (`invoiceid` , `booking_bookingid`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_payment_paymentMethod1`
    FOREIGN KEY (`paymentMethod_paymentMethodID`)
    REFERENCES `mydb`.`paymentMethod` (`paymentMethodID`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `mydb`.`branch`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `mydb`.`branch` (
  `branchid` INT NOT NULL AUTO_INCREMENT,
  `branchname` VARCHAR(45) NULL,
  `city_cityid` INT NOT NULL,
  `city_country_countryid` INT(3) NOT NULL,
  PRIMARY KEY (`branchid`, `city_cityid`, `city_country_countryid`),
  INDEX `fk_branch_city1_idx` (`city_cityid` ASC, `city_country_countryid` ASC) VISIBLE,
  CONSTRAINT `fk_branch_city1`
    FOREIGN KEY (`city_cityid` , `city_country_countryid`)
    REFERENCES `mydb`.`city` (`cityid` , `country_countryid`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `mydb`.`office`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `mydb`.`office` (
  `officeid` INT NOT NULL AUTO_INCREMENT,
  `officeName` VARCHAR(45) NULL,
  PRIMARY KEY (`officeid`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `mydb`.`staff`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `mydb`.`staff` (
  `staffid` INT NOT NULL AUTO_INCREMENT,
  `firstname` VARCHAR(45) NULL,
  `lastname` VARCHAR(45) NULL,
  `dateofbirth` DATE NULL,
  `email` VARCHAR(100) NULL,
  `contact` VARCHAR(45) NULL,
  `age` INT(3) NULL,
  `branch_branchid` VARCHAR(20) NOT NULL,
  `branch_city_cityid` INT NOT NULL,
  `branch_city_country_countryid` INT(3) NOT NULL,
  `office_officeid` INT NOT NULL,
  PRIMARY KEY (`staffid`, `branch_branchid`, `branch_city_cityid`, `branch_city_country_countryid`, `office_officeid`),
  INDEX `fk_staff_branch1_idx` (`branch_branchid` ASC, `branch_city_cityid` ASC, `branch_city_country_countryid` ASC) VISIBLE,
  INDEX `fk_staff_office1_idx` (`office_officeid` ASC) VISIBLE,
  CONSTRAINT `fk_staff_branch1`
    FOREIGN KEY (`branch_branchid` , `branch_city_cityid` , `branch_city_country_countryid`)
    REFERENCES `mydb`.`branch` (`branchid` , `city_cityid` , `city_country_countryid`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_staff_office1`
    FOREIGN KEY (`office_officeid`)
    REFERENCES `mydb`.`office` (`officeid`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `mydb`.`tourguides`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `mydb`.`tourguides` (
  `tourguideid` INT NOT NULL AUTO_INCREMENT,
  `firstname` VARCHAR(45) NULL,
  `lastname` VARCHAR(45) NULL,
  `dateofbirth` DATE NULL,
  `email` VARCHAR(45) NULL,
  `contact` VARCHAR(45) NULL,
  `tourguidelicence` VARCHAR(45) NULL,
  `tour_tourid` INT NOT NULL,
  PRIMARY KEY (`tourguideid`, `tour_tourid`),
  INDEX `fk_tourguides_tour1_idx` (`tour_tourid` ASC) VISIBLE,
  CONSTRAINT `fk_tourguides_tour1`
    FOREIGN KEY (`tour_tourid`)
    REFERENCES `mydb`.`tour` (`tourid`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `mydb`.`login`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `mydb`.`login` (
  `username` VARCHAR(50) NOT NULL,
  `password` VARCHAR(45) NULL,
  `timestamp` DATETIME NULL DEFAULT now(),
  PRIMARY KEY (`username`))
ENGINE = InnoDB;


SET SQL_MODE=@OLD_SQL_MODE;
SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS;
SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS;
