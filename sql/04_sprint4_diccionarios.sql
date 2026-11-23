-- Preparacion del Sprint 4. Ejecutar una vez antes de abrir esta version.
-- Puede repetirse: conserva los valores de validacion que ya existan.
USE `futbol`;
SET NAMES utf8mb4;

START TRANSACTION;

INSERT INTO codetype (`Type`, Description)
SELECT 'NACIONAL', 'Nacionalidades'
WHERE NOT EXISTS (SELECT 1 FROM codetype WHERE `Type` = 'NACIONAL');

-- Solo las nacionalidades ya utilizadas. La descripcion es el valor completo.
-- La clave corta se obtiene del texto para conservarla en sucesivas ejecuciones.
INSERT INTO codemast (`Type`, Code, Description)
SELECT 'NACIONAL', UPPER(LEFT(SHA2(n.Nacionalidad, 256), 10)), n.Nacionalidad
FROM (
    SELECT DISTINCT TRIM(Nacionalidad) AS Nacionalidad FROM jugador
    UNION
    SELECT DISTINCT TRIM(Nacionalidad) AS Nacionalidad FROM entrenador
) AS n
WHERE n.Nacionalidad IS NOT NULL AND n.Nacionalidad <> ''
AND NOT EXISTS (
    SELECT 1 FROM codemast AS c
    WHERE c.`Type` = 'NACIONAL' AND c.Description = n.Nacionalidad
);

-- Establecer el punto de partida real antes de mantener los totales con el DD.
UPDATE liga AS l
LEFT JOIN (
    SELECT LigaID, COUNT(*) AS Total FROM equipo GROUP BY LigaID
) AS e ON e.LigaID = l.ID
SET l.Equipos = COALESCE(e.Total, 0);

COMMIT;
