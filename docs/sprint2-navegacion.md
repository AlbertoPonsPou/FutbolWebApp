# Sprint 2: navegacion

Primera implementacion: 08/11/2026. Basada en las dailys del martes 03/11 y
jueves 05/11. Rama de trabajo: `feature/sprint2-navegacion`, creada desde `develop`.
Estado: **implementado y validado para el alcance del Sprint 2**.
Validacion funcional cerrada el 08/11/2026, con las confirmaciones manuales de
Alberto y la comprobacion final de los datos. Entrega del 11/11/2026 identificada
con la etiqueta `v2.0.0`, mediante integracion feature -> develop -> main.

La daily del 11/11 confirma el uso de `Constrain_File` para la lista incrustada.
No introduce requisitos nuevos para esta entrega: los contadores y limites de
equipos se anuncian para el trabajo posterior con DD y el siguiente sprint se
dedicara a mejoras visuales. Se conserva el codigo funcional ya validado.

## Requisitos y cambios

| Recorrido o requisito | Implementacion |
| --- | --- |
| Las cinco parejas Select -> Zoom (`nfFromMain`) | Ya incluidas en Sprint 1. |
| Equipo -> Liga, Entrenador/Jugador -> Equipo (`nfFromChild`) | Ya incluidos los selectores de padre directo. |
| Liga -> SelectEquipo (`nfFromParent`) | Boton en `ZoomLiga`, ruta registrada y guardado antes de navegar. El framework aplica la restriccion por el padre. |
| Lista de equipos dentro de ZoomLiga | DD hijo `oequipo_DD`, servidor `oliga_DD`, `Constrain_File` a liga y lista de consulta vinculada al DD hijo. |
| Jugador -> Posiciones (`nfUndefined`) | Boton «Consultar posiciones» con `ntNavigateForwardCustom`. No asigna posiciones al jugador ni escribe en `jugadorposicion`. |
| Titulos y migas de pan | Los cinco Zoom muestran el registro actual o el texto de alta. SelectEquipo distingue el contexto de una liga del listado general. Los otros Select ya tienen nombres comprensibles. |

El boton de equipos solo se habilita para una liga existente. Para una liga nueva,
primero se guarda y se vuelve a abrir su ficha. La lista de equipos usa el DD hijo;
el DD principal y los formularios siguen perteneciendo a liga.

`bSaveBeforeNavigate` evita navegar hacia los hijos con cambios del padre sin
guardar. Al volver desde el listado se actualiza la lista incrustada. La ruta
general del dashboard conserva el listado completo de equipos: el filtro de
SelectEquipo se establece dinamicamente por el contexto de navegacion.

Los titulos se calculan en `OnNavigateForward` con `HasRecord` y
`Field_Current_Value`, usando `SetHeaderCaption` y `SetBreadcrumbCaption`.
Cada entrada vuelve a establecerlos para no conservar el nombre de otra ficha.

## Conceptos que hay que saber explicar

- `OnGetNavigateForwardData` pertenece al objeto que inicia el viaje. Su parametro
  `ByRef` permite cambiar las banderas antes de llegar a la siguiente vista.
- `OnNavigateForward` pertenece a la vista destino y permite personalizarla.
- `OnGetNavigateBackData` prepara los datos de vuelta y `OnNavigateBack` permite
  reaccionar en el objeto que inicio el recorrido.
- `bNewRecord` prepara un alta; `bReadOnly` abre la ficha en consulta;
  `bSaveBeforeNavigate` exige guardar correctamente antes de continuar.
- `NamedValues` es un array de `tNameValuePair`, con `sName` y `sValue`.
  `NamedValueAdd`, `NamedValueGet` y `NamedValueIndex` permiten gestionar datos
  propios. El jueves se pide estudiarlo, pero no impone una nueva funcionalidad
  que necesite usarlo; no se han anadido parametros artificiales a estas rutas.
- Un `RowID` identifica un registro en el contexto de su tabla. No hay que
  tratarlo como un identificador global de toda la base de datos.

Referencias: [navegacion hacia delante](https://docs.dataaccess.com/dataflexhelp/mergedProjects/DevelopmentGuide/The_Forward_Navigation_Process.htm)
y [NavigateForwardCustom](https://docs.dataaccess.com/dataflexhelp/mergedProjects/VDFClassRef/cWebView-Procedure-NavigateForwardCustom.htm).
La implementacion tambien se ha contrastado con `cWebView.pkg` de DataFlex 25.0
instalado en este equipo.

## Verificacion realizada

- Compilacion de una copia aislada con DataFlex 25.0 de 64 bits:
  **0 errores y 0 advertencias**.
- `git diff --check`: sin errores.
- Revision de las relaciones y servidores de los DD: liga es padre directo de
  equipo; la lista incrustada y el boton emplean sus servidores correspondientes.
- La comprobacion final de la base ha sido de solo lectura: siguen las ligas y
  equipos originales y no quedan los registros temporales de estas pruebas.

### Validacion manual confirmada por Alberto

Las siguientes comprobaciones se han realizado en la aplicacion y confirmado en
este chat. Las capturas muestran la ficha de LaLiga, sus dos listados de equipos,
la ficha de Real Madrid y el listado de posiciones. No se han automatizado estas
pruebas ni se da por comprobado lo que no se ha confirmado.

| Comprobacion | Resultado y evidencia |
| --- | --- |
| Lista incrustada de LaLiga | Real Madrid, FC Barcelona y Atletico de Madrid; captura del alumno. |
| Liga -> SelectEquipo filtrado | Los mismos tres equipos; captura del alumno. |
| SelectEquipo -> ZoomEquipo | Abre Real Madrid, ligado a LaLiga, con titulo y breadcrumbs correctos; captura del alumno. |
| Volver a Ligas y abrir la otra liga | Filtra sus propios equipos; confirmado por Alberto. |
| Equipos desde el dashboard despues de filtrar | Muestra los equipos de ambas ligas; confirmado por Alberto. |
| Jugador -> Consultar posiciones | Muestra las seis posiciones; captura del alumno. |
| Volver desde Posiciones al jugador | Conserva su nombre y su equipo; confirmado por Alberto. |
| Nueva liga sin guardar | Cabecera «Nueva liga», lista vacia y boton de equipos deshabilitado; confirmado por Alberto. |
| Liga y Jugador en ventana estrecha | Campos, listas y botones accesibles; confirmado por Alberto. |
| Jugador -> Posiciones -> Jugador durante una edicion | Conserva el nombre modificado sin guardar y el equipo; Descartar cambios recupera el nombre original. Confirmado por Alberto. |
| Liga temporal guardada y reabierta sin equipos | Lista vacia y boton de equipos habilitado; confirmado por Alberto. |
| Guardado antes de Liga -> Equipos | El nombre editado de la liga persiste al reabrirla, aunque no se pulso Guardar antes de navegar; confirmado por Alberto. |
| Nuevo equipo desde la liga | La liga viene seleccionada en la ficha nueva; confirmado por Alberto. |
| Actualizacion de la lista incrustada al volver | El equipo nuevo aparece en la ficha de la liga tras guardarlo y volver; confirmado por Alberto. |

Pepito (ID 5) y Manolito (ID 6) ya estaban en `sql/futbol.sql`, linea 184, y en
la copia original del script. No son registros creados por las pruebas del Sprint 2.

## Estado final de los datos

Consulta directa de MySQL al cerrar la validacion: 2 ligas, 6 equipos,
7 entrenadores, 60 jugadores, 6 posiciones y 0 filas en jugadorposicion.
Las ligas son LaLiga y Premier League; los seis equipos y sus ligas coinciden
con los del script original. No se encontraron la liga ni el equipo temporales,
ni jugadores cuyo nombre contuviera PRUEBA. No fue necesario ejecutar borrados.

## Alcance de la validacion

Se han comprobado los recorridos nuevos, los filtros, el retorno, el guardado
antes de navegar, el refresco de la lista hija y el uso en ventana estrecha.
La validacion de los CRUD y selectores ya existentes corresponde al Sprint 1
(`docs/pruebas-vistas.md`); no se ha repetido una regresion completa de esas vistas.
La tabla anterior enumera las comprobaciones realmente confirmadas: no acredita
pruebas de errores de guardado con datos invalidos ni una revision visual de cada
combinacion de titulo, entidad y modo de alta.
