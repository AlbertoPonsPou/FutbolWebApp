# Sprint 2: navegacion

Primera implementacion: 08/11/2026. Basada en las dailys del martes 03/11 y
jueves 05/11. Rama de trabajo: `feature/sprint2-navegacion`, creada desde `develop`.
Estado: **implementado y compilado; recorridos principales validados en navegador**.
Quedan pendientes los casos de alta, cambios sin guardar y ventana estrecha.

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
- No se han ejecutado escrituras SQL ni cambiado los datos de partida.

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

Pepito (ID 5) y Manolito (ID 6) ya estaban en `sql/futbol.sql`, linea 184, y en
la copia original del script. No son registros creados por las pruebas del Sprint 2.

El sprint aun no esta cerrado ni publicado como una version. Los resultados de
arriba validan los recorridos principales; faltan las comprobaciones de abajo.

## Recorrido de pruebas pendiente

1. Probar una liga sin equipos y una ficha nueva: lista vacia y boton deshabilitado
   hasta que la liga se haya guardado y vuelto a abrir.
2. En una liga temporal, editar un campo y navegar a Equipos: comprobar guardado
   previo; un dato invalido debe impedir la navegacion. Revisar tambien la vuelta
   tras crear/modificar un equipo temporal de esa liga.
3. Repetir Jugador -> Posiciones -> Jugador con cambios sin guardar y descartar
   esos cambios despues de la prueba.
4. Revisar los titulos de las fichas en modo Nuevo y los titulos de Entrenador y
   Posicion con registros existentes. Comprobar acciones de consulta/edicion.
5. Revisar el selector Equipo -> Liga tras anadir el DD hijo en ZoomLiga.
   Las otras relaciones y parejas Select/Zoom ya se validaron en Sprint 1.
6. Revisar Liga y Jugador en una ventana estrecha, especialmente lista y botones.

Usar registros temporales para las pruebas de escritura y limpiar solo esos
registros al terminar, conservando los datos del profesor.
