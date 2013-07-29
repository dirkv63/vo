-- phpMyAdmin SQL Dump
-- version 3.4.10.1
-- http://www.phpmyadmin.net
--
-- Host: localhost
-- Generation Time: Jul 23, 2013 at 09:08 AM
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
-- Table structure for table `component`
--

DROP TABLE IF EXISTS `component`;
CREATE TABLE IF NOT EXISTS `component` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `cmdb_id` int(11) NOT NULL,
  `bt_nummer` int(11) DEFAULT NULL,
  `ci_categorie` varchar(255) DEFAULT NULL,
  `ci_class` varchar(255) DEFAULT NULL,
  `ci_type` varchar(255) DEFAULT NULL,
  `datum_buiten_gebruik` date DEFAULT NULL,
  `datum_in_gebruik` date DEFAULT NULL,
  `dienstentype` varchar(255) DEFAULT NULL,
  `eigenaar_beleidsdomein` varchar(255) DEFAULT NULL,
  `eigenaar_entiteit` varchar(255) DEFAULT NULL,
  `fin_beleidsdomein` varchar(255) DEFAULT NULL,
  `fin_entiteit` varchar(255) DEFAULT NULL,
  `functionele_naam` varchar(255) DEFAULT NULL,
  `hw_sw_flag` varchar(255) DEFAULT NULL,
  `locatie` varchar(255) DEFAULT NULL,
  `naam` varchar(255) DEFAULT NULL,
  `omgeving` varchar(255) DEFAULT NULL,
  `os` varchar(255) DEFAULT NULL,
  `os_versie` varchar(255) DEFAULT NULL,
  `producent` varchar(255) DEFAULT NULL,
  `product` varchar(255) DEFAULT NULL,
  `so_toepassingsmanager` varchar(255) DEFAULT NULL,
  `status` varchar(255) DEFAULT NULL,
  `versie` varchar(255) DEFAULT NULL,
  `vo_toepassingsmanager` varchar(255) DEFAULT NULL,
  `standaarddatum` date DEFAULT NULL,
  `uitdovend_datum` date DEFAULT NULL,
  `uitgedoofd_datum` date DEFAULT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `cmdb_id` (`cmdb_id`)
) ENGINE=MyISAM  DEFAULT CHARSET=utf8 AUTO_INCREMENT=16626 ;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
