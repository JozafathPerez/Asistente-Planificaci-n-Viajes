% Predicado principal para consultar actividades por precio
consultar_por_precio :-
    write('Ingrese el monto que desea consultar: '),
    read(Monto),
    writeln('Seleccione una opción:'),
    writeln('1. Consultar actividades más baratas'),
    writeln('2. Consultar actividades más caras'),
    write('Seleccione el número de opción: '),
    read(Opcion),
    ( Opcion = 1 -> 
        actividades_mas_baratas(Monto) 
    ; Opcion = 2 -> 
        actividades_mas_caras(Monto) 
    ; writeln('Opción no válida, por favor intente nuevamente.')
    ).

% Predicado para listar actividades mas baratas que el monto dado
actividades_mas_baratas(Monto) :-
    findall((Actividad, Destino, Costo, Duracion, Descripcion),
            (actividad(Actividad, Costo, Duracion, Descripcion, ListaTipos),
             Costo < Monto,
             asociar_actividad(Destino, Actividad)),
            Actividades),
    mostrar_actividades_precio(Actividades, 'más baratas que').

% Predicado para listar actividades mas caras que el monto dado
actividades_mas_caras(Monto) :-
    findall((Actividad, Destino, Costo, Duracion, Descripcion),
            (actividad(Actividad, Costo, Duracion, Descripcion, ListaTipos),
             Costo > Monto,
             asociar_actividad(Destino, Actividad)),
            Actividades),
    mostrar_actividades_precio(Actividades, 'más caras que').

% Predicado para mostrar las actividades filtradas por precio
mostrar_actividades_precio([], _) :-
    writeln('No hay actividades disponibles para esta consulta.').

mostrar_actividades_precio([(Actividad, Destino, Costo, Duracion, Descripcion)|Resto], Comparacion) :-
    format('Actividad: ~w~n', [Actividad]),
    format('  Destino: ~w~n', [Destino]),
    format('  Descripción: ~w~n', [Descripcion]),
    format('  Costo: ~w~n', [Costo]),
    format('  Duración: ~w días~n', [Duracion]),
    format('Estas actividades son ~w ~w.~n', [Comparacion, Costo]),
    mostrar_actividades_precio(Resto, Comparacion).