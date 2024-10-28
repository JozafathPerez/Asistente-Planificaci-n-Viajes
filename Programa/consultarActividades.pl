/****************************************************
 * Entradas:
 *   - Ninguna.
 * 
 * Salidas:
 *   - Muestra un menú con las categorías de actividades.
 *   - Solicita al usuario que seleccione un tipo de actividad.
 *   - Lista las actividades disponibles según el tipo seleccionado.
 *
 * Restricciones:
 *   - El usuario debe ingresar un número correspondiente a un tipo de actividad válido.
 *
 * Objetivo:
 *   - Permitir al usuario consultar las actividades disponibles según el tipo de actividad deseado.
 ****************************************************/
consultar_actividades_tipo :-
    writeln('----------------------------------------'),
    writeln('Seleccione el tipo de actividad que desea consultar:'),
    listar_categorias,
    write('Seleccione el numero correspondiente al tipo: '),
    read(Opcion),
    tipo_actividad(Opcion, Tipo),
    listar_actividades_tipo(Tipo),
    writeln('----------------------------------------').

/****************************************************
 * Entradas:
 *   - Ninguna.
 * 
 * Salidas:
 *   - Muestra en pantalla las categorías de actividades disponibles.
 *
 * Restricciones:
 *   - Las categorías deben estar definidas en el sistema.
 *
 * Objetivo:
 *   - Listar las categorías de actividades que el usuario puede consultar.
 ****************************************************/
listar_categorias :-
    categorias_actividades(Categorias),
    listar_categorias_aux(Categorias, 1).

/****************************************************
 * Entradas:
 *   - Una lista de categorías (categorias).
 *   - Un número entero (Num) que representa el índice de la categoría actual.
 * 
 * Salidas:
 *   - Muestra en pantalla cada categoría con su correspondiente número.
 *
 * Restricciones:
 *   - La lista de categorías no puede estar vacía.
 *
 * Objetivo:
 *   - Mostrar las categorías de actividades junto con sus números correspondientes.
 ****************************************************/
listar_categorias_aux([], _).
listar_categorias_aux([Categoria|Resto], Num) :-
    format('~w. ~w~n', [Num, Categoria]),
    NextNum is Num + 1,
    listar_categorias_aux(Resto, NextNum).

% Mapear numero a tipo de actividad
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

/****************************************************
 * Entradas:
 *   - Ninguna.
 * 
 * Salidas:
 *   - Muestra un mensaje indicando que el tipo de actividad no es válido.
 *
 * Restricciones:
 *   - No se permite el ingreso de un tipo de actividad no definido.
 *
 * Objetivo:
 *   - Notificar al usuario que el tipo de actividad seleccionado no es válido.
 ****************************************************/
listar_actividades_tipo(desconocido) :-
    writeln('----------------------------------------'),
    writeln('Tipo de actividad no valido, por favor intente nuevamente.'),
    writeln('----------------------------------------').

/****************************************************
 * Entradas:
 *   - Un tipo de actividad (Tipo).
 * 
 * Salidas:
 *   - Muestra las actividades disponibles para el tipo de actividad seleccionado.
 *
 * Restricciones:
 *   - Las actividades deben estar definidas en el sistema.
 *
 * Objetivo:
 *   - Listar las actividades disponibles para el tipo de actividad especificado.
 ****************************************************/
listar_actividades_tipo(Tipo) :-
    findall((Actividad, Destino, Costo, Duracion, Descripcion),
            (actividad(Actividad, Costo, Duracion, Descripcion, ListaTipos),
             member(Tipo, ListaTipos),
             asociar_actividad(Destino, Actividad)),
            Actividades),
    (   
        Actividades \= [] ->
        mostrar_actividades_tipo(Actividades);
        writeln('----------------------------------------'),
        writeln('No hay actividades disponibles para este tipo.'),
        writeln('----------------------------------------')
    ).

/****************************************************
 * Entradas:
 *   - Una lista de actividades (Actividades).
 * 
 * Salidas:
 *   - Muestra en pantalla cada actividad con sus detalles (nombre, destino, descripción, costo y duración).
 *
 * Restricciones:
 *   - La lista de actividades no debe estar vacía.
 *
 * Objetivo:
 *   - Mostrar los detalles de cada actividad disponible.
 ****************************************************/
mostrar_actividades_tipo([]).
mostrar_actividades_tipo([(Actividad, Destino, Costo, Duracion, Descripcion)|Resto]) :-
    writeln('----------------------------------------'),
    format('Actividad: ~w~n', [Actividad]),
    format('  Destino: ~w~n', [Destino]),
    format('  Descripcion: ~w~n', [Descripcion]),
    format('  Costo: ~w~n', [Costo]),
    format('  Duracion: ~w dias~n', [Duracion]),
    writeln('----------------------------------------'),
    mostrar_actividades_tipo(Resto).
