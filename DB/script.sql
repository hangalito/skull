-- MySQL Workbench Forward Engineering

SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0;
SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0;
SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION';

-- -----------------------------------------------------
-- Schema skull_db
-- -----------------------------------------------------

-- -----------------------------------------------------
-- Schema skull_db
-- -----------------------------------------------------
CREATE SCHEMA IF NOT EXISTS `skull_db` DEFAULT CHARACTER SET utf8 COLLATE utf8_general_mysql500_ci ;
USE `skull_db` ;

-- -----------------------------------------------------
-- Table `skull_db`.`localização`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `skull_db`.`localização` (
  `id_localizacao` INT NOT NULL,
  `provincia` VARCHAR(45) NOT NULL DEFAULT 'Luanda',
  `municipio` VARCHAR(45) NULL,
  PRIMARY KEY (`id_localizacao`));


-- -----------------------------------------------------
-- Table `skull_db`.`colegio`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `skull_db`.`colegio` (
  `id_colegio` INT NOT NULL AUTO_INCREMENT,
  `name` VARCHAR(255) NOT NULL,
  `nif` INT NULL,
  `localizacao` INT NOT NULL,
  PRIMARY KEY (`id_colegio`),
  INDEX `colegio_localizacao_idx` (`localizacao` ASC) VISIBLE,
  CONSTRAINT `colegio_localizacao`
    FOREIGN KEY (`localizacao`)
    REFERENCES `skull_db`.`localização` (`id_localizacao`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION);


-- -----------------------------------------------------
-- Table `skull_db`.`classe`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `skull_db`.`classe` (
  `id_classe` INT NOT NULL AUTO_INCREMENT,
  `classe` VARCHAR(9) NOT NULL,
  `colegio_id` INT NOT NULL,
  PRIMARY KEY (`id_classe`),
  INDEX `classe_colegio_id_idx` (`colegio_id` ASC) VISIBLE,
  CONSTRAINT `classe_colegio_id`
    FOREIGN KEY (`colegio_id`)
    REFERENCES `skull_db`.`colegio` (`id_colegio`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION);


-- -----------------------------------------------------
-- Table `skull_db`.`usuario`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `skull_db`.`usuario` (
  `usuario_id` INT NOT NULL,
  `nome` VARCHAR(45) NOT NULL,
  `sobrenome` VARCHAR(45) NULL,
  `sexo` ENUM("Masculino", "Feminino") NULL,
  `email` VARCHAR(60) NULL,
  `turma_id` INT NULL,
  `create_time` TIMESTAMP NULL DEFAULT CURRENT_TIMESTAMP,
  PRIMARY KEY (`usuario_id`),
  INDEX `turma_id_idx` (`turma_id` ASC) VISIBLE,
  CONSTRAINT `usuario_turma_id`
    FOREIGN KEY (`turma_id`)
    REFERENCES `skull_db`.`turma` (`id_turma`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION);


-- -----------------------------------------------------
-- Table `skull_db`.`turma`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `skull_db`.`turma` (
  `id_turma` INT NOT NULL,
  `nome` VARCHAR(9) NOT NULL,
  `classe_id` INT NOT NULL,
  `director_de_turma` INT NOT NULL,
  PRIMARY KEY (`id_turma`),
  INDEX `classe_id_idx` (`classe_id` ASC) VISIBLE,
  INDEX `usuario_id_idx` (`director_de_turma` ASC) VISIBLE,
  CONSTRAINT `turma_classe_id`
    FOREIGN KEY (`classe_id`)
    REFERENCES `skull_db`.`classe` (`id_classe`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `turma_usuario_id`
    FOREIGN KEY (`director_de_turma`)
    REFERENCES `skull_db`.`usuario` (`usuario_id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION);


-- -----------------------------------------------------
-- Table `skull_db`.`contacto`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `skull_db`.`contacto` (
  `id_contacto` INT NOT NULL AUTO_INCREMENT,
  `email` VARCHAR(60) NOT NULL,
  `telefone` VARCHAR(45) NULL,
  `usuario_id` INT NOT NULL,
  PRIMARY KEY (`id_contacto`),
  INDEX `usuario_id_idx` (`usuario_id` ASC) VISIBLE,
  CONSTRAINT `contacto_usuario_id`
    FOREIGN KEY (`usuario_id`)
    REFERENCES `skull_db`.`usuario` (`usuario_id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION);


SET SQL_MODE=@OLD_SQL_MODE;
SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS;
SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS;
