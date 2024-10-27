% Importacion de modulos necesarios para el programa.

:- ensure_loaded('BC.pl').          
:- ensure_loaded('reglas.pl').       
:- ensure_loaded('herramientas.pl'). 
:- ensure_loaded('agregarHechos.pl').       
:- ensure_loaded('consultarDestino.pl').     
:- ensure_loaded('consultarActividades.pl'). 
:- ensure_loaded('consultarPrecio.pl').    
:- ensure_loaded('generarIMonto.pl').
:- ensure_loaded('generarIDias.pl').
:- ensure_loaded('recomendar.pl').
:- ensure_loaded('estadisticas.pl'). 

/****************************************************
 * Entradas:
 *   - Entrada del usuario mediante opciones numericas.
 * 
 * Salidas:
 *   - Mensajes en la consola que muestran los resultados
 *     de las consultas o acciones seleccionadas por el usuario.
 *
 * Restricciones:
 *   - La entrada debe ser un numero entre 1 y 9 para ser una opcion valida.
 *   - Las opciones deben estar implementadas correctamente en sus modulos.
 *
 * Objetivo:
 *   - Mostrar un menu interactivo para el usuario, permitiendole 
 *     realizar consultas y operaciones relacionadas con destinos,
 *     actividades, precios y generacion de itinerarios.
 ****************************************************/

menu :-
    print_menu,
    read(Opcion),
    menu_opcion(Opcion).

print_menu :-
    writeln('--------------------------------------'),
    writeln('|         ASISTENTE DE VIAJES        |'),
    writeln('--------------------------------------'),
    writeln('| 1 | Agregar hechos                  |'),
    writeln('| 2 | Consulta destino                |'),
    writeln('| 3 | Actividades por tipo            |'),
    writeln('| 4 | Consulta por precio             |'),
    writeln('| 5 | Generar itinerario por monto    |'),
    writeln('| 6 | Generar itinerario por dias     |'),
    writeln('| 7 | Recomendar por frase            |'),
    writeln('| 8 | Estadisticas                    |'),
    writeln('| 9 | Salir                           |'),
    writeln('--------------------------------------'),
    write('Seleccione una opcion: ').

menu_opcion(1) :-
    agregar_hechos,
    menu.

menu_opcion(2) :-
    consultar_destino,
    menu.

menu_opcion(3) :-
    consultar_actividades_tipo,
    menu.

menu_opcion(4) :-
    consultar_por_precio,
    menu.

menu_opcion(5) :-
    % generar_itinerario_monto,
    menu.

menu_opcion(6) :-
    % generar_itinerario_dias,
    menu.

menu_opcion(7) :-
    recomendar_por_frase,
    menu.

menu_opcion(8) :-
    mostrar_estadisticas,
    menu.

menu_opcion(9) :-
    writeln('Gracias por usar el Asistente de Viajes. Hasta pronto!').

menu_opcion(_) :-
    writeln('Opcion no valida, intente de nuevo.'),
    menu.
