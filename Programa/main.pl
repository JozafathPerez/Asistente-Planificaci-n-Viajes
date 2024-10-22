% Archivo main.pl
:- ensure_loaded('agregarHechos.pl').  % Cargar las funcionalidades de hechos


% Menú principal del sistema de planificación de viajes.
menu_principal :-
    print_menu_principal,
    read(Opcion),
    menu_opcion(Opcion).

% Mostrar el menú con caja
print_menu_principal :-
    writeln('--------------------------------------'),
    writeln('|         ASISTENTE DE VIAJES        |'),
    writeln('--------------------------------------'),
    writeln('| 1. Agregar hechos                  |'),
    writeln('| 2. Consulta destino                |'),
    writeln('| 3. Actividades por tipo            |'),
    writeln('| 4. Consulta por precio             |'),
    writeln('| 5. Generar itinerario por monto    |'),
    writeln('| 6. Generar itinerario por dias     |'),
    writeln('| 7. Recomendar por frase            |'),
    writeln('| 8. Estadisticas                    |'),
    writeln('| 9. Salir                           |'),
    writeln('--------------------------------------'),
    write('Seleccione una opcion: ').

% Manejar la opción elegida por el usuario
menu_opcion(1) :-
    agregar_hechos,
    menu_principal.

menu_opcion(2) :-
    %consultar_destino,
    menu_principal.

menu_opcion(3) :-
    %consultar_actividades_tipo,
    menu_principal.

menu_opcion(4) :-
    %consultar_por_precio,
    menu_principal.

menu_opcion(5) :-
    %generar_itinerario_monto,
    menu_principal.

menu_opcion(6) :-
    %generar_itinerario_dias,
    menu_principal.

menu_opcion(7) :-
    %recomendar_por_frase,
    menu_principal.

menu_opcion(8) :-
    %mostrar_estadisticas,
    menu_principal.

menu_opcion(9) :-
    writeln('Gracias por usar el Asistente de Viajes. ¡Hasta pronto!').

menu_opcion(_) :-
    writeln('Opción no válida, intente de nuevo.'),
    menu_principal.



