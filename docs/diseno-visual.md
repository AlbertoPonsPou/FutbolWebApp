# Propuesta visual: panel deportivo

Primera propuesta en `feature/mejoras-visuales`. Se mantiene la navegacion del
Sprint 2 y se personaliza el tema mediante `AppHtml/CssStyle/application.css`.
No se modifican el motor ni los estilos originales de DataFlex.

## Cambios

- Azul marino para la identidad y verde para acciones y seleccion.
- Bienvenida en el inicio y cinco tarjetas con iconos SVG propios, descripcion
  y acceso mediante botones nativos utilizables con teclado.
- Fondo claro, bordes suaves, formularios sobre tarjetas y etiquetas uniformes.
- Tablas con filas alternas y seleccion diferenciada.
- Acciones de las vistas traducidas al castellano y boton de liga renombrado a
  «Gestionar equipos de esta liga».
- Estilos para pantalla estrecha, foco de teclado visible, soporte de movimiento
  reducido y zoom de navegador permitido.
- Titulo de la pagina y version del CSS para renovar la cache.

## Verificacion

Compilacion aislada con DataFlex 25.0 x64: 0 errores y 0 advertencias.
La actualizacion del ejecutable del workspace habitual queda pendiente: el
servidor mantiene WebApp.exe abierto y el intento de detener el servicio ha
devuelto un error de permisos. El servicio sigue funcionando con el ejecutable
anterior. No se han cambiado los datos ni publicado esta propuesta.

Para revisar el resultado completo: abrir FutbolWebApp.sws en DataFlex Studio,
compilar/ejecutar con F5 y recargar el navegador con Ctrl+F5. Revisar inicio,
listado de ligas, ficha de liga y ficha de jugador en escritorio y ventana
estrecha. La revision visual completa queda pendiente de cargar el ejecutable.

## Continuacion del estudio de Data Dictionary

La mejora visual se acompana del estudio del constructor de DataDictionary,
Field_Options, buffers, Field_Current_Value y Field_Changed_Value, validaciones
y tratamiento de NULL. No se incorporan aun contadores de equipos ni asignacion
de posiciones: esas reglas de negocio se anunciaron para sesiones posteriores.
