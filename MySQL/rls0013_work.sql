-- phpMyAdmin SQL Dump
-- version 3.4.10.1
-- http://www.phpmyadmin.net
--
-- Host: localhost
-- Generation Time: Jul 24, 2013 at 01:46 PM
-- Server version: 5.5.22
-- PHP Version: 5.4.0

SET SQL_MODE="NO_AUTO_VALUE_ON_ZERO";
SET time_zone = "+00:00";


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8 */;

--
-- Database: `vo`
--

-- --------------------------------------------------------

--
-- Table structure for table `rls0013_work`
--

CREATE TABLE IF NOT EXISTS `rls0013_work` (
  `ID` int(11) NOT NULL AUTO_INCREMENT,
  `Toepassingomgeving` varchar(255) DEFAULT NULL,
  `CMDB referentie omgeving` varchar(255) DEFAULT NULL,
  `Versie` varchar(255) DEFAULT NULL,
  `Type omgeving` varchar(255) DEFAULT NULL,
  `Datum in gebruik` datetime DEFAULT NULL,
  `Datum buiten gebruik` datetime DEFAULT NULL,
  `CMDB referentie bedrijfstoepassing` varchar(255) DEFAULT NULL,
  `Naam bedrijfstoepassing` varchar(255) DEFAULT NULL,
  `Nummer bedrijfstoepassing` varchar(255) DEFAULT NULL,
  `Dienstentype` varchar(255) DEFAULT NULL,
  `Financieel beheerder (Beleidsdomein)` varchar(255) DEFAULT NULL,
  `Financieel beheerder (entiteit)` varchar(255) DEFAULT NULL,
  `Eigenaar (Beleidsdomein)` varchar(255) DEFAULT NULL,
  `Eigenaar (entiteit)` varchar(255) DEFAULT NULL,
  `Status bedrijfstoepassing` varchar(255) DEFAULT NULL,
  `Field16` datetime DEFAULT NULL,
  `Field17` datetime DEFAULT NULL,
  `SO Toepassingsmanager(s)` varchar(255) DEFAULT NULL,
  `VO Applicatiebeheerder(s)` varchar(255) DEFAULT NULL,
  `Field20` varchar(255) DEFAULT NULL,
  `CI categorie` varchar(255) DEFAULT NULL,
  `CI CMDB referentie` varchar(255) DEFAULT NULL,
  `CI systeemnaam` varchar(255) DEFAULT NULL,
  `Gerelateerd systeem (CMDB referentie)` varchar(255) DEFAULT NULL,
  `CI status` varchar(255) DEFAULT NULL,
  `CI eigenaar` varchar(255) DEFAULT NULL,
  `Producent` varchar(255) DEFAULT NULL,
  `Product` varchar(255) DEFAULT NULL,
  `Field29` varchar(255) DEFAULT NULL,
  `Dienst CI` varchar(255) DEFAULT NULL,
  `Beleidsdomein financieel beh` varchar(255) DEFAULT NULL,
  `Entiteit financieel beh` varchar(255) DEFAULT NULL,
  `RSM J/N` varchar(255) DEFAULT NULL,
  `Standaarddatum` datetime DEFAULT NULL,
  `Uitdovend datum` datetime DEFAULT NULL,
  `Uitgedoofd datum` datetime DEFAULT NULL,
  `HW/SW` varchar(255) DEFAULT NULL,
  `Locatie` varchar(255) DEFAULT NULL,
  PRIMARY KEY (`ID`)
) ENGINE=MyISAM  DEFAULT CHARSET=utf8 AUTO_INCREMENT=12882 ;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
