% Predicado para consultar las actividades de un destino
consultar_destino :-
    write('Ingrese el nombre del destino: '),
    read(Destino),
    (   
        destino(Destino, _) ->  % Verificar si el destino existe
        (
            writeln('Actividades disponibles para el destino: '),
            listar_actividades_destino(Destino, CostoTotal, TiempoTotal),
            format('Costo total de actividades: ~w~n', [CostoTotal]),
            format('Tiempo total de actividades (días): ~w~n', [TiempoTotal])
        );
        writeln('El destino ingresado no existe. Por favor, verifique e intente nuevamente.')
    ).

% Predicado para listar actividades y calcular costo y tiempo totales
listar_actividades_destino(Destino, CostoTotal, TiempoTotal) :-
    findall((Actividad, Costo, Duracion, Descripcion, ListaTipos),
            (asociar_actividad(Destino, Actividad),
             actividad(Actividad, Costo, Duracion, Descripcion, ListaTipos)),
            Actividades),
    mostrar_actividades(Actividades),
    calcular_totales(Actividades, CostoTotal, TiempoTotal).

% Predicado para mostrar cada actividad y sus detalles
mostrar_actividades([]).
mostrar_actividades([(Actividad, Costo, Duracion, Descripcion, ListaTipos)|Resto]) :-
    format('Actividad: ~w~n', [Actividad]),
    format('  Descripción: ~w~n', [Descripcion]),
    format('  Costo: ~w~n', [Costo]),
    format('  Duración: ~w días~n', [Duracion]),
    format('  Tipos: ~w~n', [ListaTipos]),
    mostrar_actividades(Resto).

% Predicado para calcular costo y tiempo totales
calcular_totales(Actividades, CostoTotal, TiempoTotal) :-
    findall(Costo, member((_, Costo, _, _, _), Actividades), ListaCostos),
    sum_list(ListaCostos, CostoTotal),
    findall(Duracion, member((_, _, Duracion, _, _), Actividades), ListaDuraciones),
    sum_list(ListaDuraciones, TiempoTotal).
