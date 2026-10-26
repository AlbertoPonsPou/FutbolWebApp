# Migracion de tablas internas a MySQL

Conversion realizada con Database > SQL Conversion Wizard y la conexion
administrada `FutbolDB`. El campo Schema se dejo vacio: la cadena de conexion
ya selecciona `DATABASE=futbol`.

## Resultado

- `CodeMast`, `CodeType`, `WebAppServerProps`, `WebAppSession` y `WebAppUser`
  convertidas a MySQL como tablas estandar con sus claves e indices.
- Archivos `.int` generados, utilizando `ODBC_DRV` y `DFCONNID=FutbolDB`.
- Definiciones `.fd` y `Data/Filelist.cfg` actualizados por el asistente.
- `DFLastId` conservada como tabla especial local.
- Archivos `.dat` originales conservados en el equipo como copia.

La base `futbol` contiene once tablas: las seis del dominio y las cinco internas.
Todas utilizan `utf8mb4_general_ci`.

## Verificacion

Se comprobaron las tablas y los archivos de conexion. Despues de la conversion,
el alumno recompilo y ejecuto la aplicacion con F5 y accedio con el usuario
inicial de desarrollo sin errores.

## Reconstruccion de un entorno nuevo

Importar primero `sql/futbol.sql` y despues `sql/03_tablas_internas.sql`.
El segundo archivo contiene el esquema de las tablas internas y un usuario de
desarrollo nuevo con la clave conocida `admin`, hasheada en el formato PBKDF2
de DataFlex 25. No contiene los usuarios ni las sesiones reales del equipo.
La conexion y las claves locales se configuran como indica el README.

El siguiente paso es incorporar las seis tablas del futbol al Filelist mediante
SQL Connect/Repair Wizard, revisando claves, relaciones y Data Dictionaries.
