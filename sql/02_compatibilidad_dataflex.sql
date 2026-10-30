-- Ajuste para una base futbol que ya esta importada.
-- Conserva los registros y adapta las comparaciones de texto a DataFlex.
-- Fuente: https://docs.dataflex.dev/DevelopmentGuide/How_to_set_up_and_test_using_MySQL/

USE `futbol`;

ALTER DATABASE `futbol`
    CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci;

ALTER TABLE `liga` CONVERT TO CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci;
ALTER TABLE `equipo` CONVERT TO CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci;
ALTER TABLE `entrenador` CONVERT TO CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci;
ALTER TABLE `jugador` CONVERT TO CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci;
ALTER TABLE `posicion` CONVERT TO CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci;
ALTER TABLE `jugadorposicion` CONVERT TO CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci;

-- Comprobar el resultado y los registros conservados.
SELECT TABLE_NAME, TABLE_COLLATION
FROM information_schema.TABLES
WHERE TABLE_SCHEMA = 'futbol'
ORDER BY TABLE_NAME;

SELECT 'liga' AS tabla, COUNT(*) AS registros FROM `liga`
UNION ALL SELECT 'equipo', COUNT(*) FROM `equipo`
UNION ALL SELECT 'entrenador', COUNT(*) FROM `entrenador`
UNION ALL SELECT 'jugador', COUNT(*) FROM `jugador`
UNION ALL SELECT 'posicion', COUNT(*) FROM `posicion`
UNION ALL SELECT 'jugadorposicion', COUNT(*) FROM `jugadorposicion`;
