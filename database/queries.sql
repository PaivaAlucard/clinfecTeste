-- MySQL Workbench Forward Engineering

SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0;
SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0;
SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION';

-- -----------------------------------------------------
-- Schema clinfecBanco
-- -----------------------------------------------------

-- -----------------------------------------------------
-- Schema clinfecBanco
-- -----------------------------------------------------
CREATE SCHEMA IF NOT EXISTS `clinfecBanco` DEFAULT CHARACTER SET utf8 ;
USE `clinfecBanco` ;

-- -----------------------------------------------------
-- Table `clinfecBanco`.`MedicoClinfec`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `clinfecBanco`.`MedicoClinfec` (
  `idMedicoClinfec` INT NOT NULL AUTO_INCREMENT,
  `nome` VARCHAR(255) NULL,
  `crm` VARCHAR(255) NULL,
  `especialidade` VARCHAR(255) NULL,
  `ativo` INT NULL DEFAULT 1,
  PRIMARY KEY (`idMedicoClinfec`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `clinfecBanco`.`ConsultaClinfec`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `clinfecBanco`.`ConsultaClinfec` (
  `idConsultaClinfec` INT NOT NULL AUTO_INCREMENT,
  `dataConsulta` DATETIME NULL,
  `idMedicoClinfec_fk` INT NULL,
  `idPacienteClinfec_fk` INT NULL,
  `ativo` INT NULL DEFAULT 1,
  PRIMARY KEY (`idConsultaClinfec`),
  INDEX `MedicoId_fk_idx` (`idMedicoClinfec_fk` ASC) VISIBLE,
  INDEX `PacienteId_fk_idx` (`idPacienteClinfec_fk` ASC) VISIBLE,
  CONSTRAINT `MedicoId_fk`
    FOREIGN KEY (`idMedicoClinfec_fk`)
    REFERENCES `clinfecBanco`.`MedicoClinfec` (`idMedicoClinfec`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `PacienteId_fk`
    FOREIGN KEY (`idPacienteClinfec_fk`)
    REFERENCES `clinfecBanco`.`PacienteClinfec` (`idPacienteClinfec`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `clinfecBanco`.`PacienteClinfec`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `clinfecBanco`.`PacienteClinfec` (
  `idPacienteClinfec` INT NOT NULL AUTO_INCREMENT,
  `nome` VARCHAR(255) NULL,
  `sobreNome` VARCHAR(255) NULL,
  `dataDeNascimento` DATETIME NULL,
  `cpf` VARCHAR(255) NULL,
  `idConsultaClinfec_fk` INT NULL,
  `ativo` INT NULL DEFAULT 1,
  PRIMARY KEY (`idPacienteClinfec`),
  INDEX `ConsultaId_fk_idx` (`idConsultaClinfec_fk` ASC) VISIBLE,
  CONSTRAINT `ConsultaId_fk`
    FOREIGN KEY (`idConsultaClinfec_fk`)
    REFERENCES `clinfecBanco`.`ConsultaClinfec` (`idConsultaClinfec`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


SET SQL_MODE=@OLD_SQL_MODE;
SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS;
SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS;


INSERT INTO `clinfecbanco`.`medicoclinfec` (`nome`, `crm`, `especialidade`) VALUES ('Brendon Souza', '6453632456', 'Especialista em Acupuntura');
INSERT INTO `clinfecbanco`.`medicoclinfec` (`nome`,`crm`,`especialidade`) VALUES ('Gabriel Paiva','1231243345','Geral');
INSERT INTO `clinfecbanco`.`medicoclinfec` (`nome`, `crm`, `especialidade`) VALUES ('Joao', '67547647745', 'Especialista em Cirurgia Pediátrica');
INSERT INTO `clinfecbanco`.`medicoclinfec` (`nome`, `crm`, `especialidade`, `ativo`) VALUES ('Filipe', '75547647745', 'Especialista em Cirurgia Pediátrica', 0);


 INSERT INTO `clinfecbanco`.`pacienteclinfec` 
 (`nome`, `sobreNome`, `dataDeNascimento`, `cpf`, `idConsultaClinfec_fk`) 
 VALUES ('Junior', 'Lima', '2098-01-23 12:45:56', '03718758112', '1');
 
 INSERT INTO `clinfecbanco`.`consultaclinfec` 
 (`dataConsulta`, `idMedicoClinfec_fk`, `idPacienteClinfec_fk`) 
 VALUES ('2098-01-23 12:45:56', '1', '1');
 
 -- ----------------
 
 INSERT INTO `clinfecbanco`.`pacienteclinfec` 
 (`nome`, `sobreNome`, `dataDeNascimento`, `cpf`, `idConsultaClinfec_fk`) 
 VALUES ('Pedro', 'Junior', '2008-01-23 12:45:56', '13718758112', '2');
 
 INSERT INTO `clinfecbanco`.`consultaclinfec` 
 (`dataConsulta`, `idMedicoClinfec_fk`, `idPacienteClinfec_fk`) 
 VALUES ('2008-01-23 12:45:56', '2', '2');

CREATE TABLE users (
  user_id INT PRIMARY KEY AUTO_INCREMENT,
  username VARCHAR (60) NOT NULL,
  password VARCHAR (60) NOT NULL,
  full_name VARCHAR(60) NOT NULL,
  email VARCHAR(60) NOT NULL,
  phone INT NOT NULL,
  delivery_address VARCHAR (60) NOT NULL,
  is_admin BOOLEAN NOT NULL DEFAULT FALSE,
  is_disabled BOOLEAN DEFAULT FALSE
);

-- Populate users table
INSERT INTO
  users
VALUES
  (
    NULL,
    "gabriel",
    "bieltdb20",
    "Gabriel Paiva",
    "bieltdb20@gmail.com",
    1122223333,
    "Brasilia 123",
    TRUE,
    FALSE
  );