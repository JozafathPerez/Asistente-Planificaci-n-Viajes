% Archivo main.pl

:- ensure_loaded('BC.pl').           % Cargar la base de conocimientos
:- ensure_loaded('reglas.pl').       % Cargar las reglas
:- ensure_loaded('herramientas.pl'). 
:- ensure_loaded('agregarHechos.pl').       % Cargar funcionalidades de agregar hechos
:- ensure_loaded('consultarDestino.pl').     % Cargar funcionalidades de consulta de destinos
:- ensure_loaded('consultarActividades.pl'). % Cargar funcionalidades de consulta de actividades
:- ensure_loaded('consultarPrecio.pl').      % Cargar funcionalidades de consulta de precios

guardar_base :-
    tell('BC.pl'),  % Abrir archivo para escribir
    listing(destino/2),  % Guardar destinos
    listing(actividad/5),  % Guardar actividades
    listing(asociar_actividad/2),  % Guardar asociaciones
    told.  % Cerrar archivo

% Menú principal del sistema de planificación de viajes.
menu :-
    print_menu,
    read(Opcion),
    menu_opcion(Opcion).

% Mostrar el menú con caja
print_menu :-
    writeln('--------------------------------------'),
    writeln('|         ASISTENTE DE VIAJES        |'),
    writeln('--------------------------------------'),
    writeln('| 1. Agregar hechos                  |'),
    writeln('| 2. Consulta destino                |'),
    writeln('| 3. Actividades por tipo            |'),
    writeln('| 4. Consulta por precio             |'),
    writeln('| 5. Generar itinerario por monto    |'),
    writeln('| 6. Generar itinerario por días     |'),
    writeln('| 7. Recomendar por frase            |'),
    writeln('| 8. Estadísticas                    |'),
    writeln('| 9. Salir                           |'),
    writeln('--------------------------------------'),
    write('Seleccione una opción: ').

% Manejar la opción elegida por el usuario
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
    % recomendar_por_frase,
    menu.

menu_opcion(8) :-
    % mostrar_estadisticas,
    menu.

menu_opcion(9) :-
    writeln('Gracias por usar el Asistente de Viajes. ¡Hasta pronto!').

menu_opcion(_) :-
    writeln('Opción no válida, intente de nuevo.'),
    menu.
