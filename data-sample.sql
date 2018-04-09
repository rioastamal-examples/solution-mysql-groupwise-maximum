-- Author       : Rio Astamal <rio@rioastamal.net>
-- Description  : Solution to SQL group-wise maximum problem
-- Link         : https://github.com/rioastamal-examples/solution-mysql-groupwise-maximum
-- Article      : https://www.linkedin.com/pulse/mysql-group-wise-maximum-query-nilai-tertinggi-pada-setiap-astamal/

-- Test Database
--
CREATE DATABASE `groupwise_example` DEFAULT CHARSET utf8;
USE groupwise_example;

-- Test Table
--
CREATE TABLE `top_scores` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `player` varchar(50) NOT NULL,
  `club` varchar(50) NOT NULL,
  `season` char(9) DEFAULT NULL,
  `goals` int(3) DEFAULT 0,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- Data are from Premier League top scores season 2015-2016
--
INSERT INTO `top_scores` (`player`, `club`, `season`, `goals`) VALUES
("Alexis Sanchez", "Arsenal", "2015-2016", 13),
("Troy Deeney", "Watford", "2015-2016", 13),
("Romelu Lukaku", "Everton", "2015-2016", 18),
("Harry Kane", "Tottenham Hotspur", "2015-2016", 25),
("Oliver Giroud", "Arsenal", "2015-2016", 16),
("Anthony Martial", "Manchester United", "2015-2016", 11),
("Riyad Mahrez", "Leicester City", "2015-2016", 17),
("Gylfi Sigurdsson", "Swansea City", "2015-2016", 11),
("Jamie Vardy", "Leicester City", "2015-2016", 24),
("Odion Ighalo", "Watford", "2015-2016", 15),
("André Ayew", "Swansea City", "2015-2016", 12),
("Diego Costa", "Chelsea", "2015-2016", 12);
