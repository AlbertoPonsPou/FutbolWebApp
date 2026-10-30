# Comprobacion de las vistas

## Resultado de la validacion - 30/10/2026

Las pruebas del navegador las ha realizado Alberto y ha confirmado sus resultados
durante la validacion. La compilacion y la comprobacion final de los datos se han
realizado desde terminal.

| Comprobacion | Resultado |
| --- | --- |
| Compilacion por etapa y tras corregir el borrado | 0 errores y 0 advertencias |
| Cinco tarjetas, cinco listados y sus fichas de detalle | Navegacion correcta |
| Posicion temporal: alta, edicion y borrado | Correcto tras la correccion de borrado |
| Equipo temporal: selector de liga, guardado, reapertura y edicion | Correcto |
| Entrenador y jugador temporales: alta sin equipo, asignacion con selector y reapertura | Correcto |
| Limpieza de entrenador, jugador y equipo temporales | Correcta |
| Liga temporal: alta, edicion, reapertura y borrado | Correcto |
| Tarjetas y formularios en una ventana estrecha | Utilizables |

El borrado inicial de una posicion produjo un error de estructura porque estaba
habilitado el borrado en cascada por defecto. Se establecio
`Cascade_Delete_State` a `False` en los cinco diccionarios principales; se recompilo
y el borrado de la posicion temporal se confirmo correctamente. Las fichas con
registros dependientes conservan la proteccion frente al borrado en cascada.

Al finalizar se consulto MySQL y se comprobaron los recuentos de partida:
2 ligas, 6 equipos, 7 entrenadores, 60 jugadores y 6 posiciones.
No quedan los registros temporales utilizados en estas pruebas.

## Compilacion

Las vistas se incorporan en ramas separadas por Select y Zoom. La comprobacion de
compilacion se realiza sobre una copia aislada del proyecto, con las dependencias
de DataFlex inicializadas y sin copiar las claves del entorno de desarrollo.
Una compilacion correcta no sustituye las comprobaciones funcionales del navegador.

## Recorrido en el navegador

1. Abrir el workspace y compilar/ejecutar WebApp.src con F5.
2. Iniciar sesion y abrir las cinco tarjetas del dashboard y las cinco opciones del menu.
3. En cada listado, abrir un registro, comprobar sus campos y volver al listado.
4. Usar Buscar en una columna indexada, y comprobar Nuevo, Guardar, Editar y Eliminar
   con registros temporales creados para la prueba.
5. En un equipo, usar el selector de liga, elegir una fila y comprobar que se devuelve
   la liga a la ficha. Guardar y volver a abrir para comprobar la relacion.
6. Repetir el selector de equipo en un entrenador y en un jugador.
7. Crear un entrenador y un jugador temporales sin equipo. Guardarlos, volver a abrirlos
   y comprobar que EquipoID es NULL. Asignarles un equipo y despues quitarlo; comprobar
   que ambos cambios persisten. Borrar solamente los registros creados para esta prueba.
8. Comprobar el dashboard y los listados en una ventana estrecha.

## Datos de partida

Antes de las pruebas manuales: 2 ligas, 6 equipos, 7 entrenadores, 60 jugadores y
6 posiciones. Hay un entrenador sin equipo; debe poder abrirse su ficha.
La generacion de vistas no modifica estos datos.

Las eliminaciones de registros con dependencias siguen las restricciones de MySQL
y los DataDictionary; no se agrega borrado en cascada a la base del profesor.
