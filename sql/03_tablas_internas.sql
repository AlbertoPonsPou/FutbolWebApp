-- Esquema de las tablas internas tras la conversion de DataFlex 25.0.
-- Inicializa una base nueva; conserva las tablas y usuarios que ya existan.
-- Las tablas de sesiones y propiedades se crean vacias.
USE `futbol`;
SET NAMES utf8mb4;

CREATE TABLE IF NOT EXISTS `codemast` (
  `Type` varchar(10) NOT NULL DEFAULT '',
  `Code` varchar(10) NOT NULL DEFAULT '',
  `Description` varchar(30) NOT NULL DEFAULT '',
  PRIMARY KEY (`Type`,`Code`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

CREATE TABLE IF NOT EXISTS `codetype` (
  `Type` varchar(10) NOT NULL DEFAULT '',
  `Description` varchar(30) NOT NULL DEFAULT '',
  `Comment` mediumtext,
  PRIMARY KEY (`Type`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

CREATE TABLE IF NOT EXISTS `webappserverprops` (
  `Key` varchar(64) NOT NULL DEFAULT '',
  `CreateDate` date NOT NULL DEFAULT '0001-01-01',
  `CreateTime` varchar(12) NOT NULL DEFAULT '',
  `ExpiresDate` date NOT NULL DEFAULT '0001-01-01',
  `ExpiresTime` varchar(12) NOT NULL DEFAULT '',
  `Locked` smallint NOT NULL DEFAULT '0',
  `LockedDate` date NOT NULL DEFAULT '0001-01-01',
  `LockedTime` varchar(12) NOT NULL DEFAULT '',
  `Page` smallint NOT NULL DEFAULT '0',
  `Pages` smallint NOT NULL DEFAULT '0',
  `Data` mediumtext,
  PRIMARY KEY (`Key`,`Page`),
  UNIQUE KEY `WebAppServerProps002` (`ExpiresDate` DESC,`ExpiresTime` DESC,`Key`,`Page`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

CREATE TABLE IF NOT EXISTS `webappsession` (
  `SessionKey` varchar(36) NOT NULL DEFAULT '',
  `CreateDate` date NOT NULL DEFAULT '0001-01-01',
  `CreateTime` varchar(8) NOT NULL DEFAULT '',
  `LastAccessDate` date NOT NULL DEFAULT '0001-01-01',
  `LastAccessTime` varchar(8) NOT NULL DEFAULT '',
  `UseCount` int NOT NULL DEFAULT '0',
  `RemoteAddress` varchar(57) NOT NULL DEFAULT '',
  `LoginName` varchar(20) NOT NULL DEFAULT '',
  `Active` varchar(1) NOT NULL DEFAULT '',
  PRIMARY KEY (`SessionKey`),
  UNIQUE KEY `WebAppSession002` (`CreateDate`,`CreateTime`,`SessionKey`),
  UNIQUE KEY `WebAppSession003` (`LastAccessDate`,`LastAccessTime`,`SessionKey`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

CREATE TABLE IF NOT EXISTS `webappuser` (
  `LoginName` varchar(20) NOT NULL DEFAULT '',
  `Password` varchar(128) NOT NULL DEFAULT '',
  `Rights` smallint NOT NULL DEFAULT '0',
  `FullName` varchar(30) NOT NULL DEFAULT '',
  `LastLogin` date NOT NULL DEFAULT '0001-01-01',
  PRIMARY KEY (`LoginName`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- Usuario inicial de prueba: admin / admin.
-- Hash nuevo generado con PBKDF2-HMAC-SHA512, 100000 iteraciones y sal de 16 bytes.
-- El formato 1$sal_base64$iteraciones$hash_base64 es el de cPasswordHasher de DataFlex 25.
INSERT INTO `webappuser` (`LoginName`, `Password`, `Rights`, `FullName`, `LastLogin`)
SELECT 'admin',
       '1$yLr++6rEYAqmHBSCrtc2xw==$100000$ljnYLH2q3laxnHeSWYpp7uebINnzh0gmFNOiUQPhp3rNGzPn83OBQZi3Pp/hHLHgCvGKP5C/5pLj8Q4EuSdiUQ==',
       1, 'Admin', '0001-01-01'
WHERE NOT EXISTS (SELECT 1 FROM `webappuser` WHERE `LoginName` = 'admin');
