CREATE DATABASE  IF NOT EXISTS `futbol` /*!40100 DEFAULT CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci */ /*!80016 DEFAULT ENCRYPTION='N' */;
USE `futbol`;
-- MySQL dump 10.13  Distrib 8.0.45, for Win64 (x86_64)
--
-- Host: 127.0.0.1    Database: football
-- ------------------------------------------------------
-- Server version	8.0.45

/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!50503 SET NAMES utf8 */;
/*!40103 SET @OLD_TIME_ZONE=@@TIME_ZONE */;
/*!40103 SET TIME_ZONE='+00:00' */;
/*!40014 SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0 */;
/*!40014 SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0 */;
/*!40101 SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='NO_AUTO_VALUE_ON_ZERO' */;
/*!40111 SET @OLD_SQL_NOTES=@@SQL_NOTES, SQL_NOTES=0 */;

--
-- Table structure for table `entrenador`
--

DROP TABLE IF EXISTS `entrenador`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `entrenador` (
  `ID` int NOT NULL AUTO_INCREMENT,
  `Nombre` varchar(60) NOT NULL,
  `Apellido` varchar(60) NOT NULL,
  `Nacionalidad` varchar(50) DEFAULT NULL,
  `EquipoID` int DEFAULT NULL,
  PRIMARY KEY (`ID`),
  UNIQUE KEY `uqEntrenadorApellidoID` (`Apellido`,`ID`) USING BTREE,
  UNIQUE KEY `uqEntrenadorEquipo` (`EquipoID`),
  CONSTRAINT `fk_entrenador_equipo` FOREIGN KEY (`EquipoID`) REFERENCES `equipo` (`ID`) ON DELETE SET NULL ON UPDATE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=8 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `entrenador`
--

LOCK TABLES `entrenador` WRITE;
/*!40000 ALTER TABLE `entrenador` DISABLE KEYS */;
INSERT INTO `entrenador` VALUES (1,'Carlo','Ancelotti','Italiano',1),(2,'Hansi','Flick','Alemán',2),(3,'Diego','Simeone','Argentino',3),(4,'Pep','Guardiola','Español',4),(5,'Arne','Slot','Neerlandés',5),(6,'Mikel','Arteta','Español',6),(7,'Alvaro','Arbeloa','Español',NULL);
/*!40000 ALTER TABLE `entrenador` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `equipo`
--

DROP TABLE IF EXISTS `equipo`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `equipo` (
  `ID` int NOT NULL AUTO_INCREMENT,
  `Nombre` varchar(120) NOT NULL,
  `LigaID` int NOT NULL,
  PRIMARY KEY (`ID`),
  UNIQUE KEY `uqEquipoNombreLiga` (`LigaID`,`Nombre`),
  CONSTRAINT `fk_Equipo_LigaID` FOREIGN KEY (`LigaID`) REFERENCES `liga` (`ID`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=7 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `equipo`
--

LOCK TABLES `equipo` WRITE;
/*!40000 ALTER TABLE `equipo` DISABLE KEYS */;
INSERT INTO `equipo` VALUES (3,'Atlético de Madrid',1),(2,'FC Barcelona',1),(1,'Real Madrid',1),(6,'Arsenal FC',2),(5,'Liverpool FC',2),(4,'Manchester City',2);
/*!40000 ALTER TABLE `equipo` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `jugador`
--

DROP TABLE IF EXISTS `jugador`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `jugador` (
  `ID` int NOT NULL AUTO_INCREMENT,
  `Nombre` varchar(60) NOT NULL,
  `Apellido` varchar(60) NOT NULL,
  `Nacionalidad` varchar(50) DEFAULT NULL,
  `EquipoID` int DEFAULT NULL,
  PRIMARY KEY (`ID`),
  UNIQUE KEY `uqJugadorApellidoID` (`Apellido`,`ID`) USING BTREE,
  UNIQUE KEY `uqJugadorEquipoID` (`EquipoID`,`ID`),
  CONSTRAINT `fkJugadorEquipo` FOREIGN KEY (`EquipoID`) REFERENCES `equipo` (`ID`) ON DELETE SET NULL ON UPDATE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=61 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `jugador`
--

LOCK TABLES `jugador` WRITE;
/*!40000 ALTER TABLE `jugador` DISABLE KEYS */;
INSERT INTO `jugador` VALUES (1,'Thibaut','Courtois','Belga',1),(2,'Dani','Carvajal','Español',1),(3,'Antonio','Rüdiger','Alemán',1),(4,'Éder','Militão','Brasileño',1),(5,'Ferland','Mendy','Francés',1),(6,'Federico','Valverde','Uruguayo',1),(7,'Jude','Bellingham','Inglés',1),(8,'Eduardo','Camavinga','Francés',1),(9,'Vinícius','Junior','Brasileño',1),(10,'Kylian','Mbappé','Francés',1),(11,'Marc-André','ter Stegen','Alemán',2),(12,'Jules','Koundé','Francés',2),(13,'Pau','Cubarsí','Español',2),(14,'Alejandro','Balde','Español',2),(15,'Pedri','González','Español',2),(16,'Gavi','Páez','Español',2),(17,'Frenkie','de Jong','Neerlandés',2),(18,'Lamine','Yamal','Español',2),(19,'Robert','Lewandowski','Polaco',2),(20,'Raphinha','Dias','Brasileño',2),(21,'Jan','Oblak','Esloveno',3),(22,'Nahuel','Molina','Argentino',3),(23,'Robin','Le Normand','Español',3),(24,'José María','Giménez','Uruguayo',3),(25,'Reinildo','Mandava','Mozambiqueño',3),(26,'Koke','Resurrección','Español',3),(27,'Rodrigo','De Paul','Argentino',3),(28,'Marcos','Llorente','Español',3),(29,'Antoine','Griezmann','Francés',3),(30,'Julián','Álvarez','Argentino',3),(31,'Ederson','Moraes','Brasileño',4),(32,'Kyle','Walker','Inglés',4),(33,'Ruben','Dias','Portugués',4),(34,'John','Stones','Inglés',4),(35,'Rodri','Hernández','Español',4),(36,'Kevin','De Bruyne','Belga',4),(37,'Bernardo','Silva','Portugués',4),(38,'Phil','Foden','Inglés',4),(39,'Jack','Grealish','Inglés',4),(40,'Erling','Haaland','Noruego',4),(41,'Alisson','Becker','Brasileño',5),(42,'Trent','Alexander-Arnold','Inglés',5),(43,'Virgil','van Dijk','Neerlandés',5),(44,'Ibrahima','Konaté','Francés',5),(45,'Andrew','Robertson','Escocés',5),(46,'Alexis','Mac Allister','Argentino',5),(47,'Dominik','Szoboszlai','Húngaro',5),(48,'Luis','Díaz','Colombiano',5),(49,'Mohamed','Salah','Egipcio',5),(50,'Darwin','Núñez','Uruguayo',5),(51,'David','Raya','Español',6),(52,'Ben','White','Inglés',6),(53,'William','Saliba','Francés',6),(54,'Gabriel','Magalhães','Brasileño',6),(55,'Declan','Rice','Inglés',6),(56,'Martin','Ødegaard','Noruego',6),(57,'Mikel','Merino','Español',6),(58,'Bukayo','Saka','Inglés',6),(59,'Gabriel','Martinelli','Brasileño',6),(60,'Kai','Havertz','Alemán',6);
/*!40000 ALTER TABLE `jugador` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `jugadorposicion`
--

DROP TABLE IF EXISTS `jugadorposicion`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `jugadorposicion` (
  `ID` int NOT NULL AUTO_INCREMENT,
  `JugadorID` int NOT NULL,
  `PosicionID` int NOT NULL,
  PRIMARY KEY (`ID`),
  UNIQUE KEY `uqJugadorPosicion` (`JugadorID`,`PosicionID`),
  UNIQUE KEY `uqPosicionJugador` (`PosicionID`, `JugadorID`),
  CONSTRAINT `fkJPJugador` FOREIGN KEY (`JugadorID`) REFERENCES `jugador` (`ID`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `fkJPPosicion` FOREIGN KEY (`PosicionID`) REFERENCES `posicion` (`ID`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `jugadorposicion`
--

LOCK TABLES `jugadorposicion` WRITE;
/*!40000 ALTER TABLE `jugadorposicion` DISABLE KEYS */;
/*!40000 ALTER TABLE `jugadorposicion` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `liga`
--

DROP TABLE IF EXISTS `liga`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `liga` (
  `ID` int NOT NULL AUTO_INCREMENT,
  `Nombre` varchar(100) NOT NULL,
  `Pais` varchar(50) NOT NULL,
  `Equipos` int NOT NULL DEFAULT '0',
  `EquiposMax` int NOT NULL DEFAULT '20',
  PRIMARY KEY (`ID`),
  UNIQUE KEY `uqLigaNombrePais` (`Nombre`,`Pais`)
) ENGINE=InnoDB AUTO_INCREMENT=3 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `liga`
--

LOCK TABLES `liga` WRITE;
/*!40000 ALTER TABLE `liga` DISABLE KEYS */;
INSERT INTO `liga` VALUES (1,'LaLiga','España',3,20),(2,'Premier League','Inglaterra',3,20);
/*!40000 ALTER TABLE `liga` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `posicion`
--

DROP TABLE IF EXISTS `posicion`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `posicion` (
  `ID` int NOT NULL AUTO_INCREMENT,
  `Nombre` varchar(50) NOT NULL,
  PRIMARY KEY (`ID`),
  UNIQUE KEY `uqPosicionNombre` (`Nombre`)
) ENGINE=InnoDB AUTO_INCREMENT=7 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `posicion`
--

LOCK TABLES `posicion` WRITE;
/*!40000 ALTER TABLE `posicion` DISABLE KEYS */;
INSERT INTO `posicion` VALUES (3,'Centrocampista'),(2,'Defensa'),(4,'Delantero'),(6,'Manolito'),(5,'Pepito'),(1,'Portero');
/*!40000 ALTER TABLE `posicion` ENABLE KEYS */;
UNLOCK TABLES;
/*!40103 SET TIME_ZONE=@OLD_TIME_ZONE */;

/*!40101 SET SQL_MODE=@OLD_SQL_MODE */;
/*!40014 SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS */;
/*!40014 SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
/*!40111 SET SQL_NOTES=@OLD_SQL_NOTES */;

-- Dump completed on 2026-06-17 16:33:13
