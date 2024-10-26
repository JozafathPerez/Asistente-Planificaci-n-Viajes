/****************************************************
 * Entradas:
 *   - Ninguna. Se solicita al usuario que ingrese el nombre del destino.
 * 
 * Salidas:
 *   - Muestra las actividades disponibles para el destino ingresado.
 *   - Muestra el costo total de las actividades.
 *   - Muestra el tiempo total (en días) de las actividades.
 *
 * Restricciones:
 *   - El destino ingresado debe ser un átomo.
 *   - El destino debe existir en la base de datos.
 *
 * Objetivo:
 *   - Consultar y mostrar las actividades disponibles para un destino específico,
 *     incluyendo el costo y la duración total de dichas actividades.
 ****************************************************/
consultar_destino :-
    write('Ingrese el nombre del destino: '),
    read(Destino),
    es_atom(Destino), 
    (   
        destino(Destino, _) ->  % Verificar si el destino existe
        (
            writeln('----------------------------------------'),
            writeln('| Actividades disponibles para el destino: |'),
            writeln('----------------------------------------'),
            listar_actividades_destino(Destino, CostoTotal, TiempoTotal),
            format('Costo total de actividades: ~w~n', [CostoTotal]),
            format('Tiempo total de actividades (dias): ~w~n', [TiempoTotal]),
            writeln('----------------------------------------')
        );
        writeln('El destino ingresado no existe. Por favor, verifique e intente nuevamente.')
    ).

/****************************************************
 * Entradas:
 *   - Destino: átomo que representa el nombre del destino.
 * 
 * Salidas:
 *   - Muestra las actividades asociadas al destino ingresado.
 *   - Retorna el costo total y el tiempo total de las actividades.
 *
 * Restricciones:
 *   - El destino debe existir en la base de datos de destinos.
 *
 * Objetivo:
 *   - Listar las actividades disponibles para un destino y calcular
 *     los costos y tiempos totales de dichas actividades.
 ****************************************************/
listar_actividades_destino(Destino, CostoTotal, TiempoTotal) :-
    findall((Actividad, Costo, Duracion, Descripcion, ListaTipos),
            (asociar_actividad(Destino, Actividad),
             actividad(Actividad, Costo, Duracion, Descripcion, ListaTipos)),
            Actividades),
    mostrar_actividades(Actividades),
    calcular_totales(Actividades, CostoTotal, TiempoTotal).

/****************************************************
 * Entradas:
 *   - Lista vacía de actividades.
 *   - Lista de actividades con detalles: (Actividad, Costo, Duracion, Descripcion, ListaTipos).
 * 
 * Salidas:
 *   - Muestra los detalles de cada actividad en la lista.
 *
 * Restricciones:
 *   - Las actividades deben ser válidas y estar asociadas a un destino.
 *
 * Objetivo:
 *   - Mostrar los detalles de cada actividad de manera estructurada
 *     y visualmente clara.
 ****************************************************/
mostrar_actividades([]).
mostrar_actividades([(Actividad, Costo, Duracion, Descripcion, ListaTipos)|Resto]) :-
    writeln('----------------------------------------'),
    format('Actividad: ~w~n', [Actividad]),
    format('  Descripcion: ~w~n', [Descripcion]),
    format('  Costo: ~w~n', [Costo]),
    format('  Duracion: ~w dias~n', [Duracion]),
    format('  Tipos: ~w~n', [ListaTipos]),
    writeln('----------------------------------------'),
    mostrar_actividades(Resto).

/****************************************************
 * Entradas:
 *   - Lista de actividades: (Actividad, Costo, Duracion, Descripcion, ListaTipos).
 * 
 * Salidas:
 *   - CostoTotal: suma de los costos de todas las actividades.
 *   - TiempoTotal: suma de las duraciones de todas las actividades.
 *
 * Restricciones:
 *   - La lista de actividades no debe estar vacía.
 *
 * Objetivo:
 *   - Calcular el costo total y el tiempo total de un conjunto de actividades
 *     listadas para un destino específico.
 ****************************************************/
calcular_totales(Actividades, CostoTotal, TiempoTotal) :-
    findall(Costo, member((_, Costo, _, _, _), Actividades), ListaCostos),
    sum_list(ListaCostos, CostoTotal),
    findall(Duracion, member((_, _, Duracion, _, _), Actividades), ListaDuraciones),
    sum_list(ListaDuraciones, TiempoTotal).
