# FutbolWebApp

Practica de DAM: aplicacion web movil de futbol con DataFlex 2025 (25.0) y MySQL 8.

## Estado del proyecto

Workspace y proyecto movil creados. La plantilla inicial se ha ejecutado en el navegador.
La base MySQL `futbol` esta creada y la conexion administrada `FutbolDB` se ha
probado y guardado en DataFlex. Las tablas utilizan `utf8mb4_general_ci`,
la intercalacion recomendada para las busquedas de DataFlex.
Las cinco tablas internas convertibles de DataFlex ya se han migrado a MySQL y
el login se ha comprobado con F5. `DFLastId` permanece como tabla especial local.
Las seis tablas del futbol ya estan incorporadas al Filelist, con sus archivos
`.int`, definiciones `.fd`, relaciones y clases DataDictionary generadas.
Las vistas Select/Zoom y las tarjetas del dashboard corresponden a las
siguientes ramas de trabajo.

## Requisitos

- Windows con DataFlex Studio 25.0 y el entorno WebApp/IIS configurado.
- MySQL 8 y MySQL Connector/ODBC Unicode de 64 bits.
- Git.

## Abrir una copia del repositorio

1. Clonar el repositorio en una carpeta local.
2. Ejecutar `scripts/Initialize-Local.ps1` desde PowerShell. Si DataFlex esta en otra
   ruta, indicar `-DataFlexRoot 'C:\ruta\DataFlex 25.0'`.
3. En una base nueva, importar `sql/futbol.sql` y despues
   `sql/03_tablas_internas.sql` desde MySQL Workbench.
4. Abrir `FutbolWebApp.sws` y configurar `FutbolDB` en SQL Connection Manager,
   siguiendo `docs/conexion-mysql.md`.
5. Registrar la aplicacion web y el directorio virtual `FutbolWebApp` en el equipo.
6. Compilar y ejecutar `WebApp.src` con F5.

El script de inicializacion copia el motor y los temas incluidos con DataFlex,
restaura las tablas que aun sean embebidas y genera claves locales. Las tablas con
archivo `.int` ya utilizan MySQL. El script local solo crea archivos que faltan;
no sustituye las tablas ni las claves de un entorno ya configurado.
La plantilla inicial utiliza el usuario de desarrollo `admin` y la clave `admin`.

## Base de datos

El archivo `sql/futbol.sql` contiene el esquema y los datos de partida del profesor,
con el nombre de base unificado a `futbol`. Incluye `liga`, `equipo`, `entrenador`,
`jugador`, `posicion` y `jugadorposicion`.

Al importar el script se eliminan y recrean esas tablas en `futbol`; utilizarlo
como carga inicial, no sobre una base con cambios que se quieran conservar.
Las conexiones y credenciales de MySQL se configuran en cada equipo y no se publican.

Para configurar la conexion administrada `FutbolDB`, consultar
[`docs/conexion-mysql.md`](docs/conexion-mysql.md). Se incluye
`Data/DFConnId.ini.example` como referencia, con un usuario de ejemplo.

Si la base ya estaba importada con la intercalacion original, el script
`sql/02_compatibilidad_dataflex.sql` adapta las seis tablas conservando los
registros. En el equipo de desarrollo este ajuste ya se ha comprobado.

`sql/03_tablas_internas.sql` permite reconstruir las cinco tablas internas con
sus indices y un usuario inicial de desarrollo `admin` / `admin`. Utiliza un hash
de prueba nuevo; no exporta usuarios, sesiones ni valores del equipo de desarrollo.
El script conserva las tablas y los usuarios que ya existan. La migracion y sus
comprobaciones se describen en `docs/migracion-tablas.md`.

## Flujo Git de la practica

- `main`: base inicial y versiones terminadas del sprint.
- `develop`: integracion de funcionalidades comprobadas.
- `feature/...`: una rama por cada vista, con Select y Zoom por separado.
- Otra rama para las tarjetas del dashboard y, si procede, para las mejoras visuales.

Ejemplos: `feature/select-jugador`, `feature/zoom-jugador`, `feature/dashboard`.
Cada feature se prueba y se integra en `develop` con un merge que conserve la rama
en el historial. Al terminar el sprint se integra `develop` en `main` y se etiqueta
la version entregada. La entrega consiste en el enlace al repositorio.

No se versionan ejecutables, logs, datos de sesiones, claves ni credenciales locales.
Se conservan los fuentes, las definiciones de tablas, el Filelist y la configuracion
del workspace necesaria para reconstruir el proyecto.
