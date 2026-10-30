# Comprobacion de las vistas

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
