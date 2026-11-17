# Mejoras visuales de FutbolWebApp

## Inicio, listados y fichas

- El inicio presenta cinco tarjetas para ligas, equipos, entrenadores,
  jugadores y posiciones. Cada tarjeta incluye un icono y abre su listado.
- Las fichas agrupan los campos en paneles, y las tablas distinguen las filas
  alternas y el registro seleccionado.
- Las acciones se muestran en castellano. El botón «Gestionar equipos de esta
  liga» abre el listado filtrado por la liga actual.
- Las tarjetas y fichas se adaptan a pantallas estrechas y muestran el foco
  al navegar con el teclado.

## Tema claro y oscuro

El botón de luna y sol de la cabecera alterna el tema en todas las vistas.
El tema oscuro usa negro y gris carbón en fondos, tablas, tarjetas y formularios.
Los iconos de la cabecera tienen contraste en ambos temas.

La preferencia se guarda en el navegador. El cambio usa una transición de
240 ms en navegadores compatibles y es inmediato si el usuario prefiere
reducir el movimiento. Los estilos y la lógica están en
[`application.css`](../AppHtml/CssStyle/application.css) y
[`theme.js`](../AppHtml/theme.js).

## Data Dictionary en el proyecto

- **Estructura y relaciones.** En [`cequipoDataDictionary.dd`](../DDSrc/cequipoDataDictionary.dd),
  `Construct_Object` llama primero al constructor de la clase padre.
  `Main_File` identifica la tabla `equipo`, `Add_Server_File` declara a
  `liga` como tabla padre y `Add_Client_File` registra los hijos.
- **Valores y cambios del formulario.** El DDO (objeto Data Dictionary) mantiene
  su propio registro actual. En [`ZoomLiga.wo`](../AppSrc/ZoomLiga.wo),
  `Field_Current_Value` lee el nombre de la liga para el título. Para que una
  edición por código quede marcada para el guardado se usa `Field_Changed_Value`.
- **Opciones y validación.** `Field_Options` configura los campos de la tabla
  propia. `Foreign_Field_Option` fija el comportamiento de los campos de tablas
  relacionadas. Por ejemplo, `DD_DISPLAYONLY` sirve para mostrar valores que no
  se editan desde el formulario. Validar un campo al guardar y bloquearlo en
  pantalla son reglas distintas.
- **Relación opcional con equipo.** En [`centrenadorDataDictionary.dd`](../DDSrc/centrenadorDataDictionary.dd),
  `ParentNullAllowed` permite un entrenador sin equipo. Al guardar,
  `Save_Main_File` marca `EquipoID` como NULL mediante `DF_FIELD_IS_NULL`
  cuando no hay equipo elegido.

## Cómo revisar la entrega

Abrir `FutbolWebApp.sws` con DataFlex Studio, compilar y ejecutar con F5, e
iniciar sesión. Alternar el tema desde la cabecera, abrir un listado y una
ficha y recargar la página para comprobar que se conserva la preferencia.

El código DataFlex del selector compiló en una copia aislada con 0 errores
y 0 advertencias. Se comprobó que el servidor local entrega los archivos
actualizados del tema.
