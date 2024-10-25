% Predicado principal para consultar actividades por tipo
consultar_actividades_tipo :-
    writeln('Seleccione el tipo de actividad que desea consultar:'),
    listar_categorias,
    write('Seleccione el número correspondiente al tipo: '),
    read(Opcion),
    tipo_actividad(Opcion, Tipo),
    listar_actividades_tipo(Tipo).

% Listar las categorías disponibles
listar_categorias :-
    categorias_actividades(Categorias),
    listar_categorias_aux(Categorias, 1).

listar_categorias_aux([], _).
listar_categorias_aux([Categoria|Resto], Num) :-
    format('~w. ~w~n', [Num, Categoria]),
    NextNum is Num + 1,
    listar_categorias_aux(Resto, NextNum).

% Mapear número a tipo de actividad
tipo_actividad(1, 'arte').
tipo_actividad(2, 'historia').
tipo_actividad(3, 'panorama').
tipo_actividad(4, 'romantico').
tipo_actividad(5, 'naturaleza').
tipo_actividad(6, 'experiencia').
tipo_actividad(7, 'cultura').
tipo_actividad(8, 'arquitectura').
tipo_actividad(9, 'diversion').
tipo_actividad(10, 'gastronomia').
tipo_actividad(11, 'educativo').
tipo_actividad(12, 'aventura').
tipo_actividad(_, desconocido).

% Predicado para listar actividades por tipo
listar_actividades_tipo(desconocido) :-
    writeln('Tipo de actividad no válido, por favor intente nuevamente.').

listar_actividades_tipo(Tipo) :-
    findall((Actividad, Destino, Costo, Duracion, Descripcion),
            (actividad(Actividad, Costo, Duracion, Descripcion, ListaTipos),
             member(Tipo, ListaTipos),
             asociar_actividad(Destino, Actividad)),
            Actividades),
    mostrar_actividades_tipo(Actividades).

% Predicado para mostrar cada actividad y su destino
mostrar_actividades_tipo([]) :-
    writeln('No hay actividades disponibles para este tipo.').

mostrar_actividades_tipo([(Actividad, Destino, Costo, Duracion, Descripcion)|Resto]) :-
    format('Actividad: ~w~n', [Actividad]),
    format('  Destino: ~w~n', [Destino]),
    format('  Descripción: ~w~n', [Descripcion]),
    format('  Costo: ~w~n', [Costo]),
    format('  Duración: ~w días~n', [Duracion]),
    mostrar_actividades_tipo(Resto).
