% Predicado principal para mostrar estadísticas
mostrar_estadisticas :-
    writeln('----------------------------------'),
    writeln('Estadisticas del Sistema:'),
    writeln('----------------------------------'),
    top_3_ciudades_con_mas_actividades,
    actividad_mas_cara,
    actividad_menor_duracion,
    categoria_mas_actividades.

% 1. Las 3 ciudades con mas actividades
top_3_ciudades_con_mas_actividades :-
    findall(Destino, asociar_actividad(Destino, _), Destinos),
    sort(Destinos, DestinosUnicos),
    contar_actividades_por_ciudad(DestinosUnicos, Contadores),
    sort(2, @>=, Contadores, Ordenado),  % Ordenar por la cantidad de actividades
    take(3, Ordenado, Top3),  % Tomar las 3 primeras ciudades
    writeln('1. Las 3 ciudades con mas actividades:'),
    mostrar_top_ciudades(Top3).

contar_actividades_por_ciudad([], []).
contar_actividades_por_ciudad([Destino|Resto], [(Destino, Conteo)|Contadores]) :-
    findall(_, asociar_actividad(Destino, _), Actividades),
    length(Actividades, Conteo),
    contar_actividades_por_ciudad(Resto, Contadores).

mostrar_top_ciudades([]).
mostrar_top_ciudades([(Ciudad, Conteo)|Resto]) :-
    format('   - ~w: ~w actividades~n', [Ciudad, Conteo]),
    mostrar_top_ciudades(Resto).

take(_, [], []).
take(0, _, []).
take(N, [X|Xs], [X|Ys]) :- 
    N > 0, 
    N1 is N - 1, 
    take(N1, Xs, Ys).

% 2. La actividad mas cara
actividad_mas_cara :-
    findall((Actividad, Costo), actividad(Actividad, Costo, _, _, _), ListaActividades),
    sort(2, @>=, ListaActividades, [(ActividadCara, CostoMax)|_]),
    format('2. La actividad mas cara es "~w" con un costo de ~w.~n', [ActividadCara, CostoMax]).

% 3. La actividad de menor duración
actividad_menor_duracion :-
    findall((Actividad, Duracion), actividad(Actividad, _, Duracion, _, _), ListaActividades),
    sort(2, @=<, ListaActividades, [(ActividadCorta, DuracionMin)|_]),
    format('3. La actividad de menor duracion es "~w" con una duracion de ~w dias.~n', [ActividadCorta, DuracionMin]).

% 4. La categoría con mas actividades
categoria_mas_actividades :-
    categorias_actividades(ListaCategorias),
    contar_actividades_por_categoria(ListaCategorias, Conteos),
    sort(2, @>=, Conteos, [(CategoriaMax, MaxActividades)|_]),
    format('4. La categoria con mas actividades es "~w" con ~w actividades.~n', [CategoriaMax, MaxActividades]).

contar_actividades_por_categoria([], []).
contar_actividades_por_categoria([Categoria|Resto], [(Categoria, Conteo)|Conteos]) :-
    findall(_, (actividad(_, _, _, _, Tipos), member(Categoria, Tipos)), Actividades),
    length(Actividades, Conteo),
    contar_actividades_por_categoria(Resto, Conteos).
