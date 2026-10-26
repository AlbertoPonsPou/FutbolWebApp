# Tablas de futbol incorporadas a DataFlex

Se utilizo Database > SQL Connect/Repair Wizard con `FutbolDB` para conectar
las seis tablas existentes de MySQL y generar sus Data Dictionaries.

| Numero en Filelist | Tabla | Clase DataDictionary | Padres |
|---|---|---|---|
| 1 | entrenador | centrenadorDataDictionary | equipo |
| 2 | equipo | cequipoDataDictionary | liga |
| 3 | jugador | cjugadorDataDictionary | equipo |
| 4 | jugadorposicion | cjugadorposicionDataDictionary | jugador, posicion |
| 5 | liga | cligaDataDictionary | - |
| 6 | posicion | cposicionDataDictionary | - |

Los archivos `.int` utilizan `ODBC_DRV` y `DFCONNID=FutbolDB`.
Los archivos `.fd` identifican los numeros de tabla y sus campos.
`DDClassList.xml` registra las seis clases como diccionarios predeterminados.
Todas las tablas tienen como clave primaria el campo SQL `ID`.

Se revisaron las referencias de las relaciones y las estructuras generadas
por el asistente. Las pruebas de altas y edicion se realizaran con las vistas.

El siguiente paso es crear `ZoomLiga` mediante Mobile Zoom Wizard y despues
`SelectLiga` mediante Mobile Select Wizard, en ramas separadas.

## Filelist y control de versiones

`Data/Filelist.cfg` es un archivo binario que tambien debe guardarse en Git.
Studio puede mantenerlo abierto y Windows puede retrasar la actualizacion de
su fecha de modificacion. Por eso se comprueba su contenido al guardar esta
fase, ademas de las definiciones y los diccionarios generados.
Guardar y cerrar Studio libera el archivo para cambios de rama que necesiten
sustituirlo por una version diferente.
