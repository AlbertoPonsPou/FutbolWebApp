# Sprint 4 de Data Dictionaries

## Reglas de las tablas de fútbol

Las seis clases DD protegen sus identificadores con `Key_Field_State` y
`Protect_Key_State`. Los controles de ID son de solo lectura, ya que MySQL
genera el identificador al insertar.

Nombre y apellido usan `DD_COMMIT` para permitir su introducción durante
el alta y bloquearlos tras guardar. `Field_CommitNoEnterOnIndex` aplica
el bloqueo también a los nombres que forman parte de índices. Se han marcado
como requeridos los campos de entrada definidos como NOT NULL en SQL.
Los campos numéricos de liga admiten cero equipos, y su máximo debe ser positivo.

`DD_NOPUT` evita trasladar una edición del control al DD.
`DD_NOENTER` impide entrar en el control, y `DD_DISPLAYONLY` combina
ambos comportamientos. El bloqueo permanente de nombres impediría escribirlos
durante el alta, por lo que se aplica el comportamiento de registro confirmado.

## Nacionalidades

Jugador y entrenador usan `cWebCombo` asociado a una `CodeValidationTable`
compartida del grupo NACIONAL de CodeType y CodeMast. La lista contiene las
nacionalidades utilizadas en las tablas actuales. La selección vacía se muestra
como «Sin especificar», puesto que el campo permite NULL en el esquema original.

CodeMast tiene claves cortas y descripciones completas. La validación utiliza
estas descripciones como valores para conservar los textos existentes, incluidos
los que superan los diez caracteres de CodeMast.Code. Una nacionalidad ajena a
la tabla de validación se rechaza también en el DD.

## Despedir a un entrenador

En la ficha existente, pulsar Editar y después Despedir. La acción limpia el
padre equipo, marca el cambio y guarda la ficha mediante Request_Save. Si hay
otros cambios pendientes, se validan y guardan en la misma operación.
El entrenador conserva su registro y EquipoID queda como SQL NULL.
Al volver a abrirlo, el campo de equipo muestra «Sin equipo».

## Contador de equipos por liga

El campo Equipos es calculado y de solo lectura. El DD de equipo resta uno
en Backout sobre la liga anterior y suma uno en Update sobre la liga nueva.
El framework ejecuta ambos eventos dentro de la transacción del guardado.
También se mantienen los totales al dar de alta o borrar un equipo.

Si el nuevo total supera EquiposMax, se cancela el guardado. Se revierten tanto
la relación del equipo como los contadores. Guardar un equipo sin cambiarlo
de liga deja el total igual. El máximo se consulta en la liga correspondiente.
La ficha de liga rechaza máximos inferiores al número de equipos existente.

## Preparación local

Ejecutar `sql/04_sprint4_diccionarios.sql` en la base futbol antes de arrancar
esta versión. El script añade el grupo de validación y las nacionalidades que
están en uso, y sincroniza el contador con los equipos reales. Puede repetirse
sin duplicar las opciones existentes. Después, compilar WebApp.src con F5.

## Comprobaciones realizadas

El código compila con DataFlex 25.0 x64 sin errores ni advertencias.
Las comprobaciones de guardado se realizaron en una base temporal con copia
de los datos y restricciones de relación.

- Se aceptan las 19 nacionalidades actuales, incluidas sus tildes.
- Se rechazan los valores ajenos a la tabla y las altas con campos obligatorios vacíos.
- Se permiten el equipo y la nacionalidad opcionales del entrenador.
- Se protegen las PK y se generan los ID de las altas.
- Los traslados de ida y vuelta mantienen los totales.
- Guardar sin traslado conserva el contador, y alta y borrado lo ajustan.
- Una liga llena cancela el traslado y revierte los contadores.
- Despedir conserva el entrenador con SQL NULL y permite reasignarle un equipo.

Las 42 comprobaciones finalizaron sin fallos. En la app local se compiló y
cargó el nuevo ejecutable, y se revisó en el navegador la ficha de entrenador:
nombres bloqueados al editar un registro existente, nombres editables en el alta,
desplegable de nacionalidades y texto «Sin equipo». Despedir queda desactivado
en modo consulta y al crear una ficha.

## Referencias

- [Opciones de campo](https://docs.dataflex.dev/DevelopmentGuide/Field_Options/)
- [Update y Backout](https://docs.dataflex.dev/DevelopmentGuide/Update_and_Backout/)
- [Padres opcionales](https://docs.dataflex.dev/DevelopmentGuide/Null_Parent_Support/)
