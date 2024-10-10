% Menú principal
menu :-
    writeln('Bienvenido al Asistente de Planificación de Viajes'),
    writeln('1. Consultar Actividades de un Destino'),
    writeln('2. Salir'),
    read(Opcion),
    ejecutar_opcion(Opcion).

% Ejecución de las opciones
ejecutar_opcion(1) :-
    writeln('Ingrese el destino: '),
    read(Destino),
    consultar_actividades_destino(Destino, Actividades, CostoTotal, DuracionTotal),
    writeln('Actividades disponibles: '), writeln(Actividades),
    writeln('Costo Total: '), writeln(CostoTotal),
    writeln('Duración Total en días: '), writeln(DuracionTotal),
    menu.
ejecutar_opcion(2) :-
    writeln('Saliendo...').




% ejemplo de base de conocimiento
iniciar_sistema :-
    consult('BC.pl').


guardar_cambios :-
    tell('BC.pl'),
    listing(destino/2),
    listing(actividad/5),
    listing(asociar_actividad/2),
    told.



