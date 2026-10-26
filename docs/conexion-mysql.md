# Conexion de DataFlex con MySQL

La conexion administrada del workspace se llama `FutbolDB`.
Utiliza MySQL Connector/ODBC 26.10 Unicode de 64 bits y una cadena directa
(DSN-less), por lo que no depende de un DSN de sistema de Windows.

## Configurar en otro equipo

1. Instalar el controlador ODBC Unicode de 64 bits e importar `sql/futbol.sql`.
2. Abrir el workspace en DataFlex Studio 25.0.
3. Entrar en Database > SQL Connection Manager > Add.
4. Seleccionar `ODBC_DRV` y escribir `FutbolDB` como Connection Id.
5. Seleccionar Custom (DSN-less) Connection String e introducir:

   ```text
   DRIVER={MySQL ODBC 26.10 Unicode Driver};SERVER=127.0.0.1;PORT=3306;DATABASE=futbol;CHARSET=utf8mb4
   ```

6. Introducir el usuario y la clave de MySQL del equipo en Login ID y Password.
7. Probar la conexion con Test Connection y guardar con OK y Save.

El nombre del controlador, servidor y puerto deben corresponder a la instalacion
local. El archivo `Data/DFConnId.ini.example` documenta los campos sin contener
credenciales reales. Los cambios de conexion deben guardarse desde el asistente
para que DataFlex gestione las claves cuando corresponda.

## Intercalacion de las tablas

Las tablas utilizan `utf8mb4_general_ci` y la conexion utiliza `CHARSET=utf8mb4`.
DataFlex documenta problemas de busqueda con las intercalaciones que contienen
`0900`. Para una base importada previamente con esa intercalacion, ejecutar
`sql/02_compatibilidad_dataflex.sql` y comprobar sus consultas finales.

## Comprobaciones de esta fase

- Conexion probada y guardada en DataFlex Studio.
- Servidor local accesible en el puerto 3306.
- Seis tablas de futbol presentes y con `utf8mb4_general_ci`.
- `Data/DFConnId.ini` y los includes de claves locales excluidos de Git.

La conversion de tablas embebidas y la conexion de las tablas existentes al
Filelist corresponden a las siguientes fases del proyecto.

## Referencias

- [Conexion administrada](https://docs.dataflex.dev/Tools/ModifyConnections/)
- [Configuracion de MySQL para DataFlex](https://docs.dataflex.dev/DevelopmentGuide/How_to_set_up_and_test_using_MySQL/)
