-- MySQL Workbench Forward Engineering

SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0;
SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0;
SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION';

-- -----------------------------------------------------
-- Schema Club_DB
-- -----------------------------------------------------
DROP SCHEMA IF EXISTS `Club_DB` ;

-- -----------------------------------------------------
-- Schema Club_DB
-- -----------------------------------------------------
CREATE SCHEMA IF NOT EXISTS `Club_DB` DEFAULT CHARACTER SET utf8 ;
USE `Club_DB` ;

-- -----------------------------------------------------
-- Table `Club_DB`.`Person`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `Club_DB`.`Person` ;

CREATE TABLE IF NOT EXISTS `Club_DB`.`Person` (
  `SSN` INT NOT NULL,
  `FName` VARCHAR(12) NOT NULL,
  `LName` VARCHAR(12) NOT NULL,
  `Address` VARCHAR(50) NOT NULL,
  `Phone` CHAR(11) NOT NULL,
  `BDATE` DATE NOT NULL,
  `Gender` CHAR(1) NOT NULL,
  `Email` VARCHAR(40) NOT NULL,
  PRIMARY KEY (`SSN`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `Club_DB`.`Member`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `Club_DB`.`Member` ;

CREATE TABLE IF NOT EXISTS `Club_DB`.`Member` (
  `Member_SSN` INT NOT NULL,
  `MembershipStartDate` DATE NOT NULL,
  PRIMARY KEY (`Member_SSN`),
  CONSTRAINT `fk_Member_Perosn`
    FOREIGN KEY (`Member_SSN`)
    REFERENCES `Club_DB`.`Person` (`SSN`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `Club_DB`.`Employee`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `Club_DB`.`Employee` ;

CREATE TABLE IF NOT EXISTS `Club_DB`.`Employee` (
  `Employee_SSN` INT NOT NULL,
  `Salary` FLOAT NOT NULL,
  PRIMARY KEY (`Employee_SSN`),
  CONSTRAINT `fk_Employee_Perosn1`
    FOREIGN KEY (`Employee_SSN`)
    REFERENCES `Club_DB`.`Person` (`SSN`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `Club_DB`.`Management`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `Club_DB`.`Management` ;

CREATE TABLE IF NOT EXISTS `Club_DB`.`Management` (
  `Name` VARCHAR(10) NOT NULL,
  `Manager_SSN` INT NOT NULL,
  PRIMARY KEY (`Name`),
  CONSTRAINT `fk_Management_Employee1`
    FOREIGN KEY (`Manager_SSN`)
    REFERENCES `Club_DB`.`Employee` (`Employee_SSN`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `Club_DB`.`Pro_Player`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `Club_DB`.`Pro_Player` ;

CREATE TABLE IF NOT EXISTS `Club_DB`.`Pro_Player` (
  `Player_SSN` INT NOT NULL,
  `Management_Name` VARCHAR(10) NOT NULL,
  `SportName` VARCHAR(15) NOT NULL,
  `Salary` FLOAT NOT NULL,
  `ContractStart` DATE NOT NULL,
  `ContractEnd` DATE NOT NULL,
  PRIMARY KEY (`Player_SSN`),
  CONSTRAINT `fk_Pro_Player_Member1`
    FOREIGN KEY (`Player_SSN`)
    REFERENCES `Club_DB`.`Member` (`Member_SSN`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_Pro_Player_Management1`
    FOREIGN KEY (`Management_Name`)
    REFERENCES `Club_DB`.`Management` (`Name`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `Club_DB`.`Coach`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `Club_DB`.`Coach` ;

CREATE TABLE IF NOT EXISTS `Club_DB`.`Coach` (
  `Coach_SSN` INT NOT NULL,
  `SportName` VARCHAR(15) NOT NULL,
  `Management_Name` VARCHAR(10) NOT NULL,
  `Salary` FLOAT NOT NULL,
  `ContractStart` DATE NOT NULL,
  `ContractEnd` DATE NOT NULL,
  PRIMARY KEY (`Coach_SSN`),
  CONSTRAINT `fk_Coach_person1`
    FOREIGN KEY (`Coach_SSN`)
    REFERENCES `Club_DB`.`Person` (`SSN`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_Coach_Management1`
    FOREIGN KEY (`Management_Name`)
    REFERENCES `Club_DB`.`Management` (`Name`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `Club_DB`.`Event`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `Club_DB`.`Event` ;

CREATE TABLE IF NOT EXISTS `Club_DB`.`Event` (
  `Name` VARCHAR(45) NOT NULL,
  `Date` DATE NOT NULL,
  PRIMARY KEY (`Name`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `Club_DB`.`Sponsor`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `Club_DB`.`Sponsor` ;

CREATE TABLE IF NOT EXISTS `Club_DB`.`Sponsor` (
  `Name` VARCHAR(15) NOT NULL,
  `Website` VARCHAR(20) NULL,
  `Event_Name` VARCHAR(45) NOT NULL,
  PRIMARY KEY (`Name`),
  CONSTRAINT `fk_Sponsor_Event1`
    FOREIGN KEY (`Event_Name`)
    REFERENCES `Club_DB`.`Event` (`Name`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `Club_DB`.`Catering`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `Club_DB`.`Catering` ;

CREATE TABLE IF NOT EXISTS `Club_DB`.`Catering` (
  `Name` VARCHAR(25) NOT NULL,
  `Management_Name` VARCHAR(10) NOT NULL,
  `NumOfBranches` INT NOT NULL,
  `Type` VARCHAR(10) NOT NULL,
  PRIMARY KEY (`Name`),
  CONSTRAINT `fk_Catering_Management1`
    FOREIGN KEY (`Management_Name`)
    REFERENCES `Club_DB`.`Management` (`Name`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `Club_DB`.`Catering_Location`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `Club_DB`.`Catering_Location` ;

CREATE TABLE IF NOT EXISTS `Club_DB`.`Catering_Location` (
  `Location` VARCHAR(25) NOT NULL,
  `CateringName` VARCHAR(25) NOT NULL,
  `Supervisor_ssn` INT NOT NULL,
  PRIMARY KEY (`Location`, `CateringName`),
  CONSTRAINT `ay_haga`
    FOREIGN KEY (`Supervisor_ssn`)
    REFERENCES `Club_DB`.`Employee` (`Employee_SSN`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_Catering_Location_Catering1`
    FOREIGN KEY (`CateringName`)
    REFERENCES `Club_DB`.`Catering` (`Name`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `Club_DB`.`Place`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `Club_DB`.`Place` ;

CREATE TABLE IF NOT EXISTS `Club_DB`.`Place` (
  `PlaceName` VARCHAR(25) NOT NULL,
  `Location` VARCHAR(25) NOT NULL,
  PRIMARY KEY (`PlaceName`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `Club_DB`.`Hall`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `Club_DB`.`Hall` ;

CREATE TABLE IF NOT EXISTS `Club_DB`.`Hall` (
  `PlaceName` VARCHAR(25) NOT NULL,
  `NumberOfSeats` INT NOT NULL,
  PRIMARY KEY (`PlaceName`),
  CONSTRAINT `fk_Hall_Place1`
    FOREIGN KEY (`PlaceName`)
    REFERENCES `Club_DB`.`Place` (`PlaceName`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `Club_DB`.`Field`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `Club_DB`.`Field` ;

CREATE TABLE IF NOT EXISTS `Club_DB`.`Field` (
  `PlaceName` VARCHAR(25) NOT NULL,
  `Area` FLOAT NOT NULL,
  PRIMARY KEY (`PlaceName`),
  CONSTRAINT `fk_Field_Place1`
    FOREIGN KEY (`PlaceName`)
    REFERENCES `Club_DB`.`Place` (`PlaceName`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `Club_DB`.`CateringStaff`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `Club_DB`.`CateringStaff` ;

CREATE TABLE IF NOT EXISTS `Club_DB`.`CateringStaff` (
  `Worker_SSN` INT NOT NULL,
  `Catering_Name` VARCHAR(25) NOT NULL,
  `Catering_Location` VARCHAR(25) NOT NULL,
  PRIMARY KEY (`Worker_SSN`),
  CONSTRAINT `fk_table1_Employee1`
    FOREIGN KEY (`Worker_SSN`)
    REFERENCES `Club_DB`.`Employee` (`Employee_SSN`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `Club_DB`.`Management_Employee`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `Club_DB`.`Management_Employee` ;

CREATE TABLE IF NOT EXISTS `Club_DB`.`Management_Employee` (
  `Management_Name` VARCHAR(10) NOT NULL,
  `Employee_SSN` INT NOT NULL,
  PRIMARY KEY (`Management_Name`, `Employee_SSN`),
  CONSTRAINT `fk_table2_Management1`
    FOREIGN KEY (`Management_Name`)
    REFERENCES `Club_DB`.`Management` (`Name`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_Management_Employee_Employee1`
    FOREIGN KEY (`Employee_SSN`)
    REFERENCES `Club_DB`.`Employee` (`Employee_SSN`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `Club_DB`.`Event_Managment_Place`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `Club_DB`.`Event_Managment_Place` ;

CREATE TABLE IF NOT EXISTS `Club_DB`.`Event_Managment_Place` (
  `Event_Name` VARCHAR(45) NOT NULL,
  `PlaceName` VARCHAR(25) NOT NULL,
  `Management_Name` VARCHAR(10) NOT NULL,
  PRIMARY KEY (`Event_Name`, `PlaceName`, `Management_Name`),
  CONSTRAINT `fk_table3_Management1`
    FOREIGN KEY (`Management_Name`)
    REFERENCES `Club_DB`.`Management` (`Name`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_table3_Place1`
    FOREIGN KEY (`PlaceName`)
    REFERENCES `Club_DB`.`Place` (`PlaceName`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_table3_Event1`
    FOREIGN KEY (`Event_Name`)
    REFERENCES `Club_DB`.`Event` (`Name`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `Club_DB`.`teamSport_Player`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `Club_DB`.`teamSport_Player` ;

CREATE TABLE IF NOT EXISTS `Club_DB`.`teamSport_Player` (
  `Player_SSN` INT NOT NULL,
  `SportName` VARCHAR(15) NOT NULL,
  `TeamName` VARCHAR(15) NOT NULL,
  PRIMARY KEY (`Player_SSN`, `TeamName`),
  CONSTRAINT `fk_TeamSport_Pro_Player1`
    FOREIGN KEY (`Player_SSN`)
    REFERENCES `Club_DB`.`Pro_Player` (`Player_SSN`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `Club_DB`.`individualSport_Player`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `Club_DB`.`individualSport_Player` ;

CREATE TABLE IF NOT EXISTS `Club_DB`.`individualSport_Player` (
  `Player_SSN` INT NOT NULL,
  `Coach_SSN` INT NOT NULL,
  PRIMARY KEY (`Player_SSN`, `Coach_SSN`),
  CONSTRAINT `fk_individualSport_Player_Pro_Player1`
    FOREIGN KEY (`Player_SSN`)
    REFERENCES `Club_DB`.`Pro_Player` (`Player_SSN`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_individualSport_Player_Coach1`
    FOREIGN KEY (`Coach_SSN`)
    REFERENCES `Club_DB`.`Coach` (`Coach_SSN`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `Club_DB`.`Menu`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `Club_DB`.`Menu` ;

CREATE TABLE IF NOT EXISTS `Club_DB`.`Menu` (
  `Catering_Name` VARCHAR(25) NOT NULL,
  `Item` VARCHAR(30) NOT NULL,
  `Price` FLOAT NOT NULL,
  PRIMARY KEY (`Catering_Name`, `Item`),
  CONSTRAINT `fk_Menu_Catering1`
    FOREIGN KEY (`Catering_Name`)
    REFERENCES `Club_DB`.`Catering` (`Name`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `Club_DB`.`Team`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `Club_DB`.`Team` ;

CREATE TABLE IF NOT EXISTS `Club_DB`.`Team` (
  `SportName` VARCHAR(15) NOT NULL,
  `TeamName` VARCHAR(15) NOT NULL,
  `Coach_SSN` INT NOT NULL,
  PRIMARY KEY (`TeamName`),
  CONSTRAINT `fk_Team_Coach1`
    FOREIGN KEY (`Coach_SSN`)
    REFERENCES `Club_DB`.`Coach` (`Coach_SSN`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `Club_DB`.`Player`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `Club_DB`.`Player` ;

CREATE TABLE IF NOT EXISTS `Club_DB`.`Player` (
  `PlayerSSN` INT NOT NULL,
  `Management_Name` VARCHAR(10) NOT NULL,
  `SportName` VARCHAR(15) NOT NULL,
  `subPrice` FLOAT NOT NULL,
  `StartDate` DATE NOT NULL,
  PRIMARY KEY (`PlayerSSN`),
  CONSTRAINT `fk_nonProPlayer_Management1`
    FOREIGN KEY (`Management_Name`)
    REFERENCES `Club_DB`.`Management` (`Name`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_Player_Member1`
    FOREIGN KEY (`PlayerSSN`)
    REFERENCES `Club_DB`.`Member` (`Member_SSN`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Data for table `Club_DB`.`Person`
-- -----------------------------------------------------
START TRANSACTION;
USE `Club_DB`;
INSERT INTO `Club_DB`.`Person` (`SSN`, `FName`, `LName`, `Address`, `Phone`, `BDATE`, `Gender`, `Email`) VALUES (1, 'Omar', 'Khalil', '100 Baghdad Heliopolis Cairo', '01505829637', '1995-04-25', 'M', 'OmarKhalil93@gmail.com');
INSERT INTO `Club_DB`.`Person` (`SSN`, `FName`, `LName`, `Address`, `Phone`, `BDATE`, `Gender`, `Email`) VALUES (2, 'Adham', 'Nader', '73 Al Ahram Heliopolis Cairo', '01594360251', '2003-09-03', 'M', 'AdhamNader24@outlook.com');
INSERT INTO `Club_DB`.`Person` (`SSN`, `FName`, `LName`, `Address`, `Phone`, `BDATE`, `Gender`, `Email`) VALUES (3, 'Sherif', 'Waleed', '93 Talaat Harb Imbaba Giza', '01115928730', '1997-07-01', 'M', 'SherifWaleed333@gmail.com');
INSERT INTO `Club_DB`.`Person` (`SSN`, `FName`, `LName`, `Address`, `Phone`, `BDATE`, `Gender`, `Email`) VALUES (4, 'Omar', 'Sayed', '13 Al Merghany Heliopolis Cairo', '01257381296', '1989-02-02', 'M', 'OmarSayed128@hotmail.com');
INSERT INTO `Club_DB`.`Person` (`SSN`, `FName`, `LName`, `Address`, `Phone`, `BDATE`, `Gender`, `Email`) VALUES (5, 'Seif', 'Hani', '56 18St. ElTahrir City Imbaba Giza', '01118265940', '1999-08-15', 'M', 'SeifHani125@gmail.com');
INSERT INTO `Club_DB`.`Person` (`SSN`, `FName`, `LName`, `Address`, `Phone`, `BDATE`, `Gender`, `Email`) VALUES (6, 'Ahmed', 'Khalil', '81 Al Kanal Maadi Cairo', '01067825309', '1997-09-14', 'M', 'AhmedKhalil270@outlook.com');
INSERT INTO `Club_DB`.`Person` (`SSN`, `FName`, `LName`, `Address`, `Phone`, `BDATE`, `Gender`, `Email`) VALUES (7, 'Ahmed', 'Khaled', '99 Al Falaky Downtown Cairo', '01238450269', '1987-04-15', 'M', 'AhmedKhaled344@gmail.com');
INSERT INTO `Club_DB`.`Person` (`SSN`, `FName`, `LName`, `Address`, `Phone`, `BDATE`, `Gender`, `Email`) VALUES (8, 'Kareem', 'Magdy', '68 Shagaret Al Dor Zamalek Cairo', '01523541068', '1998-07-14', 'M', 'KareemMagdy52@gmail.com');
INSERT INTO `Club_DB`.`Person` (`SSN`, `FName`, `LName`, `Address`, `Phone`, `BDATE`, `Gender`, `Email`) VALUES (9, 'Eyad', 'Farag', '26 Mohammed Mazhar Zamalek Cairo', '01062409138', '1995-01-17', 'M', 'EyadFarag321@outlook.com');
INSERT INTO `Club_DB`.`Person` (`SSN`, `FName`, `LName`, `Address`, `Phone`, `BDATE`, `Gender`, `Email`) VALUES (10, 'Mohamed', 'Sayed', '100 Mamdouh Salem Imbaba Giza', '01245712360', '2003-12-28', 'M', 'MohamedSayed152@gmail.com');
INSERT INTO `Club_DB`.`Person` (`SSN`, `FName`, `LName`, `Address`, `Phone`, `BDATE`, `Gender`, `Email`) VALUES (11, 'Mohamed', 'Ghanim', '75 El Sadat Al-Salam Cairo', '01571342958', '1987-08-27', 'M', 'MohamedGhanim346@gmail.com');
INSERT INTO `Club_DB`.`Person` (`SSN`, `FName`, `LName`, `Address`, `Phone`, `BDATE`, `Gender`, `Email`) VALUES (12, 'Mostafa', 'Fawzi', '100 Taha Hussein Zamalek Cairo', '01175386940', '1989-09-10', 'M', 'MostafaFawzi140@hotmail.com');
INSERT INTO `Club_DB`.`Person` (`SSN`, `FName`, `LName`, `Address`, `Phone`, `BDATE`, `Gender`, `Email`) VALUES (13, 'Mahmoud', 'Yaser', '7 Talaat Harb Downtown Cairo', '01564021578', '2002-06-10', 'M', 'MahmoudYaser88@outlook.com');
INSERT INTO `Club_DB`.`Person` (`SSN`, `FName`, `LName`, `Address`, `Phone`, `BDATE`, `Gender`, `Email`) VALUES (14, 'Haytham', 'Zakaria', '46 Hassan Sabry Zamalek Cairo', '01249871625', '1998-04-15', 'M', 'HaythamZakaria134@outlook.com');
INSERT INTO `Club_DB`.`Person` (`SSN`, `FName`, `LName`, `Address`, `Phone`, `BDATE`, `Gender`, `Email`) VALUES (15, 'Adham', 'Ghanim', '94 Adly Downtown Cairo', '01137129058', '2001-03-24', 'M', 'AdhamGhanim152@outlook.com');
INSERT INTO `Club_DB`.`Person` (`SSN`, `FName`, `LName`, `Address`, `Phone`, `BDATE`, `Gender`, `Email`) VALUES (16, 'Yousif', 'Ezzat', '67 Gad Eid Al Doqi Giza', '01274802935', '1987-02-06', 'M', 'YousifEzzat101@outlook.com');
INSERT INTO `Club_DB`.`Person` (`SSN`, `FName`, `LName`, `Address`, `Phone`, `BDATE`, `Gender`, `Email`) VALUES (17, 'Abdallah', 'Magdy', '33 Damascus Maadi Cairo', '01086135042', '1987-04-04', 'M', 'AbdallahMagdy396@hotmail.com');
INSERT INTO `Club_DB`.`Person` (`SSN`, `FName`, `LName`, `Address`, `Phone`, `BDATE`, `Gender`, `Email`) VALUES (18, 'Seif', 'Khaled', '77 Talaat Harb Downtown Cairo', '01207985142', '1994-08-01', 'M', 'SeifKhaled59@hotmail.com');
INSERT INTO `Club_DB`.`Person` (`SSN`, `FName`, `LName`, `Address`, `Phone`, `BDATE`, `Gender`, `Email`) VALUES (19, 'Mohamed', 'Nader', '51 Al Hegaz Heliopolis Cairo', '01179584362', '1995-05-03', 'M', 'MohamedNader219@outlook.com');
INSERT INTO `Club_DB`.`Person` (`SSN`, `FName`, `LName`, `Address`, `Phone`, `BDATE`, `Gender`, `Email`) VALUES (20, 'Seif', 'Ashraf', '2 Talaat Harb Imbaba Giza', '01528015439', '1996-02-15', 'M', 'SeifAshraf82@gmail.com');
INSERT INTO `Club_DB`.`Person` (`SSN`, `FName`, `LName`, `Address`, `Phone`, `BDATE`, `Gender`, `Email`) VALUES (21, 'Ahmed', 'Fawzi', '10 Salah El Din Heliopolis Cairo', '01175031864', '1997-12-28', 'M', 'AhmedFawzi239@outlook.com');
INSERT INTO `Club_DB`.`Person` (`SSN`, `FName`, `LName`, `Address`, `Phone`, `BDATE`, `Gender`, `Email`) VALUES (22, 'Ahmed', 'Ezzat', '28 Doletyan Shobra Cairo', '01559420381', '2002-06-27', 'M', 'AhmedEzzat130@outlook.com');
INSERT INTO `Club_DB`.`Person` (`SSN`, `FName`, `LName`, `Address`, `Phone`, `BDATE`, `Gender`, `Email`) VALUES (23, 'Ali', 'Hani', '81 Rod El Farag Shobra Cairo', '01257328016', '1995-11-27', 'M', 'AliHani162@gmail.com');
INSERT INTO `Club_DB`.`Person` (`SSN`, `FName`, `LName`, `Address`, `Phone`, `BDATE`, `Gender`, `Email`) VALUES (24, 'Kareem', 'Ghanim', '6 Rod El Farag Shobra Cairo', '01575941280', '1992-11-22', 'M', 'KareemGhanim103@hotmail.com');
INSERT INTO `Club_DB`.`Person` (`SSN`, `FName`, `LName`, `Address`, `Phone`, `BDATE`, `Gender`, `Email`) VALUES (25, 'Zeyad', 'Fawzi', '35 Gad Eid Al Doqi Giza', '01230265174', '1992-01-26', 'M', 'ZeyadFawzi398@hotmail.com');
INSERT INTO `Club_DB`.`Person` (`SSN`, `FName`, `LName`, `Address`, `Phone`, `BDATE`, `Gender`, `Email`) VALUES (26, 'Abdelrahman', 'Ashraf', '8 Ahmed Helmy Shobra Cairo', '01047128036', '1994-10-10', 'M', 'AbdelrahmanAshraf24@hotmail.com');
INSERT INTO `Club_DB`.`Person` (`SSN`, `FName`, `LName`, `Address`, `Phone`, `BDATE`, `Gender`, `Email`) VALUES (27, 'Zeyad', 'Mohamed', '34 El Sadat Al-Salam Cairo', '01198024653', '1994-10-26', 'M', 'ZeyadMohamed244@gmail.com');
INSERT INTO `Club_DB`.`Person` (`SSN`, `FName`, `LName`, `Address`, `Phone`, `BDATE`, `Gender`, `Email`) VALUES (28, 'Amir', 'Yaser', '16 Rod El Farag Shobra Cairo', '01287093125', '1998-07-11', 'M', 'AmirYaser98@gmail.com');
INSERT INTO `Club_DB`.`Person` (`SSN`, `FName`, `LName`, `Address`, `Phone`, `BDATE`, `Gender`, `Email`) VALUES (29, 'Omar', 'Fawzi', '44 Kholousi Shobra Cairo', '01219428306', '1994-12-13', 'M', 'OmarFawzi192@gmail.com');
INSERT INTO `Club_DB`.`Person` (`SSN`, `FName`, `LName`, `Address`, `Phone`, `BDATE`, `Gender`, `Email`) VALUES (30, 'Ahmed', 'Fawzi', '63 Salah El Din Helipolis Cairo', '01098574103', '1992-09-21', 'M', 'AhmedFawzi362@hotmail.com');
INSERT INTO `Club_DB`.`Person` (`SSN`, `FName`, `LName`, `Address`, `Phone`, `BDATE`, `Gender`, `Email`) VALUES (31, 'Mohamed', 'Hani', '34 28St. El-Tahrir City Imbaba Giza', '01030178425', '2005-09-14', 'M', 'MohamedHani129@outlook.com');
INSERT INTO `Club_DB`.`Person` (`SSN`, `FName`, `LName`, `Address`, `Phone`, `BDATE`, `Gender`, `Email`) VALUES (32, 'Zeyad', 'Yaser', '40 18St.  ElTahrir City Imbaba Giza', '01102374158', '2005-07-20', 'M', 'ZeyadYaser356@hotmail.com');
INSERT INTO `Club_DB`.`Person` (`SSN`, `FName`, `LName`, `Address`, `Phone`, `BDATE`, `Gender`, `Email`) VALUES (33, 'Seif', 'Magdy', '50 Shaheen Al Doqi Giza', '01149832615', '2007-05-24', 'M', 'SeifMagdy359@hotmail.com');
INSERT INTO `Club_DB`.`Person` (`SSN`, `FName`, `LName`, `Address`, `Phone`, `BDATE`, `Gender`, `Email`) VALUES (34, 'Ehab', 'Waleed', '44 28St. El-Tahrir City Imbaba Giza', '01016289075', '2006-12-23', 'M', 'EhabWaleed339@outlook.com');
INSERT INTO `Club_DB`.`Person` (`SSN`, `FName`, `LName`, `Address`, `Phone`, `BDATE`, `Gender`, `Email`) VALUES (35, 'Abdallah', 'Farag', '54 Gamal Abdel Nasser Al-Salam Cairo', '01245198607', '2007-08-20', 'M', 'AbdallahFarag128@hotmail.com');
INSERT INTO `Club_DB`.`Person` (`SSN`, `FName`, `LName`, `Address`, `Phone`, `BDATE`, `Gender`, `Email`) VALUES (36, 'Amr', 'Ashraf', '77 Hassan Ramadan Al Doqi Giza', '01507639154', '2007-02-18', 'M', 'AmrAshraf272@gmail.com');
INSERT INTO `Club_DB`.`Person` (`SSN`, `FName`, `LName`, `Address`, `Phone`, `BDATE`, `Gender`, `Email`) VALUES (37, 'Abdallah', 'Yaser', '74 Taha Hussein Zamalek Cairo', '01505397412', '2007-04-15', 'M', 'AbdallahYaser291@hotmail.com');
INSERT INTO `Club_DB`.`Person` (`SSN`, `FName`, `LName`, `Address`, `Phone`, `BDATE`, `Gender`, `Email`) VALUES (38, 'Wael', 'Khaled', '62 26 July St Downtown Cairo', '01241683907', '2005-06-18', 'M', 'WaelKhaled403@hotmail.com');
INSERT INTO `Club_DB`.`Person` (`SSN`, `FName`, `LName`, `Address`, `Phone`, `BDATE`, `Gender`, `Email`) VALUES (39, 'Yousif', 'Magdy', '58 Talaat Harb Imbaba Giza', '01153297064', '2007-08-23', 'M', 'YousifMagdy139@gmail.com');
INSERT INTO `Club_DB`.`Person` (`SSN`, `FName`, `LName`, `Address`, `Phone`, `BDATE`, `Gender`, `Email`) VALUES (40, 'Abdalaziz', 'Khalil', '42 Bahgat Ali Zamalek Cairo', '01152193076', '2007-08-07', 'M', 'AbdalazizKhalil67@hotmail.com');
INSERT INTO `Club_DB`.`Person` (`SSN`, `FName`, `LName`, `Address`, `Phone`, `BDATE`, `Gender`, `Email`) VALUES (41, 'Eyad', 'Salah', '46 Gamal Abdel Nasser Al-Salam Cairo', '01150762139', '2008-02-15', 'M', 'EyadSalah153@outlook.com');
INSERT INTO `Club_DB`.`Person` (`SSN`, `FName`, `LName`, `Address`, `Phone`, `BDATE`, `Gender`, `Email`) VALUES (42, 'Adham', 'Zakaria', '24 Shaheen Al Doqi Giza', '01137492185', '2005-11-04', 'M', 'AdhamZakaria139@gmail.com');
INSERT INTO `Club_DB`.`Person` (`SSN`, `FName`, `LName`, `Address`, `Phone`, `BDATE`, `Gender`, `Email`) VALUES (43, 'Mahmoud', 'Salah', '33 Taha Hussein Zamalek Cairo', '01584035912', '2006-06-24', 'M', 'MahmoudSalah9@hotmail.com');
INSERT INTO `Club_DB`.`Person` (`SSN`, `FName`, `LName`, `Address`, `Phone`, `BDATE`, `Gender`, `Email`) VALUES (44, 'Ibrahim', 'Emad', '3 Al Merghany Heliopolis Cairo', '01152730861', '2005-03-09', 'M', 'IbrahimEmad331@outlook.com');
INSERT INTO `Club_DB`.`Person` (`SSN`, `FName`, `LName`, `Address`, `Phone`, `BDATE`, `Gender`, `Email`) VALUES (45, 'Mohamed', 'Khaled', '27 Al Kanal Maadi Cairo', '01018963524', '2007-03-14', 'M', 'MohamedKhaled122@outlook.com');
INSERT INTO `Club_DB`.`Person` (`SSN`, `FName`, `LName`, `Address`, `Phone`, `BDATE`, `Gender`, `Email`) VALUES (46, 'Yousif', 'Ashraf', '86 Hassan Ramadan Al Doqi Giza', '01249713826', '2007-02-23', 'M', 'YousifAshraf61@outlook.com');
INSERT INTO `Club_DB`.`Person` (`SSN`, `FName`, `LName`, `Address`, `Phone`, `BDATE`, `Gender`, `Email`) VALUES (47, 'Haytham', 'Hassan', '77 Sherif Downtown Cairo', '01150176382', '2007-01-11', 'M', 'HaythamHassan103@gmail.com');
INSERT INTO `Club_DB`.`Person` (`SSN`, `FName`, `LName`, `Address`, `Phone`, `BDATE`, `Gender`, `Email`) VALUES (48, 'Eyad', 'Hani', '100 28St. El-Tahrir City Imbaba Giza', '01235081479', '2007-01-05', 'M', 'EyadHani210@outlook.com');
INSERT INTO `Club_DB`.`Person` (`SSN`, `FName`, `LName`, `Address`, `Phone`, `BDATE`, `Gender`, `Email`) VALUES (49, 'Amr', 'Farag', '88 Gamal Abdel Nasser Al-Salam Cairo', '01093281057', '2008-06-21', 'M', 'AmrFarag253@gmail.com');
INSERT INTO `Club_DB`.`Person` (`SSN`, `FName`, `LName`, `Address`, `Phone`, `BDATE`, `Gender`, `Email`) VALUES (50, 'Abdallah', 'Mohamed', '67 Al Teraa Al Boulakeya Shobra Cairo', '01578546120', '2008-11-03', 'M', 'AbdallahMohamed184@hotmail.com');
INSERT INTO `Club_DB`.`Person` (`SSN`, `FName`, `LName`, `Address`, `Phone`, `BDATE`, `Gender`, `Email`) VALUES (51, 'Rashad', 'Khaled', '8 Shaheen Al Doqi Giza', '01589041623', '2008-05-26', 'M', 'RashadKhaled353@outlook.com');
INSERT INTO `Club_DB`.`Person` (`SSN`, `FName`, `LName`, `Address`, `Phone`, `BDATE`, `Gender`, `Email`) VALUES (52, 'Mahmoud', 'Sayed', '17 Kholousi Shobra Cairo', '01225807169', '2006-08-18', 'M', 'MahmoudSayed22@gmail.com');
INSERT INTO `Club_DB`.`Person` (`SSN`, `FName`, `LName`, `Address`, `Phone`, `BDATE`, `Gender`, `Email`) VALUES (53, 'Haytham', 'Magdy', '87 Salah El Din Helipolis Cairo', '01292830175', '2007-05-23', 'M', 'HaythamMagdy46@hotmail.com');
INSERT INTO `Club_DB`.`Person` (`SSN`, `FName`, `LName`, `Address`, `Phone`, `BDATE`, `Gender`, `Email`) VALUES (54, 'Eyad', 'Zakaria', '90 Gamal Abdel Nasser Al-Salam Cairo', '01090572483', '2005-09-14', 'M', 'EyadZakaria299@gmail.com');
INSERT INTO `Club_DB`.`Person` (`SSN`, `FName`, `LName`, `Address`, `Phone`, `BDATE`, `Gender`, `Email`) VALUES (55, 'Rashad', 'Fawzi', '12 Talaat Harb Imbaba Giza', '01171643928', '2008-01-11', 'M', 'RashadFawzi172@gmail.com');
INSERT INTO `Club_DB`.`Person` (`SSN`, `FName`, `LName`, `Address`, `Phone`, `BDATE`, `Gender`, `Email`) VALUES (56, 'Zeyad', 'Salah', '71 Rod El Farag Shobra Cairo', '01147951082', '2007-08-17', 'M', 'ZeyadSalah180@outlook.com');
INSERT INTO `Club_DB`.`Person` (`SSN`, `FName`, `LName`, `Address`, `Phone`, `BDATE`, `Gender`, `Email`) VALUES (57, 'Ibrahim', 'Fawzi', '94 Baghdad Helipolis Cairo', '01087302169', '2008-10-17', 'M', 'IbrahimFawzi217@outlook.com');
INSERT INTO `Club_DB`.`Person` (`SSN`, `FName`, `LName`, `Address`, `Phone`, `BDATE`, `Gender`, `Email`) VALUES (58, 'Amir', 'Sayed', '74 Talaat Harb Imbaba Giza', '01081945036', '2006-07-13', 'M', 'AmirSayed140@hotmail.com');
INSERT INTO `Club_DB`.`Person` (`SSN`, `FName`, `LName`, `Address`, `Phone`, `BDATE`, `Gender`, `Email`) VALUES (59, 'Ibrahim', 'Ashraf', '11 El Tahrir Downtown Cairo', '01126408931', '2005-11-13', 'M', 'IbrahimAshraf175@gmail.com');
INSERT INTO `Club_DB`.`Person` (`SSN`, `FName`, `LName`, `Address`, `Phone`, `BDATE`, `Gender`, `Email`) VALUES (60, 'Amr', 'Farag', '63 Taha Hussein Zamalek Cairo', '01007695183', '2005-11-24', 'M', 'AmrFarag116@hotmail.com');
INSERT INTO `Club_DB`.`Person` (`SSN`, `FName`, `LName`, `Address`, `Phone`, `BDATE`, `Gender`, `Email`) VALUES (61, 'Rashad', 'Sayed', '65 Kholousi Shobra Cairo', '01119276584', '1999-12-06', 'M', 'RashadSayed177@outlook.com');
INSERT INTO `Club_DB`.`Person` (`SSN`, `FName`, `LName`, `Address`, `Phone`, `BDATE`, `Gender`, `Email`) VALUES (62, 'Haytham', 'Nader', '19 Hassan Ramadan Al Doqi Giza', '01257160239', '2002-05-16', 'M', 'HaythamNader105@gmail.com');
INSERT INTO `Club_DB`.`Person` (`SSN`, `FName`, `LName`, `Address`, `Phone`, `BDATE`, `Gender`, `Email`) VALUES (63, 'Sherif', 'Hani', '4 Mamdouh Salem Imbaba Giza', '01126018379', '1999-10-09', 'M', 'SherifHani303@gmail.com');
INSERT INTO `Club_DB`.`Person` (`SSN`, `FName`, `LName`, `Address`, `Phone`, `BDATE`, `Gender`, `Email`) VALUES (64, 'Sherif', 'Khaled', '53 Al Saad Al Aaly Maadi Cairo', '01131765240', '1995-01-09', 'M', 'SherifKhaled57@gmail.com');
INSERT INTO `Club_DB`.`Person` (`SSN`, `FName`, `LName`, `Address`, `Phone`, `BDATE`, `Gender`, `Email`) VALUES (65, 'Omar', 'Sobhi', '46 Taha Hussein Zamalek Cairo', '01549512830', '1993-10-22', 'M', 'OmarSobhi152@outlook.com');
INSERT INTO `Club_DB`.`Person` (`SSN`, `FName`, `LName`, `Address`, `Phone`, `BDATE`, `Gender`, `Email`) VALUES (66, 'Kareem', 'Farag', '98 26 July St Downtown Cairo', '01517486923', '1994-12-22', 'M', 'KareemFarag230@outlook.com');
INSERT INTO `Club_DB`.`Person` (`SSN`, `FName`, `LName`, `Address`, `Phone`, `BDATE`, `Gender`, `Email`) VALUES (67, 'Ibrahim', 'Khaled', '83 Adly Downtown Cairo', '01528741963', '1994-11-11', 'M', 'IbrahimKhaled75@hotmail.com');
INSERT INTO `Club_DB`.`Person` (`SSN`, `FName`, `LName`, `Address`, `Phone`, `BDATE`, `Gender`, `Email`) VALUES (68, 'Eyad', 'Sobhi', '73 Abou El Feda Zamalek Cairo', '01224063981', '1996-03-01', 'M', 'EyadSobhi407@gmail.com');
INSERT INTO `Club_DB`.`Person` (`SSN`, `FName`, `LName`, `Address`, `Phone`, `BDATE`, `Gender`, `Email`) VALUES (69, 'Haytham', 'Zakaria', '77 Gamal Abdel Nasser Al-Salam Cairo', '01197240631', '1992-10-17', 'M', 'HaythamZakaria59@hotmail.com');
INSERT INTO `Club_DB`.`Person` (`SSN`, `FName`, `LName`, `Address`, `Phone`, `BDATE`, `Gender`, `Email`) VALUES (70, 'Rashad', 'Nader', '58 Al Ahram Helipolis Cairo', '01505493216', '1994-01-24', 'M', 'RashadNader339@outlook.com');
INSERT INTO `Club_DB`.`Person` (`SSN`, `FName`, `LName`, `Address`, `Phone`, `BDATE`, `Gender`, `Email`) VALUES (71, 'Seif', 'Mohamed', '16 26 July St Downtown Cairo', '01128176935', '2000-04-10', 'M', 'SeifMohamed292@outlook.com');
INSERT INTO `Club_DB`.`Person` (`SSN`, `FName`, `LName`, `Address`, `Phone`, `BDATE`, `Gender`, `Email`) VALUES (72, 'Seif', 'Sobhi', '79 kamal Al Tawil Zamalek Cairo', '01208932671', '2001-10-22', 'M', 'SeifSobhi298@gmail.com');
INSERT INTO `Club_DB`.`Person` (`SSN`, `FName`, `LName`, `Address`, `Phone`, `BDATE`, `Gender`, `Email`) VALUES (73, 'Yasmin', 'Hassan', '92 Champeleon Downtown Cairo', '01212963458', '2002-03-22', 'F', 'YasminHassan380@gmail.com');
INSERT INTO `Club_DB`.`Person` (`SSN`, `FName`, `LName`, `Address`, `Phone`, `BDATE`, `Gender`, `Email`) VALUES (74, 'Salma', 'Khalil', '13 Gamal Abdel Nasser Al-Salam Cairo', '01198345027', '1995-01-27', 'F', 'SalmaKhalil71@hotmail.com');
INSERT INTO `Club_DB`.`Person` (`SSN`, `FName`, `LName`, `Address`, `Phone`, `BDATE`, `Gender`, `Email`) VALUES (75, 'Hana', 'Magdy', '80 Bahgat Ali Zamalek Cairo', '01297056842', '1996-11-26', 'F', 'HanaMagdy330@outlook.com');
INSERT INTO `Club_DB`.`Person` (`SSN`, `FName`, `LName`, `Address`, `Phone`, `BDATE`, `Gender`, `Email`) VALUES (76, 'Esraa', 'Ezzat', '27 Gad Eid Al Doqi Giza', '01065317249', '2001-03-04', 'F', 'EsraaEzzat135@hotmail.com');
INSERT INTO `Club_DB`.`Person` (`SSN`, `FName`, `LName`, `Address`, `Phone`, `BDATE`, `Gender`, `Email`) VALUES (77, 'Aya', 'Mohamed', '50 Gamal Abdel Nasser Al-Salam Cairo', '01221740893', '1991-04-07', 'F', 'AyaMohamed24@gmail.com');
INSERT INTO `Club_DB`.`Person` (`SSN`, `FName`, `LName`, `Address`, `Phone`, `BDATE`, `Gender`, `Email`) VALUES (78, 'Nour', 'Ghanim', '10 Mamdouh Salem Imbaba Giza', '01214928753', '1994-03-06', 'F', 'NourGhanim311@gmail.com');
INSERT INTO `Club_DB`.`Person` (`SSN`, `FName`, `LName`, `Address`, `Phone`, `BDATE`, `Gender`, `Email`) VALUES (79, 'Yasmin', 'Hassan', '23 Oraby Maadi Cairo', '01150391872', '1995-12-16', 'F', 'YasminHassan415@outlook.com');
INSERT INTO `Club_DB`.`Person` (`SSN`, `FName`, `LName`, `Address`, `Phone`, `BDATE`, `Gender`, `Email`) VALUES (80, 'Amal', 'Khaled', '27 Shaheen Al Doqi Giza', '01061237485', '1991-03-24', 'F', 'AmalKhaled402@gmail.com');
INSERT INTO `Club_DB`.`Person` (`SSN`, `FName`, `LName`, `Address`, `Phone`, `BDATE`, `Gender`, `Email`) VALUES (81, 'Amani', 'Waleed', '92 Al Ahram Helipolis Cairo', '01219273548', '1997-07-14', 'F', 'AmaniWaleed196@gmail.com');
INSERT INTO `Club_DB`.`Person` (`SSN`, `FName`, `LName`, `Address`, `Phone`, `BDATE`, `Gender`, `Email`) VALUES (82, 'Arwa', 'Khalil', '9 Gamal Abdel Nasser Al-Salam Cairo', '01175423906', '1998-04-11', 'F', 'ArwaKhalil403@gmail.com');
INSERT INTO `Club_DB`.`Person` (`SSN`, `FName`, `LName`, `Address`, `Phone`, `BDATE`, `Gender`, `Email`) VALUES (83, 'Omnya', 'Khaled', '7 Al Merghany Heliopolis Cairo', '01029730458', '1996-05-01', 'F', 'OmnyaKhaled318@gmail.com');
INSERT INTO `Club_DB`.`Person` (`SSN`, `FName`, `LName`, `Address`, `Phone`, `BDATE`, `Gender`, `Email`) VALUES (84, 'Rahma', 'Sobhi', '92 Mamdouh Salem Imbaba Giza', '01523571648', '1998-03-27', 'F', 'RahmaSobhi212@outlook.com');
INSERT INTO `Club_DB`.`Person` (`SSN`, `FName`, `LName`, `Address`, `Phone`, `BDATE`, `Gender`, `Email`) VALUES (85, 'Salma', 'Salah', '65 26 July St Downtown Cairo', '01521548936', '2002-01-02', 'F', 'SalmaSalah286@outlook.com');
INSERT INTO `Club_DB`.`Person` (`SSN`, `FName`, `LName`, `Address`, `Phone`, `BDATE`, `Gender`, `Email`) VALUES (86, 'Salma', 'Khaled', '53 Kholousi Shobra Cairo', '01273980156', '2004-03-17', 'F', 'SalmaKhaled5@outlook.com');
INSERT INTO `Club_DB`.`Person` (`SSN`, `FName`, `LName`, `Address`, `Phone`, `BDATE`, `Gender`, `Email`) VALUES (87, 'Mostafa', 'Sobhi', '24 Doletyan Shobra Cairo', '01539218046', '2001-11-15', 'M', 'MostafaSobhi199@outlook.com');
INSERT INTO `Club_DB`.`Person` (`SSN`, `FName`, `LName`, `Address`, `Phone`, `BDATE`, `Gender`, `Email`) VALUES (88, 'Toaa', 'Hani', '20 Hassan Sabry Zamalek Cairo', '01217398620', '2000-01-24', 'F', 'ToaaHani357@gmail.com');
INSERT INTO `Club_DB`.`Person` (`SSN`, `FName`, `LName`, `Address`, `Phone`, `BDATE`, `Gender`, `Email`) VALUES (89, 'Yasmin', 'Fawzi', '74 Salah El Din Helipolis Cairo', '01208473291', '2000-09-16', 'F', 'YasminFawzi13@gmail.com');
INSERT INTO `Club_DB`.`Person` (`SSN`, `FName`, `LName`, `Address`, `Phone`, `BDATE`, `Gender`, `Email`) VALUES (90, 'Mostafa', 'Khalil', '61 Salah El Din Helipolis Cairo', '01564973102', '2001-08-10', 'M', 'MostafaKhalil107@outlook.com');
INSERT INTO `Club_DB`.`Person` (`SSN`, `FName`, `LName`, `Address`, `Phone`, `BDATE`, `Gender`, `Email`) VALUES (91, 'Yasmin', 'Nader', '91 151 St. Maadi Cairo', '01230586724', '1998-01-27', 'F', 'YasminNader230@hotmail.com');
INSERT INTO `Club_DB`.`Person` (`SSN`, `FName`, `LName`, `Address`, `Phone`, `BDATE`, `Gender`, `Email`) VALUES (92, 'Ibrahim', 'Adel', '92 Bahgat Ali Zamalek Cairo', '01296273105', '2001-10-16', 'M', 'IbrahimAdel20@hotmail.com');
INSERT INTO `Club_DB`.`Person` (`SSN`, `FName`, `LName`, `Address`, `Phone`, `BDATE`, `Gender`, `Email`) VALUES (93, 'Abdallah', 'Zakaria', '19 Shaheen Al Doqi Giza', '01597628104', '2003-09-01', 'M', 'AbdallahZakaria401@outlook.com');
INSERT INTO `Club_DB`.`Person` (`SSN`, `FName`, `LName`, `Address`, `Phone`, `BDATE`, `Gender`, `Email`) VALUES (94, 'Ahmed', 'Khalil', '42 18St. El-Tahrir City Imbaba Giza', '01196237450', '1994-08-16', 'M', 'AhmedKhalil52@outlook.com');
INSERT INTO `Club_DB`.`Person` (`SSN`, `FName`, `LName`, `Address`, `Phone`, `BDATE`, `Gender`, `Email`) VALUES (95, 'Amani', 'Emad', '25 Al Merghany Heliopolis Cairo', '01145701892', '2002-07-19', 'F', 'AmaniEmad90@hotmail.com');
INSERT INTO `Club_DB`.`Person` (`SSN`, `FName`, `LName`, `Address`, `Phone`, `BDATE`, `Gender`, `Email`) VALUES (96, 'Noureen', 'Nader', '15 Bahgat Ali Zamalek Cairo', '01152803697', '1998-09-27', 'F', 'NoureenNader296@hotmail.com');
INSERT INTO `Club_DB`.`Person` (`SSN`, `FName`, `LName`, `Address`, `Phone`, `BDATE`, `Gender`, `Email`) VALUES (97, 'Rahma', 'Yaser', '95 Al Kanal Maadi Cairo', '01143586219', '2001-12-05', 'F', 'RahmaYaser232@gmail.com');
INSERT INTO `Club_DB`.`Person` (`SSN`, `FName`, `LName`, `Address`, `Phone`, `BDATE`, `Gender`, `Email`) VALUES (98, 'Amal', 'Nader', '5 Shaheen Al Doqi Giza', '01596873520', '1999-07-06', 'F', 'AmalNader414@hotmail.com');
INSERT INTO `Club_DB`.`Person` (`SSN`, `FName`, `LName`, `Address`, `Phone`, `BDATE`, `Gender`, `Email`) VALUES (99, 'Ehab', 'Zakaria', '60 El Sadat Al-Salam Cairo', '01582017354', '2001-04-08', 'M', 'EhabZakaria23@hotmail.com');
INSERT INTO `Club_DB`.`Person` (`SSN`, `FName`, `LName`, `Address`, `Phone`, `BDATE`, `Gender`, `Email`) VALUES (100, 'Ahmed', 'Ashraf', '66 Gezira Zamalek Cairo', '01128461309', '1995-07-26', 'M', 'AhmedAshraf46@gmail.com');
INSERT INTO `Club_DB`.`Person` (`SSN`, `FName`, `LName`, `Address`, `Phone`, `BDATE`, `Gender`, `Email`) VALUES (101, 'Salma', 'Khalil', '72 Al Hegaz Helipolis Cairo', '01061924078', '2000-02-21', 'F', 'SalmaKhalil177@gmail.com');
INSERT INTO `Club_DB`.`Person` (`SSN`, `FName`, `LName`, `Address`, `Phone`, `BDATE`, `Gender`, `Email`) VALUES (102, 'Yousif', 'Ezzat', '53 Kholousi Shobra Cairo', '01573812965', '1999-05-06', 'M', 'YousifEzzat383@gmail.com');
INSERT INTO `Club_DB`.`Person` (`SSN`, `FName`, `LName`, `Address`, `Phone`, `BDATE`, `Gender`, `Email`) VALUES (103, 'Ali', 'Salah', '42 Talaat Harb Imbaba Giza', '01069183740', '1995-04-05', 'M', 'AliSalah71@hotmail.com');
INSERT INTO `Club_DB`.`Person` (`SSN`, `FName`, `LName`, `Address`, `Phone`, `BDATE`, `Gender`, `Email`) VALUES (104, 'Noureen', 'Ashraf', '91 Al Nozha Helipolis Cairo', '01010359476', '1994-09-09', 'F', 'NoureenAshraf331@outlook.com');
INSERT INTO `Club_DB`.`Person` (`SSN`, `FName`, `LName`, `Address`, `Phone`, `BDATE`, `Gender`, `Email`) VALUES (105, 'Yousif', 'Emad', '93 Champeleon Downtown Cairo', '01169247835', '1985-03-11', 'M', 'YousifEmad138@hotmail.com');
INSERT INTO `Club_DB`.`Person` (`SSN`, `FName`, `LName`, `Address`, `Phone`, `BDATE`, `Gender`, `Email`) VALUES (106, 'Eyad', 'Fawzi', '53 Damascus Maadi Cairo', '01138452016', '1976-03-04', 'M', 'EyadFawzi146@outlook.com');
INSERT INTO `Club_DB`.`Person` (`SSN`, `FName`, `LName`, `Address`, `Phone`, `BDATE`, `Gender`, `Email`) VALUES (107, 'Abdalaziz', 'Zakaria', '62 Al Hegaz Helipolis Cairo', '01132159408', '1962-01-17', 'M', 'AbdalazizZakaria375@gmail.com');
INSERT INTO `Club_DB`.`Person` (`SSN`, `FName`, `LName`, `Address`, `Phone`, `BDATE`, `Gender`, `Email`) VALUES (108, 'Rahma', 'Mohamed', '5 Talaat Harb Imbaba Giza', '01129463781', '1987-05-19', 'F', 'AliMohamed256@gmail.com');
INSERT INTO `Club_DB`.`Person` (`SSN`, `FName`, `LName`, `Address`, `Phone`, `BDATE`, `Gender`, `Email`) VALUES (109, 'Kareem', 'Sobhi', '92 Ahmed Helmy Shobra Cairo', '01164875392', '1985-04-24', 'M', 'KareemSobhi162@gmail.com');
INSERT INTO `Club_DB`.`Person` (`SSN`, `FName`, `LName`, `Address`, `Phone`, `BDATE`, `Gender`, `Email`) VALUES (110, 'Abdallah', 'Khaled', '17 Shagaret Al Dor Zamalek Cairo', '01296812375', '1978-02-15', 'M', 'AbdallahKhaled113@hotmail.com');
INSERT INTO `Club_DB`.`Person` (`SSN`, `FName`, `LName`, `Address`, `Phone`, `BDATE`, `Gender`, `Email`) VALUES (111, 'Omnya', 'Khaled', '57 Mamdouh Salem Imbaba Giza', '01198410573', '1984-11-26', 'F', 'OmnyaKhaled379@outlook.com');
INSERT INTO `Club_DB`.`Person` (`SSN`, `FName`, `LName`, `Address`, `Phone`, `BDATE`, `Gender`, `Email`) VALUES (112, 'Amr', 'Adel', '70 9 St. Maadi Cairo', '01513249768', '1985-07-19', 'M', 'AmrAdel89@gmail.com');
INSERT INTO `Club_DB`.`Person` (`SSN`, `FName`, `LName`, `Address`, `Phone`, `BDATE`, `Gender`, `Email`) VALUES (113, 'Wael', 'Khalil', '65 Hassan Sabry Zamalek Cairo', '01016725398', '1984-03-21', 'M', 'WaelKhalil88@outlook.com');
INSERT INTO `Club_DB`.`Person` (`SSN`, `FName`, `LName`, `Address`, `Phone`, `BDATE`, `Gender`, `Email`) VALUES (114, 'Yousif', 'Yaser', '83 Talaat Harb Imbaba Giza', '01245380216', '1964-07-01', 'M', 'YousifYaser110@outlook.com');
INSERT INTO `Club_DB`.`Person` (`SSN`, `FName`, `LName`, `Address`, `Phone`, `BDATE`, `Gender`, `Email`) VALUES (115, 'Aya', 'Ezzat', '90 Kholousi Shobra Cairo', '01212950786', '2019-07-26', 'F', 'AyaEzzat265@hotmail.com');
INSERT INTO `Club_DB`.`Person` (`SSN`, `FName`, `LName`, `Address`, `Phone`, `BDATE`, `Gender`, `Email`) VALUES (116, 'Mahmoud', 'Zakaria', '23 151 St. Maadi Cairo', '01228905416', '1974-12-04', 'M', 'MahmoudZakaria299@hotmail.com');
INSERT INTO `Club_DB`.`Person` (`SSN`, `FName`, `LName`, `Address`, `Phone`, `BDATE`, `Gender`, `Email`) VALUES (117, 'Marawan', 'Ghanim', '61 18St. El-Tahrir City Imbaba Giza', '01076905423', '2011-02-25', 'M', 'MarawanGhanim187@hotmail.com');
INSERT INTO `Club_DB`.`Person` (`SSN`, `FName`, `LName`, `Address`, `Phone`, `BDATE`, `Gender`, `Email`) VALUES (118, 'Shahd', 'Ashraf', '17 151 St. Maadi Cairo', '01029560741', '1972-09-22', 'F', 'ShahdAshraf124@hotmail.com');
INSERT INTO `Club_DB`.`Person` (`SSN`, `FName`, `LName`, `Address`, `Phone`, `BDATE`, `Gender`, `Email`) VALUES (119, 'Kareem', 'Khalil', '95 Hassan Sabry Zamalek Cairo', '01029076415', '1980-06-13', 'M', 'KareemKhalil297@outlook.com');
INSERT INTO `Club_DB`.`Person` (`SSN`, `FName`, `LName`, `Address`, `Phone`, `BDATE`, `Gender`, `Email`) VALUES (120, 'Omnya', 'Hani', '78 Al Ahram Helipolis Cairo', '01520839745', '1960-04-12', 'F', 'OmnyaHani250@hotmail.com');
INSERT INTO `Club_DB`.`Person` (`SSN`, `FName`, `LName`, `Address`, `Phone`, `BDATE`, `Gender`, `Email`) VALUES (121, 'Ali', 'Nader', '72 Taha Hussein Zamalek Cairo', '01048392160', '2013-10-10', 'M', 'AliNader306@gmail.com');
INSERT INTO `Club_DB`.`Person` (`SSN`, `FName`, `LName`, `Address`, `Phone`, `BDATE`, `Gender`, `Email`) VALUES (122, 'Mariam', 'Salah', '99 18St. El-Tahrir City Imbaba Giza', '01505672381', '2000-04-02', 'F', 'MariamSalah194@gmail.com');
INSERT INTO `Club_DB`.`Person` (`SSN`, `FName`, `LName`, `Address`, `Phone`, `BDATE`, `Gender`, `Email`) VALUES (123, 'Nourhan', 'Yaser', '50 Al Merghany Heliopolis Cairo', '01269820351', '1972-01-01', 'F', 'NourhanYaser164@hotmail.com');
INSERT INTO `Club_DB`.`Person` (`SSN`, `FName`, `LName`, `Address`, `Phone`, `BDATE`, `Gender`, `Email`) VALUES (124, 'Toaa', 'Fawzi', '92 Shaheen Al Doqi Giza', '01572394085', '1961-04-27', 'F', 'ToaaFawzi32@outlook.com');
INSERT INTO `Club_DB`.`Person` (`SSN`, `FName`, `LName`, `Address`, `Phone`, `BDATE`, `Gender`, `Email`) VALUES (125, 'Shahd', 'Ghanim', '42 Kholousi Shobra Cairo', '01268352907', '2004-11-06', 'F', 'ShahdGhanim128@hotmail.com');
INSERT INTO `Club_DB`.`Person` (`SSN`, `FName`, `LName`, `Address`, `Phone`, `BDATE`, `Gender`, `Email`) VALUES (126, 'Hana', 'Mohamed', '86 Al Saad Al Aaly Maadi Cairo', '01178019432', '1971-12-27', 'F', 'HanaMohamed372@hotmail.com');
INSERT INTO `Club_DB`.`Person` (`SSN`, `FName`, `LName`, `Address`, `Phone`, `BDATE`, `Gender`, `Email`) VALUES (127, 'Ahmed', 'Ashraf', '66 Hassan Ramadan Al Doqi Giza', '01001298675', '2008-01-27', 'M', 'AhmedAshraf71@gmail.com');
INSERT INTO `Club_DB`.`Person` (`SSN`, `FName`, `LName`, `Address`, `Phone`, `BDATE`, `Gender`, `Email`) VALUES (128, 'Esraa', 'Fawzi', '78 Sherif Downtown Cairo', '01595130678', '2001-06-19', 'F', 'EsraaFawzi141@outlook.com');
INSERT INTO `Club_DB`.`Person` (`SSN`, `FName`, `LName`, `Address`, `Phone`, `BDATE`, `Gender`, `Email`) VALUES (129, 'Ahmed', 'Adel', '15 Shaheen Al Doqi Giza', '01212456980', '1964-05-06', 'M', 'AhmedAdel97@hotmail.com');
INSERT INTO `Club_DB`.`Person` (`SSN`, `FName`, `LName`, `Address`, `Phone`, `BDATE`, `Gender`, `Email`) VALUES (130, 'Nour', 'Hani', '69 Salah El Din Helipolis Cairo', '01523601987', '1978-11-28', 'F', 'NourHani231@hotmail.com');
INSERT INTO `Club_DB`.`Person` (`SSN`, `FName`, `LName`, `Address`, `Phone`, `BDATE`, `Gender`, `Email`) VALUES (131, 'Marawan', 'Adel', '8 El Tahrir Downtown Cairo', '01020478163', '2015-10-15', 'M', 'MarawanAdel389@hotmail.com');
INSERT INTO `Club_DB`.`Person` (`SSN`, `FName`, `LName`, `Address`, `Phone`, `BDATE`, `Gender`, `Email`) VALUES (132, 'Sherif', 'Waleed', '59 Adly Downtown Cairo', '01520169785', '1974-11-01', 'M', 'SherifWaleed396@gmail.com');
INSERT INTO `Club_DB`.`Person` (`SSN`, `FName`, `LName`, `Address`, `Phone`, `BDATE`, `Gender`, `Email`) VALUES (133, 'Ibrahim', 'Nader', '95 Gad Eid Al Doqi Giza', '01140897325', '2017-09-18', 'M', 'IbrahimNader129@outlook.com');
INSERT INTO `Club_DB`.`Person` (`SSN`, `FName`, `LName`, `Address`, `Phone`, `BDATE`, `Gender`, `Email`) VALUES (134, 'Ali', 'Adel', '83 Hassan Sabry Zamalek Cairo', '01041578392', '2016-12-26', 'M', 'AliAdel168@outlook.com');
INSERT INTO `Club_DB`.`Person` (`SSN`, `FName`, `LName`, `Address`, `Phone`, `BDATE`, `Gender`, `Email`) VALUES (135, 'Dina', 'Zakaria', '78 Gamal Abdel Nasser Al-Salam Cairo', '01130142958', '2000-07-01', 'F', 'DinaZakaria238@hotmail.com');
INSERT INTO `Club_DB`.`Person` (`SSN`, `FName`, `LName`, `Address`, `Phone`, `BDATE`, `Gender`, `Email`) VALUES (136, 'Amir', 'Ghanim', '56 Hassan Ramadan Al Doqi Giza', '01278413962', '1976-09-13', 'M', 'AmirGhanim296@gmail.com');
INSERT INTO `Club_DB`.`Person` (`SSN`, `FName`, `LName`, `Address`, `Phone`, `BDATE`, `Gender`, `Email`) VALUES (137, 'Hana', 'Ghanim', '41 26 July St Downtown Cairo', '01529506374', '1960-04-10', 'F', 'HanaGhanim335@outlook.com');
INSERT INTO `Club_DB`.`Person` (`SSN`, `FName`, `LName`, `Address`, `Phone`, `BDATE`, `Gender`, `Email`) VALUES (138, 'Rahma', 'Salah', '55 Rod El Farag Shobra Cairo', '01231264870', '2011-08-18', 'F', 'RahmaSalah55@hotmail.com');
INSERT INTO `Club_DB`.`Person` (`SSN`, `FName`, `LName`, `Address`, `Phone`, `BDATE`, `Gender`, `Email`) VALUES (139, 'Nada', 'Mohamed', '86 Al Ahram Helipolis Cairo', '01139465781', '1992-06-28', 'F', 'NadaMohamed211@hotmail.com');
INSERT INTO `Club_DB`.`Person` (`SSN`, `FName`, `LName`, `Address`, `Phone`, `BDATE`, `Gender`, `Email`) VALUES (140, 'Haytham', 'Nader', '82 Al Nozha Helipolis Cairo', '01087023159', '2007-02-14', 'M', 'HaythamNader374@hotmail.com');
INSERT INTO `Club_DB`.`Person` (`SSN`, `FName`, `LName`, `Address`, `Phone`, `BDATE`, `Gender`, `Email`) VALUES (141, 'Seif', 'Yaser', '23 Damascus Maadi Cairo', '01524381096', '1996-10-05', 'M', 'SeifYaser51@hotmail.com');
INSERT INTO `Club_DB`.`Person` (`SSN`, `FName`, `LName`, `Address`, `Phone`, `BDATE`, `Gender`, `Email`) VALUES (142, 'Rahma', 'Farag', '40 Al Nozha Helipolis Cairo', '01196371820', '1990-07-14', 'F', 'RahmaFarag243@gmail.com');
INSERT INTO `Club_DB`.`Person` (`SSN`, `FName`, `LName`, `Address`, `Phone`, `BDATE`, `Gender`, `Email`) VALUES (143, 'Esraa', 'Fawzi', '91 Al Khamrawaya Shobra Cairo', '01186475032', '1962-04-17', 'F', 'EsraaFawzi139@outlook.com');
INSERT INTO `Club_DB`.`Person` (`SSN`, `FName`, `LName`, `Address`, `Phone`, `BDATE`, `Gender`, `Email`) VALUES (144, 'Rahma', 'Farag', '9 Gamal Abdel Nasser Al-Salam Cairo', '01559708326', '2004-07-06', 'F', 'RahmaFarag92@gmail.com');
INSERT INTO `Club_DB`.`Person` (`SSN`, `FName`, `LName`, `Address`, `Phone`, `BDATE`, `Gender`, `Email`) VALUES (145, 'Nourhan', 'Farag', '99 Gezira Zamalek Cairo', '01195304621', '2010-02-26', 'F', 'NourhanFarag348@outlook.com');
INSERT INTO `Club_DB`.`Person` (`SSN`, `FName`, `LName`, `Address`, `Phone`, `BDATE`, `Gender`, `Email`) VALUES (146, 'Aya', 'Hassan', '5 26 July St Downtown Cairo', '01258274610', '1988-02-01', 'F', 'AyaHassan189@gmail.com');
INSERT INTO `Club_DB`.`Person` (`SSN`, `FName`, `LName`, `Address`, `Phone`, `BDATE`, `Gender`, `Email`) VALUES (147, 'Amal', 'Hassan', '83 Mamdouh Salem Imbaba Giza', '01150698372', '2003-03-13', 'F', 'AmalHassan190@outlook.com');
INSERT INTO `Club_DB`.`Person` (`SSN`, `FName`, `LName`, `Address`, `Phone`, `BDATE`, `Gender`, `Email`) VALUES (148, 'Adham', 'Magdy', '96 Baghdad Helipolis Cairo', '01070463951', '2008-07-26', 'M', 'AdhamMagdy379@hotmail.com');
INSERT INTO `Club_DB`.`Person` (`SSN`, `FName`, `LName`, `Address`, `Phone`, `BDATE`, `Gender`, `Email`) VALUES (149, 'Abdelrahman', 'Emad', '44 Al Nahda Maadi Cairo', '01182159403', '1979-12-07', 'M', 'AbdelrahmanEmad49@hotmail.com');
INSERT INTO `Club_DB`.`Person` (`SSN`, `FName`, `LName`, `Address`, `Phone`, `BDATE`, `Gender`, `Email`) VALUES (150, 'Mostafa', 'Adel', '43 El Tahrir Downtown Cairo', '01172061384', '1995-09-16', 'M', 'MostafaAdel309@outlook.com');
INSERT INTO `Club_DB`.`Person` (`SSN`, `FName`, `LName`, `Address`, `Phone`, `BDATE`, `Gender`, `Email`) VALUES (151, 'Hana', 'Sobhi', '86 Gamal Abdel Nasser Al-Salam Cairo', '01137219054', '1960-01-05', 'F', 'HanaSobhi296@outlook.com');
INSERT INTO `Club_DB`.`Person` (`SSN`, `FName`, `LName`, `Address`, `Phone`, `BDATE`, `Gender`, `Email`) VALUES (152, 'Ahmed', 'Waleed', '72 Talaat Harb Imbaba Giza', '01145107398', '2011-11-05', 'M', 'AhmedWaleed327@gmail.com');
INSERT INTO `Club_DB`.`Person` (`SSN`, `FName`, `LName`, `Address`, `Phone`, `BDATE`, `Gender`, `Email`) VALUES (153, 'Mahmoud', 'Adel', '26 Al Kanal Maadi Cairo', '01006538479', '1994-06-22', 'M', 'MahmoudAdel136@outlook.com');
INSERT INTO `Club_DB`.`Person` (`SSN`, `FName`, `LName`, `Address`, `Phone`, `BDATE`, `Gender`, `Email`) VALUES (154, 'Abdalaziz', 'Sobhi', '31 Talaat Harb Downtown Cairo', '01593051674', '1962-11-22', 'M', 'AbdalazizSobhi331@hotmail.com');
INSERT INTO `Club_DB`.`Person` (`SSN`, `FName`, `LName`, `Address`, `Phone`, `BDATE`, `Gender`, `Email`) VALUES (155, 'Abdalaziz', 'Zakaria', '29 Hassan Assem Zamalek Cairo', '01232974106', '2003-12-16', 'M', 'AbdalazizZakaria326@gmail.com');
INSERT INTO `Club_DB`.`Person` (`SSN`, `FName`, `LName`, `Address`, `Phone`, `BDATE`, `Gender`, `Email`) VALUES (156, 'Abdallah', 'Hani', '90 Baghdad Helipolis Cairo', '01071256038', '1981-06-26', 'M', 'AbdallahHani121@outlook.com');
INSERT INTO `Club_DB`.`Person` (`SSN`, `FName`, `LName`, `Address`, `Phone`, `BDATE`, `Gender`, `Email`) VALUES (157, 'Amal', 'Adel', '50 Shobra St. Shobra Cairo', '01057612438', '1983-08-18', 'F', 'AmalAdel370@gmail.com');
INSERT INTO `Club_DB`.`Person` (`SSN`, `FName`, `LName`, `Address`, `Phone`, `BDATE`, `Gender`, `Email`) VALUES (158, 'Marawan', 'Ezzat', '5 Al Saad Al Aaly Maadi Cairo', '01570961254', '1961-02-06', 'M', 'MarawanEzzat372@gmail.com');
INSERT INTO `Club_DB`.`Person` (`SSN`, `FName`, `LName`, `Address`, `Phone`, `BDATE`, `Gender`, `Email`) VALUES (159, 'Adham', 'Ghanim', '30 Al Nadi Maadi Cairo', '01179630418', '2000-03-28', 'M', 'AdhamGhanim132@gmail.com');
INSERT INTO `Club_DB`.`Person` (`SSN`, `FName`, `LName`, `Address`, `Phone`, `BDATE`, `Gender`, `Email`) VALUES (160, 'Kareem', 'Ashraf', '86 Oraby Maadi Cairo', '01517390456', '2003-11-23', 'M', 'KareemAshraf54@outlook.com');
INSERT INTO `Club_DB`.`Person` (`SSN`, `FName`, `LName`, `Address`, `Phone`, `BDATE`, `Gender`, `Email`) VALUES (161, 'Ali', 'Nader', '29 Al Ahram Helipolis Cairo', '01518936472', '1998-11-17', 'M', 'AliNader332@outlook.com');
INSERT INTO `Club_DB`.`Person` (`SSN`, `FName`, `LName`, `Address`, `Phone`, `BDATE`, `Gender`, `Email`) VALUES (162, 'Omar', 'Mohamed', '2 Al Kanal Maadi Cairo', '01574823169', '2014-03-21', 'M', 'OmarMohamed112@hotmail.com');
INSERT INTO `Club_DB`.`Person` (`SSN`, `FName`, `LName`, `Address`, `Phone`, `BDATE`, `Gender`, `Email`) VALUES (163, 'Seif', 'Sobhi', '16 Damascus Maadi Cairo', '01562987543', '1962-03-15', 'M', 'SeifSobhi37@gmail.com');
INSERT INTO `Club_DB`.`Person` (`SSN`, `FName`, `LName`, `Address`, `Phone`, `BDATE`, `Gender`, `Email`) VALUES (164, 'Abdelrahman', 'Emad', '40 Rod El Farag Shobra Cairo', '01525678039', '1994-03-18', 'M', 'AbdelrahmanEmad229@hotmail.com');
INSERT INTO `Club_DB`.`Person` (`SSN`, `FName`, `LName`, `Address`, `Phone`, `BDATE`, `Gender`, `Email`) VALUES (165, 'Mohamed', 'Adel', '66 Champeleon Downtown Cairo', '01167398041', '2006-07-06', 'M', 'MohamedAdel124@outlook.com');
INSERT INTO `Club_DB`.`Person` (`SSN`, `FName`, `LName`, `Address`, `Phone`, `BDATE`, `Gender`, `Email`) VALUES (166, 'Nour', 'Magdy', '74 28St. El-Tahrir City Imbaba Giza', '01262089317', '1984-07-16', 'F', 'NourMagdy91@outlook.com');
INSERT INTO `Club_DB`.`Person` (`SSN`, `FName`, `LName`, `Address`, `Phone`, `BDATE`, `Gender`, `Email`) VALUES (167, 'Amir', 'Khaled', '75 Talaat Harb Imbaba Giza', '01226837915', '2008-02-07', 'M', 'AmirKhaled255@outlook.com');
INSERT INTO `Club_DB`.`Person` (`SSN`, `FName`, `LName`, `Address`, `Phone`, `BDATE`, `Gender`, `Email`) VALUES (168, 'Ibrahim', 'Sayed', '59 Al Kanal Maadi Cairo', '01507286319', '1990-08-18', 'M', 'IbrahimSayed170@hotmail.com');
INSERT INTO `Club_DB`.`Person` (`SSN`, `FName`, `LName`, `Address`, `Phone`, `BDATE`, `Gender`, `Email`) VALUES (169, 'Rahma', 'Sayed', '98 Al Ahram Helipolis Cairo', '01030862971', '1967-09-25', 'F', 'RahmaSayed139@outlook.com');
INSERT INTO `Club_DB`.`Person` (`SSN`, `FName`, `LName`, `Address`, `Phone`, `BDATE`, `Gender`, `Email`) VALUES (170, 'Abdalaziz', 'Khaled', '21 Al Nozha Helipolis Cairo', '01005687193', '1960-02-20', 'M', 'AbdalazizKhaled86@hotmail.com');
INSERT INTO `Club_DB`.`Person` (`SSN`, `FName`, `LName`, `Address`, `Phone`, `BDATE`, `Gender`, `Email`) VALUES (171, 'Rashad', 'Khalil', '28 Sherif Downtown Cairo', '01274189035', '2014-11-01', 'M', 'RashadKhalil63@outlook.com');
INSERT INTO `Club_DB`.`Person` (`SSN`, `FName`, `LName`, `Address`, `Phone`, `BDATE`, `Gender`, `Email`) VALUES (172, 'Nourhan', 'Khalil', '10 18St. El-Tahrir City Imbaba Giza', '01150673294', '1994-10-15', 'F', 'NourhanKhalil252@hotmail.com');
INSERT INTO `Club_DB`.`Person` (`SSN`, `FName`, `LName`, `Address`, `Phone`, `BDATE`, `Gender`, `Email`) VALUES (173, 'Nour', 'Fawzi', '46 Talaat Harb Imbaba Giza', '01520567489', '1965-10-20', 'F', 'NourFawzi136@hotmail.com');
INSERT INTO `Club_DB`.`Person` (`SSN`, `FName`, `LName`, `Address`, `Phone`, `BDATE`, `Gender`, `Email`) VALUES (174, 'Wael', 'Sobhi', '53 El Sadat Al-Salam Cairo', '01091048573', '2005-03-17', 'M', 'WaelSobhi221@gmail.com');
INSERT INTO `Club_DB`.`Person` (`SSN`, `FName`, `LName`, `Address`, `Phone`, `BDATE`, `Gender`, `Email`) VALUES (175, 'Mohamed', 'Fawzi', '51 Baghdad Helipolis Cairo', '01565089127', '1987-07-23', 'M', 'MohamedFawzi314@gmail.com');
INSERT INTO `Club_DB`.`Person` (`SSN`, `FName`, `LName`, `Address`, `Phone`, `BDATE`, `Gender`, `Email`) VALUES (176, 'Zeyad', 'Salah', '58 Al Nadi Maadi Cairo', '01051496320', '1998-06-24', 'M', 'ZeyadSalah281@hotmail.com');
INSERT INTO `Club_DB`.`Person` (`SSN`, `FName`, `LName`, `Address`, `Phone`, `BDATE`, `Gender`, `Email`) VALUES (177, 'Kareem', 'Hani', '15 Taha Hussein Zamalek Cairo', '01284965327', '2012-08-05', 'M', 'KareemHani300@outlook.com');
INSERT INTO `Club_DB`.`Person` (`SSN`, `FName`, `LName`, `Address`, `Phone`, `BDATE`, `Gender`, `Email`) VALUES (178, 'Mohamed', 'Sobhi', '25 Shaheen Al Doqi Giza', '01282637094', '1974-11-22', 'M', 'MohamedSobhi12@hotmail.com');
INSERT INTO `Club_DB`.`Person` (`SSN`, `FName`, `LName`, `Address`, `Phone`, `BDATE`, `Gender`, `Email`) VALUES (179, 'Rashad', 'Adel', '9 Al Kanal Maadi Cairo', '01558036217', '1970-12-23', 'M', 'RashadAdel408@hotmail.com');
INSERT INTO `Club_DB`.`Person` (`SSN`, `FName`, `LName`, `Address`, `Phone`, `BDATE`, `Gender`, `Email`) VALUES (180, 'Esraa', 'Fawzi', '21 Sherif Downtown Cairo', '01264837125', '1984-03-21', 'F', 'EsraaFawzi262@outlook.com');
INSERT INTO `Club_DB`.`Person` (`SSN`, `FName`, `LName`, `Address`, `Phone`, `BDATE`, `Gender`, `Email`) VALUES (181, 'Haytham', 'Sobhi', '54 El Sadat Al-Salam Cairo', '01201849725', '1998-12-03', 'M', 'HaythamSobhi312@outlook.com');
INSERT INTO `Club_DB`.`Person` (`SSN`, `FName`, `LName`, `Address`, `Phone`, `BDATE`, `Gender`, `Email`) VALUES (182, 'Mostafa', 'Ashraf', '95 Sherif Downtown Cairo', '01279648150', '1971-10-14', 'M', 'MostafaAshraf124@outlook.com');
INSERT INTO `Club_DB`.`Person` (`SSN`, `FName`, `LName`, `Address`, `Phone`, `BDATE`, `Gender`, `Email`) VALUES (183, 'Salma', 'Khaled', '45 kamal Al Tawil Zamalek Cairo', '01051970826', '1972-06-28', 'F', 'SalmaKhaled115@outlook.com');
INSERT INTO `Club_DB`.`Person` (`SSN`, `FName`, `LName`, `Address`, `Phone`, `BDATE`, `Gender`, `Email`) VALUES (184, 'Hager', 'Zakaria', '26 18St. El-Tahrir City Imbaba Giza', '01519524860', '1976-01-19', 'F', 'HagerZakaria51@hotmail.com');
INSERT INTO `Club_DB`.`Person` (`SSN`, `FName`, `LName`, `Address`, `Phone`, `BDATE`, `Gender`, `Email`) VALUES (185, 'Omnya', 'Sobhi', '8 Baghdad Helipolis Cairo', '01062473519', '1992-12-16', 'F', 'OmnyaSobhi354@gmail.com');
INSERT INTO `Club_DB`.`Person` (`SSN`, `FName`, `LName`, `Address`, `Phone`, `BDATE`, `Gender`, `Email`) VALUES (186, 'Omnya', 'Mohamed', '49 Mamdouh Salem Imbaba Giza', '01128701463', '1961-11-28', 'F', 'OmnyaMohamed250@hotmail.com');
INSERT INTO `Club_DB`.`Person` (`SSN`, `FName`, `LName`, `Address`, `Phone`, `BDATE`, `Gender`, `Email`) VALUES (187, 'Arwa', 'Magdy', '55 Taha Hussein Zamalek Cairo', '01505413692', '1972-08-14', 'F', 'ArwaMagdy377@outlook.com');
INSERT INTO `Club_DB`.`Person` (`SSN`, `FName`, `LName`, `Address`, `Phone`, `BDATE`, `Gender`, `Email`) VALUES (188, 'Hager', 'Zakaria', '16 Al Falaky Downtown Cairo', '01028304759', '1971-04-02', 'F', 'HagerZakaria247@outlook.com');
INSERT INTO `Club_DB`.`Person` (`SSN`, `FName`, `LName`, `Address`, `Phone`, `BDATE`, `Gender`, `Email`) VALUES (189, 'Ibrahim', 'Sayed', '59 Shaheen Al Doqi Giza', '01049530687', '1987-09-05', 'M', 'IbrahimSayed224@gmail.com');
INSERT INTO `Club_DB`.`Person` (`SSN`, `FName`, `LName`, `Address`, `Phone`, `BDATE`, `Gender`, `Email`) VALUES (190, 'Ehab', 'Sobhi', '98 Damascus Maadi Cairo', '01575809412', '2016-01-11', 'M', 'EhabSobhi147@gmail.com');
INSERT INTO `Club_DB`.`Person` (`SSN`, `FName`, `LName`, `Address`, `Phone`, `BDATE`, `Gender`, `Email`) VALUES (191, 'Hager', 'Ashraf', '53 El Sadat Al-Salam Cairo', '01075942160', '1963-11-25', 'F', 'HagerAshraf81@hotmail.com');
INSERT INTO `Club_DB`.`Person` (`SSN`, `FName`, `LName`, `Address`, `Phone`, `BDATE`, `Gender`, `Email`) VALUES (192, 'Amal', 'Sobhi', '91 Shaheen Al Doqi Giza', '01140913857', '2004-11-17', 'F', 'AmalSobhi25@outlook.com');
INSERT INTO `Club_DB`.`Person` (`SSN`, `FName`, `LName`, `Address`, `Phone`, `BDATE`, `Gender`, `Email`) VALUES (193, 'Omnya', 'Yaser', '62 Shaheen Al Doqi Giza', '01072485316', '1990-04-14', 'F', 'OmnyaYaser417@hotmail.com');
INSERT INTO `Club_DB`.`Person` (`SSN`, `FName`, `LName`, `Address`, `Phone`, `BDATE`, `Gender`, `Email`) VALUES (194, 'Eyad', 'Ashraf', '61 El Sadat Al-Salam Cairo', '01038749206', '1978-11-25', 'M', 'EyadAshraf326@gmail.com');
INSERT INTO `Club_DB`.`Person` (`SSN`, `FName`, `LName`, `Address`, `Phone`, `BDATE`, `Gender`, `Email`) VALUES (195, 'Mohamed', 'Khalil', '94 Al Khamrawaya Shobra Cairo', '01038945620', '1975-06-24', 'M', 'MohamedKhalil127@hotmail.com');
INSERT INTO `Club_DB`.`Person` (`SSN`, `FName`, `LName`, `Address`, `Phone`, `BDATE`, `Gender`, `Email`) VALUES (196, 'Rashad', 'Ashraf', '92 Shobra St. Shobra Cairo', '01535921486', '2002-04-16', 'M', 'RashadAshraf130@outlook.com');
INSERT INTO `Club_DB`.`Person` (`SSN`, `FName`, `LName`, `Address`, `Phone`, `BDATE`, `Gender`, `Email`) VALUES (197, 'Adham', 'Yaser', '38 Ahmed Helmy Shobra Cairo', '01003564179', '1977-04-13', 'M', 'AdhamYaser103@hotmail.com');
INSERT INTO `Club_DB`.`Person` (`SSN`, `FName`, `LName`, `Address`, `Phone`, `BDATE`, `Gender`, `Email`) VALUES (198, 'Esraa', 'Mohamed', '57 Shaheen Al Doqi Giza', '01039857462', '1970-06-22', 'F', 'EsraaMohamed4@outlook.com');
INSERT INTO `Club_DB`.`Person` (`SSN`, `FName`, `LName`, `Address`, `Phone`, `BDATE`, `Gender`, `Email`) VALUES (199, 'Noureen', 'Farag', '21 Shaheen Al Doqi Giza', '01546937018', '1976-07-16', 'F', 'NoureenFarag178@hotmail.com');
INSERT INTO `Club_DB`.`Person` (`SSN`, `FName`, `LName`, `Address`, `Phone`, `BDATE`, `Gender`, `Email`) VALUES (200, 'Nour', 'Magdy', '51 Baghdad Helipolis Cairo', '01559243876', '1970-04-11', 'F', 'NourMagdy25@outlook.com');
INSERT INTO `Club_DB`.`Person` (`SSN`, `FName`, `LName`, `Address`, `Phone`, `BDATE`, `Gender`, `Email`) VALUES (201, 'Amal', 'Salah', '62 Talaat Harb Downtown Cairo', '01109418362', '1996-02-03', 'F', 'AmalSalah222@hotmail.com');
INSERT INTO `Club_DB`.`Person` (`SSN`, `FName`, `LName`, `Address`, `Phone`, `BDATE`, `Gender`, `Email`) VALUES (202, 'Amir', 'Magdy', '14 Gamal Abdel Nasser Al-Salam Cairo', '01086172493', '1996-06-27', 'M', 'AmirMagdy132@outlook.com');
INSERT INTO `Club_DB`.`Person` (`SSN`, `FName`, `LName`, `Address`, `Phone`, `BDATE`, `Gender`, `Email`) VALUES (203, 'Kareem', 'Emad', '27 9 St. Maadi Cairo', '01595728604', '1997-02-10', 'M', 'KareemEmad161@gmail.com');
INSERT INTO `Club_DB`.`Person` (`SSN`, `FName`, `LName`, `Address`, `Phone`, `BDATE`, `Gender`, `Email`) VALUES (204, 'Esraa', 'Salah', '50 Adly Downtown Cairo', '01062398750', '1997-08-13', 'F', 'EsraaSalah285@gmail.com');
INSERT INTO `Club_DB`.`Person` (`SSN`, `FName`, `LName`, `Address`, `Phone`, `BDATE`, `Gender`, `Email`) VALUES (205, 'Sherif', 'Salah', '59 Champeleon Downtown Cairo', '01295410236', '1995-05-08', 'M', 'SherifSalah197@gmail.com');
INSERT INTO `Club_DB`.`Person` (`SSN`, `FName`, `LName`, `Address`, `Phone`, `BDATE`, `Gender`, `Email`) VALUES (206, 'Amani', 'Salah', '17 Gamal Abdel Nasser Al-Salam Cairo', '01151963780', '1997-07-28', 'F', 'AmaniSalah288@outlook.com');
INSERT INTO `Club_DB`.`Person` (`SSN`, `FName`, `LName`, `Address`, `Phone`, `BDATE`, `Gender`, `Email`) VALUES (207, 'Mahmoud', 'Fawzi', '60 Al Nahda Maadi Cairo', '01213724580', '1995-05-09', 'M', 'MahmoudFawzi330@outlook.com');
INSERT INTO `Club_DB`.`Person` (`SSN`, `FName`, `LName`, `Address`, `Phone`, `BDATE`, `Gender`, `Email`) VALUES (208, 'Rashad', 'Ezzat', '34 28St. El-Tahrir City Imbaba Giza', '01549612573', '1997-09-16', 'M', 'RashadEzzat155@gmail.com');
INSERT INTO `Club_DB`.`Person` (`SSN`, `FName`, `LName`, `Address`, `Phone`, `BDATE`, `Gender`, `Email`) VALUES (209, 'Shahd', 'Khalil', '11 Al Teraa Al Boulakeya Shobra Cairo', '01049752831', '2003-09-14', 'F', 'ShahdKhalil59@outlook.com');
INSERT INTO `Club_DB`.`Person` (`SSN`, `FName`, `LName`, `Address`, `Phone`, `BDATE`, `Gender`, `Email`) VALUES (210, 'Nada', 'Adel', '88 Hassan Assem Zamalek Cairo', '01106431728', '2000-04-22', 'F', 'NadaAdel15@gmail.com');
INSERT INTO `Club_DB`.`Person` (`SSN`, `FName`, `LName`, `Address`, `Phone`, `BDATE`, `Gender`, `Email`) VALUES (211, 'Salma', 'Fawzi', '80 Al Saad Al Aaly Maadi Cairo', '01520746385', '1995-04-20', 'F', 'SalmaFawzi251@outlook.com');
INSERT INTO `Club_DB`.`Person` (`SSN`, `FName`, `LName`, `Address`, `Phone`, `BDATE`, `Gender`, `Email`) VALUES (212, 'Nour', 'Hani', '22 Gamal Abdel Nasser Al-Salam Cairo', '01563594827', '1995-02-03', 'F', 'NourHani284@gmail.com');
INSERT INTO `Club_DB`.`Person` (`SSN`, `FName`, `LName`, `Address`, `Phone`, `BDATE`, `Gender`, `Email`) VALUES (213, 'Sherif', 'Magdy', '28 Doletyan Shobra Cairo', '01598065173', '2003-08-18', 'M', 'SherifMagdy85@outlook.com');
INSERT INTO `Club_DB`.`Person` (`SSN`, `FName`, `LName`, `Address`, `Phone`, `BDATE`, `Gender`, `Email`) VALUES (214, 'Hager', 'Waleed', '35 Baghdad Helipolis Cairo', '01090283674', '2002-04-19', 'F', 'HagerWaleed267@outlook.com');
INSERT INTO `Club_DB`.`Person` (`SSN`, `FName`, `LName`, `Address`, `Phone`, `BDATE`, `Gender`, `Email`) VALUES (215, 'Rashad', 'Magdy', '49 15 May Shobra Cairo', '01095103278', '1999-07-07', 'M', 'RashadMagdy382@outlook.com');
INSERT INTO `Club_DB`.`Person` (`SSN`, `FName`, `LName`, `Address`, `Phone`, `BDATE`, `Gender`, `Email`) VALUES (216, 'Mariam', 'Nader', '18 El Sadat Al-Salam Cairo', '01514386972', '1996-02-23', 'F', 'MariamNader348@hotmail.com');
INSERT INTO `Club_DB`.`Person` (`SSN`, `FName`, `LName`, `Address`, `Phone`, `BDATE`, `Gender`, `Email`) VALUES (217, 'Kareem', 'Emad', '86 Gamal Abdel Nasser Al-Salam Cairo', '01252891067', '2003-08-12', 'M', 'KareemEmad191@hotmail.com');
INSERT INTO `Club_DB`.`Person` (`SSN`, `FName`, `LName`, `Address`, `Phone`, `BDATE`, `Gender`, `Email`) VALUES (218, 'Abdallah', 'Khalil', '25 151 St. Maadi Cairo', '01201523849', '1998-09-14', 'M', 'AbdallahKhalil132@hotmail.com');
INSERT INTO `Club_DB`.`Person` (`SSN`, `FName`, `LName`, `Address`, `Phone`, `BDATE`, `Gender`, `Email`) VALUES (219, 'Ali', 'Sayed', '75 Al Nahda Maadi Cairo', '01272385941', '2000-08-12', 'M', 'AliSayed108@outlook.com');
INSERT INTO `Club_DB`.`Person` (`SSN`, `FName`, `LName`, `Address`, `Phone`, `BDATE`, `Gender`, `Email`) VALUES (220, 'Ali', 'Khalil', '64 Gad Eid Al Doqi Giza', '01576450928', '1999-11-18', 'M', 'AliKhalil296@outlook.com');
INSERT INTO `Club_DB`.`Person` (`SSN`, `FName`, `LName`, `Address`, `Phone`, `BDATE`, `Gender`, `Email`) VALUES (221, 'Hana', 'Ghanim', '93 26 July St Downtown Cairo', '01115743082', '1996-06-13', 'F', 'HanaGhanim305@gmail.com');
INSERT INTO `Club_DB`.`Person` (`SSN`, `FName`, `LName`, `Address`, `Phone`, `BDATE`, `Gender`, `Email`) VALUES (222, 'Nourhan', 'Ghanim', '5 Hassan Ramadan Al Doqi Giza', '01128395706', '1995-01-01', 'F', 'NourhanGhanim51@gmail.com');
INSERT INTO `Club_DB`.`Person` (`SSN`, `FName`, `LName`, `Address`, `Phone`, `BDATE`, `Gender`, `Email`) VALUES (223, 'Noureen', 'Khalil', '9 Al Saad Al Aaly Maadi Cairo', '01294537810', '2001-09-14', 'F', 'NoureenKhalil272@outlook.com');
INSERT INTO `Club_DB`.`Person` (`SSN`, `FName`, `LName`, `Address`, `Phone`, `BDATE`, `Gender`, `Email`) VALUES (224, 'Sherif', 'Khaled', '11 18St. El-Tahrir City Imbaba Giza', '01180476219', '2001-06-25', 'M', 'SherifKhaled299@outlook.com');
INSERT INTO `Club_DB`.`Person` (`SSN`, `FName`, `LName`, `Address`, `Phone`, `BDATE`, `Gender`, `Email`) VALUES (225, 'Aya', 'Salah', '41 Al Kanal Maadi Cairo', '01518049325', '2001-05-07', 'F', 'AyaSalah188@gmail.com');
INSERT INTO `Club_DB`.`Person` (`SSN`, `FName`, `LName`, `Address`, `Phone`, `BDATE`, `Gender`, `Email`) VALUES (226, 'Rashad', 'Sayed', '52 El Sadat Al-Salam Cairo', '01280365974', '2000-03-28', 'M', 'RashadSayed296@outlook.com');
INSERT INTO `Club_DB`.`Person` (`SSN`, `FName`, `LName`, `Address`, `Phone`, `BDATE`, `Gender`, `Email`) VALUES (227, 'Ehab', 'Zakaria', '10 Al Hegaz Helipolis Cairo', '01167935201', '1994-06-19', 'M', 'EhabZakaria117@outlook.com');
INSERT INTO `Club_DB`.`Person` (`SSN`, `FName`, `LName`, `Address`, `Phone`, `BDATE`, `Gender`, `Email`) VALUES (228, 'Mahmoud', 'Ashraf', '52 Damascus Maadi Cairo', '01116457098', '1998-08-14', 'M', 'MahmoudAshraf371@hotmail.com');
INSERT INTO `Club_DB`.`Person` (`SSN`, `FName`, `LName`, `Address`, `Phone`, `BDATE`, `Gender`, `Email`) VALUES (229, 'Yara', 'Fawzi', '29 Hassan Sabry Zamalek Cairo', '01130761489', '2003-12-20', 'F', 'YaraFawzi112@gmail.com');
INSERT INTO `Club_DB`.`Person` (`SSN`, `FName`, `LName`, `Address`, `Phone`, `BDATE`, `Gender`, `Email`) VALUES (230, 'Ahmed', 'Zakaria', '6 Al Nozha Helipolis Cairo', '01508436179', '1997-11-03', 'M', 'AhmedZakaria306@gmail.com');
INSERT INTO `Club_DB`.`Person` (`SSN`, `FName`, `LName`, `Address`, `Phone`, `BDATE`, `Gender`, `Email`) VALUES (231, 'Esraa', 'Hani', '14 Gamal Abdel Nasser Al-Salam Cairo', '01594281065', '2000-04-03', 'F', 'EsraaHani75@gmail.com');
INSERT INTO `Club_DB`.`Person` (`SSN`, `FName`, `LName`, `Address`, `Phone`, `BDATE`, `Gender`, `Email`) VALUES (232, 'Rashad', 'Khaled', '13 El Tahrir Downtown Cairo', '01002187936', '2001-04-13', 'M', 'RashadKhaled249@gmail.com');
INSERT INTO `Club_DB`.`Person` (`SSN`, `FName`, `LName`, `Address`, `Phone`, `BDATE`, `Gender`, `Email`) VALUES (233, 'Hager', 'Ezzat', '98 Shobra St. Shobra Cairo', '01028390457', '1996-11-16', 'F', 'HagerEzzat415@outlook.com');
INSERT INTO `Club_DB`.`Person` (`SSN`, `FName`, `LName`, `Address`, `Phone`, `BDATE`, `Gender`, `Email`) VALUES (234, 'Mahmoud', 'Emad', '58 Al Nadi Maadi Cairo', '01291287054', '2001-10-08', 'M', 'MahmoudEmad87@hotmail.com');
INSERT INTO `Club_DB`.`Person` (`SSN`, `FName`, `LName`, `Address`, `Phone`, `BDATE`, `Gender`, `Email`) VALUES (235, 'Esraa', 'Yaser', '18 Shagaret Al Dor Zamalek Cairo', '01575491368', '1997-03-08', 'F', 'EsraaYaser183@gmail.com');
INSERT INTO `Club_DB`.`Person` (`SSN`, `FName`, `LName`, `Address`, `Phone`, `BDATE`, `Gender`, `Email`) VALUES (236, 'Toaa', 'Magdy', '8 Gad Eid Al Doqi Giza', '01202786315', '1994-08-06', 'F', 'ToaaMagdy346@hotmail.com');
INSERT INTO `Club_DB`.`Person` (`SSN`, `FName`, `LName`, `Address`, `Phone`, `BDATE`, `Gender`, `Email`) VALUES (237, 'Zeyad', 'Emad', '36 Doletyan Shobra Cairo', '01592134867', '1998-11-15', 'M', 'ZeyadEmad102@hotmail.com');
INSERT INTO `Club_DB`.`Person` (`SSN`, `FName`, `LName`, `Address`, `Phone`, `BDATE`, `Gender`, `Email`) VALUES (238, 'Amr', 'Khaled', '7 Talaat Harb Imbaba Giza', '01572619508', '2003-06-08', 'M', 'AmrKhaled53@gmail.com');
INSERT INTO `Club_DB`.`Person` (`SSN`, `FName`, `LName`, `Address`, `Phone`, `BDATE`, `Gender`, `Email`) VALUES (239, 'Toaa', 'Sayed', '59 Adly Downtown Cairo', '01510956782', '1999-12-03', 'F', 'ToaaSayed280@hotmail.com');
INSERT INTO `Club_DB`.`Person` (`SSN`, `FName`, `LName`, `Address`, `Phone`, `BDATE`, `Gender`, `Email`) VALUES (240, 'Esraa', 'Nader', '55 Bahgat Ali Zamalek Cairo', '01149208536', '1996-01-28', 'F', 'EsraaNader270@outlook.com');
INSERT INTO `Club_DB`.`Person` (`SSN`, `FName`, `LName`, `Address`, `Phone`, `BDATE`, `Gender`, `Email`) VALUES (241, 'Abdelrahman', 'Khaled', '95 Sherif Downtown Cairo', '01007524813', '1996-03-17', 'M', 'AbdelrahmanKhaled274@gmail.com');
INSERT INTO `Club_DB`.`Person` (`SSN`, `FName`, `LName`, `Address`, `Phone`, `BDATE`, `Gender`, `Email`) VALUES (242, 'Sherif', 'Adel', '41 Oraby Maadi Cairo', '01153026147', '1995-11-04', 'M', 'SherifAdel335@outlook.com');
INSERT INTO `Club_DB`.`Person` (`SSN`, `FName`, `LName`, `Address`, `Phone`, `BDATE`, `Gender`, `Email`) VALUES (243, 'Mariam', 'Hassan', '90 Al Ahram Helipolis Cairo', '01056734902', '2003-06-20', 'F', 'MariamHassan390@outlook.com');
INSERT INTO `Club_DB`.`Person` (`SSN`, `FName`, `LName`, `Address`, `Phone`, `BDATE`, `Gender`, `Email`) VALUES (244, 'Nour', 'Ezzat', '42 Hassan Sabry Zamalek Cairo', '01284013697', '1995-12-16', 'F', 'NourEzzat256@outlook.com');
INSERT INTO `Club_DB`.`Person` (`SSN`, `FName`, `LName`, `Address`, `Phone`, `BDATE`, `Gender`, `Email`) VALUES (245, 'Eman', 'Magdy', '18 Champeleon Downtown Cairo', '01591865047', '2000-02-14', 'F', 'EmanMagdy285@hotmail.com');
INSERT INTO `Club_DB`.`Person` (`SSN`, `FName`, `LName`, `Address`, `Phone`, `BDATE`, `Gender`, `Email`) VALUES (246, 'Nourhan', 'Hani', '83 Al Merghany Heliopolis Cairo', '01087016529', '1998-08-18', 'F', 'NourhanHani25@outlook.com');
INSERT INTO `Club_DB`.`Person` (`SSN`, `FName`, `LName`, `Address`, `Phone`, `BDATE`, `Gender`, `Email`) VALUES (247, 'Mohamed', 'Waleed', '97 Gad Eid Al Doqi Giza', '01025781630', '1996-01-10', 'M', 'MohamedWaleed129@hotmail.com');
INSERT INTO `Club_DB`.`Person` (`SSN`, `FName`, `LName`, `Address`, `Phone`, `BDATE`, `Gender`, `Email`) VALUES (248, 'Shahd', 'Sobhi', '35 Champeleon Downtown Cairo', '01043501928', '2000-04-12', 'F', 'ShahdSobhi253@hotmail.com');
INSERT INTO `Club_DB`.`Person` (`SSN`, `FName`, `LName`, `Address`, `Phone`, `BDATE`, `Gender`, `Email`) VALUES (249, 'Mahmoud', 'Fawzi', '82 Gad Eid Al Doqi Giza', '01238540619', '2002-11-22', 'M', 'MahmoudFawzi17@hotmail.com');
INSERT INTO `Club_DB`.`Person` (`SSN`, `FName`, `LName`, `Address`, `Phone`, `BDATE`, `Gender`, `Email`) VALUES (250, 'Marawan', 'Khaled', '14 kamal Al Tawil Zamalek Cairo', '01028369701', '1996-01-08', 'M', 'MarawanKhaled42@hotmail.com');
INSERT INTO `Club_DB`.`Person` (`SSN`, `FName`, `LName`, `Address`, `Phone`, `BDATE`, `Gender`, `Email`) VALUES (251, 'Mostafa', 'Sayed', '84 Baghdad Helipolis Cairo', '01527196345', '2000-08-11', 'M', 'MostafaSayed352@outlook.com');
INSERT INTO `Club_DB`.`Person` (`SSN`, `FName`, `LName`, `Address`, `Phone`, `BDATE`, `Gender`, `Email`) VALUES (252, 'Rashad', 'Sayed', '100 Al Teraa Al Boulakeya Shobra Cairo', '01268720951', '2001-10-11', 'M', 'RashadSayed129@hotmail.com');
INSERT INTO `Club_DB`.`Person` (`SSN`, `FName`, `LName`, `Address`, `Phone`, `BDATE`, `Gender`, `Email`) VALUES (253, 'Mohamed', 'Hani', '28 9 St. Maadi Cairo', '01249702683', '1995-11-27', 'M', 'MohamedHani241@outlook.com');
INSERT INTO `Club_DB`.`Person` (`SSN`, `FName`, `LName`, `Address`, `Phone`, `BDATE`, `Gender`, `Email`) VALUES (254, 'Ali', 'Farag', '88 15 May Shobra Cairo', '01579451236', '2001-07-14', 'M', 'AliFarag372@hotmail.com');
INSERT INTO `Club_DB`.`Person` (`SSN`, `FName`, `LName`, `Address`, `Phone`, `BDATE`, `Gender`, `Email`) VALUES (255, 'Aya', 'Salah', '26 Gad Eid Al Doqi Giza', '01109348625', '1997-10-04', 'F', 'AyaSalah92@hotmail.com');
INSERT INTO `Club_DB`.`Person` (`SSN`, `FName`, `LName`, `Address`, `Phone`, `BDATE`, `Gender`, `Email`) VALUES (256, 'Ali', 'Mohamed', '29 Mamdouh Salem Imbaba Giza', '01538967540', '1995-01-25', 'M', 'AliMohamed163@gmail.com');
INSERT INTO `Club_DB`.`Person` (`SSN`, `FName`, `LName`, `Address`, `Phone`, `BDATE`, `Gender`, `Email`) VALUES (257, 'Abdalaziz', 'Ezzat', '78 Baghdad Helipolis Cairo', '01185710924', '1998-08-21', 'M', 'AbdalazizEzzat71@hotmail.com');
INSERT INTO `Club_DB`.`Person` (`SSN`, `FName`, `LName`, `Address`, `Phone`, `BDATE`, `Gender`, `Email`) VALUES (258, 'Haytham', 'Nader', '33 18St. El-Tahrir City Imbaba Giza', '01217896502', '1999-02-28', 'M', 'HaythamNader294@gmail.com');
INSERT INTO `Club_DB`.`Person` (`SSN`, `FName`, `LName`, `Address`, `Phone`, `BDATE`, `Gender`, `Email`) VALUES (259, 'Mostafa', 'Sayed', '86 Al Merghany Heliopolis Cairo', '01023904786', '1997-09-18', 'M', 'MostafaSayed145@outlook.com');
INSERT INTO `Club_DB`.`Person` (`SSN`, `FName`, `LName`, `Address`, `Phone`, `BDATE`, `Gender`, `Email`) VALUES (260, 'Amani', 'Hassan', '84 Al Nadi Maadi Cairo', '01254670398', '1994-01-09', 'F', 'AmaniHassan177@gmail.com');
INSERT INTO `Club_DB`.`Person` (`SSN`, `FName`, `LName`, `Address`, `Phone`, `BDATE`, `Gender`, `Email`) VALUES (261, 'Mahmoud', 'Ashraf', '65 Shaheen Al Doqi Giza', '01280927364', '1997-07-18', 'M', 'MahmoudAshraf65@outlook.com');
INSERT INTO `Club_DB`.`Person` (`SSN`, `FName`, `LName`, `Address`, `Phone`, `BDATE`, `Gender`, `Email`) VALUES (262, 'Ibrahim', 'Ashraf', '13 Shobra St. Shobra Cairo', '01297483512', '2003-12-16', 'M', 'IbrahimAshraf141@hotmail.com');
INSERT INTO `Club_DB`.`Person` (`SSN`, `FName`, `LName`, `Address`, `Phone`, `BDATE`, `Gender`, `Email`) VALUES (263, 'Amal', 'Ashraf', '90 Doletyan Shobra Cairo', '01102597134', '1994-08-20', 'F', 'AmalAshraf113@outlook.com');
INSERT INTO `Club_DB`.`Person` (`SSN`, `FName`, `LName`, `Address`, `Phone`, `BDATE`, `Gender`, `Email`) VALUES (264, 'Aya', 'Hassan', '98 Gamal Abdel Nasser Al-Salam Cairo', '01562597381', '2002-02-28', 'F', 'AyaHassan156@outlook.com');
INSERT INTO `Club_DB`.`Person` (`SSN`, `FName`, `LName`, `Address`, `Phone`, `BDATE`, `Gender`, `Email`) VALUES (265, 'Hager', 'Emad', '100 Hassan Ramadan Al Doqi Giza', '01292716043', '1999-04-01', 'F', 'HagerEmad313@gmail.com');
INSERT INTO `Club_DB`.`Person` (`SSN`, `FName`, `LName`, `Address`, `Phone`, `BDATE`, `Gender`, `Email`) VALUES (266, 'Eyad', 'Khalil', '64 Gamal Abdel Nasser Al-Salam Cairo', '01094561237', '1994-01-20', 'M', 'EyadKhalil381@gmail.com');
INSERT INTO `Club_DB`.`Person` (`SSN`, `FName`, `LName`, `Address`, `Phone`, `BDATE`, `Gender`, `Email`) VALUES (267, 'Amani', 'Emad', '82 Hassan Assem Zamalek Cairo', '01043097162', '1997-03-28', 'F', 'AmaniEmad152@outlook.com');
INSERT INTO `Club_DB`.`Person` (`SSN`, `FName`, `LName`, `Address`, `Phone`, `BDATE`, `Gender`, `Email`) VALUES (268, 'Rahma', 'Adel', '97 Hassan Ramadan Al Doqi Giza', '01280742519', '2004-06-07', 'F', 'RahmaAdel238@hotmail.com');
INSERT INTO `Club_DB`.`Person` (`SSN`, `FName`, `LName`, `Address`, `Phone`, `BDATE`, `Gender`, `Email`) VALUES (269, 'Mostafa', 'Ezzat', '62 Adly Downtown Cairo', '01513864759', '2007-02-08', 'M', 'MostafaEzzat112@outlook.com');
INSERT INTO `Club_DB`.`Person` (`SSN`, `FName`, `LName`, `Address`, `Phone`, `BDATE`, `Gender`, `Email`) VALUES (270, 'Marawan', 'Hassan', '52 Gamal Abdel Nasser Al-Salam Cairo', '01162340985', '2003-12-01', 'M', 'MarawanHassan182@outlook.com');
INSERT INTO `Club_DB`.`Person` (`SSN`, `FName`, `LName`, `Address`, `Phone`, `BDATE`, `Gender`, `Email`) VALUES (271, 'Yasmin', 'Ezzat', '28 Al Khamrawaya Shobra Cairo', '01262098457', '2007-08-28', 'F', 'YasminEzzat237@gmail.com');
INSERT INTO `Club_DB`.`Person` (`SSN`, `FName`, `LName`, `Address`, `Phone`, `BDATE`, `Gender`, `Email`) VALUES (272, 'Nada', 'Ashraf', '100 Gamal Abdel Nasser Al-Salam Cairo', '01551286930', '2006-12-10', 'F', 'NadaAshraf234@gmail.com');
INSERT INTO `Club_DB`.`Person` (`SSN`, `FName`, `LName`, `Address`, `Phone`, `BDATE`, `Gender`, `Email`) VALUES (273, 'Seif', 'Emad', '34 15 May Shobra Cairo', '01227196053', '2008-03-17', 'M', 'SeifEmad359@hotmail.com');
INSERT INTO `Club_DB`.`Person` (`SSN`, `FName`, `LName`, `Address`, `Phone`, `BDATE`, `Gender`, `Email`) VALUES (274, 'Marawan', 'Khaled', '42 Al Merghany Heliopolis Cairo', '01290152643', '2003-08-23', 'M', 'MarawanKhaled116@gmail.com');
INSERT INTO `Club_DB`.`Person` (`SSN`, `FName`, `LName`, `Address`, `Phone`, `BDATE`, `Gender`, `Email`) VALUES (275, 'Marawan', 'Nader', '62 Hassan Ramadan Al Doqi Giza', '01115603792', '2005-10-20', 'M', 'MarawanNader269@outlook.com');
INSERT INTO `Club_DB`.`Person` (`SSN`, `FName`, `LName`, `Address`, `Phone`, `BDATE`, `Gender`, `Email`) VALUES (276, 'Noureen', 'Magdy', '26 Shagaret Al Dor Zamalek Cairo', '01008216435', '2004-09-12', 'F', 'NoureenMagdy255@hotmail.com');
INSERT INTO `Club_DB`.`Person` (`SSN`, `FName`, `LName`, `Address`, `Phone`, `BDATE`, `Gender`, `Email`) VALUES (277, 'Yara', 'Adel', '85 Adly Downtown Cairo', '01001962835', '2003-04-26', 'F', 'YaraAdel344@outlook.com');
INSERT INTO `Club_DB`.`Person` (`SSN`, `FName`, `LName`, `Address`, `Phone`, `BDATE`, `Gender`, `Email`) VALUES (278, 'Ahmed', 'Hani', '37 Hassan Sabry Zamalek Cairo', '01263521478', '2003-10-13', 'M', 'AhmedHani268@gmail.com');
INSERT INTO `Club_DB`.`Person` (`SSN`, `FName`, `LName`, `Address`, `Phone`, `BDATE`, `Gender`, `Email`) VALUES (279, 'Kareem', 'Farag', '50 Hassan Assem Zamalek Cairo', '01279614580', '2004-01-24', 'M', 'KareemFarag149@outlook.com');
INSERT INTO `Club_DB`.`Person` (`SSN`, `FName`, `LName`, `Address`, `Phone`, `BDATE`, `Gender`, `Email`) VALUES (280, 'Amani', 'Salah', '42 Salah El Din Heliopolis Cairo', '01103176842', '2008-11-25', 'F', 'AmaniSalah415@gmail.com');
INSERT INTO `Club_DB`.`Person` (`SSN`, `FName`, `LName`, `Address`, `Phone`, `BDATE`, `Gender`, `Email`) VALUES (281, 'Mahmoud', 'Khaled', '46 Al Nozha Heliopolis Cairo', '01565143208', '2006-08-20', 'M', 'MahmoudKhaled64@hotmail.com');
INSERT INTO `Club_DB`.`Person` (`SSN`, `FName`, `LName`, `Address`, `Phone`, `BDATE`, `Gender`, `Email`) VALUES (282, 'Ali', 'Nader', '43 Hassan Assem Zamalek Cairo', '01514280759', '2003-10-20', 'M', 'AliNader250@outlook.com');
INSERT INTO `Club_DB`.`Person` (`SSN`, `FName`, `LName`, `Address`, `Phone`, `BDATE`, `Gender`, `Email`) VALUES (283, 'Amr', 'Waleed', '80 Hassan Ramadan Al Doqi Giza', '01206289743', '2005-11-20', 'M', 'AmrWaleed350@gmail.com');
INSERT INTO `Club_DB`.`Person` (`SSN`, `FName`, `LName`, `Address`, `Phone`, `BDATE`, `Gender`, `Email`) VALUES (284, 'Wael', 'Mohamed', '84 Gamal Abdel Nasser Al-Salam Cairo', '01054671328', '2007-07-06', 'M', 'WaelMohamed409@hotmail.com');
INSERT INTO `Club_DB`.`Person` (`SSN`, `FName`, `LName`, `Address`, `Phone`, `BDATE`, `Gender`, `Email`) VALUES (285, 'Arwa', 'Farag', '28 Gamal Abdel Nasser Al-Salam Cairo', '01129408517', '2003-06-23', 'F', 'ArwaFarag29@outlook.com');
INSERT INTO `Club_DB`.`Person` (`SSN`, `FName`, `LName`, `Address`, `Phone`, `BDATE`, `Gender`, `Email`) VALUES (286, 'Abdalaziz', 'Nader', '55 Salah El Din Heliopolis Cairo', '01197152843', '2007-10-13', 'M', 'AbdalazizNader137@gmail.com');
INSERT INTO `Club_DB`.`Person` (`SSN`, `FName`, `LName`, `Address`, `Phone`, `BDATE`, `Gender`, `Email`) VALUES (287, 'Adham', 'Waleed', '84 kamal Al Tawil Zamalek Cairo', '01540216537', '2004-11-27', 'M', 'AdhamWaleed70@outlook.com');
INSERT INTO `Club_DB`.`Person` (`SSN`, `FName`, `LName`, `Address`, `Phone`, `BDATE`, `Gender`, `Email`) VALUES (288, 'Nour', 'Fawzi', '51 Sherif Downtown Cairo', '01018607349', '2008-04-14', 'F', 'NourFawzi78@outlook.com');
INSERT INTO `Club_DB`.`Person` (`SSN`, `FName`, `LName`, `Address`, `Phone`, `BDATE`, `Gender`, `Email`) VALUES (289, 'Omar', 'Nader', '85 Ahmed Helmy Shobra Cairo', '01590562417', '2004-09-06', 'M', 'OmarNader19@gmail.com');
INSERT INTO `Club_DB`.`Person` (`SSN`, `FName`, `LName`, `Address`, `Phone`, `BDATE`, `Gender`, `Email`) VALUES (290, 'Arwa', 'Farag', '96 Al Merghany Heliopolis Cairo', '01018396420', '2007-05-26', 'F', 'ArwaFarag355@hotmail.com');
INSERT INTO `Club_DB`.`Person` (`SSN`, `FName`, `LName`, `Address`, `Phone`, `BDATE`, `Gender`, `Email`) VALUES (291, 'Omnya', 'Hassan', '14 Talaat Harb Downtown Cairo', '01149367582', '2007-06-15', 'F', 'OmnyaHassan239@gmail.com');
INSERT INTO `Club_DB`.`Person` (`SSN`, `FName`, `LName`, `Address`, `Phone`, `BDATE`, `Gender`, `Email`) VALUES (292, 'Shahd', 'Ashraf', '65 Al Hegaz Heliopolis Cairo', '01272835409', '2005-05-14', 'F', 'ShahdAshraf162@hotmail.com');
INSERT INTO `Club_DB`.`Person` (`SSN`, `FName`, `LName`, `Address`, `Phone`, `BDATE`, `Gender`, `Email`) VALUES (293, 'Ibrahim', 'Hassan', '54 Shaheen Al Doqi Giza', '01167041932', '2006-01-06', 'M', 'IbrahimHassan91@hotmail.com');
INSERT INTO `Club_DB`.`Person` (`SSN`, `FName`, `LName`, `Address`, `Phone`, `BDATE`, `Gender`, `Email`) VALUES (294, 'Amir', 'Yaser', '55 Al Hegaz Heliopolis Cairo', '01557421936', '2006-04-03', 'M', 'AmirYaser133@gmail.com');
INSERT INTO `Club_DB`.`Person` (`SSN`, `FName`, `LName`, `Address`, `Phone`, `BDATE`, `Gender`, `Email`) VALUES (295, 'Seif', 'Nader', '51 Hassan Ramadan Al Doqi Giza', '01276481205', '2005-11-02', 'M', 'SeifNader349@outlook.com');
INSERT INTO `Club_DB`.`Person` (`SSN`, `FName`, `LName`, `Address`, `Phone`, `BDATE`, `Gender`, `Email`) VALUES (296, 'Abdelrahman', 'Mohamed', '29 Gad Eid Al Doqi Giza', '01503619287', '2004-09-21', 'M', 'AbdelrahmanMohamed107@gmail.com');
INSERT INTO `Club_DB`.`Person` (`SSN`, `FName`, `LName`, `Address`, `Phone`, `BDATE`, `Gender`, `Email`) VALUES (297, 'Hager', 'Sobhi', '73 Champeleon Downtown Cairo', '01064023917', '2006-11-23', 'F', 'HagerSobhi231@hotmail.com');
INSERT INTO `Club_DB`.`Person` (`SSN`, `FName`, `LName`, `Address`, `Phone`, `BDATE`, `Gender`, `Email`) VALUES (298, 'Sherif', 'Hassan', '63 Adly Downtown Cairo', '01232450891', '2005-08-16', 'M', 'SherifHassan408@gmail.com');
INSERT INTO `Club_DB`.`Person` (`SSN`, `FName`, `LName`, `Address`, `Phone`, `BDATE`, `Gender`, `Email`) VALUES (299, 'Nada', 'Fawzi', '98 Hassan Ramadan Al Doqi Giza', '01210328657', '2004-06-23', 'F', 'NadaFawzi307@hotmail.com');
INSERT INTO `Club_DB`.`Person` (`SSN`, `FName`, `LName`, `Address`, `Phone`, `BDATE`, `Gender`, `Email`) VALUES (300, 'Amani', 'Adel', '76 Doletyan Shobra Cairo', '01207618294', '2008-09-23', 'F', 'AmaniAdel400@hotmail.com');
INSERT INTO `Club_DB`.`Person` (`SSN`, `FName`, `LName`, `Address`, `Phone`, `BDATE`, `Gender`, `Email`) VALUES (301, 'Salma', 'Waleed', '92 Al Ahram Heliopolis Cairo', '01276358941', '2004-08-14', 'F', 'SalmaWaleed48@hotmail.com');
INSERT INTO `Club_DB`.`Person` (`SSN`, `FName`, `LName`, `Address`, `Phone`, `BDATE`, `Gender`, `Email`) VALUES (302, 'Wael', 'Fawzi', '73 18St. ElTahrir City Imbaba Giza', '01045907681', '2004-04-13', 'M', 'WaelFawzi66@outlook.com ');
INSERT INTO `Club_DB`.`Person` (`SSN`, `FName`, `LName`, `Address`, `Phone`, `BDATE`, `Gender`, `Email`) VALUES (303, 'Yasmin', 'Mohamed', '13 Damascus Maadi Cairo', '01178314502', '2004-06-27', 'F', 'YasminMohamed367@gmail.com');
INSERT INTO `Club_DB`.`Person` (`SSN`, `FName`, `LName`, `Address`, `Phone`, `BDATE`, `Gender`, `Email`) VALUES (304, 'Yara', 'Zakaria', '31 Adly Downtown Cairo', '01273195860', '2004-04-26', 'F', 'YaraZakaria191@hotmail.com');
INSERT INTO `Club_DB`.`Person` (`SSN`, `FName`, `LName`, `Address`, `Phone`, `BDATE`, `Gender`, `Email`) VALUES (305, 'Yousif', 'Fawzi', '56 Talaat Harb Imbaba Giza', '01235928064', '2008-11-05', 'M', 'YousifFawzi296@gmail.com');
INSERT INTO `Club_DB`.`Person` (`SSN`, `FName`, `LName`, `Address`, `Phone`, `BDATE`, `Gender`, `Email`) VALUES (306, 'Sherif', 'Salah', '29 Al Ahram Heliopolis Cairo', '01085132064', '2007-07-13', 'M', 'SherifSalah379@gmail.com');
INSERT INTO `Club_DB`.`Person` (`SSN`, `FName`, `LName`, `Address`, `Phone`, `BDATE`, `Gender`, `Email`) VALUES (307, 'Abdalaziz', 'Sobhi', '23 Hassan Sabry Zamalek Cairo', '01214632597', '2003-05-16', 'M', 'AbdalazizSobhi203@hotmail.com');
INSERT INTO `Club_DB`.`Person` (`SSN`, `FName`, `LName`, `Address`, `Phone`, `BDATE`, `Gender`, `Email`) VALUES (308, 'Shahd', 'Adel', '100 Ahmed Helmy Shobra Cairo', '01293086572', '2008-03-26', 'F', 'ShahdAdel99@gmail.com');
INSERT INTO `Club_DB`.`Person` (`SSN`, `FName`, `LName`, `Address`, `Phone`, `BDATE`, `Gender`, `Email`) VALUES (309, 'Abdallah', 'Waleed', '77 Shaheen Al Doqi Giza', '01537859104', '2003-09-25', 'M', 'AbdallahWaleed69@hotmail.com');
INSERT INTO `Club_DB`.`Person` (`SSN`, `FName`, `LName`, `Address`, `Phone`, `BDATE`, `Gender`, `Email`) VALUES (310, 'Amani', 'Fawzi', '99 El Sadat Al-Salam Cairo', '01174308921', '2007-11-16', 'F', 'AmaniFawzi368@hotmail.com');
INSERT INTO `Club_DB`.`Person` (`SSN`, `FName`, `LName`, `Address`, `Phone`, `BDATE`, `Gender`, `Email`) VALUES (311, 'Amir', 'Sayed', '72 Salah El Din Heliopolis Cairo', '01237569082', '2003-09-22', 'M', 'AmirSayed239@gmail.com');
INSERT INTO `Club_DB`.`Person` (`SSN`, `FName`, `LName`, `Address`, `Phone`, `BDATE`, `Gender`, `Email`) VALUES (312, 'Ehab', 'Hani', '78 18St. ElTahrir City Imbaba Giza', '01251832079', '2007-07-13', 'M', 'EhabHani203@outlook.com');
INSERT INTO `Club_DB`.`Person` (`SSN`, `FName`, `LName`, `Address`, `Phone`, `BDATE`, `Gender`, `Email`) VALUES (313, 'Noureen', 'Adel', '66 18St. ElTahrir City Imbaba Giza', '01045320187', '2003-03-19', 'F', 'NoureenAdel133@gmail.com');
INSERT INTO `Club_DB`.`Person` (`SSN`, `FName`, `LName`, `Address`, `Phone`, `BDATE`, `Gender`, `Email`) VALUES (314, 'Nour', 'Waleed', '21 Mamdouh Salem Imbaba Giza', '01552943701', '2005-02-09', 'F', 'NourWaleed62@hotmail.com');
INSERT INTO `Club_DB`.`Person` (`SSN`, `FName`, `LName`, `Address`, `Phone`, `BDATE`, `Gender`, `Email`) VALUES (315, 'Nourhan', 'Adel', '85 15 May Shobra Cairo', '01513789546', '2003-12-08', 'F', 'NourhanAdel333@gmail.com');
INSERT INTO `Club_DB`.`Person` (`SSN`, `FName`, `LName`, `Address`, `Phone`, `BDATE`, `Gender`, `Email`) VALUES (316, 'Marawan', 'Hani', '72 El Sadat Al-Salam Cairo', '01230852649', '2005-01-21', 'M', 'MarawanHani49@outlook.com');
INSERT INTO `Club_DB`.`Person` (`SSN`, `FName`, `LName`, `Address`, `Phone`, `BDATE`, `Gender`, `Email`) VALUES (317, 'Nada', 'Farag', '48 Ahmed Helmy Shobra Cairo', '01043725081', '2008-06-21', 'F', 'NadaFarag390@gmail.com');
INSERT INTO `Club_DB`.`Person` (`SSN`, `FName`, `LName`, `Address`, `Phone`, `BDATE`, `Gender`, `Email`) VALUES (318, 'Rahma', 'Ezzat', '54 Baghdad Heliopolis Cairo', '01523975681', '2005-06-22', 'F', 'RahmaEzzat312@outlook.com');
INSERT INTO `Club_DB`.`Person` (`SSN`, `FName`, `LName`, `Address`, `Phone`, `BDATE`, `Gender`, `Email`) VALUES (319, 'Kareem', 'Salah', '23 Talaat Harb Downtown Cairo', '01578953421', '2006-01-08', 'M', 'KareemSalah61@hotmail.com');
INSERT INTO `Club_DB`.`Person` (`SSN`, `FName`, `LName`, `Address`, `Phone`, `BDATE`, `Gender`, `Email`) VALUES (320, 'Omar', 'Ashraf', '99 Gamal Abdel Nasser Al-Salam Cairo', '01276901523', '2004-05-25', 'M', 'OmarAshraf420@hotmail.com');
INSERT INTO `Club_DB`.`Person` (`SSN`, `FName`, `LName`, `Address`, `Phone`, `BDATE`, `Gender`, `Email`) VALUES (321, 'Nada', 'Emad', '5 28St. ElTahrir City Imbaba Giza', '01083460215', '2004-08-21', 'F', 'NadaEmad320@hotmail.com');
INSERT INTO `Club_DB`.`Person` (`SSN`, `FName`, `LName`, `Address`, `Phone`, `BDATE`, `Gender`, `Email`) VALUES (322, 'Kareem', 'Salah', '91 Mamdouh Salem Imbaba Giza', '01106541983', '2007-11-12', 'M', 'KareemSalah6@outlook.com');
INSERT INTO `Club_DB`.`Person` (`SSN`, `FName`, `LName`, `Address`, `Phone`, `BDATE`, `Gender`, `Email`) VALUES (323, 'Dina', 'Yaser', '98 Gamal Abdel Nasser Al-Salam Cairo', '01225416709', '2007-03-01', 'F', 'DinaYaser57@hotmail.com');
INSERT INTO `Club_DB`.`Person` (`SSN`, `FName`, `LName`, `Address`, `Phone`, `BDATE`, `Gender`, `Email`) VALUES (324, 'Seif', 'Sayed', '50 Al Merghany Heliopolis Cairo', '01119463570', '2005-10-09', 'M', 'SeifSayed313@hotmail.com');
INSERT INTO `Club_DB`.`Person` (`SSN`, `FName`, `LName`, `Address`, `Phone`, `BDATE`, `Gender`, `Email`) VALUES (325, 'Mohamed', 'Ezzat', '42 Damascus Maadi Cairo', '01004583169', '2003-05-08', 'M', 'MohamedEzzat11@hotmail.com');
INSERT INTO `Club_DB`.`Person` (`SSN`, `FName`, `LName`, `Address`, `Phone`, `BDATE`, `Gender`, `Email`) VALUES (326, 'Arwa', 'Khalil', '39 Rod El Farag Shobra Cairo', '01183165472', '2003-01-15', 'F', 'ArwaKhalil368@outlook.com');
INSERT INTO `Club_DB`.`Person` (`SSN`, `FName`, `LName`, `Address`, `Phone`, `BDATE`, `Gender`, `Email`) VALUES (327, 'Marawan', 'Khalil', '51 El Tahrir Downtown Cairo', '01116084325', '2005-05-21', 'M', 'MarawanKhalil191@outlook.com');
INSERT INTO `Club_DB`.`Person` (`SSN`, `FName`, `LName`, `Address`, `Phone`, `BDATE`, `Gender`, `Email`) VALUES (328, 'Yara', 'Magdy', '51 18St. ElTahrir City Imbaba Giza', '01534561079', '2005-10-07', 'F', 'YaraMagdy374@hotmail.com');
INSERT INTO `Club_DB`.`Person` (`SSN`, `FName`, `LName`, `Address`, `Phone`, `BDATE`, `Gender`, `Email`) VALUES (329, 'Arwa', 'Ashraf', '50 Damascus Maadi Cairo', '01126549371', '2004-03-17', 'F', 'ArwaAshraf310@gmail.com');
INSERT INTO `Club_DB`.`Person` (`SSN`, `FName`, `LName`, `Address`, `Phone`, `BDATE`, `Gender`, `Email`) VALUES (330, 'Abdalaziz', 'Nader', '56 Oraby Maadi Cairo', '01057106423', '2004-01-06', 'M', 'AbdalazizNader97@hotmail.com');
INSERT INTO `Club_DB`.`Person` (`SSN`, `FName`, `LName`, `Address`, `Phone`, `BDATE`, `Gender`, `Email`) VALUES (331, 'Haytham', 'Sayed', '53 15 May Shobra Cairo', '01140235697', '2006-05-01', 'M', 'HaythamSayed290@gmail.com');
INSERT INTO `Club_DB`.`Person` (`SSN`, `FName`, `LName`, `Address`, `Phone`, `BDATE`, `Gender`, `Email`) VALUES (332, 'Sherif', 'Emad', '99 Mohammed Mazhar Zamalek Cairo', '01578240561', '2008-02-08', 'M', 'SherifEmad222@outlook.com');
INSERT INTO `Club_DB`.`Person` (`SSN`, `FName`, `LName`, `Address`, `Phone`, `BDATE`, `Gender`, `Email`) VALUES (333, 'Nourhan', 'Sobhi', '75 Rod El Farag Shobra Cairo', '01532875604', '2007-07-13', 'F', 'NourhanSobhi405@gmail.com');
INSERT INTO `Club_DB`.`Person` (`SSN`, `FName`, `LName`, `Address`, `Phone`, `BDATE`, `Gender`, `Email`) VALUES (334, 'Toaa', 'Salah', '29 El Sadat Al-Salam Cairo', '01597658210', '2003-02-15', 'F', 'ToaaSalah236@outlook.com');
INSERT INTO `Club_DB`.`Person` (`SSN`, `FName`, `LName`, `Address`, `Phone`, `BDATE`, `Gender`, `Email`) VALUES (335, 'Aya', 'Ghanim', '91 Sherif Downtown Cairo', '01164783105', '2006-12-22', 'F', 'AyaGhanim19@outlook.com');
INSERT INTO `Club_DB`.`Person` (`SSN`, `FName`, `LName`, `Address`, `Phone`, `BDATE`, `Gender`, `Email`) VALUES (336, 'Amani', 'Waleed', '58 El Tahrir Downtown Cairo', '01540816327', '2003-05-28', 'F', 'AmaniWaleed418@hotmail.com');
INSERT INTO `Club_DB`.`Person` (`SSN`, `FName`, `LName`, `Address`, `Phone`, `BDATE`, `Gender`, `Email`) VALUES (337, 'Nourhan', 'Yaser', '87 Shobra St. Shobra Cairo', '01250683497', '2006-04-07', 'F', 'NourhanYaser225@hotmail.com');
INSERT INTO `Club_DB`.`Person` (`SSN`, `FName`, `LName`, `Address`, `Phone`, `BDATE`, `Gender`, `Email`) VALUES (338, 'Dina', 'Zakaria', '21 Al Nahda Maadi Cairo', '01502438657', '2005-04-17', 'F', 'DinaZakaria289@outlook.com');
INSERT INTO `Club_DB`.`Person` (`SSN`, `FName`, `LName`, `Address`, `Phone`, `BDATE`, `Gender`, `Email`) VALUES (339, 'Mostafa', 'Mohamed', '26 Hassan Assem Zamalek Cairo', '01226853097', '2003-10-15', 'M', 'MostafaMohamed264@gmail.com');
INSERT INTO `Club_DB`.`Person` (`SSN`, `FName`, `LName`, `Address`, `Phone`, `BDATE`, `Gender`, `Email`) VALUES (340, 'Eyad', 'Magdy', '78 Ahmed Helmy Shobra Cairo', '01097164250', '2006-04-14', 'M', 'EyadMagdy64@outlook.com');
INSERT INTO `Club_DB`.`Person` (`SSN`, `FName`, `LName`, `Address`, `Phone`, `BDATE`, `Gender`, `Email`) VALUES (341, 'Mariam', 'Khalil', '24 Salah El Din Heliopolis Cairo', '01560519482', '2008-02-11', 'F', 'MariamKhalil330@outlook.com');
INSERT INTO `Club_DB`.`Person` (`SSN`, `FName`, `LName`, `Address`, `Phone`, `BDATE`, `Gender`, `Email`) VALUES (342, 'Dina', 'Nader', '26 Al Ahram Heliopolis Cairo', '01076385209', '2005-10-25', 'F', 'DinaNader206@hotmail.com');
INSERT INTO `Club_DB`.`Person` (`SSN`, `FName`, `LName`, `Address`, `Phone`, `BDATE`, `Gender`, `Email`) VALUES (343, 'Omnya', 'Hassan', '39 Champeleon Downtown Cairo', '01139518427', '2004-03-23', 'F', 'OmnyaHassan179@hotmail.com');
INSERT INTO `Club_DB`.`Person` (`SSN`, `FName`, `LName`, `Address`, `Phone`, `BDATE`, `Gender`, `Email`) VALUES (344, 'Yara', 'Nader', '61 28St. ElTahrir City Imbaba Giza', '01050271693', '2005-07-01', 'F', 'YaraNader198@hotmail.com ');
INSERT INTO `Club_DB`.`Person` (`SSN`, `FName`, `LName`, `Address`, `Phone`, `BDATE`, `Gender`, `Email`) VALUES (345, 'Noureen', 'Hassan', '76 Shobra St. Shobra Cairo', '01061853290', '2007-08-13', 'F', 'NoureenHassan273@outlook.com');
INSERT INTO `Club_DB`.`Person` (`SSN`, `FName`, `LName`, `Address`, `Phone`, `BDATE`, `Gender`, `Email`) VALUES (346, 'Nada', 'Khaled', '80 Shaheen Al Doqi Giza', '01285039746', '2004-05-19', 'F', 'NadaKhaled298@outlook.com');
INSERT INTO `Club_DB`.`Person` (`SSN`, `FName`, `LName`, `Address`, `Phone`, `BDATE`, `Gender`, `Email`) VALUES (347, 'Abdelrahman', 'Adel', '47 Al Teraa Al Boulakeya Shobra Cairo', '01529345168', '2005-03-14', 'M', 'AbdelrahmanAdel29@gmail.com');

COMMIT;


-- -----------------------------------------------------
-- Data for table `Club_DB`.`Member`
-- -----------------------------------------------------
START TRANSACTION;
USE `Club_DB`;
INSERT INTO `Club_DB`.`Member` (`Member_SSN`, `MembershipStartDate`) VALUES (1, '2022-02-05');
INSERT INTO `Club_DB`.`Member` (`Member_SSN`, `MembershipStartDate`) VALUES (2, '2022-02-07');
INSERT INTO `Club_DB`.`Member` (`Member_SSN`, `MembershipStartDate`) VALUES (3, '2020-01-23');
INSERT INTO `Club_DB`.`Member` (`Member_SSN`, `MembershipStartDate`) VALUES (4, '2022-04-21');
INSERT INTO `Club_DB`.`Member` (`Member_SSN`, `MembershipStartDate`) VALUES (5, '2022-11-28');
INSERT INTO `Club_DB`.`Member` (`Member_SSN`, `MembershipStartDate`) VALUES (6, '2022-03-05');
INSERT INTO `Club_DB`.`Member` (`Member_SSN`, `MembershipStartDate`) VALUES (7, '2021-06-25');
INSERT INTO `Club_DB`.`Member` (`Member_SSN`, `MembershipStartDate`) VALUES (8, '2022-05-12');
INSERT INTO `Club_DB`.`Member` (`Member_SSN`, `MembershipStartDate`) VALUES (9, '2021-06-21');
INSERT INTO `Club_DB`.`Member` (`Member_SSN`, `MembershipStartDate`) VALUES (10, '2022-11-11');
INSERT INTO `Club_DB`.`Member` (`Member_SSN`, `MembershipStartDate`) VALUES (11, '2021-03-08');
INSERT INTO `Club_DB`.`Member` (`Member_SSN`, `MembershipStartDate`) VALUES (12, '2021-04-17');
INSERT INTO `Club_DB`.`Member` (`Member_SSN`, `MembershipStartDate`) VALUES (13, '2021-05-06');
INSERT INTO `Club_DB`.`Member` (`Member_SSN`, `MembershipStartDate`) VALUES (14, '2020-05-05');
INSERT INTO `Club_DB`.`Member` (`Member_SSN`, `MembershipStartDate`) VALUES (15, '2021-05-01');
INSERT INTO `Club_DB`.`Member` (`Member_SSN`, `MembershipStartDate`) VALUES (16, '2021-12-14');
INSERT INTO `Club_DB`.`Member` (`Member_SSN`, `MembershipStartDate`) VALUES (17, '2020-11-25');
INSERT INTO `Club_DB`.`Member` (`Member_SSN`, `MembershipStartDate`) VALUES (18, '2022-09-23');
INSERT INTO `Club_DB`.`Member` (`Member_SSN`, `MembershipStartDate`) VALUES (19, '2021-04-28');
INSERT INTO `Club_DB`.`Member` (`Member_SSN`, `MembershipStartDate`) VALUES (20, '2020-05-12');
INSERT INTO `Club_DB`.`Member` (`Member_SSN`, `MembershipStartDate`) VALUES (21, '2021-05-02');
INSERT INTO `Club_DB`.`Member` (`Member_SSN`, `MembershipStartDate`) VALUES (22, '2021-05-08');
INSERT INTO `Club_DB`.`Member` (`Member_SSN`, `MembershipStartDate`) VALUES (23, '2022-05-25');
INSERT INTO `Club_DB`.`Member` (`Member_SSN`, `MembershipStartDate`) VALUES (24, '2022-01-27');
INSERT INTO `Club_DB`.`Member` (`Member_SSN`, `MembershipStartDate`) VALUES (25, '2022-09-22');
INSERT INTO `Club_DB`.`Member` (`Member_SSN`, `MembershipStartDate`) VALUES (26, '2022-06-27');
INSERT INTO `Club_DB`.`Member` (`Member_SSN`, `MembershipStartDate`) VALUES (27, '2022-08-17');
INSERT INTO `Club_DB`.`Member` (`Member_SSN`, `MembershipStartDate`) VALUES (28, '2022-04-17');
INSERT INTO `Club_DB`.`Member` (`Member_SSN`, `MembershipStartDate`) VALUES (29, '2021-10-08');
INSERT INTO `Club_DB`.`Member` (`Member_SSN`, `MembershipStartDate`) VALUES (30, '2021-09-25');
INSERT INTO `Club_DB`.`Member` (`Member_SSN`, `MembershipStartDate`) VALUES (31, '2021-06-01');
INSERT INTO `Club_DB`.`Member` (`Member_SSN`, `MembershipStartDate`) VALUES (32, '2021-02-08');
INSERT INTO `Club_DB`.`Member` (`Member_SSN`, `MembershipStartDate`) VALUES (33, '2022-04-16');
INSERT INTO `Club_DB`.`Member` (`Member_SSN`, `MembershipStartDate`) VALUES (34, '2022-04-28');
INSERT INTO `Club_DB`.`Member` (`Member_SSN`, `MembershipStartDate`) VALUES (35, '2020-09-03');
INSERT INTO `Club_DB`.`Member` (`Member_SSN`, `MembershipStartDate`) VALUES (36, '2020-06-04');
INSERT INTO `Club_DB`.`Member` (`Member_SSN`, `MembershipStartDate`) VALUES (37, '2022-10-17');
INSERT INTO `Club_DB`.`Member` (`Member_SSN`, `MembershipStartDate`) VALUES (38, '2022-05-25');
INSERT INTO `Club_DB`.`Member` (`Member_SSN`, `MembershipStartDate`) VALUES (39, '2020-03-13');
INSERT INTO `Club_DB`.`Member` (`Member_SSN`, `MembershipStartDate`) VALUES (40, '2022-03-04');
INSERT INTO `Club_DB`.`Member` (`Member_SSN`, `MembershipStartDate`) VALUES (41, '2021-08-11');
INSERT INTO `Club_DB`.`Member` (`Member_SSN`, `MembershipStartDate`) VALUES (42, '2021-04-26');
INSERT INTO `Club_DB`.`Member` (`Member_SSN`, `MembershipStartDate`) VALUES (43, '2020-06-01');
INSERT INTO `Club_DB`.`Member` (`Member_SSN`, `MembershipStartDate`) VALUES (44, '2022-04-24');
INSERT INTO `Club_DB`.`Member` (`Member_SSN`, `MembershipStartDate`) VALUES (45, '2022-08-21');
INSERT INTO `Club_DB`.`Member` (`Member_SSN`, `MembershipStartDate`) VALUES (46, '2022-12-19');
INSERT INTO `Club_DB`.`Member` (`Member_SSN`, `MembershipStartDate`) VALUES (47, '2020-01-18');
INSERT INTO `Club_DB`.`Member` (`Member_SSN`, `MembershipStartDate`) VALUES (48, '2022-12-10');
INSERT INTO `Club_DB`.`Member` (`Member_SSN`, `MembershipStartDate`) VALUES (49, '2020-11-24');
INSERT INTO `Club_DB`.`Member` (`Member_SSN`, `MembershipStartDate`) VALUES (50, '2021-03-24');
INSERT INTO `Club_DB`.`Member` (`Member_SSN`, `MembershipStartDate`) VALUES (51, '2021-08-02');
INSERT INTO `Club_DB`.`Member` (`Member_SSN`, `MembershipStartDate`) VALUES (52, '2022-09-10');
INSERT INTO `Club_DB`.`Member` (`Member_SSN`, `MembershipStartDate`) VALUES (53, '2020-09-18');
INSERT INTO `Club_DB`.`Member` (`Member_SSN`, `MembershipStartDate`) VALUES (54, '2021-01-14');
INSERT INTO `Club_DB`.`Member` (`Member_SSN`, `MembershipStartDate`) VALUES (55, '2021-06-12');
INSERT INTO `Club_DB`.`Member` (`Member_SSN`, `MembershipStartDate`) VALUES (56, '2022-02-10');
INSERT INTO `Club_DB`.`Member` (`Member_SSN`, `MembershipStartDate`) VALUES (57, '2022-02-01');
INSERT INTO `Club_DB`.`Member` (`Member_SSN`, `MembershipStartDate`) VALUES (58, '2021-02-11');
INSERT INTO `Club_DB`.`Member` (`Member_SSN`, `MembershipStartDate`) VALUES (59, '2021-05-27');
INSERT INTO `Club_DB`.`Member` (`Member_SSN`, `MembershipStartDate`) VALUES (60, '2020-05-24');
INSERT INTO `Club_DB`.`Member` (`Member_SSN`, `MembershipStartDate`) VALUES (61, '2020-10-03');
INSERT INTO `Club_DB`.`Member` (`Member_SSN`, `MembershipStartDate`) VALUES (62, '2021-08-17');
INSERT INTO `Club_DB`.`Member` (`Member_SSN`, `MembershipStartDate`) VALUES (63, '2020-07-24');
INSERT INTO `Club_DB`.`Member` (`Member_SSN`, `MembershipStartDate`) VALUES (64, '2022-02-20');
INSERT INTO `Club_DB`.`Member` (`Member_SSN`, `MembershipStartDate`) VALUES (65, '2022-09-24');
INSERT INTO `Club_DB`.`Member` (`Member_SSN`, `MembershipStartDate`) VALUES (66, '2021-10-19');
INSERT INTO `Club_DB`.`Member` (`Member_SSN`, `MembershipStartDate`) VALUES (67, '2022-08-19');
INSERT INTO `Club_DB`.`Member` (`Member_SSN`, `MembershipStartDate`) VALUES (68, '2022-11-03');
INSERT INTO `Club_DB`.`Member` (`Member_SSN`, `MembershipStartDate`) VALUES (69, '2021-06-10');
INSERT INTO `Club_DB`.`Member` (`Member_SSN`, `MembershipStartDate`) VALUES (70, '2020-03-08');
INSERT INTO `Club_DB`.`Member` (`Member_SSN`, `MembershipStartDate`) VALUES (71, '2021-11-16');
INSERT INTO `Club_DB`.`Member` (`Member_SSN`, `MembershipStartDate`) VALUES (72, '2021-08-21');
INSERT INTO `Club_DB`.`Member` (`Member_SSN`, `MembershipStartDate`) VALUES (73, '2022-05-27');
INSERT INTO `Club_DB`.`Member` (`Member_SSN`, `MembershipStartDate`) VALUES (74, '2020-08-24');
INSERT INTO `Club_DB`.`Member` (`Member_SSN`, `MembershipStartDate`) VALUES (75, '2021-06-03');
INSERT INTO `Club_DB`.`Member` (`Member_SSN`, `MembershipStartDate`) VALUES (76, '2020-09-02');
INSERT INTO `Club_DB`.`Member` (`Member_SSN`, `MembershipStartDate`) VALUES (77, '2022-12-10');
INSERT INTO `Club_DB`.`Member` (`Member_SSN`, `MembershipStartDate`) VALUES (78, '2021-10-19');
INSERT INTO `Club_DB`.`Member` (`Member_SSN`, `MembershipStartDate`) VALUES (79, '2020-09-20');
INSERT INTO `Club_DB`.`Member` (`Member_SSN`, `MembershipStartDate`) VALUES (80, '2020-02-14');
INSERT INTO `Club_DB`.`Member` (`Member_SSN`, `MembershipStartDate`) VALUES (81, '2020-09-17');
INSERT INTO `Club_DB`.`Member` (`Member_SSN`, `MembershipStartDate`) VALUES (82, '2021-05-07');
INSERT INTO `Club_DB`.`Member` (`Member_SSN`, `MembershipStartDate`) VALUES (83, '2020-07-26');
INSERT INTO `Club_DB`.`Member` (`Member_SSN`, `MembershipStartDate`) VALUES (84, '2021-01-27');
INSERT INTO `Club_DB`.`Member` (`Member_SSN`, `MembershipStartDate`) VALUES (85, '2022-03-23');
INSERT INTO `Club_DB`.`Member` (`Member_SSN`, `MembershipStartDate`) VALUES (86, '2021-06-21');
INSERT INTO `Club_DB`.`Member` (`Member_SSN`, `MembershipStartDate`) VALUES (87, '2016-06-19');
INSERT INTO `Club_DB`.`Member` (`Member_SSN`, `MembershipStartDate`) VALUES (88, '2019-07-28');
INSERT INTO `Club_DB`.`Member` (`Member_SSN`, `MembershipStartDate`) VALUES (89, '2018-08-18');
INSERT INTO `Club_DB`.`Member` (`Member_SSN`, `MembershipStartDate`) VALUES (90, '2021-12-10');
INSERT INTO `Club_DB`.`Member` (`Member_SSN`, `MembershipStartDate`) VALUES (91, '2019-03-05');
INSERT INTO `Club_DB`.`Member` (`Member_SSN`, `MembershipStartDate`) VALUES (92, '2022-03-12');
INSERT INTO `Club_DB`.`Member` (`Member_SSN`, `MembershipStartDate`) VALUES (93, '2015-03-12');
INSERT INTO `Club_DB`.`Member` (`Member_SSN`, `MembershipStartDate`) VALUES (94, '2019-04-06');
INSERT INTO `Club_DB`.`Member` (`Member_SSN`, `MembershipStartDate`) VALUES (95, '2016-12-10');
INSERT INTO `Club_DB`.`Member` (`Member_SSN`, `MembershipStartDate`) VALUES (96, '2023-06-09');
INSERT INTO `Club_DB`.`Member` (`Member_SSN`, `MembershipStartDate`) VALUES (97, '2015-06-19');
INSERT INTO `Club_DB`.`Member` (`Member_SSN`, `MembershipStartDate`) VALUES (98, '2018-08-01');
INSERT INTO `Club_DB`.`Member` (`Member_SSN`, `MembershipStartDate`) VALUES (99, '2017-12-27');
INSERT INTO `Club_DB`.`Member` (`Member_SSN`, `MembershipStartDate`) VALUES (100, '2021-02-26');
INSERT INTO `Club_DB`.`Member` (`Member_SSN`, `MembershipStartDate`) VALUES (101, '2019-06-26');
INSERT INTO `Club_DB`.`Member` (`Member_SSN`, `MembershipStartDate`) VALUES (102, '2021-02-16');
INSERT INTO `Club_DB`.`Member` (`Member_SSN`, `MembershipStartDate`) VALUES (103, '2022-02-27');
INSERT INTO `Club_DB`.`Member` (`Member_SSN`, `MembershipStartDate`) VALUES (104, '2023-10-07');
INSERT INTO `Club_DB`.`Member` (`Member_SSN`, `MembershipStartDate`) VALUES (115, '2010-02-15');
INSERT INTO `Club_DB`.`Member` (`Member_SSN`, `MembershipStartDate`) VALUES (116, '2008-11-10');
INSERT INTO `Club_DB`.`Member` (`Member_SSN`, `MembershipStartDate`) VALUES (117, '2011-06-05');
INSERT INTO `Club_DB`.`Member` (`Member_SSN`, `MembershipStartDate`) VALUES (118, '2015-05-08');
INSERT INTO `Club_DB`.`Member` (`Member_SSN`, `MembershipStartDate`) VALUES (119, '2009-02-15');
INSERT INTO `Club_DB`.`Member` (`Member_SSN`, `MembershipStartDate`) VALUES (120, '2010-11-19');
INSERT INTO `Club_DB`.`Member` (`Member_SSN`, `MembershipStartDate`) VALUES (121, '2012-11-19');
INSERT INTO `Club_DB`.`Member` (`Member_SSN`, `MembershipStartDate`) VALUES (122, '2015-02-26');
INSERT INTO `Club_DB`.`Member` (`Member_SSN`, `MembershipStartDate`) VALUES (123, '2011-01-07');
INSERT INTO `Club_DB`.`Member` (`Member_SSN`, `MembershipStartDate`) VALUES (124, '2011-11-16');
INSERT INTO `Club_DB`.`Member` (`Member_SSN`, `MembershipStartDate`) VALUES (125, '2021-02-15');
INSERT INTO `Club_DB`.`Member` (`Member_SSN`, `MembershipStartDate`) VALUES (126, '2006-01-11');
INSERT INTO `Club_DB`.`Member` (`Member_SSN`, `MembershipStartDate`) VALUES (127, '2008-08-24');
INSERT INTO `Club_DB`.`Member` (`Member_SSN`, `MembershipStartDate`) VALUES (128, '2021-10-22');
INSERT INTO `Club_DB`.`Member` (`Member_SSN`, `MembershipStartDate`) VALUES (129, '2019-07-15');
INSERT INTO `Club_DB`.`Member` (`Member_SSN`, `MembershipStartDate`) VALUES (130, '2006-05-10');
INSERT INTO `Club_DB`.`Member` (`Member_SSN`, `MembershipStartDate`) VALUES (131, '2022-01-24');
INSERT INTO `Club_DB`.`Member` (`Member_SSN`, `MembershipStartDate`) VALUES (132, '2017-11-08');
INSERT INTO `Club_DB`.`Member` (`Member_SSN`, `MembershipStartDate`) VALUES (133, '2022-01-08');
INSERT INTO `Club_DB`.`Member` (`Member_SSN`, `MembershipStartDate`) VALUES (134, '2022-07-07');
INSERT INTO `Club_DB`.`Member` (`Member_SSN`, `MembershipStartDate`) VALUES (135, '2009-07-06');
INSERT INTO `Club_DB`.`Member` (`Member_SSN`, `MembershipStartDate`) VALUES (136, '2020-07-05');
INSERT INTO `Club_DB`.`Member` (`Member_SSN`, `MembershipStartDate`) VALUES (137, '2005-12-04');
INSERT INTO `Club_DB`.`Member` (`Member_SSN`, `MembershipStartDate`) VALUES (138, '2021-04-01');
INSERT INTO `Club_DB`.`Member` (`Member_SSN`, `MembershipStartDate`) VALUES (139, '2021-06-16');
INSERT INTO `Club_DB`.`Member` (`Member_SSN`, `MembershipStartDate`) VALUES (140, '2011-08-03');
INSERT INTO `Club_DB`.`Member` (`Member_SSN`, `MembershipStartDate`) VALUES (141, '2017-05-15');
INSERT INTO `Club_DB`.`Member` (`Member_SSN`, `MembershipStartDate`) VALUES (142, '2021-10-16');
INSERT INTO `Club_DB`.`Member` (`Member_SSN`, `MembershipStartDate`) VALUES (143, '2015-03-27');
INSERT INTO `Club_DB`.`Member` (`Member_SSN`, `MembershipStartDate`) VALUES (144, '2009-04-04');
INSERT INTO `Club_DB`.`Member` (`Member_SSN`, `MembershipStartDate`) VALUES (145, '2019-08-04');
INSERT INTO `Club_DB`.`Member` (`Member_SSN`, `MembershipStartDate`) VALUES (146, '2012-11-27');
INSERT INTO `Club_DB`.`Member` (`Member_SSN`, `MembershipStartDate`) VALUES (147, '2020-11-25');
INSERT INTO `Club_DB`.`Member` (`Member_SSN`, `MembershipStartDate`) VALUES (148, '2015-11-23');
INSERT INTO `Club_DB`.`Member` (`Member_SSN`, `MembershipStartDate`) VALUES (149, '2022-07-20');
INSERT INTO `Club_DB`.`Member` (`Member_SSN`, `MembershipStartDate`) VALUES (150, '2021-03-01');
INSERT INTO `Club_DB`.`Member` (`Member_SSN`, `MembershipStartDate`) VALUES (151, '2015-12-01');
INSERT INTO `Club_DB`.`Member` (`Member_SSN`, `MembershipStartDate`) VALUES (152, '2015-07-15');
INSERT INTO `Club_DB`.`Member` (`Member_SSN`, `MembershipStartDate`) VALUES (153, '2021-02-13');
INSERT INTO `Club_DB`.`Member` (`Member_SSN`, `MembershipStartDate`) VALUES (154, '2009-08-24');
INSERT INTO `Club_DB`.`Member` (`Member_SSN`, `MembershipStartDate`) VALUES (155, '2006-08-08');
INSERT INTO `Club_DB`.`Member` (`Member_SSN`, `MembershipStartDate`) VALUES (156, '2014-05-09');
INSERT INTO `Club_DB`.`Member` (`Member_SSN`, `MembershipStartDate`) VALUES (157, '2008-10-06');
INSERT INTO `Club_DB`.`Member` (`Member_SSN`, `MembershipStartDate`) VALUES (158, '2018-01-25');
INSERT INTO `Club_DB`.`Member` (`Member_SSN`, `MembershipStartDate`) VALUES (159, '2021-11-01');
INSERT INTO `Club_DB`.`Member` (`Member_SSN`, `MembershipStartDate`) VALUES (160, '2014-06-16');
INSERT INTO `Club_DB`.`Member` (`Member_SSN`, `MembershipStartDate`) VALUES (161, '2019-08-21');
INSERT INTO `Club_DB`.`Member` (`Member_SSN`, `MembershipStartDate`) VALUES (162, '2010-11-21');
INSERT INTO `Club_DB`.`Member` (`Member_SSN`, `MembershipStartDate`) VALUES (163, '2007-02-04');
INSERT INTO `Club_DB`.`Member` (`Member_SSN`, `MembershipStartDate`) VALUES (164, '2019-06-21');
INSERT INTO `Club_DB`.`Member` (`Member_SSN`, `MembershipStartDate`) VALUES (165, '2020-03-13');
INSERT INTO `Club_DB`.`Member` (`Member_SSN`, `MembershipStartDate`) VALUES (166, '2008-10-12');
INSERT INTO `Club_DB`.`Member` (`Member_SSN`, `MembershipStartDate`) VALUES (167, '2022-06-12');
INSERT INTO `Club_DB`.`Member` (`Member_SSN`, `MembershipStartDate`) VALUES (168, '2007-10-08');
INSERT INTO `Club_DB`.`Member` (`Member_SSN`, `MembershipStartDate`) VALUES (169, '2007-06-25');
INSERT INTO `Club_DB`.`Member` (`Member_SSN`, `MembershipStartDate`) VALUES (170, '2019-02-26');
INSERT INTO `Club_DB`.`Member` (`Member_SSN`, `MembershipStartDate`) VALUES (171, '2018-11-12');
INSERT INTO `Club_DB`.`Member` (`Member_SSN`, `MembershipStartDate`) VALUES (172, '2010-09-22');
INSERT INTO `Club_DB`.`Member` (`Member_SSN`, `MembershipStartDate`) VALUES (173, '2008-08-17');
INSERT INTO `Club_DB`.`Member` (`Member_SSN`, `MembershipStartDate`) VALUES (174, '2020-07-26');
INSERT INTO `Club_DB`.`Member` (`Member_SSN`, `MembershipStartDate`) VALUES (175, '2010-10-17');
INSERT INTO `Club_DB`.`Member` (`Member_SSN`, `MembershipStartDate`) VALUES (176, '2013-11-16');
INSERT INTO `Club_DB`.`Member` (`Member_SSN`, `MembershipStartDate`) VALUES (177, '2014-01-04');
INSERT INTO `Club_DB`.`Member` (`Member_SSN`, `MembershipStartDate`) VALUES (178, '2009-11-14');
INSERT INTO `Club_DB`.`Member` (`Member_SSN`, `MembershipStartDate`) VALUES (179, '2017-04-22');
INSERT INTO `Club_DB`.`Member` (`Member_SSN`, `MembershipStartDate`) VALUES (180, '2009-04-25');
INSERT INTO `Club_DB`.`Member` (`Member_SSN`, `MembershipStartDate`) VALUES (181, '2020-03-04');
INSERT INTO `Club_DB`.`Member` (`Member_SSN`, `MembershipStartDate`) VALUES (182, '2012-11-12');
INSERT INTO `Club_DB`.`Member` (`Member_SSN`, `MembershipStartDate`) VALUES (183, '2005-11-28');
INSERT INTO `Club_DB`.`Member` (`Member_SSN`, `MembershipStartDate`) VALUES (184, '2015-04-15');
INSERT INTO `Club_DB`.`Member` (`Member_SSN`, `MembershipStartDate`) VALUES (185, '2006-10-27');
INSERT INTO `Club_DB`.`Member` (`Member_SSN`, `MembershipStartDate`) VALUES (186, '2016-12-07');
INSERT INTO `Club_DB`.`Member` (`Member_SSN`, `MembershipStartDate`) VALUES (187, '2018-05-28');
INSERT INTO `Club_DB`.`Member` (`Member_SSN`, `MembershipStartDate`) VALUES (188, '2019-11-04');
INSERT INTO `Club_DB`.`Member` (`Member_SSN`, `MembershipStartDate`) VALUES (189, '2016-01-08');
INSERT INTO `Club_DB`.`Member` (`Member_SSN`, `MembershipStartDate`) VALUES (190, '2021-05-12');
INSERT INTO `Club_DB`.`Member` (`Member_SSN`, `MembershipStartDate`) VALUES (191, '2015-05-02');
INSERT INTO `Club_DB`.`Member` (`Member_SSN`, `MembershipStartDate`) VALUES (192, '2009-07-24');
INSERT INTO `Club_DB`.`Member` (`Member_SSN`, `MembershipStartDate`) VALUES (193, '2008-10-13');
INSERT INTO `Club_DB`.`Member` (`Member_SSN`, `MembershipStartDate`) VALUES (194, '2009-06-26');
INSERT INTO `Club_DB`.`Member` (`Member_SSN`, `MembershipStartDate`) VALUES (195, '2021-08-07');
INSERT INTO `Club_DB`.`Member` (`Member_SSN`, `MembershipStartDate`) VALUES (196, '2011-01-25');
INSERT INTO `Club_DB`.`Member` (`Member_SSN`, `MembershipStartDate`) VALUES (197, '2019-10-08');
INSERT INTO `Club_DB`.`Member` (`Member_SSN`, `MembershipStartDate`) VALUES (198, '2021-09-26');
INSERT INTO `Club_DB`.`Member` (`Member_SSN`, `MembershipStartDate`) VALUES (199, '2020-05-04');
INSERT INTO `Club_DB`.`Member` (`Member_SSN`, `MembershipStartDate`) VALUES (200, '2020-08-23');
INSERT INTO `Club_DB`.`Member` (`Member_SSN`, `MembershipStartDate`) VALUES (268, '2019-06-26');
INSERT INTO `Club_DB`.`Member` (`Member_SSN`, `MembershipStartDate`) VALUES (269, '2023-03-01');
INSERT INTO `Club_DB`.`Member` (`Member_SSN`, `MembershipStartDate`) VALUES (270, '2019-09-11');
INSERT INTO `Club_DB`.`Member` (`Member_SSN`, `MembershipStartDate`) VALUES (271, '2018-02-03');
INSERT INTO `Club_DB`.`Member` (`Member_SSN`, `MembershipStartDate`) VALUES (272, '2019-12-12');
INSERT INTO `Club_DB`.`Member` (`Member_SSN`, `MembershipStartDate`) VALUES (273, '2020-07-26');
INSERT INTO `Club_DB`.`Member` (`Member_SSN`, `MembershipStartDate`) VALUES (274, '2018-11-23');
INSERT INTO `Club_DB`.`Member` (`Member_SSN`, `MembershipStartDate`) VALUES (275, '2023-07-28');
INSERT INTO `Club_DB`.`Member` (`Member_SSN`, `MembershipStartDate`) VALUES (276, '2020-03-08');
INSERT INTO `Club_DB`.`Member` (`Member_SSN`, `MembershipStartDate`) VALUES (277, '2020-02-07');
INSERT INTO `Club_DB`.`Member` (`Member_SSN`, `MembershipStartDate`) VALUES (278, '2019-03-24');
INSERT INTO `Club_DB`.`Member` (`Member_SSN`, `MembershipStartDate`) VALUES (279, '2019-08-26');
INSERT INTO `Club_DB`.`Member` (`Member_SSN`, `MembershipStartDate`) VALUES (280, '2020-04-15');
INSERT INTO `Club_DB`.`Member` (`Member_SSN`, `MembershipStartDate`) VALUES (281, '2018-04-19');
INSERT INTO `Club_DB`.`Member` (`Member_SSN`, `MembershipStartDate`) VALUES (282, '2020-09-22');
INSERT INTO `Club_DB`.`Member` (`Member_SSN`, `MembershipStartDate`) VALUES (283, '2018-12-03');
INSERT INTO `Club_DB`.`Member` (`Member_SSN`, `MembershipStartDate`) VALUES (284, '2022-06-19');
INSERT INTO `Club_DB`.`Member` (`Member_SSN`, `MembershipStartDate`) VALUES (285, '2020-01-25');
INSERT INTO `Club_DB`.`Member` (`Member_SSN`, `MembershipStartDate`) VALUES (286, '2018-06-17');
INSERT INTO `Club_DB`.`Member` (`Member_SSN`, `MembershipStartDate`) VALUES (287, '2019-03-23');
INSERT INTO `Club_DB`.`Member` (`Member_SSN`, `MembershipStartDate`) VALUES (288, '2020-11-28');
INSERT INTO `Club_DB`.`Member` (`Member_SSN`, `MembershipStartDate`) VALUES (289, '2023-11-10');
INSERT INTO `Club_DB`.`Member` (`Member_SSN`, `MembershipStartDate`) VALUES (290, '2022-01-18');
INSERT INTO `Club_DB`.`Member` (`Member_SSN`, `MembershipStartDate`) VALUES (291, '2022-06-22');
INSERT INTO `Club_DB`.`Member` (`Member_SSN`, `MembershipStartDate`) VALUES (292, '2021-06-23');
INSERT INTO `Club_DB`.`Member` (`Member_SSN`, `MembershipStartDate`) VALUES (293, '2018-06-02');
INSERT INTO `Club_DB`.`Member` (`Member_SSN`, `MembershipStartDate`) VALUES (294, '2021-12-18');
INSERT INTO `Club_DB`.`Member` (`Member_SSN`, `MembershipStartDate`) VALUES (295, '2018-05-24');
INSERT INTO `Club_DB`.`Member` (`Member_SSN`, `MembershipStartDate`) VALUES (296, '2023-09-23');
INSERT INTO `Club_DB`.`Member` (`Member_SSN`, `MembershipStartDate`) VALUES (297, '2020-07-03');
INSERT INTO `Club_DB`.`Member` (`Member_SSN`, `MembershipStartDate`) VALUES (298, '2021-11-24');
INSERT INTO `Club_DB`.`Member` (`Member_SSN`, `MembershipStartDate`) VALUES (299, '2018-01-21');
INSERT INTO `Club_DB`.`Member` (`Member_SSN`, `MembershipStartDate`) VALUES (300, '2018-03-21');
INSERT INTO `Club_DB`.`Member` (`Member_SSN`, `MembershipStartDate`) VALUES (301, '2018-06-01');
INSERT INTO `Club_DB`.`Member` (`Member_SSN`, `MembershipStartDate`) VALUES (302, '2023-08-18');
INSERT INTO `Club_DB`.`Member` (`Member_SSN`, `MembershipStartDate`) VALUES (303, '2023-07-21');
INSERT INTO `Club_DB`.`Member` (`Member_SSN`, `MembershipStartDate`) VALUES (304, '2020-01-24');
INSERT INTO `Club_DB`.`Member` (`Member_SSN`, `MembershipStartDate`) VALUES (305, '2019-01-08');
INSERT INTO `Club_DB`.`Member` (`Member_SSN`, `MembershipStartDate`) VALUES (306, '2023-11-05');
INSERT INTO `Club_DB`.`Member` (`Member_SSN`, `MembershipStartDate`) VALUES (307, '2022-06-23');
INSERT INTO `Club_DB`.`Member` (`Member_SSN`, `MembershipStartDate`) VALUES (308, '2023-10-12');
INSERT INTO `Club_DB`.`Member` (`Member_SSN`, `MembershipStartDate`) VALUES (309, '2018-11-17');
INSERT INTO `Club_DB`.`Member` (`Member_SSN`, `MembershipStartDate`) VALUES (310, '2023-09-22');
INSERT INTO `Club_DB`.`Member` (`Member_SSN`, `MembershipStartDate`) VALUES (311, '2019-12-09');
INSERT INTO `Club_DB`.`Member` (`Member_SSN`, `MembershipStartDate`) VALUES (312, '2018-05-03');
INSERT INTO `Club_DB`.`Member` (`Member_SSN`, `MembershipStartDate`) VALUES (313, '2021-05-16');
INSERT INTO `Club_DB`.`Member` (`Member_SSN`, `MembershipStartDate`) VALUES (314, '2023-04-15');
INSERT INTO `Club_DB`.`Member` (`Member_SSN`, `MembershipStartDate`) VALUES (315, '2021-05-14');
INSERT INTO `Club_DB`.`Member` (`Member_SSN`, `MembershipStartDate`) VALUES (316, '2023-05-09');
INSERT INTO `Club_DB`.`Member` (`Member_SSN`, `MembershipStartDate`) VALUES (317, '2022-06-16');
INSERT INTO `Club_DB`.`Member` (`Member_SSN`, `MembershipStartDate`) VALUES (318, '2021-11-28');
INSERT INTO `Club_DB`.`Member` (`Member_SSN`, `MembershipStartDate`) VALUES (319, '2022-11-11');
INSERT INTO `Club_DB`.`Member` (`Member_SSN`, `MembershipStartDate`) VALUES (320, '2020-04-19');
INSERT INTO `Club_DB`.`Member` (`Member_SSN`, `MembershipStartDate`) VALUES (321, '2018-08-14');
INSERT INTO `Club_DB`.`Member` (`Member_SSN`, `MembershipStartDate`) VALUES (322, '2022-08-18');
INSERT INTO `Club_DB`.`Member` (`Member_SSN`, `MembershipStartDate`) VALUES (323, '2020-07-24');
INSERT INTO `Club_DB`.`Member` (`Member_SSN`, `MembershipStartDate`) VALUES (324, '2020-01-06');
INSERT INTO `Club_DB`.`Member` (`Member_SSN`, `MembershipStartDate`) VALUES (325, '2018-08-15');
INSERT INTO `Club_DB`.`Member` (`Member_SSN`, `MembershipStartDate`) VALUES (326, '2019-01-03');
INSERT INTO `Club_DB`.`Member` (`Member_SSN`, `MembershipStartDate`) VALUES (327, '2020-02-22');
INSERT INTO `Club_DB`.`Member` (`Member_SSN`, `MembershipStartDate`) VALUES (328, '2019-12-19');
INSERT INTO `Club_DB`.`Member` (`Member_SSN`, `MembershipStartDate`) VALUES (329, '2021-05-01');
INSERT INTO `Club_DB`.`Member` (`Member_SSN`, `MembershipStartDate`) VALUES (330, '2018-01-16');
INSERT INTO `Club_DB`.`Member` (`Member_SSN`, `MembershipStartDate`) VALUES (331, '2018-05-12');
INSERT INTO `Club_DB`.`Member` (`Member_SSN`, `MembershipStartDate`) VALUES (332, '2018-02-21');
INSERT INTO `Club_DB`.`Member` (`Member_SSN`, `MembershipStartDate`) VALUES (333, '2018-07-01');
INSERT INTO `Club_DB`.`Member` (`Member_SSN`, `MembershipStartDate`) VALUES (334, '2022-04-17');
INSERT INTO `Club_DB`.`Member` (`Member_SSN`, `MembershipStartDate`) VALUES (335, '2019-11-06');
INSERT INTO `Club_DB`.`Member` (`Member_SSN`, `MembershipStartDate`) VALUES (336, '2021-10-14');
INSERT INTO `Club_DB`.`Member` (`Member_SSN`, `MembershipStartDate`) VALUES (337, '2023-04-07');
INSERT INTO `Club_DB`.`Member` (`Member_SSN`, `MembershipStartDate`) VALUES (338, '2018-04-07');
INSERT INTO `Club_DB`.`Member` (`Member_SSN`, `MembershipStartDate`) VALUES (339, '2019-12-19');
INSERT INTO `Club_DB`.`Member` (`Member_SSN`, `MembershipStartDate`) VALUES (340, '2019-08-05');
INSERT INTO `Club_DB`.`Member` (`Member_SSN`, `MembershipStartDate`) VALUES (341, '2023-12-18');
INSERT INTO `Club_DB`.`Member` (`Member_SSN`, `MembershipStartDate`) VALUES (342, '2021-12-27');
INSERT INTO `Club_DB`.`Member` (`Member_SSN`, `MembershipStartDate`) VALUES (343, '2019-02-28');
INSERT INTO `Club_DB`.`Member` (`Member_SSN`, `MembershipStartDate`) VALUES (344, '2022-01-21');
INSERT INTO `Club_DB`.`Member` (`Member_SSN`, `MembershipStartDate`) VALUES (345, '2023-11-12');
INSERT INTO `Club_DB`.`Member` (`Member_SSN`, `MembershipStartDate`) VALUES (346, '2019-12-25');
INSERT INTO `Club_DB`.`Member` (`Member_SSN`, `MembershipStartDate`) VALUES (347, '2019-12-24');

COMMIT;


-- -----------------------------------------------------
-- Data for table `Club_DB`.`Employee`
-- -----------------------------------------------------
START TRANSACTION;
USE `Club_DB`;
INSERT INTO `Club_DB`.`Employee` (`Employee_SSN`, `Salary`) VALUES (115, 75000);
INSERT INTO `Club_DB`.`Employee` (`Employee_SSN`, `Salary`) VALUES (116, 76700);
INSERT INTO `Club_DB`.`Employee` (`Employee_SSN`, `Salary`) VALUES (117, 76000);
INSERT INTO `Club_DB`.`Employee` (`Employee_SSN`, `Salary`) VALUES (118, 78000);
INSERT INTO `Club_DB`.`Employee` (`Employee_SSN`, `Salary`) VALUES (119, 78900);
INSERT INTO `Club_DB`.`Employee` (`Employee_SSN`, `Salary`) VALUES (120, 90000);
INSERT INTO `Club_DB`.`Employee` (`Employee_SSN`, `Salary`) VALUES (121, 75000);
INSERT INTO `Club_DB`.`Employee` (`Employee_SSN`, `Salary`) VALUES (122, 75000);
INSERT INTO `Club_DB`.`Employee` (`Employee_SSN`, `Salary`) VALUES (123, 77400);
INSERT INTO `Club_DB`.`Employee` (`Employee_SSN`, `Salary`) VALUES (124, 82500);
INSERT INTO `Club_DB`.`Employee` (`Employee_SSN`, `Salary`) VALUES (125, 81000);
INSERT INTO `Club_DB`.`Employee` (`Employee_SSN`, `Salary`) VALUES (126, 77600);
INSERT INTO `Club_DB`.`Employee` (`Employee_SSN`, `Salary`) VALUES (127, 76000);
INSERT INTO `Club_DB`.`Employee` (`Employee_SSN`, `Salary`) VALUES (128, 78900);
INSERT INTO `Club_DB`.`Employee` (`Employee_SSN`, `Salary`) VALUES (129, 79800);
INSERT INTO `Club_DB`.`Employee` (`Employee_SSN`, `Salary`) VALUES (130, 76000);
INSERT INTO `Club_DB`.`Employee` (`Employee_SSN`, `Salary`) VALUES (131, 80000);
INSERT INTO `Club_DB`.`Employee` (`Employee_SSN`, `Salary`) VALUES (132, 88750);
INSERT INTO `Club_DB`.`Employee` (`Employee_SSN`, `Salary`) VALUES (133, 78900);
INSERT INTO `Club_DB`.`Employee` (`Employee_SSN`, `Salary`) VALUES (134, 84000);
INSERT INTO `Club_DB`.`Employee` (`Employee_SSN`, `Salary`) VALUES (135, 135000);
INSERT INTO `Club_DB`.`Employee` (`Employee_SSN`, `Salary`) VALUES (136, 78900);
INSERT INTO `Club_DB`.`Employee` (`Employee_SSN`, `Salary`) VALUES (137, 82100);
INSERT INTO `Club_DB`.`Employee` (`Employee_SSN`, `Salary`) VALUES (138, 81000);
INSERT INTO `Club_DB`.`Employee` (`Employee_SSN`, `Salary`) VALUES (139, 76800);
INSERT INTO `Club_DB`.`Employee` (`Employee_SSN`, `Salary`) VALUES (140, 120000);
INSERT INTO `Club_DB`.`Employee` (`Employee_SSN`, `Salary`) VALUES (141, 83000);
INSERT INTO `Club_DB`.`Employee` (`Employee_SSN`, `Salary`) VALUES (142, 78000);
INSERT INTO `Club_DB`.`Employee` (`Employee_SSN`, `Salary`) VALUES (143, 76700);
INSERT INTO `Club_DB`.`Employee` (`Employee_SSN`, `Salary`) VALUES (144, 74700);
INSERT INTO `Club_DB`.`Employee` (`Employee_SSN`, `Salary`) VALUES (145, 84700);
INSERT INTO `Club_DB`.`Employee` (`Employee_SSN`, `Salary`) VALUES (146, 86430);
INSERT INTO `Club_DB`.`Employee` (`Employee_SSN`, `Salary`) VALUES (147, 125000);
INSERT INTO `Club_DB`.`Employee` (`Employee_SSN`, `Salary`) VALUES (148, 127000);
INSERT INTO `Club_DB`.`Employee` (`Employee_SSN`, `Salary`) VALUES (149, 200000);
INSERT INTO `Club_DB`.`Employee` (`Employee_SSN`, `Salary`) VALUES (150, 188600);
INSERT INTO `Club_DB`.`Employee` (`Employee_SSN`, `Salary`) VALUES (151, 178000);
INSERT INTO `Club_DB`.`Employee` (`Employee_SSN`, `Salary`) VALUES (152, 167000);
INSERT INTO `Club_DB`.`Employee` (`Employee_SSN`, `Salary`) VALUES (201, 50014);
INSERT INTO `Club_DB`.`Employee` (`Employee_SSN`, `Salary`) VALUES (202, 52358);
INSERT INTO `Club_DB`.`Employee` (`Employee_SSN`, `Salary`) VALUES (203, 52213);
INSERT INTO `Club_DB`.`Employee` (`Employee_SSN`, `Salary`) VALUES (204, 52513);
INSERT INTO `Club_DB`.`Employee` (`Employee_SSN`, `Salary`) VALUES (205, 52532);
INSERT INTO `Club_DB`.`Employee` (`Employee_SSN`, `Salary`) VALUES (206, 49880);
INSERT INTO `Club_DB`.`Employee` (`Employee_SSN`, `Salary`) VALUES (207, 54920);
INSERT INTO `Club_DB`.`Employee` (`Employee_SSN`, `Salary`) VALUES (208, 90000);
INSERT INTO `Club_DB`.`Employee` (`Employee_SSN`, `Salary`) VALUES (209, 52118);
INSERT INTO `Club_DB`.`Employee` (`Employee_SSN`, `Salary`) VALUES (210, 51135);
INSERT INTO `Club_DB`.`Employee` (`Employee_SSN`, `Salary`) VALUES (211, 48826);
INSERT INTO `Club_DB`.`Employee` (`Employee_SSN`, `Salary`) VALUES (212, 50144);
INSERT INTO `Club_DB`.`Employee` (`Employee_SSN`, `Salary`) VALUES (213, 52281);
INSERT INTO `Club_DB`.`Employee` (`Employee_SSN`, `Salary`) VALUES (214, 51642);
INSERT INTO `Club_DB`.`Employee` (`Employee_SSN`, `Salary`) VALUES (215, 52862);
INSERT INTO `Club_DB`.`Employee` (`Employee_SSN`, `Salary`) VALUES (216, 90000);
INSERT INTO `Club_DB`.`Employee` (`Employee_SSN`, `Salary`) VALUES (217, 49044);
INSERT INTO `Club_DB`.`Employee` (`Employee_SSN`, `Salary`) VALUES (218, 54482);
INSERT INTO `Club_DB`.`Employee` (`Employee_SSN`, `Salary`) VALUES (219, 50147);
INSERT INTO `Club_DB`.`Employee` (`Employee_SSN`, `Salary`) VALUES (220, 49752);
INSERT INTO `Club_DB`.`Employee` (`Employee_SSN`, `Salary`) VALUES (221, 53561);
INSERT INTO `Club_DB`.`Employee` (`Employee_SSN`, `Salary`) VALUES (222, 52766);
INSERT INTO `Club_DB`.`Employee` (`Employee_SSN`, `Salary`) VALUES (223, 52935);
INSERT INTO `Club_DB`.`Employee` (`Employee_SSN`, `Salary`) VALUES (224, 87500);
INSERT INTO `Club_DB`.`Employee` (`Employee_SSN`, `Salary`) VALUES (225, 51668);
INSERT INTO `Club_DB`.`Employee` (`Employee_SSN`, `Salary`) VALUES (226, 53573);
INSERT INTO `Club_DB`.`Employee` (`Employee_SSN`, `Salary`) VALUES (227, 49987);
INSERT INTO `Club_DB`.`Employee` (`Employee_SSN`, `Salary`) VALUES (228, 53104);
INSERT INTO `Club_DB`.`Employee` (`Employee_SSN`, `Salary`) VALUES (229, 50778);
INSERT INTO `Club_DB`.`Employee` (`Employee_SSN`, `Salary`) VALUES (230, 48312);
INSERT INTO `Club_DB`.`Employee` (`Employee_SSN`, `Salary`) VALUES (231, 48638);
INSERT INTO `Club_DB`.`Employee` (`Employee_SSN`, `Salary`) VALUES (232, 90000);
INSERT INTO `Club_DB`.`Employee` (`Employee_SSN`, `Salary`) VALUES (233, 48394);
INSERT INTO `Club_DB`.`Employee` (`Employee_SSN`, `Salary`) VALUES (234, 53354);
INSERT INTO `Club_DB`.`Employee` (`Employee_SSN`, `Salary`) VALUES (235, 54066);
INSERT INTO `Club_DB`.`Employee` (`Employee_SSN`, `Salary`) VALUES (236, 50447);
INSERT INTO `Club_DB`.`Employee` (`Employee_SSN`, `Salary`) VALUES (237, 48486);
INSERT INTO `Club_DB`.`Employee` (`Employee_SSN`, `Salary`) VALUES (238, 87500);
INSERT INTO `Club_DB`.`Employee` (`Employee_SSN`, `Salary`) VALUES (239, 49813);
INSERT INTO `Club_DB`.`Employee` (`Employee_SSN`, `Salary`) VALUES (240, 49365);
INSERT INTO `Club_DB`.`Employee` (`Employee_SSN`, `Salary`) VALUES (241, 53241);
INSERT INTO `Club_DB`.`Employee` (`Employee_SSN`, `Salary`) VALUES (242, 48523);
INSERT INTO `Club_DB`.`Employee` (`Employee_SSN`, `Salary`) VALUES (243, 48380);
INSERT INTO `Club_DB`.`Employee` (`Employee_SSN`, `Salary`) VALUES (244, 88000);
INSERT INTO `Club_DB`.`Employee` (`Employee_SSN`, `Salary`) VALUES (245, 54032);
INSERT INTO `Club_DB`.`Employee` (`Employee_SSN`, `Salary`) VALUES (246, 50613);
INSERT INTO `Club_DB`.`Employee` (`Employee_SSN`, `Salary`) VALUES (247, 53402);
INSERT INTO `Club_DB`.`Employee` (`Employee_SSN`, `Salary`) VALUES (248, 54106);
INSERT INTO `Club_DB`.`Employee` (`Employee_SSN`, `Salary`) VALUES (249, 82500);
INSERT INTO `Club_DB`.`Employee` (`Employee_SSN`, `Salary`) VALUES (250, 49879);
INSERT INTO `Club_DB`.`Employee` (`Employee_SSN`, `Salary`) VALUES (251, 49150);
INSERT INTO `Club_DB`.`Employee` (`Employee_SSN`, `Salary`) VALUES (252, 54024);
INSERT INTO `Club_DB`.`Employee` (`Employee_SSN`, `Salary`) VALUES (253, 50835);
INSERT INTO `Club_DB`.`Employee` (`Employee_SSN`, `Salary`) VALUES (254, 82500);
INSERT INTO `Club_DB`.`Employee` (`Employee_SSN`, `Salary`) VALUES (255, 48600);
INSERT INTO `Club_DB`.`Employee` (`Employee_SSN`, `Salary`) VALUES (256, 49076);
INSERT INTO `Club_DB`.`Employee` (`Employee_SSN`, `Salary`) VALUES (257, 48299);
INSERT INTO `Club_DB`.`Employee` (`Employee_SSN`, `Salary`) VALUES (258, 49161);
INSERT INTO `Club_DB`.`Employee` (`Employee_SSN`, `Salary`) VALUES (259, 82500);
INSERT INTO `Club_DB`.`Employee` (`Employee_SSN`, `Salary`) VALUES (260, 53354);
INSERT INTO `Club_DB`.`Employee` (`Employee_SSN`, `Salary`) VALUES (261, 50037);
INSERT INTO `Club_DB`.`Employee` (`Employee_SSN`, `Salary`) VALUES (262, 48907);
INSERT INTO `Club_DB`.`Employee` (`Employee_SSN`, `Salary`) VALUES (263, 51407);
INSERT INTO `Club_DB`.`Employee` (`Employee_SSN`, `Salary`) VALUES (264, 49817);
INSERT INTO `Club_DB`.`Employee` (`Employee_SSN`, `Salary`) VALUES (265, 54576);
INSERT INTO `Club_DB`.`Employee` (`Employee_SSN`, `Salary`) VALUES (266, 54773);
INSERT INTO `Club_DB`.`Employee` (`Employee_SSN`, `Salary`) VALUES (267, 87600);

COMMIT;


-- -----------------------------------------------------
-- Data for table `Club_DB`.`Management`
-- -----------------------------------------------------
START TRANSACTION;
USE `Club_DB`;
INSERT INTO `Club_DB`.`Management` (`Name`, `Manager_SSN`) VALUES ('Sport',  130);
INSERT INTO `Club_DB`.`Management` (`Name`, `Manager_SSN`) VALUES ('Events',  135);
INSERT INTO `Club_DB`.`Management` (`Name`, `Manager_SSN`) VALUES ('Quality',  140);
INSERT INTO `Club_DB`.`Management` (`Name`, `Manager_SSN`) VALUES ('Services',  148);
INSERT INTO `Club_DB`.`Management` (`Name`, `Manager_SSN`) VALUES ('Board',  149);

COMMIT;


-- -----------------------------------------------------
-- Data for table `Club_DB`.`Pro_Player`
-- -----------------------------------------------------
START TRANSACTION;
USE `Club_DB`;
INSERT INTO `Club_DB`.`Pro_Player` (`Player_SSN`, `Management_Name`, `SportName`, `Salary`, `ContractStart`, `ContractEnd`) VALUES (1, 'Sport', 'Football', 409916, '2022-03-03', '2025-06-23');
INSERT INTO `Club_DB`.`Pro_Player` (`Player_SSN`, `Management_Name`, `SportName`, `Salary`, `ContractStart`, `ContractEnd`) VALUES (2, 'Sport', 'Football', 282056, '2021-08-05', '2025-10-02');
INSERT INTO `Club_DB`.`Pro_Player` (`Player_SSN`, `Management_Name`, `SportName`, `Salary`, `ContractStart`, `ContractEnd`) VALUES (3, 'Sport', 'Football', 422345, '2020-10-04', '2024-01-12');
INSERT INTO `Club_DB`.`Pro_Player` (`Player_SSN`, `Management_Name`, `SportName`, `Salary`, `ContractStart`, `ContractEnd`) VALUES (4, 'Sport', 'Football', 424615, '2023-12-05', '2026-10-27');
INSERT INTO `Club_DB`.`Pro_Player` (`Player_SSN`, `Management_Name`, `SportName`, `Salary`, `ContractStart`, `ContractEnd`) VALUES (5, 'Sport', 'Football', 426611, '2020-10-05', '2026-04-18');
INSERT INTO `Club_DB`.`Pro_Player` (`Player_SSN`, `Management_Name`, `SportName`, `Salary`, `ContractStart`, `ContractEnd`) VALUES (6, 'Sport', 'Football', 373424, '2022-07-06', '2024-06-14');
INSERT INTO `Club_DB`.`Pro_Player` (`Player_SSN`, `Management_Name`, `SportName`, `Salary`, `ContractStart`, `ContractEnd`) VALUES (7, 'Sport', 'Football', 213697, '2020-01-05', '2025-12-06');
INSERT INTO `Club_DB`.`Pro_Player` (`Player_SSN`, `Management_Name`, `SportName`, `Salary`, `ContractStart`, `ContractEnd`) VALUES (8, 'Sport', 'Football', 292068, '2023-06-03', '2026-03-12');
INSERT INTO `Club_DB`.`Pro_Player` (`Player_SSN`, `Management_Name`, `SportName`, `Salary`, `ContractStart`, `ContractEnd`) VALUES (9, 'Sport', 'Football', 415439, '2023-05-01', '2024-05-03');
INSERT INTO `Club_DB`.`Pro_Player` (`Player_SSN`, `Management_Name`, `SportName`, `Salary`, `ContractStart`, `ContractEnd`) VALUES (10, 'Sport', 'Football', 433134, '2022-08-03', '2025-09-17');
INSERT INTO `Club_DB`.`Pro_Player` (`Player_SSN`, `Management_Name`, `SportName`, `Salary`, `ContractStart`, `ContractEnd`) VALUES (11, 'Sport', 'Football', 201077, '2020-05-06', '2024-08-11');
INSERT INTO `Club_DB`.`Pro_Player` (`Player_SSN`, `Management_Name`, `SportName`, `Salary`, `ContractStart`, `ContractEnd`) VALUES (12, 'Sport', 'Football', 338020, '2022-09-05', '2026-12-14');
INSERT INTO `Club_DB`.`Pro_Player` (`Player_SSN`, `Management_Name`, `SportName`, `Salary`, `ContractStart`, `ContractEnd`) VALUES (13, 'Sport', 'Football', 339133, '2023-06-01', '2024-06-23');
INSERT INTO `Club_DB`.`Pro_Player` (`Player_SSN`, `Management_Name`, `SportName`, `Salary`, `ContractStart`, `ContractEnd`) VALUES (14, 'Sport', 'Football', 210788, '2022-08-01', '2025-07-24');
INSERT INTO `Club_DB`.`Pro_Player` (`Player_SSN`, `Management_Name`, `SportName`, `Salary`, `ContractStart`, `ContractEnd`) VALUES (15, 'Sport', 'Football', 276596, '2020-06-01', '2025-10-24');
INSERT INTO `Club_DB`.`Pro_Player` (`Player_SSN`, `Management_Name`, `SportName`, `Salary`, `ContractStart`, `ContractEnd`) VALUES (16, 'Sport', 'Football', 385569, '2022-11-05', '2025-08-04');
INSERT INTO `Club_DB`.`Pro_Player` (`Player_SSN`, `Management_Name`, `SportName`, `Salary`, `ContractStart`, `ContractEnd`) VALUES (17, 'Sport', 'Football', 337675, '2023-09-04', '2026-08-26');
INSERT INTO `Club_DB`.`Pro_Player` (`Player_SSN`, `Management_Name`, `SportName`, `Salary`, `ContractStart`, `ContractEnd`) VALUES (18, 'Sport', 'Football', 336118, '2022-07-06', '2024-05-13');
INSERT INTO `Club_DB`.`Pro_Player` (`Player_SSN`, `Management_Name`, `SportName`, `Salary`, `ContractStart`, `ContractEnd`) VALUES (19, 'Sport', 'Football', 363535, '2021-07-03', '2025-01-03');
INSERT INTO `Club_DB`.`Pro_Player` (`Player_SSN`, `Management_Name`, `SportName`, `Salary`, `ContractStart`, `ContractEnd`) VALUES (20, 'Sport', 'Football', 374058, '2022-07-04', '2025-04-08');
INSERT INTO `Club_DB`.`Pro_Player` (`Player_SSN`, `Management_Name`, `SportName`, `Salary`, `ContractStart`, `ContractEnd`) VALUES (21, 'Sport', 'Football', 219003, '2022-09-01', '2025-03-22');
INSERT INTO `Club_DB`.`Pro_Player` (`Player_SSN`, `Management_Name`, `SportName`, `Salary`, `ContractStart`, `ContractEnd`) VALUES (22, 'Sport', 'Football', 281909, '2022-10-02', '2025-07-01');
INSERT INTO `Club_DB`.`Pro_Player` (`Player_SSN`, `Management_Name`, `SportName`, `Salary`, `ContractStart`, `ContractEnd`) VALUES (23, 'Sport', 'Football', 329828, '2022-08-05', '2026-08-16');
INSERT INTO `Club_DB`.`Pro_Player` (`Player_SSN`, `Management_Name`, `SportName`, `Salary`, `ContractStart`, `ContractEnd`) VALUES (24, 'Sport', 'Football', 352318, '2020-05-03', '2024-12-23');
INSERT INTO `Club_DB`.`Pro_Player` (`Player_SSN`, `Management_Name`, `SportName`, `Salary`, `ContractStart`, `ContractEnd`) VALUES (25, 'Sport', 'Football', 276201, '2020-11-02', '2025-07-25');
INSERT INTO `Club_DB`.`Pro_Player` (`Player_SSN`, `Management_Name`, `SportName`, `Salary`, `ContractStart`, `ContractEnd`) VALUES (26, 'Sport', 'Football', 361562, '2021-08-03', '2025-10-23');
INSERT INTO `Club_DB`.`Pro_Player` (`Player_SSN`, `Management_Name`, `SportName`, `Salary`, `ContractStart`, `ContractEnd`) VALUES (27, 'Sport', 'Football', 225535, '2022-11-05', '2024-07-25');
INSERT INTO `Club_DB`.`Pro_Player` (`Player_SSN`, `Management_Name`, `SportName`, `Salary`, `ContractStart`, `ContractEnd`) VALUES (28, 'Sport', 'Football', 262794, '2022-08-05', '2026-05-27');
INSERT INTO `Club_DB`.`Pro_Player` (`Player_SSN`, `Management_Name`, `SportName`, `Salary`, `ContractStart`, `ContractEnd`) VALUES (29, 'Sport', 'Football', 311242, '2023-08-04', '2024-08-02');
INSERT INTO `Club_DB`.`Pro_Player` (`Player_SSN`, `Management_Name`, `SportName`, `Salary`, `ContractStart`, `ContractEnd`) VALUES (30, 'Sport', 'Football', 399745, '2021-01-02', '2024-11-11');
INSERT INTO `Club_DB`.`Pro_Player` (`Player_SSN`, `Management_Name`, `SportName`, `Salary`, `ContractStart`, `ContractEnd`) VALUES (31, 'Sport', 'Football', 105811, '2020-02-02', '2025-03-02');
INSERT INTO `Club_DB`.`Pro_Player` (`Player_SSN`, `Management_Name`, `SportName`, `Salary`, `ContractStart`, `ContractEnd`) VALUES (32, 'Sport', 'Football', 97601, '2021-10-04', '2026-02-13');
INSERT INTO `Club_DB`.`Pro_Player` (`Player_SSN`, `Management_Name`, `SportName`, `Salary`, `ContractStart`, `ContractEnd`) VALUES (33, 'Sport', 'Football', 81436, '2020-06-03', '2024-12-15');
INSERT INTO `Club_DB`.`Pro_Player` (`Player_SSN`, `Management_Name`, `SportName`, `Salary`, `ContractStart`, `ContractEnd`) VALUES (34, 'Sport', 'Football', 105298, '2023-02-03', '2026-08-18');
INSERT INTO `Club_DB`.`Pro_Player` (`Player_SSN`, `Management_Name`, `SportName`, `Salary`, `ContractStart`, `ContractEnd`) VALUES (35, 'Sport', 'Football', 102287, '2020-10-04', '2024-05-27');
INSERT INTO `Club_DB`.`Pro_Player` (`Player_SSN`, `Management_Name`, `SportName`, `Salary`, `ContractStart`, `ContractEnd`) VALUES (36, 'Sport', 'Football', 78836, '2020-01-06', '2024-05-02');
INSERT INTO `Club_DB`.`Pro_Player` (`Player_SSN`, `Management_Name`, `SportName`, `Salary`, `ContractStart`, `ContractEnd`) VALUES (37, 'Sport', 'Football', 98450, '2022-11-03', '2025-12-10');
INSERT INTO `Club_DB`.`Pro_Player` (`Player_SSN`, `Management_Name`, `SportName`, `Salary`, `ContractStart`, `ContractEnd`) VALUES (38, 'Sport', 'Football', 81671, '2023-12-04', '2024-12-18');
INSERT INTO `Club_DB`.`Pro_Player` (`Player_SSN`, `Management_Name`, `SportName`, `Salary`, `ContractStart`, `ContractEnd`) VALUES (39, 'Sport', 'Football', 118825, '2023-04-03', '2025-04-22');
INSERT INTO `Club_DB`.`Pro_Player` (`Player_SSN`, `Management_Name`, `SportName`, `Salary`, `ContractStart`, `ContractEnd`) VALUES (40, 'Sport', 'Football', 86308, '2021-12-01', '2025-12-22');
INSERT INTO `Club_DB`.`Pro_Player` (`Player_SSN`, `Management_Name`, `SportName`, `Salary`, `ContractStart`, `ContractEnd`) VALUES (41, 'Sport', 'Football', 116795, '2023-05-01', '2024-04-18');
INSERT INTO `Club_DB`.`Pro_Player` (`Player_SSN`, `Management_Name`, `SportName`, `Salary`, `ContractStart`, `ContractEnd`) VALUES (42, 'Sport', 'Football', 95344, '2022-01-06', '2025-11-16');
INSERT INTO `Club_DB`.`Pro_Player` (`Player_SSN`, `Management_Name`, `SportName`, `Salary`, `ContractStart`, `ContractEnd`) VALUES (43, 'Sport', 'Football', 91095, '2023-07-05', '2024-01-16');
INSERT INTO `Club_DB`.`Pro_Player` (`Player_SSN`, `Management_Name`, `SportName`, `Salary`, `ContractStart`, `ContractEnd`) VALUES (44, 'Sport', 'Football', 108190, '2020-12-05', '2026-04-25');
INSERT INTO `Club_DB`.`Pro_Player` (`Player_SSN`, `Management_Name`, `SportName`, `Salary`, `ContractStart`, `ContractEnd`) VALUES (45, 'Sport', 'Football', 70694, '2022-09-05', '2024-07-07');
INSERT INTO `Club_DB`.`Pro_Player` (`Player_SSN`, `Management_Name`, `SportName`, `Salary`, `ContractStart`, `ContractEnd`) VALUES (46, 'Sport', 'Football', 88180, '2020-01-03', '2024-01-08');
INSERT INTO `Club_DB`.`Pro_Player` (`Player_SSN`, `Management_Name`, `SportName`, `Salary`, `ContractStart`, `ContractEnd`) VALUES (47, 'Sport', 'Football', 96955, '2022-12-05', '2024-12-16');
INSERT INTO `Club_DB`.`Pro_Player` (`Player_SSN`, `Management_Name`, `SportName`, `Salary`, `ContractStart`, `ContractEnd`) VALUES (48, 'Sport', 'Football', 77265, '2020-08-01', '2024-04-25');
INSERT INTO `Club_DB`.`Pro_Player` (`Player_SSN`, `Management_Name`, `SportName`, `Salary`, `ContractStart`, `ContractEnd`) VALUES (49, 'Sport', 'Football', 93806, '2021-06-06', '2025-04-28');
INSERT INTO `Club_DB`.`Pro_Player` (`Player_SSN`, `Management_Name`, `SportName`, `Salary`, `ContractStart`, `ContractEnd`) VALUES (50, 'Sport', 'Football', 80436, '2020-06-02', '2024-10-07');
INSERT INTO `Club_DB`.`Pro_Player` (`Player_SSN`, `Management_Name`, `SportName`, `Salary`, `ContractStart`, `ContractEnd`) VALUES (51, 'Sport', 'Football', 107698, '2023-09-05', '2025-10-08');
INSERT INTO `Club_DB`.`Pro_Player` (`Player_SSN`, `Management_Name`, `SportName`, `Salary`, `ContractStart`, `ContractEnd`) VALUES (52, 'Sport', 'Football', 110310, '2023-04-06', '2026-01-10');
INSERT INTO `Club_DB`.`Pro_Player` (`Player_SSN`, `Management_Name`, `SportName`, `Salary`, `ContractStart`, `ContractEnd`) VALUES (53, 'Sport', 'Football', 98607, '2023-05-04', '2024-09-19');
INSERT INTO `Club_DB`.`Pro_Player` (`Player_SSN`, `Management_Name`, `SportName`, `Salary`, `ContractStart`, `ContractEnd`) VALUES (54, 'Sport', 'Football', 111771, '2023-10-04', '2024-11-11');
INSERT INTO `Club_DB`.`Pro_Player` (`Player_SSN`, `Management_Name`, `SportName`, `Salary`, `ContractStart`, `ContractEnd`) VALUES (55, 'Sport', 'Football', 103267, '2023-03-02', '2025-03-10');
INSERT INTO `Club_DB`.`Pro_Player` (`Player_SSN`, `Management_Name`, `SportName`, `Salary`, `ContractStart`, `ContractEnd`) VALUES (56, 'Sport', 'Football', 93545, '2022-09-05', '2026-11-27');
INSERT INTO `Club_DB`.`Pro_Player` (`Player_SSN`, `Management_Name`, `SportName`, `Salary`, `ContractStart`, `ContractEnd`) VALUES (57, 'Sport', 'Football', 110463, '2020-07-01', '2026-10-13');
INSERT INTO `Club_DB`.`Pro_Player` (`Player_SSN`, `Management_Name`, `SportName`, `Salary`, `ContractStart`, `ContractEnd`) VALUES (58, 'Sport', 'Football', 99769, '2023-05-03', '2026-09-20');
INSERT INTO `Club_DB`.`Pro_Player` (`Player_SSN`, `Management_Name`, `SportName`, `Salary`, `ContractStart`, `ContractEnd`) VALUES (59, 'Sport', 'Football', 104945, '2023-11-04', '2026-06-20');
INSERT INTO `Club_DB`.`Pro_Player` (`Player_SSN`, `Management_Name`, `SportName`, `Salary`, `ContractStart`, `ContractEnd`) VALUES (60, 'Sport', 'Football', 117627, '2022-01-04', '2025-08-15');
INSERT INTO `Club_DB`.`Pro_Player` (`Player_SSN`, `Management_Name`, `SportName`, `Salary`, `ContractStart`, `ContractEnd`) VALUES (61, 'Sport', 'Basketball', 155605, '2020-03-06', '2026-01-07');
INSERT INTO `Club_DB`.`Pro_Player` (`Player_SSN`, `Management_Name`, `SportName`, `Salary`, `ContractStart`, `ContractEnd`) VALUES (62, 'Sport', 'Basketball', 162287, '2021-04-05', '2026-03-23');
INSERT INTO `Club_DB`.`Pro_Player` (`Player_SSN`, `Management_Name`, `SportName`, `Salary`, `ContractStart`, `ContractEnd`) VALUES (63, 'Sport', 'Basketball', 166569, '2021-09-06', '2024-04-08');
INSERT INTO `Club_DB`.`Pro_Player` (`Player_SSN`, `Management_Name`, `SportName`, `Salary`, `ContractStart`, `ContractEnd`) VALUES (64, 'Sport', 'Basketball', 164241, '2021-04-03', '2025-05-01');
INSERT INTO `Club_DB`.`Pro_Player` (`Player_SSN`, `Management_Name`, `SportName`, `Salary`, `ContractStart`, `ContractEnd`) VALUES (65, 'Sport', 'Basketball', 218288, '2020-07-04', '2024-10-07');
INSERT INTO `Club_DB`.`Pro_Player` (`Player_SSN`, `Management_Name`, `SportName`, `Salary`, `ContractStart`, `ContractEnd`) VALUES (66, 'Sport', 'Basketball', 150341, '2021-09-04', '2024-07-08');
INSERT INTO `Club_DB`.`Pro_Player` (`Player_SSN`, `Management_Name`, `SportName`, `Salary`, `ContractStart`, `ContractEnd`) VALUES (67, 'Sport', 'Basketball', 188940, '2020-04-04', '2024-07-26');
INSERT INTO `Club_DB`.`Pro_Player` (`Player_SSN`, `Management_Name`, `SportName`, `Salary`, `ContractStart`, `ContractEnd`) VALUES (68, 'Sport', 'Basketball', 226256, '2020-06-06', '2026-02-06');
INSERT INTO `Club_DB`.`Pro_Player` (`Player_SSN`, `Management_Name`, `SportName`, `Salary`, `ContractStart`, `ContractEnd`) VALUES (69, 'Sport', 'Basketball', 137371, '2022-01-06', '2026-10-01');
INSERT INTO `Club_DB`.`Pro_Player` (`Player_SSN`, `Management_Name`, `SportName`, `Salary`, `ContractStart`, `ContractEnd`) VALUES (70, 'Sport', 'Basketball', 149819, '2022-09-04', '2026-03-16');
INSERT INTO `Club_DB`.`Pro_Player` (`Player_SSN`, `Management_Name`, `SportName`, `Salary`, `ContractStart`, `ContractEnd`) VALUES (71, 'Sport', 'Basketball', 142645, '2023-02-01', '2024-09-13');
INSERT INTO `Club_DB`.`Pro_Player` (`Player_SSN`, `Management_Name`, `SportName`, `Salary`, `ContractStart`, `ContractEnd`) VALUES (72, 'Sport', 'Basketball', 197347, '2021-05-05', '2025-12-01');
INSERT INTO `Club_DB`.`Pro_Player` (`Player_SSN`, `Management_Name`, `SportName`, `Salary`, `ContractStart`, `ContractEnd`) VALUES (73, 'Sport', 'Basketball', 144013, '2023-07-02', '2024-04-28');
INSERT INTO `Club_DB`.`Pro_Player` (`Player_SSN`, `Management_Name`, `SportName`, `Salary`, `ContractStart`, `ContractEnd`) VALUES (74, 'Sport', 'Basketball', 117309, '2022-12-02', '2024-03-25');
INSERT INTO `Club_DB`.`Pro_Player` (`Player_SSN`, `Management_Name`, `SportName`, `Salary`, `ContractStart`, `ContractEnd`) VALUES (75, 'Sport', 'Basketball', 135298, '2022-12-06', '2024-07-03');
INSERT INTO `Club_DB`.`Pro_Player` (`Player_SSN`, `Management_Name`, `SportName`, `Salary`, `ContractStart`, `ContractEnd`) VALUES (76, 'Sport', 'Basketball', 135253, '2022-12-02', '2026-07-13');
INSERT INTO `Club_DB`.`Pro_Player` (`Player_SSN`, `Management_Name`, `SportName`, `Salary`, `ContractStart`, `ContractEnd`) VALUES (77, 'Sport', 'Basketball', 114414, '2022-05-03', '2025-01-17');
INSERT INTO `Club_DB`.`Pro_Player` (`Player_SSN`, `Management_Name`, `SportName`, `Salary`, `ContractStart`, `ContractEnd`) VALUES (78, 'Sport', 'Basketball', 121816, '2023-05-06', '2026-04-21');
INSERT INTO `Club_DB`.`Pro_Player` (`Player_SSN`, `Management_Name`, `SportName`, `Salary`, `ContractStart`, `ContractEnd`) VALUES (79, 'Sport', 'Basketball', 124189, '2023-12-04', '2026-01-04');
INSERT INTO `Club_DB`.`Pro_Player` (`Player_SSN`, `Management_Name`, `SportName`, `Salary`, `ContractStart`, `ContractEnd`) VALUES (80, 'Sport', 'Basketball', 116771, '2022-02-05', '2025-02-07');
INSERT INTO `Club_DB`.`Pro_Player` (`Player_SSN`, `Management_Name`, `SportName`, `Salary`, `ContractStart`, `ContractEnd`) VALUES (81, 'Sport', 'Basketball', 144058, '2023-08-05', '2025-05-02');
INSERT INTO `Club_DB`.`Pro_Player` (`Player_SSN`, `Management_Name`, `SportName`, `Salary`, `ContractStart`, `ContractEnd`) VALUES (82, 'Sport', 'Basketball', 134779, '2023-12-01', '2024-10-03');
INSERT INTO `Club_DB`.`Pro_Player` (`Player_SSN`, `Management_Name`, `SportName`, `Salary`, `ContractStart`, `ContractEnd`) VALUES (83, 'Sport', 'Basketball', 130349, '2022-10-06', '2026-12-17');
INSERT INTO `Club_DB`.`Pro_Player` (`Player_SSN`, `Management_Name`, `SportName`, `Salary`, `ContractStart`, `ContractEnd`) VALUES (84, 'Sport', 'Basketball', 119109, '2022-07-05', '2025-06-22');
INSERT INTO `Club_DB`.`Pro_Player` (`Player_SSN`, `Management_Name`, `SportName`, `Salary`, `ContractStart`, `ContractEnd`) VALUES (85, 'Sport', 'Swimming', 156526, '2023-09-06', '2024-11-20');
INSERT INTO `Club_DB`.`Pro_Player` (`Player_SSN`, `Management_Name`, `SportName`, `Salary`, `ContractStart`, `ContractEnd`) VALUES (86, 'Sport', 'Swimming', 138367, '2023-10-01', '2026-03-23');
INSERT INTO `Club_DB`.`Pro_Player` (`Player_SSN`, `Management_Name`, `SportName`, `Salary`, `ContractStart`, `ContractEnd`) VALUES (87, 'Sport', 'Swimming', 140162, '2022-02-06', '2025-11-07');
INSERT INTO `Club_DB`.`Pro_Player` (`Player_SSN`, `Management_Name`, `SportName`, `Salary`, `ContractStart`, `ContractEnd`) VALUES (88, 'Sport', 'Swimming', 145097, '2022-11-03', '2026-01-09');
INSERT INTO `Club_DB`.`Pro_Player` (`Player_SSN`, `Management_Name`, `SportName`, `Salary`, `ContractStart`, `ContractEnd`) VALUES (89, 'Sport', 'Swimming', 127079, '2022-01-05', '2025-06-13');
INSERT INTO `Club_DB`.`Pro_Player` (`Player_SSN`, `Management_Name`, `SportName`, `Salary`, `ContractStart`, `ContractEnd`) VALUES (90, 'Sport', 'Swimming', 123290, '2023-03-03', '2026-08-10');
INSERT INTO `Club_DB`.`Pro_Player` (`Player_SSN`, `Management_Name`, `SportName`, `Salary`, `ContractStart`, `ContractEnd`) VALUES (91, 'Sport', 'Swimming', 159542, '2023-11-05', '2025-07-07');
INSERT INTO `Club_DB`.`Pro_Player` (`Player_SSN`, `Management_Name`, `SportName`, `Salary`, `ContractStart`, `ContractEnd`) VALUES (92, 'Sport', 'Swimming', 149449, '2022-04-01', '2026-04-09');
INSERT INTO `Club_DB`.`Pro_Player` (`Player_SSN`, `Management_Name`, `SportName`, `Salary`, `ContractStart`, `ContractEnd`) VALUES (93, 'Sport', 'Swimming', 122025, '2022-12-04', '2025-02-20');
INSERT INTO `Club_DB`.`Pro_Player` (`Player_SSN`, `Management_Name`, `SportName`, `Salary`, `ContractStart`, `ContractEnd`) VALUES (94, 'Sport', 'Swimming', 158108, '2022-03-02', '2026-08-19');
INSERT INTO `Club_DB`.`Pro_Player` (`Player_SSN`, `Management_Name`, `SportName`, `Salary`, `ContractStart`, `ContractEnd`) VALUES (95, 'Sport', 'Kung Fu', 101586, '2022-03-05', '2024-07-03');
INSERT INTO `Club_DB`.`Pro_Player` (`Player_SSN`, `Management_Name`, `SportName`, `Salary`, `ContractStart`, `ContractEnd`) VALUES (96, 'Sport', 'Kung Fu', 91671, '2022-07-04', '2025-03-18');
INSERT INTO `Club_DB`.`Pro_Player` (`Player_SSN`, `Management_Name`, `SportName`, `Salary`, `ContractStart`, `ContractEnd`) VALUES (97, 'Sport', 'Kung Fu', 91071, '2023-11-06', '2025-01-11');
INSERT INTO `Club_DB`.`Pro_Player` (`Player_SSN`, `Management_Name`, `SportName`, `Salary`, `ContractStart`, `ContractEnd`) VALUES (98, 'Sport', 'Kung Fu', 112574, '2022-09-06', '2024-02-09');
INSERT INTO `Club_DB`.`Pro_Player` (`Player_SSN`, `Management_Name`, `SportName`, `Salary`, `ContractStart`, `ContractEnd`) VALUES (99, 'Sport', 'Kung Fu', 95913, '2022-12-03', '2025-08-26');
INSERT INTO `Club_DB`.`Pro_Player` (`Player_SSN`, `Management_Name`, `SportName`, `Salary`, `ContractStart`, `ContractEnd`) VALUES (100, 'Sport', 'Kung Fu', 104142, '2022-10-03', '2026-07-07');
INSERT INTO `Club_DB`.`Pro_Player` (`Player_SSN`, `Management_Name`, `SportName`, `Salary`, `ContractStart`, `ContractEnd`) VALUES (101, 'Sport', 'Kung Fu', 104972, '2023-06-02', '2024-01-19');
INSERT INTO `Club_DB`.`Pro_Player` (`Player_SSN`, `Management_Name`, `SportName`, `Salary`, `ContractStart`, `ContractEnd`) VALUES (102, 'Sport', 'Kung Fu', 91490, '2023-06-03', '2025-04-18');
INSERT INTO `Club_DB`.`Pro_Player` (`Player_SSN`, `Management_Name`, `SportName`, `Salary`, `ContractStart`, `ContractEnd`) VALUES (103, 'Sport', 'Kung Fu', 99797, '2022-03-05', '2024-05-12');
INSERT INTO `Club_DB`.`Pro_Player` (`Player_SSN`, `Management_Name`, `SportName`, `Salary`, `ContractStart`, `ContractEnd`) VALUES (104, 'Sport', 'Kung Fu', 106056, '2023-11-06', '2024-03-21');

COMMIT;


-- -----------------------------------------------------
-- Data for table `Club_DB`.`Coach`
-- -----------------------------------------------------
START TRANSACTION;
USE `Club_DB`;
INSERT INTO `Club_DB`.`Coach` (`Coach_SSN`, `SportName`, `Management_Name`, `Salary`, `ContractStart`, `ContractEnd`) VALUES (105, 'Football', 'Sport', 194682, '2021-04-03', '2025-10-25');
INSERT INTO `Club_DB`.`Coach` (`Coach_SSN`, `SportName`, `Management_Name`, `Salary`, `ContractStart`, `ContractEnd`) VALUES (106, 'Football', 'Sport', 156649, '2020-09-04', '2025-01-08');
INSERT INTO `Club_DB`.`Coach` (`Coach_SSN`, `SportName`, `Management_Name`, `Salary`, `ContractStart`, `ContractEnd`) VALUES (107, 'Basketball', 'Sport', 125188, '2022-10-05', '2025-01-21');
INSERT INTO `Club_DB`.`Coach` (`Coach_SSN`, `SportName`, `Management_Name`, `Salary`, `ContractStart`, `ContractEnd`) VALUES (108, 'Basketball', 'Sport', 134850, '2019-03-06', '2026-11-24');
INSERT INTO `Club_DB`.`Coach` (`Coach_SSN`, `SportName`, `Management_Name`, `Salary`, `ContractStart`, `ContractEnd`) VALUES (109, 'Swimming', 'Sport', 127778, '2021-11-06', '2024-01-16');
INSERT INTO `Club_DB`.`Coach` (`Coach_SSN`, `SportName`, `Management_Name`, `Salary`, `ContractStart`, `ContractEnd`) VALUES (110, 'Swimming', 'Sport', 124745, '2021-09-05', '2025-08-26');
INSERT INTO `Club_DB`.`Coach` (`Coach_SSN`, `SportName`, `Management_Name`, `Salary`, `ContractStart`, `ContractEnd`) VALUES (111, 'Swimming', 'Sport', 145006, '2020-12-06', '2024-12-22');
INSERT INTO `Club_DB`.`Coach` (`Coach_SSN`, `SportName`, `Management_Name`, `Salary`, `ContractStart`, `ContractEnd`) VALUES (112, 'Kung Fu', 'Sport', 123781, '2021-08-02', '2024-02-14');
INSERT INTO `Club_DB`.`Coach` (`Coach_SSN`, `SportName`, `Management_Name`, `Salary`, `ContractStart`, `ContractEnd`) VALUES (113, 'Kung Fu', 'Sport', 137288, '2021-08-04', '2024-11-27');
INSERT INTO `Club_DB`.`Coach` (`Coach_SSN`, `SportName`, `Management_Name`, `Salary`, `ContractStart`, `ContractEnd`) VALUES (114, 'Kung Fu', 'Sport', 124605, '2020-08-06', '2025-12-13');

COMMIT;


-- -----------------------------------------------------
-- Data for table `Club_DB`.`Event`
-- -----------------------------------------------------
START TRANSACTION;
USE `Club_DB`;
INSERT INTO `Club_DB`.`Event` (`Name`, `Date`) VALUES ('Swimming Championship', '2023-12-23');
INSERT INTO `Club_DB`.`Event` (`Name`, `Date`) VALUES ('FIFA Tournament', '2024-01-12');
INSERT INTO `Club_DB`.`Event` (`Name`, `Date`) VALUES ('New Years Concert', '2023-12-31');
INSERT INTO `Club_DB`.`Event` (`Name`, `Date`) VALUES ('Watch Party', '2024-03-01');
INSERT INTO `Club_DB`.`Event` (`Name`, `Date`) VALUES ('Ramadan 5on5 Football', '2024-03-20');
INSERT INTO `Club_DB`.`Event` (`Name`, `Date`) VALUES ('Ramadan 5on5 Football Final', '2024-04-01');

COMMIT;


-- -----------------------------------------------------
-- Data for table `Club_DB`.`Sponsor`
-- -----------------------------------------------------
START TRANSACTION;
USE `Club_DB`;
INSERT INTO `Club_DB`.`Sponsor` (`Name`, `Website`, `Event_Name`) VALUES ('Nike', 'Nike.com', 'Swimming Championship');
INSERT INTO `Club_DB`.`Sponsor` (`Name`, `Website`, `Event_Name`) VALUES ('WE', 'te.eg', 'Fifa tournament');
INSERT INTO `Club_DB`.`Sponsor` (`Name`, `Website`, `Event_Name`) VALUES ('BanqueMisr', 'banquemisr.com', 'New Years Concert');
INSERT INTO `Club_DB`.`Sponsor` (`Name`, `Website`, `Event_Name`) VALUES ('Watch It', 'watchit.com', 'Watch Party');
INSERT INTO `Club_DB`.`Sponsor` (`Name`, `Website`, `Event_Name`) VALUES ('Nike ', 'Nike.com', 'Ramadan 5on5 Football');

COMMIT;


-- -----------------------------------------------------
-- Data for table `Club_DB`.`Catering`
-- -----------------------------------------------------
START TRANSACTION;
USE `Club_DB`;
INSERT INTO `Club_DB`.`Catering` (`Name`, `Management_Name`, `NumOfBranches`, `Type`) VALUES ('Azure', 'Catering', 2, 'Restaurant');
INSERT INTO `Club_DB`.`Catering` (`Name`, `Management_Name`, `NumOfBranches`, `Type`) VALUES ('Sail In Sea', 'Catering', 1, 'Restaurant');
INSERT INTO `Club_DB`.`Catering` (`Name`, `Management_Name`, `NumOfBranches`, `Type`) VALUES ('Dominos', 'Catering', 1, 'Restaurant');
INSERT INTO `Club_DB`.`Catering` (`Name`, `Management_Name`, `NumOfBranches`, `Type`) VALUES ('Buffalo Burger', 'Catering', 1, 'Restaurant');
INSERT INTO `Club_DB`.`Catering` (`Name`, `Management_Name`, `NumOfBranches`, `Type`) VALUES ('Blaban', 'Catering', 1, 'Restaurant');
INSERT INTO `Club_DB`.`Catering` (`Name`, `Management_Name`, `NumOfBranches`, `Type`) VALUES ('Vamos', 'Catering', 3, 'Cafe');
INSERT INTO `Club_DB`.`Catering` (`Name`, `Management_Name`, `NumOfBranches`, `Type`) VALUES ('Costa Coffee', 'Catering', 1, 'Cafe');

COMMIT;


-- -----------------------------------------------------
-- Data for table `Club_DB`.`Catering_Location`
-- -----------------------------------------------------
START TRANSACTION;
USE `Club_DB`;
INSERT INTO `Club_DB`.`Catering_Location` (`Location`, `CateringName`, `Supervisor_ssn`) VALUES ('Main Club Building', 'Azure', 208);
INSERT INTO `Club_DB`.`Catering_Location` (`Location`, `CateringName`, `Supervisor_ssn`) VALUES ('Food Court', 'Azure', 216);
INSERT INTO `Club_DB`.`Catering_Location` (`Location`, `CateringName`, `Supervisor_ssn`) VALUES ('Food Court', 'Sail In Sea', 224);
INSERT INTO `Club_DB`.`Catering_Location` (`Location`, `CateringName`, `Supervisor_ssn`) VALUES ('Food Court', 'Buffalo Burger', 238);
INSERT INTO `Club_DB`.`Catering_Location` (`Location`, `CateringName`, `Supervisor_ssn`) VALUES ('Food Court', 'Dominos', 232);
INSERT INTO `Club_DB`.`Catering_Location` (`Location`, `CateringName`, `Supervisor_ssn`) VALUES ('Poolside', 'Dolato', 244);
INSERT INTO `Club_DB`.`Catering_Location` (`Location`, `CateringName`, `Supervisor_ssn`) VALUES ('Main Club Building', 'VAMOS', 249);
INSERT INTO `Club_DB`.`Catering_Location` (`Location`, `CateringName`, `Supervisor_ssn`) VALUES ('Poolside', 'VAMOS', 254);
INSERT INTO `Club_DB`.`Catering_Location` (`Location`, `CateringName`, `Supervisor_ssn`) VALUES ('Club Track', 'VAMOS', 259);
INSERT INTO `Club_DB`.`Catering_Location` (`Location`, `CateringName`, `Supervisor_ssn`) VALUES ('Food Court', 'Costa Coffee', 267);

COMMIT;


-- -----------------------------------------------------
-- Data for table `Club_DB`.`Place`
-- -----------------------------------------------------
START TRANSACTION;
USE `Club_DB`;
INSERT INTO `Club_DB`.`Place` (`PlaceName`, `Location`) VALUES ('Main Football Field ', 'Sports Complex');
INSERT INTO `Club_DB`.`Place` (`PlaceName`, `Location`) VALUES ('Indoor Sports Hall 1', 'Sports Complex Building');
INSERT INTO `Club_DB`.`Place` (`PlaceName`, `Location`) VALUES ('Indoor Sports Hall 2', 'Sports Complex Building');
INSERT INTO `Club_DB`.`Place` (`PlaceName`, `Location`) VALUES ('Poolside Lounge', 'Main Pool');
INSERT INTO `Club_DB`.`Place` (`PlaceName`, `Location`) VALUES ('Activity Hall 1', 'Main Club Building');
INSERT INTO `Club_DB`.`Place` (`PlaceName`, `Location`) VALUES ('Activity Hall 2', 'Main Club Building');
INSERT INTO `Club_DB`.`Place` (`PlaceName`, `Location`) VALUES ('Azure 1', 'Main Club Building');
INSERT INTO `Club_DB`.`Place` (`PlaceName`, `Location`) VALUES ('VAMOS Trackside', 'Club Track');
INSERT INTO `Club_DB`.`Place` (`PlaceName`, `Location`) VALUES ('Football Training Field 1', 'Sports Complex');
INSERT INTO `Club_DB`.`Place` (`PlaceName`, `Location`) VALUES ('Football Training Field 2', 'Sports Complex');
INSERT INTO `Club_DB`.`Place` (`PlaceName`, `Location`) VALUES ('Azure 2', 'Food Court');
INSERT INTO `Club_DB`.`Place` (`PlaceName`, `Location`) VALUES ('Buffalo Burger', 'Food Court');
INSERT INTO `Club_DB`.`Place` (`PlaceName`, `Location`) VALUES ('Domino\'s', 'Food Court');
INSERT INTO `Club_DB`.`Place` (`PlaceName`, `Location`) VALUES ('Sail In Sea', 'Food Court');
INSERT INTO `Club_DB`.`Place` (`PlaceName`, `Location`) VALUES ('Dolato', 'Poolside');
INSERT INTO `Club_DB`.`Place` (`PlaceName`, `Location`) VALUES ('VAMOS Lounge', 'Main Club Building');
INSERT INTO `Club_DB`.`Place` (`PlaceName`, `Location`) VALUES ('VAMOS Poolside', 'Main Pool');
INSERT INTO `Club_DB`.`Place` (`PlaceName`, `Location`) VALUES ('Costa Coffee', 'Food Court');
INSERT INTO `Club_DB`.`Place` (`PlaceName`, `Location`) VALUES ('5on5 Football Field 1', 'Sports Complex');
INSERT INTO `Club_DB`.`Place` (`PlaceName`, `Location`) VALUES ('5on5 Football Field 2', 'Sports Complex');
INSERT INTO `Club_DB`.`Place` (`PlaceName`, `Location`) VALUES ('5on5 Football Field 3', 'Sports Complex');
INSERT INTO `Club_DB`.`Place` (`PlaceName`, `Location`) VALUES ('Olympic Pool', 'Water Sports Complex');

COMMIT;


-- -----------------------------------------------------
-- Data for table `Club_DB`.`Hall`
-- -----------------------------------------------------
START TRANSACTION;
USE `Club_DB`;
INSERT INTO `Club_DB`.`Hall` (`PlaceName`, `NumberOfSeats`) VALUES ('Indoor Sports Hall 1', 2000);
INSERT INTO `Club_DB`.`Hall` (`PlaceName`, `NumberOfSeats`) VALUES ('Indoor Sports Hall 2', 600);
INSERT INTO `Club_DB`.`Hall` (`PlaceName`, `NumberOfSeats`) VALUES ('Activity Hall 1', 100);
INSERT INTO `Club_DB`.`Hall` (`PlaceName`, `NumberOfSeats`) VALUES ('Activity Hall 2', 100);

COMMIT;


-- -----------------------------------------------------
-- Data for table `Club_DB`.`Field`
-- -----------------------------------------------------
START TRANSACTION;
USE `Club_DB`;
INSERT INTO `Club_DB`.`Field` (`PlaceName`, `Area`) VALUES ('Main Football Field ', 7140);
INSERT INTO `Club_DB`.`Field` (`PlaceName`, `Area`) VALUES ('Football Training Field 1', 5000);
INSERT INTO `Club_DB`.`Field` (`PlaceName`, `Area`) VALUES ('Football Training Field 2', 5000);
INSERT INTO `Club_DB`.`Field` (`PlaceName`, `Area`) VALUES ('Club Track', 1117.51);
INSERT INTO `Club_DB`.`Field` (`PlaceName`, `Area`) VALUES ('5on5 Football Field 1', 800);
INSERT INTO `Club_DB`.`Field` (`PlaceName`, `Area`) VALUES ('5on5 Football Field 2', 800);
INSERT INTO `Club_DB`.`Field` (`PlaceName`, `Area`) VALUES ('5on5 Football Field 3', 800);

COMMIT;


-- -----------------------------------------------------
-- Data for table `Club_DB`.`CateringStaff`
-- -----------------------------------------------------
START TRANSACTION;
USE `Club_DB`;
INSERT INTO `Club_DB`.`CateringStaff` (`Worker_SSN`, `Catering_Name`, `Catering_Location`) VALUES (201, 'Azure', 'Main Club Building');
INSERT INTO `Club_DB`.`CateringStaff` (`Worker_SSN`, `Catering_Name`, `Catering_Location`) VALUES (202, 'Azure', 'Main Club Building');
INSERT INTO `Club_DB`.`CateringStaff` (`Worker_SSN`, `Catering_Name`, `Catering_Location`) VALUES (203, 'Azure', 'Main Club Building');
INSERT INTO `Club_DB`.`CateringStaff` (`Worker_SSN`, `Catering_Name`, `Catering_Location`) VALUES (204, 'Azure', 'Main Club Building');
INSERT INTO `Club_DB`.`CateringStaff` (`Worker_SSN`, `Catering_Name`, `Catering_Location`) VALUES (205, 'Azure', 'Main Club Building');
INSERT INTO `Club_DB`.`CateringStaff` (`Worker_SSN`, `Catering_Name`, `Catering_Location`) VALUES (206, 'Azure', 'Main Club Building');
INSERT INTO `Club_DB`.`CateringStaff` (`Worker_SSN`, `Catering_Name`, `Catering_Location`) VALUES (207, 'Azure', 'Main Club Building');
INSERT INTO `Club_DB`.`CateringStaff` (`Worker_SSN`, `Catering_Name`, `Catering_Location`) VALUES (208, 'Azure', 'Main Club Building');
INSERT INTO `Club_DB`.`CateringStaff` (`Worker_SSN`, `Catering_Name`, `Catering_Location`) VALUES (209, 'Azure', 'Food Court');
INSERT INTO `Club_DB`.`CateringStaff` (`Worker_SSN`, `Catering_Name`, `Catering_Location`) VALUES (210, 'Azure', 'Food Court');
INSERT INTO `Club_DB`.`CateringStaff` (`Worker_SSN`, `Catering_Name`, `Catering_Location`) VALUES (211, 'Azure', 'Food Court');
INSERT INTO `Club_DB`.`CateringStaff` (`Worker_SSN`, `Catering_Name`, `Catering_Location`) VALUES (212, 'Azure', 'Food Court');
INSERT INTO `Club_DB`.`CateringStaff` (`Worker_SSN`, `Catering_Name`, `Catering_Location`) VALUES (213, 'Azure', 'Food Court');
INSERT INTO `Club_DB`.`CateringStaff` (`Worker_SSN`, `Catering_Name`, `Catering_Location`) VALUES (214, 'Azure', 'Food Court');
INSERT INTO `Club_DB`.`CateringStaff` (`Worker_SSN`, `Catering_Name`, `Catering_Location`) VALUES (215, 'Azure', 'Food Court');
INSERT INTO `Club_DB`.`CateringStaff` (`Worker_SSN`, `Catering_Name`, `Catering_Location`) VALUES (216, 'Azure', 'Food Court');
INSERT INTO `Club_DB`.`CateringStaff` (`Worker_SSN`, `Catering_Name`, `Catering_Location`) VALUES (217, 'Sail In Sea', 'Food Court');
INSERT INTO `Club_DB`.`CateringStaff` (`Worker_SSN`, `Catering_Name`, `Catering_Location`) VALUES (218, 'Sail In Sea', 'Food Court');
INSERT INTO `Club_DB`.`CateringStaff` (`Worker_SSN`, `Catering_Name`, `Catering_Location`) VALUES (219, 'Sail In Sea', 'Food Court');
INSERT INTO `Club_DB`.`CateringStaff` (`Worker_SSN`, `Catering_Name`, `Catering_Location`) VALUES (220, 'Sail In Sea', 'Food Court');
INSERT INTO `Club_DB`.`CateringStaff` (`Worker_SSN`, `Catering_Name`, `Catering_Location`) VALUES (221, 'Sail In Sea', 'Food Court');
INSERT INTO `Club_DB`.`CateringStaff` (`Worker_SSN`, `Catering_Name`, `Catering_Location`) VALUES (222, 'Sail In Sea', 'Food Court');
INSERT INTO `Club_DB`.`CateringStaff` (`Worker_SSN`, `Catering_Name`, `Catering_Location`) VALUES (223, 'Sail In Sea', 'Food Court');
INSERT INTO `Club_DB`.`CateringStaff` (`Worker_SSN`, `Catering_Name`, `Catering_Location`) VALUES (224, 'Sail In Sea', 'Food Court');
INSERT INTO `Club_DB`.`CateringStaff` (`Worker_SSN`, `Catering_Name`, `Catering_Location`) VALUES (225, 'Dominos', 'Food Court');
INSERT INTO `Club_DB`.`CateringStaff` (`Worker_SSN`, `Catering_Name`, `Catering_Location`) VALUES (226, 'Dominos', 'Food Court');
INSERT INTO `Club_DB`.`CateringStaff` (`Worker_SSN`, `Catering_Name`, `Catering_Location`) VALUES (227, 'Dominos', 'Food Court');
INSERT INTO `Club_DB`.`CateringStaff` (`Worker_SSN`, `Catering_Name`, `Catering_Location`) VALUES (228, 'Dominos', 'Food Court');
INSERT INTO `Club_DB`.`CateringStaff` (`Worker_SSN`, `Catering_Name`, `Catering_Location`) VALUES (229, 'Dominos', 'Food Court');
INSERT INTO `Club_DB`.`CateringStaff` (`Worker_SSN`, `Catering_Name`, `Catering_Location`) VALUES (230, 'Dominos', 'Food Court');
INSERT INTO `Club_DB`.`CateringStaff` (`Worker_SSN`, `Catering_Name`, `Catering_Location`) VALUES (231, 'Dominos', 'Food Court');
INSERT INTO `Club_DB`.`CateringStaff` (`Worker_SSN`, `Catering_Name`, `Catering_Location`) VALUES (232, 'Dominos', 'Food Court');
INSERT INTO `Club_DB`.`CateringStaff` (`Worker_SSN`, `Catering_Name`, `Catering_Location`) VALUES (233, 'Buffalo Burger', 'Food Court');
INSERT INTO `Club_DB`.`CateringStaff` (`Worker_SSN`, `Catering_Name`, `Catering_Location`) VALUES (234, 'Buffalo Burger', 'Food Court');
INSERT INTO `Club_DB`.`CateringStaff` (`Worker_SSN`, `Catering_Name`, `Catering_Location`) VALUES (235, 'Buffalo Burger', 'Food Court');
INSERT INTO `Club_DB`.`CateringStaff` (`Worker_SSN`, `Catering_Name`, `Catering_Location`) VALUES (236, 'Buffalo Burger', 'Food Court');
INSERT INTO `Club_DB`.`CateringStaff` (`Worker_SSN`, `Catering_Name`, `Catering_Location`) VALUES (237, 'Buffalo Burger', 'Food Court');
INSERT INTO `Club_DB`.`CateringStaff` (`Worker_SSN`, `Catering_Name`, `Catering_Location`) VALUES (238, 'Buffalo Burger', 'Food Court');
INSERT INTO `Club_DB`.`CateringStaff` (`Worker_SSN`, `Catering_Name`, `Catering_Location`) VALUES (239, 'Dolato', 'Poolside');
INSERT INTO `Club_DB`.`CateringStaff` (`Worker_SSN`, `Catering_Name`, `Catering_Location`) VALUES (240, 'Dolato', 'Poolside');
INSERT INTO `Club_DB`.`CateringStaff` (`Worker_SSN`, `Catering_Name`, `Catering_Location`) VALUES (241, 'Dolato', 'Poolside');
INSERT INTO `Club_DB`.`CateringStaff` (`Worker_SSN`, `Catering_Name`, `Catering_Location`) VALUES (242, 'Dolato', 'Poolside');
INSERT INTO `Club_DB`.`CateringStaff` (`Worker_SSN`, `Catering_Name`, `Catering_Location`) VALUES (243, 'Dolato', 'Poolside');
INSERT INTO `Club_DB`.`CateringStaff` (`Worker_SSN`, `Catering_Name`, `Catering_Location`) VALUES (244, 'Dolato', 'Poolside');
INSERT INTO `Club_DB`.`CateringStaff` (`Worker_SSN`, `Catering_Name`, `Catering_Location`) VALUES (245, 'VAMOS', 'Main Club Building');
INSERT INTO `Club_DB`.`CateringStaff` (`Worker_SSN`, `Catering_Name`, `Catering_Location`) VALUES (246, 'VAMOS', 'Main Club Building');
INSERT INTO `Club_DB`.`CateringStaff` (`Worker_SSN`, `Catering_Name`, `Catering_Location`) VALUES (247, 'VAMOS', 'Main Club Building');
INSERT INTO `Club_DB`.`CateringStaff` (`Worker_SSN`, `Catering_Name`, `Catering_Location`) VALUES (248, 'VAMOS', 'Main Club Building');
INSERT INTO `Club_DB`.`CateringStaff` (`Worker_SSN`, `Catering_Name`, `Catering_Location`) VALUES (249, 'VAMOS', 'Main Club Building');
INSERT INTO `Club_DB`.`CateringStaff` (`Worker_SSN`, `Catering_Name`, `Catering_Location`) VALUES (250, 'VAMOS', 'Poolside');
INSERT INTO `Club_DB`.`CateringStaff` (`Worker_SSN`, `Catering_Name`, `Catering_Location`) VALUES (251, 'VAMOS', 'Poolside');
INSERT INTO `Club_DB`.`CateringStaff` (`Worker_SSN`, `Catering_Name`, `Catering_Location`) VALUES (252, 'VAMOS', 'Poolside');
INSERT INTO `Club_DB`.`CateringStaff` (`Worker_SSN`, `Catering_Name`, `Catering_Location`) VALUES (253, 'VAMOS', 'Poolside');
INSERT INTO `Club_DB`.`CateringStaff` (`Worker_SSN`, `Catering_Name`, `Catering_Location`) VALUES (254, 'VAMOS', 'Poolside');
INSERT INTO `Club_DB`.`CateringStaff` (`Worker_SSN`, `Catering_Name`, `Catering_Location`) VALUES (255, 'VAMOS', 'Club Track');
INSERT INTO `Club_DB`.`CateringStaff` (`Worker_SSN`, `Catering_Name`, `Catering_Location`) VALUES (256, 'VAMOS', 'Club Track');
INSERT INTO `Club_DB`.`CateringStaff` (`Worker_SSN`, `Catering_Name`, `Catering_Location`) VALUES (257, 'VAMOS', 'Club Track');
INSERT INTO `Club_DB`.`CateringStaff` (`Worker_SSN`, `Catering_Name`, `Catering_Location`) VALUES (258, 'VAMOS', 'Club Track');
INSERT INTO `Club_DB`.`CateringStaff` (`Worker_SSN`, `Catering_Name`, `Catering_Location`) VALUES (259, 'VAMOS', 'Club Track');
INSERT INTO `Club_DB`.`CateringStaff` (`Worker_SSN`, `Catering_Name`, `Catering_Location`) VALUES (260, 'Costa Coffee', 'Food Court');
INSERT INTO `Club_DB`.`CateringStaff` (`Worker_SSN`, `Catering_Name`, `Catering_Location`) VALUES (261, 'Costa Coffee', 'Food Court');
INSERT INTO `Club_DB`.`CateringStaff` (`Worker_SSN`, `Catering_Name`, `Catering_Location`) VALUES (262, 'Costa Coffee', 'Food Court');
INSERT INTO `Club_DB`.`CateringStaff` (`Worker_SSN`, `Catering_Name`, `Catering_Location`) VALUES (263, 'Costa Coffee', 'Food Court');
INSERT INTO `Club_DB`.`CateringStaff` (`Worker_SSN`, `Catering_Name`, `Catering_Location`) VALUES (264, 'Costa Coffee', 'Food Court');
INSERT INTO `Club_DB`.`CateringStaff` (`Worker_SSN`, `Catering_Name`, `Catering_Location`) VALUES (265, 'Costa Coffee', 'Food Court');
INSERT INTO `Club_DB`.`CateringStaff` (`Worker_SSN`, `Catering_Name`, `Catering_Location`) VALUES (266, 'Costa Coffee', 'Food Court');
INSERT INTO `Club_DB`.`CateringStaff` (`Worker_SSN`, `Catering_Name`, `Catering_Location`) VALUES (267, 'Costa Coffee', 'Food Court');

COMMIT;


-- -----------------------------------------------------
-- Data for table `Club_DB`.`Management_Employee`
-- -----------------------------------------------------
START TRANSACTION;
USE `Club_DB`;
INSERT INTO `Club_DB`.`Management_Employee` (`Management_Name`, `Employee_SSN`) VALUES ('Sport',  115);
INSERT INTO `Club_DB`.`Management_Employee` (`Management_Name`, `Employee_SSN`) VALUES ('Sport',  116);
INSERT INTO `Club_DB`.`Management_Employee` (`Management_Name`, `Employee_SSN`) VALUES ('Sport',  117);
INSERT INTO `Club_DB`.`Management_Employee` (`Management_Name`, `Employee_SSN`) VALUES ('Sport',  118);
INSERT INTO `Club_DB`.`Management_Employee` (`Management_Name`, `Employee_SSN`) VALUES ('Sport',  119);
INSERT INTO `Club_DB`.`Management_Employee` (`Management_Name`, `Employee_SSN`) VALUES ('Sport',  120);
INSERT INTO `Club_DB`.`Management_Employee` (`Management_Name`, `Employee_SSN`) VALUES ('Sport',  121);
INSERT INTO `Club_DB`.`Management_Employee` (`Management_Name`, `Employee_SSN`) VALUES ('Sport',  122);
INSERT INTO `Club_DB`.`Management_Employee` (`Management_Name`, `Employee_SSN`) VALUES ('Sport',  123);
INSERT INTO `Club_DB`.`Management_Employee` (`Management_Name`, `Employee_SSN`) VALUES ('Sport',  124);
INSERT INTO `Club_DB`.`Management_Employee` (`Management_Name`, `Employee_SSN`) VALUES ('Sport',  125);
INSERT INTO `Club_DB`.`Management_Employee` (`Management_Name`, `Employee_SSN`) VALUES ('Sport',  126);
INSERT INTO `Club_DB`.`Management_Employee` (`Management_Name`, `Employee_SSN`) VALUES ('Sport',  127);
INSERT INTO `Club_DB`.`Management_Employee` (`Management_Name`, `Employee_SSN`) VALUES ('Sport',  128);
INSERT INTO `Club_DB`.`Management_Employee` (`Management_Name`, `Employee_SSN`) VALUES ('Sport',  129);
INSERT INTO `Club_DB`.`Management_Employee` (`Management_Name`, `Employee_SSN`) VALUES ('Sport',  130);
INSERT INTO `Club_DB`.`Management_Employee` (`Management_Name`, `Employee_SSN`) VALUES ('Events',  131);
INSERT INTO `Club_DB`.`Management_Employee` (`Management_Name`, `Employee_SSN`) VALUES ('Events',  132);
INSERT INTO `Club_DB`.`Management_Employee` (`Management_Name`, `Employee_SSN`) VALUES ('Events',  133);
INSERT INTO `Club_DB`.`Management_Employee` (`Management_Name`, `Employee_SSN`) VALUES ('Events',  134);
INSERT INTO `Club_DB`.`Management_Employee` (`Management_Name`, `Employee_SSN`) VALUES ('Events',  135);
INSERT INTO `Club_DB`.`Management_Employee` (`Management_Name`, `Employee_SSN`) VALUES ('Quality',  136);
INSERT INTO `Club_DB`.`Management_Employee` (`Management_Name`, `Employee_SSN`) VALUES ('Quality',  137);
INSERT INTO `Club_DB`.`Management_Employee` (`Management_Name`, `Employee_SSN`) VALUES ('Quality',  138);
INSERT INTO `Club_DB`.`Management_Employee` (`Management_Name`, `Employee_SSN`) VALUES ('Quality',  139);
INSERT INTO `Club_DB`.`Management_Employee` (`Management_Name`, `Employee_SSN`) VALUES ('Quality',  140);
INSERT INTO `Club_DB`.`Management_Employee` (`Management_Name`, `Employee_SSN`) VALUES ('Services',  141);
INSERT INTO `Club_DB`.`Management_Employee` (`Management_Name`, `Employee_SSN`) VALUES ('Services',  142);
INSERT INTO `Club_DB`.`Management_Employee` (`Management_Name`, `Employee_SSN`) VALUES ('Services',  143);
INSERT INTO `Club_DB`.`Management_Employee` (`Management_Name`, `Employee_SSN`) VALUES ('Services',  144);
INSERT INTO `Club_DB`.`Management_Employee` (`Management_Name`, `Employee_SSN`) VALUES ('Services',  145);
INSERT INTO `Club_DB`.`Management_Employee` (`Management_Name`, `Employee_SSN`) VALUES ('Services',  146);
INSERT INTO `Club_DB`.`Management_Employee` (`Management_Name`, `Employee_SSN`) VALUES ('Services',  147);
INSERT INTO `Club_DB`.`Management_Employee` (`Management_Name`, `Employee_SSN`) VALUES ('Services',  148);
INSERT INTO `Club_DB`.`Management_Employee` (`Management_Name`, `Employee_SSN`) VALUES ('Board',  149);
INSERT INTO `Club_DB`.`Management_Employee` (`Management_Name`, `Employee_SSN`) VALUES ('Board',  150);
INSERT INTO `Club_DB`.`Management_Employee` (`Management_Name`, `Employee_SSN`) VALUES ('Board',  151);
INSERT INTO `Club_DB`.`Management_Employee` (`Management_Name`, `Employee_SSN`) VALUES ('Board',  152);

COMMIT;


-- -----------------------------------------------------
-- Data for table `Club_DB`.`Event_Managment_Place`
-- -----------------------------------------------------
START TRANSACTION;
USE `Club_DB`;
INSERT INTO `Club_DB`.`Event_Managment_Place` (`Event_Name`, `PlaceName`, `Management_Name`) VALUES ('Swimming Championship', 'Olympic Pool', 'Events');
INSERT INTO `Club_DB`.`Event_Managment_Place` (`Event_Name`, `PlaceName`, `Management_Name`) VALUES ('FIFA Tournament', 'Activity Hall 1', 'Events');
INSERT INTO `Club_DB`.`Event_Managment_Place` (`Event_Name`, `PlaceName`, `Management_Name`) VALUES ('New Years Concert', 'Indoor Sports Hall 1', 'Events');
INSERT INTO `Club_DB`.`Event_Managment_Place` (`Event_Name`, `PlaceName`, `Management_Name`) VALUES ('Watch Party', 'Poolside Lounge', 'Events');
INSERT INTO `Club_DB`.`Event_Managment_Place` (`Event_Name`, `PlaceName`, `Management_Name`) VALUES ('Ramadan 5on5 Football', '5on5 Football Field 1', 'Events');
INSERT INTO `Club_DB`.`Event_Managment_Place` (`Event_Name`, `PlaceName`, `Management_Name`) VALUES ('Ramadan 5on5 Football', '5on5 Football Field 2', 'Events');
INSERT INTO `Club_DB`.`Event_Managment_Place` (`Event_Name`, `PlaceName`, `Management_Name`) VALUES ('Ramadan 5on5 Football', '5on5 Football Field 3', 'Events');
INSERT INTO `Club_DB`.`Event_Managment_Place` (`Event_Name`, `PlaceName`, `Management_Name`) VALUES ('Ramadan 5on5 Football Final', '5on5 Football Field 1', 'Events');

COMMIT;


-- -----------------------------------------------------
-- Data for table `Club_DB`.`teamSport_Player`
-- -----------------------------------------------------
START TRANSACTION;
USE `Club_DB`;
INSERT INTO `Club_DB`.`teamSport_Player` (`Player_SSN`, `SportName`, `TeamName`) VALUES (1, 'Football', 'First Team');
INSERT INTO `Club_DB`.`teamSport_Player` (`Player_SSN`, `SportName`, `TeamName`) VALUES (2, 'Football', 'First Team');
INSERT INTO `Club_DB`.`teamSport_Player` (`Player_SSN`, `SportName`, `TeamName`) VALUES (3, 'Football', 'First Team');
INSERT INTO `Club_DB`.`teamSport_Player` (`Player_SSN`, `SportName`, `TeamName`) VALUES (4, 'Football', 'First Team');
INSERT INTO `Club_DB`.`teamSport_Player` (`Player_SSN`, `SportName`, `TeamName`) VALUES (5, 'Football', 'First Team');
INSERT INTO `Club_DB`.`teamSport_Player` (`Player_SSN`, `SportName`, `TeamName`) VALUES (6, 'Football', 'First Team');
INSERT INTO `Club_DB`.`teamSport_Player` (`Player_SSN`, `SportName`, `TeamName`) VALUES (7, 'Football', 'First Team');
INSERT INTO `Club_DB`.`teamSport_Player` (`Player_SSN`, `SportName`, `TeamName`) VALUES (8, 'Football', 'First Team');
INSERT INTO `Club_DB`.`teamSport_Player` (`Player_SSN`, `SportName`, `TeamName`) VALUES (9, 'Football', 'First Team');
INSERT INTO `Club_DB`.`teamSport_Player` (`Player_SSN`, `SportName`, `TeamName`) VALUES (10, 'Football', 'First Team');
INSERT INTO `Club_DB`.`teamSport_Player` (`Player_SSN`, `SportName`, `TeamName`) VALUES (11, 'Football', 'First Team');
INSERT INTO `Club_DB`.`teamSport_Player` (`Player_SSN`, `SportName`, `TeamName`) VALUES (12, 'Football', 'First Team');
INSERT INTO `Club_DB`.`teamSport_Player` (`Player_SSN`, `SportName`, `TeamName`) VALUES (13, 'Football', 'First Team');
INSERT INTO `Club_DB`.`teamSport_Player` (`Player_SSN`, `SportName`, `TeamName`) VALUES (14, 'Football', 'First Team');
INSERT INTO `Club_DB`.`teamSport_Player` (`Player_SSN`, `SportName`, `TeamName`) VALUES (15, 'Football', 'First Team');
INSERT INTO `Club_DB`.`teamSport_Player` (`Player_SSN`, `SportName`, `TeamName`) VALUES (16, 'Football', 'First Team');
INSERT INTO `Club_DB`.`teamSport_Player` (`Player_SSN`, `SportName`, `TeamName`) VALUES (17, 'Football', 'First Team');
INSERT INTO `Club_DB`.`teamSport_Player` (`Player_SSN`, `SportName`, `TeamName`) VALUES (18, 'Football', 'First Team');
INSERT INTO `Club_DB`.`teamSport_Player` (`Player_SSN`, `SportName`, `TeamName`) VALUES (19, 'Football', 'First Team');
INSERT INTO `Club_DB`.`teamSport_Player` (`Player_SSN`, `SportName`, `TeamName`) VALUES (20, 'Football', 'First Team');
INSERT INTO `Club_DB`.`teamSport_Player` (`Player_SSN`, `SportName`, `TeamName`) VALUES (21, 'Football', 'First Team');
INSERT INTO `Club_DB`.`teamSport_Player` (`Player_SSN`, `SportName`, `TeamName`) VALUES (22, 'Football', 'First Team');
INSERT INTO `Club_DB`.`teamSport_Player` (`Player_SSN`, `SportName`, `TeamName`) VALUES (23, 'Football', 'First Team');
INSERT INTO `Club_DB`.`teamSport_Player` (`Player_SSN`, `SportName`, `TeamName`) VALUES (24, 'Football', 'First Team');
INSERT INTO `Club_DB`.`teamSport_Player` (`Player_SSN`, `SportName`, `TeamName`) VALUES (25, 'Football', 'First Team');
INSERT INTO `Club_DB`.`teamSport_Player` (`Player_SSN`, `SportName`, `TeamName`) VALUES (26, 'Football', 'First Team');
INSERT INTO `Club_DB`.`teamSport_Player` (`Player_SSN`, `SportName`, `TeamName`) VALUES (27, 'Football', 'First Team');
INSERT INTO `Club_DB`.`teamSport_Player` (`Player_SSN`, `SportName`, `TeamName`) VALUES (28, 'Football', 'First Team');
INSERT INTO `Club_DB`.`teamSport_Player` (`Player_SSN`, `SportName`, `TeamName`) VALUES (29, 'Football', 'First Team');
INSERT INTO `Club_DB`.`teamSport_Player` (`Player_SSN`, `SportName`, `TeamName`) VALUES (30, 'Football', 'First Team');
INSERT INTO `Club_DB`.`teamSport_Player` (`Player_SSN`, `SportName`, `TeamName`) VALUES (31, 'Football', 'Academy Team');
INSERT INTO `Club_DB`.`teamSport_Player` (`Player_SSN`, `SportName`, `TeamName`) VALUES (32, 'Football', 'Academy Team');
INSERT INTO `Club_DB`.`teamSport_Player` (`Player_SSN`, `SportName`, `TeamName`) VALUES (33, 'Football', 'Academy Team');
INSERT INTO `Club_DB`.`teamSport_Player` (`Player_SSN`, `SportName`, `TeamName`) VALUES (34, 'Football', 'Academy Team');
INSERT INTO `Club_DB`.`teamSport_Player` (`Player_SSN`, `SportName`, `TeamName`) VALUES (35, 'Football', 'Academy Team');
INSERT INTO `Club_DB`.`teamSport_Player` (`Player_SSN`, `SportName`, `TeamName`) VALUES (36, 'Football', 'Academy Team');
INSERT INTO `Club_DB`.`teamSport_Player` (`Player_SSN`, `SportName`, `TeamName`) VALUES (37, 'Football', 'Academy Team');
INSERT INTO `Club_DB`.`teamSport_Player` (`Player_SSN`, `SportName`, `TeamName`) VALUES (38, 'Football', 'Academy Team');
INSERT INTO `Club_DB`.`teamSport_Player` (`Player_SSN`, `SportName`, `TeamName`) VALUES (39, 'Football', 'Academy Team');
INSERT INTO `Club_DB`.`teamSport_Player` (`Player_SSN`, `SportName`, `TeamName`) VALUES (40, 'Football', 'Academy Team');
INSERT INTO `Club_DB`.`teamSport_Player` (`Player_SSN`, `SportName`, `TeamName`) VALUES (41, 'Football', 'Academy Team');
INSERT INTO `Club_DB`.`teamSport_Player` (`Player_SSN`, `SportName`, `TeamName`) VALUES (42, 'Football', 'Academy Team');
INSERT INTO `Club_DB`.`teamSport_Player` (`Player_SSN`, `SportName`, `TeamName`) VALUES (43, 'Football', 'Academy Team');
INSERT INTO `Club_DB`.`teamSport_Player` (`Player_SSN`, `SportName`, `TeamName`) VALUES (44, 'Football', 'Academy Team');
INSERT INTO `Club_DB`.`teamSport_Player` (`Player_SSN`, `SportName`, `TeamName`) VALUES (45, 'Football', 'Academy Team');
INSERT INTO `Club_DB`.`teamSport_Player` (`Player_SSN`, `SportName`, `TeamName`) VALUES (46, 'Football', 'Academy Team');
INSERT INTO `Club_DB`.`teamSport_Player` (`Player_SSN`, `SportName`, `TeamName`) VALUES (47, 'Football', 'Academy Team');
INSERT INTO `Club_DB`.`teamSport_Player` (`Player_SSN`, `SportName`, `TeamName`) VALUES (48, 'Football', 'Academy Team');
INSERT INTO `Club_DB`.`teamSport_Player` (`Player_SSN`, `SportName`, `TeamName`) VALUES (49, 'Football', 'Academy Team');
INSERT INTO `Club_DB`.`teamSport_Player` (`Player_SSN`, `SportName`, `TeamName`) VALUES (50, 'Football', 'Academy Team');
INSERT INTO `Club_DB`.`teamSport_Player` (`Player_SSN`, `SportName`, `TeamName`) VALUES (51, 'Football', 'Academy Team');
INSERT INTO `Club_DB`.`teamSport_Player` (`Player_SSN`, `SportName`, `TeamName`) VALUES (52, 'Football', 'Academy Team');
INSERT INTO `Club_DB`.`teamSport_Player` (`Player_SSN`, `SportName`, `TeamName`) VALUES (53, 'Football', 'Academy Team');
INSERT INTO `Club_DB`.`teamSport_Player` (`Player_SSN`, `SportName`, `TeamName`) VALUES (54, 'Football', 'Academy Team');
INSERT INTO `Club_DB`.`teamSport_Player` (`Player_SSN`, `SportName`, `TeamName`) VALUES (55, 'Football', 'Academy Team');
INSERT INTO `Club_DB`.`teamSport_Player` (`Player_SSN`, `SportName`, `TeamName`) VALUES (56, 'Football', 'Academy Team');
INSERT INTO `Club_DB`.`teamSport_Player` (`Player_SSN`, `SportName`, `TeamName`) VALUES (57, 'Football', 'Academy Team');
INSERT INTO `Club_DB`.`teamSport_Player` (`Player_SSN`, `SportName`, `TeamName`) VALUES (58, 'Football', 'Academy Team');
INSERT INTO `Club_DB`.`teamSport_Player` (`Player_SSN`, `SportName`, `TeamName`) VALUES (59, 'Football', 'Academy Team');
INSERT INTO `Club_DB`.`teamSport_Player` (`Player_SSN`, `SportName`, `TeamName`) VALUES (60, 'Football', 'Academy Team');
INSERT INTO `Club_DB`.`teamSport_Player` (`Player_SSN`, `SportName`, `TeamName`) VALUES (61, 'Basketball', 'Mens Team');
INSERT INTO `Club_DB`.`teamSport_Player` (`Player_SSN`, `SportName`, `TeamName`) VALUES (62, 'Basketball', 'Mens Team');
INSERT INTO `Club_DB`.`teamSport_Player` (`Player_SSN`, `SportName`, `TeamName`) VALUES (63, 'Basketball', 'Mens Team');
INSERT INTO `Club_DB`.`teamSport_Player` (`Player_SSN`, `SportName`, `TeamName`) VALUES (64, 'Basketball', 'Mens Team');
INSERT INTO `Club_DB`.`teamSport_Player` (`Player_SSN`, `SportName`, `TeamName`) VALUES (65, 'Basketball', 'Mens Team');
INSERT INTO `Club_DB`.`teamSport_Player` (`Player_SSN`, `SportName`, `TeamName`) VALUES (66, 'Basketball', 'Mens Team');
INSERT INTO `Club_DB`.`teamSport_Player` (`Player_SSN`, `SportName`, `TeamName`) VALUES (67, 'Basketball', 'Mens Team');
INSERT INTO `Club_DB`.`teamSport_Player` (`Player_SSN`, `SportName`, `TeamName`) VALUES (68, 'Basketball', 'Mens Team');
INSERT INTO `Club_DB`.`teamSport_Player` (`Player_SSN`, `SportName`, `TeamName`) VALUES (69, 'Basketball', 'Mens Team');
INSERT INTO `Club_DB`.`teamSport_Player` (`Player_SSN`, `SportName`, `TeamName`) VALUES (70, 'Basketball', 'Mens Team');
INSERT INTO `Club_DB`.`teamSport_Player` (`Player_SSN`, `SportName`, `TeamName`) VALUES (71, 'Basketball', 'Mens Team');
INSERT INTO `Club_DB`.`teamSport_Player` (`Player_SSN`, `SportName`, `TeamName`) VALUES (72, 'Basketball', 'Mens Team');
INSERT INTO `Club_DB`.`teamSport_Player` (`Player_SSN`, `SportName`, `TeamName`) VALUES (73, 'Basketball', 'Womens Team');
INSERT INTO `Club_DB`.`teamSport_Player` (`Player_SSN`, `SportName`, `TeamName`) VALUES (74, 'Basketball', 'Womens Team');
INSERT INTO `Club_DB`.`teamSport_Player` (`Player_SSN`, `SportName`, `TeamName`) VALUES (75, 'Basketball', 'Womens Team');
INSERT INTO `Club_DB`.`teamSport_Player` (`Player_SSN`, `SportName`, `TeamName`) VALUES (76, 'Basketball', 'Womens Team');
INSERT INTO `Club_DB`.`teamSport_Player` (`Player_SSN`, `SportName`, `TeamName`) VALUES (77, 'Basketball', 'Womens Team');
INSERT INTO `Club_DB`.`teamSport_Player` (`Player_SSN`, `SportName`, `TeamName`) VALUES (78, 'Basketball', 'Womens Team');
INSERT INTO `Club_DB`.`teamSport_Player` (`Player_SSN`, `SportName`, `TeamName`) VALUES (79, 'Basketball', 'Womens Team');
INSERT INTO `Club_DB`.`teamSport_Player` (`Player_SSN`, `SportName`, `TeamName`) VALUES (80, 'Basketball', 'Womens Team');
INSERT INTO `Club_DB`.`teamSport_Player` (`Player_SSN`, `SportName`, `TeamName`) VALUES (81, 'Basketball', 'Womens Team');
INSERT INTO `Club_DB`.`teamSport_Player` (`Player_SSN`, `SportName`, `TeamName`) VALUES (82, 'Basketball', 'Womens Team');
INSERT INTO `Club_DB`.`teamSport_Player` (`Player_SSN`, `SportName`, `TeamName`) VALUES (83, 'Basketball', 'Womens Team');
INSERT INTO `Club_DB`.`teamSport_Player` (`Player_SSN`, `SportName`, `TeamName`) VALUES (84, 'Basketball', 'Womens Team');

COMMIT;


-- -----------------------------------------------------
-- Data for table `Club_DB`.`individualSport_Player`
-- -----------------------------------------------------
START TRANSACTION;
USE `Club_DB`;
INSERT INTO `Club_DB`.`individualSport_Player` (`Player_SSN`, `Coach_SSN`) VALUES (85,  109);
INSERT INTO `Club_DB`.`individualSport_Player` (`Player_SSN`, `Coach_SSN`) VALUES (86,  109);
INSERT INTO `Club_DB`.`individualSport_Player` (`Player_SSN`, `Coach_SSN`) VALUES (87,  109);
INSERT INTO `Club_DB`.`individualSport_Player` (`Player_SSN`, `Coach_SSN`) VALUES (88,  109);
INSERT INTO `Club_DB`.`individualSport_Player` (`Player_SSN`, `Coach_SSN`) VALUES (89,  110);
INSERT INTO `Club_DB`.`individualSport_Player` (`Player_SSN`, `Coach_SSN`) VALUES (90,  110);
INSERT INTO `Club_DB`.`individualSport_Player` (`Player_SSN`, `Coach_SSN`) VALUES (91,  110);
INSERT INTO `Club_DB`.`individualSport_Player` (`Player_SSN`, `Coach_SSN`) VALUES (92,  111);
INSERT INTO `Club_DB`.`individualSport_Player` (`Player_SSN`, `Coach_SSN`) VALUES (93,  111);
INSERT INTO `Club_DB`.`individualSport_Player` (`Player_SSN`, `Coach_SSN`) VALUES (94,  111);
INSERT INTO `Club_DB`.`individualSport_Player` (`Player_SSN`, `Coach_SSN`) VALUES (95,  112);
INSERT INTO `Club_DB`.`individualSport_Player` (`Player_SSN`, `Coach_SSN`) VALUES (96,  112);
INSERT INTO `Club_DB`.`individualSport_Player` (`Player_SSN`, `Coach_SSN`) VALUES (97,  112);
INSERT INTO `Club_DB`.`individualSport_Player` (`Player_SSN`, `Coach_SSN`) VALUES (98,  112);
INSERT INTO `Club_DB`.`individualSport_Player` (`Player_SSN`, `Coach_SSN`) VALUES (99,  113);
INSERT INTO `Club_DB`.`individualSport_Player` (`Player_SSN`, `Coach_SSN`) VALUES (100,  113);
INSERT INTO `Club_DB`.`individualSport_Player` (`Player_SSN`, `Coach_SSN`) VALUES (101,  113);
INSERT INTO `Club_DB`.`individualSport_Player` (`Player_SSN`, `Coach_SSN`) VALUES (102,  114);
INSERT INTO `Club_DB`.`individualSport_Player` (`Player_SSN`, `Coach_SSN`) VALUES (103,  114);
INSERT INTO `Club_DB`.`individualSport_Player` (`Player_SSN`, `Coach_SSN`) VALUES (104,  114);

COMMIT;


-- -----------------------------------------------------
-- Data for table `Club_DB`.`Menu`
-- -----------------------------------------------------
START TRANSACTION;
USE `Club_DB`;
INSERT INTO `Club_DB`.`Menu` (`Catering_Name`, `Item`, `Price`) VALUES ('Azure', 'Kofta', 180.0);
INSERT INTO `Club_DB`.`Menu` (`Catering_Name`, `Item`, `Price`) VALUES ('Azure', 'Shish Tawook', 164.0);
INSERT INTO `Club_DB`.`Menu` (`Catering_Name`, `Item`, `Price`) VALUES ('Azure', 'Grilled Chicken', 118.0);
INSERT INTO `Club_DB`.`Menu` (`Catering_Name`, `Item`, `Price`) VALUES ('Azure', 'Alfredo Pasta', 100.0);
INSERT INTO `Club_DB`.`Menu` (`Catering_Name`, `Item`, `Price`) VALUES ('Azure', 'Mushroom Cream Soup', 39.5);
INSERT INTO `Club_DB`.`Menu` (`Catering_Name`, `Item`, `Price`) VALUES ('sail in sea', 'Shrimp Pasta', 125.0);
INSERT INTO `Club_DB`.`Menu` (`Catering_Name`, `Item`, `Price`) VALUES ('sail in sea', 'Fried Shrimp Sandwich', 80.0);
INSERT INTO `Club_DB`.`Menu` (`Catering_Name`, `Item`, `Price`) VALUES ('sail in sea', 'seafood soup', 65.0);
INSERT INTO `Club_DB`.`Menu` (`Catering_Name`, `Item`, `Price`) VALUES ('sail in sea', 'panne sandwich', 49.0);
INSERT INTO `Club_DB`.`Menu` (`Catering_Name`, `Item`, `Price`) VALUES ('sail in sea', 'caviar salad', 30.0);
INSERT INTO `Club_DB`.`Menu` (`Catering_Name`, `Item`, `Price`) VALUES ('Dominos', 'pepperoni pizza', 150.0);
INSERT INTO `Club_DB`.`Menu` (`Catering_Name`, `Item`, `Price`) VALUES ('Dominos', 'margherita pizza', 100.0);
INSERT INTO `Club_DB`.`Menu` (`Catering_Name`, `Item`, `Price`) VALUES ('Dominos', 'Chicken ranch pizza', 135.0);
INSERT INTO `Club_DB`.`Menu` (`Catering_Name`, `Item`, `Price`) VALUES ('Dominos', 'Chicken BBQ Pizza', 140.0);
INSERT INTO `Club_DB`.`Menu` (`Catering_Name`, `Item`, `Price`) VALUES ('Dominos', 'Veggie Pizza', 110.0);
INSERT INTO `Club_DB`.`Menu` (`Catering_Name`, `Item`, `Price`) VALUES ('Buffalo', 'Mushroom burger', 90.0);
INSERT INTO `Club_DB`.`Menu` (`Catering_Name`, `Item`, `Price`) VALUES ('Buffalo', 'Bacon Burger', 105.0);
INSERT INTO `Club_DB`.`Menu` (`Catering_Name`, `Item`, `Price`) VALUES ('Buffalo', 'Cheese Burger', 80.0);
INSERT INTO `Club_DB`.`Menu` (`Catering_Name`, `Item`, `Price`) VALUES ('Buffalo', 'Chicken Burger', 90.0);
INSERT INTO `Club_DB`.`Menu` (`Catering_Name`, `Item`, `Price`) VALUES ('Buffalo', 'Cheese Fries', 35.0);
INSERT INTO `Club_DB`.`Menu` (`Catering_Name`, `Item`, `Price`) VALUES ('Dolato', 'Bubble Waffle', 35.0);
INSERT INTO `Club_DB`.`Menu` (`Catering_Name`, `Item`, `Price`) VALUES ('Dolato', 'Tiramisu', 50.0);
INSERT INTO `Club_DB`.`Menu` (`Catering_Name`, `Item`, `Price`) VALUES ('Dolato', 'Frozen Yogurt', 34.0);
INSERT INTO `Club_DB`.`Menu` (`Catering_Name`, `Item`, `Price`) VALUES ('Dolato', 'Gelato', 30.0);
INSERT INTO `Club_DB`.`Menu` (`Catering_Name`, `Item`, `Price`) VALUES ('Dolato', 'Cheesecake', 40.0);
INSERT INTO `Club_DB`.`Menu` (`Catering_Name`, `Item`, `Price`) VALUES ('VAMOS', 'Turkish coffee', 12.0);
INSERT INTO `Club_DB`.`Menu` (`Catering_Name`, `Item`, `Price`) VALUES ('VAMOS', 'Tea', 8.5);
INSERT INTO `Club_DB`.`Menu` (`Catering_Name`, `Item`, `Price`) VALUES ('VAMOS', 'Anise', 10.0);
INSERT INTO `Club_DB`.`Menu` (`Catering_Name`, `Item`, `Price`) VALUES ('VAMOS', 'BBQ Chicken Sandwich', 74.0);
INSERT INTO `Club_DB`.`Menu` (`Catering_Name`, `Item`, `Price`) VALUES ('VAMOS', 'French Coffee', 20.0);
INSERT INTO `Club_DB`.`Menu` (`Catering_Name`, `Item`, `Price`) VALUES ('VAMOS', 'Breakfast Sandwich', 16.0);
INSERT INTO `Club_DB`.`Menu` (`Catering_Name`, `Item`, `Price`) VALUES ('VAMOS', 'Fresh Juice', 33.0);
INSERT INTO `Club_DB`.`Menu` (`Catering_Name`, `Item`, `Price`) VALUES ('Costa Coffee', 'Croissant', 25.0);
INSERT INTO `Club_DB`.`Menu` (`Catering_Name`, `Item`, `Price`) VALUES ('Costa Coffee', 'Ice coffee', 45.0);
INSERT INTO `Club_DB`.`Menu` (`Catering_Name`, `Item`, `Price`) VALUES ('Costa Coffee', 'espresso', 25.0);
INSERT INTO `Club_DB`.`Menu` (`Catering_Name`, `Item`, `Price`) VALUES ('Costa Coffee', 'Club Sandwich', 65.0);
INSERT INTO `Club_DB`.`Menu` (`Catering_Name`, `Item`, `Price`) VALUES ('Costa Coffee', 'Cappuccino', 40.0);
INSERT INTO `Club_DB`.`Menu` (`Catering_Name`, `Item`, `Price`) VALUES ('Azure', 'Tehina', 20.0);
INSERT INTO `Club_DB`.`Menu` (`Catering_Name`, `Item`, `Price`) VALUES ('Azure', 'Cesar Salad', 45.0);
INSERT INTO `Club_DB`.`Menu` (`Catering_Name`, `Item`, `Price`) VALUES ('Azure', 'Rice', 18.0);
INSERT INTO `Club_DB`.`Menu` (`Catering_Name`, `Item`, `Price`) VALUES ('Azure', 'Molokhia', 45.0);
INSERT INTO `Club_DB`.`Menu` (`Catering_Name`, `Item`, `Price`) VALUES ('Azure', 'Fahita Sandwich', 50.0);
INSERT INTO `Club_DB`.`Menu` (`Catering_Name`, `Item`, `Price`) VALUES ('Azure', 'French Fries', 26.0);

COMMIT;


-- -----------------------------------------------------
-- Data for table `Club_DB`.`Team`
-- -----------------------------------------------------
START TRANSACTION;
USE `Club_DB`;
INSERT INTO `Club_DB`.`Team` (`SportName`, `TeamName`, `Coach_SSN`) VALUES ('Football', 'First Team', 105);
INSERT INTO `Club_DB`.`Team` (`SportName`, `TeamName`, `Coach_SSN`) VALUES ('Football', 'Academy Team', 106);
INSERT INTO `Club_DB`.`Team` (`SportName`, `TeamName`, `Coach_SSN`) VALUES ('Basketball', 'Mens Team', 107);
INSERT INTO `Club_DB`.`Team` (`SportName`, `TeamName`, `Coach_SSN`) VALUES ('Basketball', 'Womens Team', 108);

COMMIT;


-- -----------------------------------------------------
-- Data for table `Club_DB`.`Player`
-- -----------------------------------------------------
START TRANSACTION;
USE `Club_DB`;
INSERT INTO `Club_DB`.`Player` (`PlayerSSN`, `Management_Name`, `SportName`, `subPrice`, `StartDate`) VALUES (268, 'Sport', 'Football', 450, '2019-07-26');
INSERT INTO `Club_DB`.`Player` (`PlayerSSN`, `Management_Name`, `SportName`, `subPrice`, `StartDate`) VALUES (269, 'Sport', 'Football', 450, '2023-05-01');
INSERT INTO `Club_DB`.`Player` (`PlayerSSN`, `Management_Name`, `SportName`, `subPrice`, `StartDate`) VALUES (270, 'Sport', 'Football', 450, '2019-12-11');
INSERT INTO `Club_DB`.`Player` (`PlayerSSN`, `Management_Name`, `SportName`, `subPrice`, `StartDate`) VALUES (271, 'Sport', 'Football', 450, '2018-09-03');
INSERT INTO `Club_DB`.`Player` (`PlayerSSN`, `Management_Name`, `SportName`, `subPrice`, `StartDate`) VALUES (272, 'Sport', 'Football', 450, '2019-12-21');
INSERT INTO `Club_DB`.`Player` (`PlayerSSN`, `Management_Name`, `SportName`, `subPrice`, `StartDate`) VALUES (273, 'Sport', 'Football', 450, '2020-09-26');
INSERT INTO `Club_DB`.`Player` (`PlayerSSN`, `Management_Name`, `SportName`, `subPrice`, `StartDate`) VALUES (274, 'Sport', 'Football', 450, '2018-12-26');
INSERT INTO `Club_DB`.`Player` (`PlayerSSN`, `Management_Name`, `SportName`, `subPrice`, `StartDate`) VALUES (275, 'Sport', 'Football', 450, '2023-07-30');
INSERT INTO `Club_DB`.`Player` (`PlayerSSN`, `Management_Name`, `SportName`, `subPrice`, `StartDate`) VALUES (276, 'Sport', 'Football', 450, '2020-03-21');
INSERT INTO `Club_DB`.`Player` (`PlayerSSN`, `Management_Name`, `SportName`, `subPrice`, `StartDate`) VALUES (277, 'Sport', 'Football', 450, '2020-02-24');
INSERT INTO `Club_DB`.`Player` (`PlayerSSN`, `Management_Name`, `SportName`, `subPrice`, `StartDate`) VALUES (278, 'Sport', 'Football', 450, '2019-03-30');
INSERT INTO `Club_DB`.`Player` (`PlayerSSN`, `Management_Name`, `SportName`, `subPrice`, `StartDate`) VALUES (279, 'Sport', 'Football', 450, '2019-10-26');
INSERT INTO `Club_DB`.`Player` (`PlayerSSN`, `Management_Name`, `SportName`, `subPrice`, `StartDate`) VALUES (280, 'Sport', 'Football', 450, '2020-04-30');
INSERT INTO `Club_DB`.`Player` (`PlayerSSN`, `Management_Name`, `SportName`, `subPrice`, `StartDate`) VALUES (281, 'Sport', 'Football', 450, '2018-09-23');
INSERT INTO `Club_DB`.`Player` (`PlayerSSN`, `Management_Name`, `SportName`, `subPrice`, `StartDate`) VALUES (282, 'Sport', 'Football', 450, '2020-12-17');
INSERT INTO `Club_DB`.`Player` (`PlayerSSN`, `Management_Name`, `SportName`, `subPrice`, `StartDate`) VALUES (283, 'Sport', 'Football', 450, '2018-12-19');
INSERT INTO `Club_DB`.`Player` (`PlayerSSN`, `Management_Name`, `SportName`, `subPrice`, `StartDate`) VALUES (284, 'Sport', 'Football', 450, '2022-06-24');
INSERT INTO `Club_DB`.`Player` (`PlayerSSN`, `Management_Name`, `SportName`, `subPrice`, `StartDate`) VALUES (285, 'Sport', 'Football', 450, '2020-01-31');
INSERT INTO `Club_DB`.`Player` (`PlayerSSN`, `Management_Name`, `SportName`, `subPrice`, `StartDate`) VALUES (286, 'Sport', 'Football', 450, '2018-06-29');
INSERT INTO `Club_DB`.`Player` (`PlayerSSN`, `Management_Name`, `SportName`, `subPrice`, `StartDate`) VALUES (287, 'Sport', 'Football', 450, '2019-07-23');
INSERT INTO `Club_DB`.`Player` (`PlayerSSN`, `Management_Name`, `SportName`, `subPrice`, `StartDate`) VALUES (288, 'Sport', 'Basketball', 300, '2020-12-28');
INSERT INTO `Club_DB`.`Player` (`PlayerSSN`, `Management_Name`, `SportName`, `subPrice`, `StartDate`) VALUES (289, 'Sport', 'Basketball', 300, '2023-12-10');
INSERT INTO `Club_DB`.`Player` (`PlayerSSN`, `Management_Name`, `SportName`, `subPrice`, `StartDate`) VALUES (290, 'Sport', 'Basketball', 300, '2022-04-23');
INSERT INTO `Club_DB`.`Player` (`PlayerSSN`, `Management_Name`, `SportName`, `subPrice`, `StartDate`) VALUES (291, 'Sport', 'Basketball', 300, '2022-06-25');
INSERT INTO `Club_DB`.`Player` (`PlayerSSN`, `Management_Name`, `SportName`, `subPrice`, `StartDate`) VALUES (292, 'Sport', 'Basketball', 300, '2021-09-23');
INSERT INTO `Club_DB`.`Player` (`PlayerSSN`, `Management_Name`, `SportName`, `subPrice`, `StartDate`) VALUES (293, 'Sport', 'Basketball', 300, '2018-12-14');
INSERT INTO `Club_DB`.`Player` (`PlayerSSN`, `Management_Name`, `SportName`, `subPrice`, `StartDate`) VALUES (294, 'Sport', 'Basketball', 300, '2022-11-07');
INSERT INTO `Club_DB`.`Player` (`PlayerSSN`, `Management_Name`, `SportName`, `subPrice`, `StartDate`) VALUES (295, 'Sport', 'Basketball', 300, '2019-07-24');
INSERT INTO `Club_DB`.`Player` (`PlayerSSN`, `Management_Name`, `SportName`, `subPrice`, `StartDate`) VALUES (296, 'Sport', 'Basketball', 300, '2023-11-23');
INSERT INTO `Club_DB`.`Player` (`PlayerSSN`, `Management_Name`, `SportName`, `subPrice`, `StartDate`) VALUES (297, 'Sport', 'Basketball', 300, '2023-07-03');
INSERT INTO `Club_DB`.`Player` (`PlayerSSN`, `Management_Name`, `SportName`, `subPrice`, `StartDate`) VALUES (298, 'Sport', 'Basketball', 300, '2022-11-24');
INSERT INTO `Club_DB`.`Player` (`PlayerSSN`, `Management_Name`, `SportName`, `subPrice`, `StartDate`) VALUES (299, 'Sport', 'Basketball', 300, '2019-01-21');
INSERT INTO `Club_DB`.`Player` (`PlayerSSN`, `Management_Name`, `SportName`, `subPrice`, `StartDate`) VALUES (300, 'Sport', 'Basketball', 300, '2018-11-21');
INSERT INTO `Club_DB`.`Player` (`PlayerSSN`, `Management_Name`, `SportName`, `subPrice`, `StartDate`) VALUES (301, 'Sport', 'Basketball', 300, '2019-02-01');
INSERT INTO `Club_DB`.`Player` (`PlayerSSN`, `Management_Name`, `SportName`, `subPrice`, `StartDate`) VALUES (302, 'Sport', 'Basketball', 300, '2023-09-18');
INSERT INTO `Club_DB`.`Player` (`PlayerSSN`, `Management_Name`, `SportName`, `subPrice`, `StartDate`) VALUES (303, 'Sport', 'Basketball', 300, '2023-12-21');
INSERT INTO `Club_DB`.`Player` (`PlayerSSN`, `Management_Name`, `SportName`, `subPrice`, `StartDate`) VALUES (304, 'Sport', 'Basketball', 300, '2020-11-24');
INSERT INTO `Club_DB`.`Player` (`PlayerSSN`, `Management_Name`, `SportName`, `subPrice`, `StartDate`) VALUES (305, 'Sport', 'Basketball', 300, '2019-12-08');
INSERT INTO `Club_DB`.`Player` (`PlayerSSN`, `Management_Name`, `SportName`, `subPrice`, `StartDate`) VALUES (306, 'Sport', 'Basketball', 300, '2023-10-05 ');
INSERT INTO `Club_DB`.`Player` (`PlayerSSN`, `Management_Name`, `SportName`, `subPrice`, `StartDate`) VALUES (307, 'Sport', 'Basketball', 300, '2022-11-23');
INSERT INTO `Club_DB`.`Player` (`PlayerSSN`, `Management_Name`, `SportName`, `subPrice`, `StartDate`) VALUES (308, 'Sport', 'Swimming', 400, '2023-11-12');
INSERT INTO `Club_DB`.`Player` (`PlayerSSN`, `Management_Name`, `SportName`, `subPrice`, `StartDate`) VALUES (309, 'Sport', 'Swimming', 400, '2019-11-29');
INSERT INTO `Club_DB`.`Player` (`PlayerSSN`, `Management_Name`, `SportName`, `subPrice`, `StartDate`) VALUES (310, 'Sport', 'Swimming', 400, '2023-10-30');
INSERT INTO `Club_DB`.`Player` (`PlayerSSN`, `Management_Name`, `SportName`, `subPrice`, `StartDate`) VALUES (311, 'Sport', 'Swimming', 400, '2020-12-09');
INSERT INTO `Club_DB`.`Player` (`PlayerSSN`, `Management_Name`, `SportName`, `subPrice`, `StartDate`) VALUES (312, 'Sport', 'Swimming', 400, '2019-05-03');
INSERT INTO `Club_DB`.`Player` (`PlayerSSN`, `Management_Name`, `SportName`, `subPrice`, `StartDate`) VALUES (313, 'Sport', 'Swimming', 400, '2022-05-16');
INSERT INTO `Club_DB`.`Player` (`PlayerSSN`, `Management_Name`, `SportName`, `subPrice`, `StartDate`) VALUES (314, 'Sport', 'Swimming', 400, '2023-07-15');
INSERT INTO `Club_DB`.`Player` (`PlayerSSN`, `Management_Name`, `SportName`, `subPrice`, `StartDate`) VALUES (315, 'Sport', 'Swimming', 400, '2021-11-14');
INSERT INTO `Club_DB`.`Player` (`PlayerSSN`, `Management_Name`, `SportName`, `subPrice`, `StartDate`) VALUES (316, 'Sport', 'Swimming', 400, '2023-07-09');
INSERT INTO `Club_DB`.`Player` (`PlayerSSN`, `Management_Name`, `SportName`, `subPrice`, `StartDate`) VALUES (317, 'Sport', 'Swimming', 400, '2022-10-16');
INSERT INTO `Club_DB`.`Player` (`PlayerSSN`, `Management_Name`, `SportName`, `subPrice`, `StartDate`) VALUES (318, 'Sport', 'Swimming', 400, '2021-12-28');
INSERT INTO `Club_DB`.`Player` (`PlayerSSN`, `Management_Name`, `SportName`, `subPrice`, `StartDate`) VALUES (319, 'Sport', 'Swimming', 400, '2023-11-11');
INSERT INTO `Club_DB`.`Player` (`PlayerSSN`, `Management_Name`, `SportName`, `subPrice`, `StartDate`) VALUES (320, 'Sport', 'Swimming', 400, '2021-04-19');
INSERT INTO `Club_DB`.`Player` (`PlayerSSN`, `Management_Name`, `SportName`, `subPrice`, `StartDate`) VALUES (321, 'Sport', 'Swimming', 400, '2019-08-17');
INSERT INTO `Club_DB`.`Player` (`PlayerSSN`, `Management_Name`, `SportName`, `subPrice`, `StartDate`) VALUES (322, 'Sport', 'Swimming', 400, '2022-11-18');
INSERT INTO `Club_DB`.`Player` (`PlayerSSN`, `Management_Name`, `SportName`, `subPrice`, `StartDate`) VALUES (323, 'Sport', 'Swimming', 400, '2021-07-26');
INSERT INTO `Club_DB`.`Player` (`PlayerSSN`, `Management_Name`, `SportName`, `subPrice`, `StartDate`) VALUES (324, 'Sport', 'Swimming', 400, '2022-01-03');
INSERT INTO `Club_DB`.`Player` (`PlayerSSN`, `Management_Name`, `SportName`, `subPrice`, `StartDate`) VALUES (325, 'Sport', 'Swimming', 400, '2018-09-17');
INSERT INTO `Club_DB`.`Player` (`PlayerSSN`, `Management_Name`, `SportName`, `subPrice`, `StartDate`) VALUES (326, 'Sport', 'Swimming', 400, '2021-04-03');
INSERT INTO `Club_DB`.`Player` (`PlayerSSN`, `Management_Name`, `SportName`, `subPrice`, `StartDate`) VALUES (327, 'Sport', 'Swimming', 400, '2020-02-26');
INSERT INTO `Club_DB`.`Player` (`PlayerSSN`, `Management_Name`, `SportName`, `subPrice`, `StartDate`) VALUES (328, 'Sport', 'Kung Fu', 250, '2020-12-19');
INSERT INTO `Club_DB`.`Player` (`PlayerSSN`, `Management_Name`, `SportName`, `subPrice`, `StartDate`) VALUES (329, 'Sport', 'Kung Fu', 250, '2021-08-12');
INSERT INTO `Club_DB`.`Player` (`PlayerSSN`, `Management_Name`, `SportName`, `subPrice`, `StartDate`) VALUES (330, 'Sport', 'Kung Fu', 250, '2019-01-17');
INSERT INTO `Club_DB`.`Player` (`PlayerSSN`, `Management_Name`, `SportName`, `subPrice`, `StartDate`) VALUES (331, 'Sport', 'Kung Fu', 250, '2021-07-14');
INSERT INTO `Club_DB`.`Player` (`PlayerSSN`, `Management_Name`, `SportName`, `subPrice`, `StartDate`) VALUES (332, 'Sport', 'Kung Fu', 250, '2019-02-27');
INSERT INTO `Club_DB`.`Player` (`PlayerSSN`, `Management_Name`, `SportName`, `subPrice`, `StartDate`) VALUES (333, 'Sport', 'Kung Fu', 250, '2019-07-26');
INSERT INTO `Club_DB`.`Player` (`PlayerSSN`, `Management_Name`, `SportName`, `subPrice`, `StartDate`) VALUES (334, 'Sport', 'Kung Fu', 250, '2023-04-17');
INSERT INTO `Club_DB`.`Player` (`PlayerSSN`, `Management_Name`, `SportName`, `subPrice`, `StartDate`) VALUES (335, 'Sport', 'Kung Fu', 250, '2019-12-30');
INSERT INTO `Club_DB`.`Player` (`PlayerSSN`, `Management_Name`, `SportName`, `subPrice`, `StartDate`) VALUES (336, 'Sport', 'Kung Fu', 250, '2022-11-17');
INSERT INTO `Club_DB`.`Player` (`PlayerSSN`, `Management_Name`, `SportName`, `subPrice`, `StartDate`) VALUES (337, 'Sport', 'Kung Fu', 250, '2023-09-27');
INSERT INTO `Club_DB`.`Player` (`PlayerSSN`, `Management_Name`, `SportName`, `subPrice`, `StartDate`) VALUES (338, 'Sport', 'Kung Fu', 250, '2019-03-27');
INSERT INTO `Club_DB`.`Player` (`PlayerSSN`, `Management_Name`, `SportName`, `subPrice`, `StartDate`) VALUES (339, 'Sport', 'Kung Fu', 250, '2020-06-19');
INSERT INTO `Club_DB`.`Player` (`PlayerSSN`, `Management_Name`, `SportName`, `subPrice`, `StartDate`) VALUES (340, 'Sport', 'Kung Fu', 250, '2019-09-27');
INSERT INTO `Club_DB`.`Player` (`PlayerSSN`, `Management_Name`, `SportName`, `subPrice`, `StartDate`) VALUES (341, 'Sport', 'Kung Fu', 250, '2023-12-18');
INSERT INTO `Club_DB`.`Player` (`PlayerSSN`, `Management_Name`, `SportName`, `subPrice`, `StartDate`) VALUES (342, 'Sport', 'Kung Fu', 250, '2022-01-27');
INSERT INTO `Club_DB`.`Player` (`PlayerSSN`, `Management_Name`, `SportName`, `subPrice`, `StartDate`) VALUES (343, 'Sport', 'Kung Fu', 250, '2020-03-28');
INSERT INTO `Club_DB`.`Player` (`PlayerSSN`, `Management_Name`, `SportName`, `subPrice`, `StartDate`) VALUES (344, 'Sport', 'Kung Fu', 250, '2022-07-23');
INSERT INTO `Club_DB`.`Player` (`PlayerSSN`, `Management_Name`, `SportName`, `subPrice`, `StartDate`) VALUES (345, 'Sport', 'Kung Fu', 250, '2023-12-06');
INSERT INTO `Club_DB`.`Player` (`PlayerSSN`, `Management_Name`, `SportName`, `subPrice`, `StartDate`) VALUES (346, 'Sport', 'Kung Fu', 250, '2021-01-25');
INSERT INTO `Club_DB`.`Player` (`PlayerSSN`, `Management_Name`, `SportName`, `subPrice`, `StartDate`) VALUES (347, 'Sport', 'Kung Fu', 250, '2020-10-24');

COMMIT;


SET SQL_MODE=@OLD_SQL_MODE;
SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS;
SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS;
