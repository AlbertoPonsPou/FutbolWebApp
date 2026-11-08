# Sprint 2: navegacion

Primera implementacion: 08/11/2026. Basada en las dailys del martes 03/11 y
jueves 05/11. Rama de trabajo: `feature/sprint2-navegacion`, creada desde `develop`.
Estado: **implementado y compilado; pendiente de validacion funcional en navegador**.

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

La compilacion comprueba la sintaxis y las referencias, pero no demuestra que los
filtros, el retorno o el diseno funcionen durante la ejecucion. Estas pruebas
quedan pendientes; el sprint aun no esta cerrado ni publicado como una version.

## Recorrido de pruebas pendiente

1. Compilar y ejecutar `WebApp.src` con F5 en el workspace habitual.
2. Abrir una liga y comprobar nombre en cabecera/breadcrumb y lista de sus equipos.
3. Pulsar «Ver equipos de esta liga»: deben coincidir exactamente los equipos de
   la ficha y los del Select. Abrir un equipo y volver usando las migas de pan.
4. Repetir con la otra liga y, despues, entrar en Equipos desde el dashboard:
   deben verse todos los equipos, sin conservar el filtro ni el titulo anterior.
5. Probar una liga sin equipos y una ficha nueva: lista vacia y boton deshabilitado
   hasta que la liga se haya guardado y vuelto a abrir.
6. En una liga temporal, editar un campo y navegar a Equipos: comprobar guardado
   previo; un dato invalido debe impedir la navegacion. Revisar tambien la vuelta
   tras crear/modificar un equipo temporal de esa liga.
7. Abrir un jugador y pulsar «Consultar posiciones»: deben aparecer todas las
   posiciones. Volver y comprobar que el jugador y su equipo no han cambiado.
   Repetir con cambios sin guardar y descartar esos cambios despues de la prueba.
8. Revisar los cinco Zoom con un registro existente y en modo Nuevo. Comprobar
   cabecera, breadcrumb y acciones de consulta/edicion.
9. Repetir los tres selectores de padre directo y las cinco parejas Select/Zoom.
10. Revisar Liga y Jugador en una ventana estrecha, especialmente lista y botones.

Usar registros temporales para las pruebas de escritura y limpiar solo esos
registros al terminar, conservando los datos del profesor.
