/****************************************************
 * Entradas:
 *   - Ninguna.
 * 
 * Salidas:
 *   - Despliega las estadísticas principales del sistema, incluyendo:
 *     - Top 3 ciudades con más actividades.
 *     - Actividad con el costo más alto.
 *     - Actividad con la menor duración.
 *     - Categoría con más actividades.
 *
 * Restricciones:
 *   - Deben existir datos para realizar las estadísticas; de lo contrario, 
 *     no se mostrarán resultados válidos.
 *
 * Objetivo:
 *   - Mostrar un resumen estadístico de las actividades en el sistema.
 ****************************************************/
mostrar_estadisticas :-
    writeln('----------------------------------'),
    writeln('Estadisticas del Sistema:'),
    writeln('----------------------------------'),
    top_3_ciudades_con_mas_actividades,
    actividad_mas_cara,
    actividad_menor_duracion,
    categoria_mas_actividades.

/****************************************************
 * Entradas:
 *   - Ninguna.
 * 
 * Salidas:
 *   - Muestra las 3 ciudades con la mayor cantidad de actividades registradas,
 *     en formato ordenado.
 *
 * Restricciones:
 *   - Debe existir al menos una actividad asociada a una ciudad para
 *     proporcionar resultados.
 *
 * Objetivo:
 *   - Identificar y mostrar las tres ciudades con más actividades disponibles.
 ****************************************************/
top_3_ciudades_con_mas_actividades :-
    findall(Destino, asociar_actividad(Destino, _), Destinos),
    sort(Destinos, DestinosUnicos),
    contar_actividades_por_ciudad(DestinosUnicos, Contadores),
    sort(2, @>=, Contadores, Ordenado),  % Ordenar por la cantidad de actividades
    take(3, Ordenado, Top3),  % Tomar las 3 primeras ciudades
    writeln('1. Las 3 ciudades con mas actividades:'),
    mostrar_top_ciudades(Top3).

/****************************************************
 * Entradas:
 *   - Lista de destinos (ciudades) únicas.
 * 
 * Salidas:
 *   - Lista de tuplas (Destino, Conteo) donde Conteo representa
 *     el número de actividades asociadas a cada destino.
 *
 * Restricciones:
 *   - Ninguna.
 *
 * Objetivo:
 *   - Calcular el número de actividades por cada ciudad y almacenar
 *     los resultados en una lista.
 ****************************************************/
contar_actividades_por_ciudad([], []).
contar_actividades_por_ciudad([Destino|Resto], [(Destino, Conteo)|Contadores]) :-
    findall(_, asociar_actividad(Destino, _), Actividades),
    length(Actividades, Conteo),
    contar_actividades_por_ciudad(Resto, Contadores).

/****************************************************
 * Entradas:
 *   - Lista de tuplas (Ciudad, Conteo) con los datos ordenados.
 * 
 * Salidas:
 *   - Muestra cada ciudad en el top 3 con su respectivo
 *     número de actividades.
 *
 * Restricciones:
 *   - La lista debe estar ordenada y tener un máximo de tres elementos.
 *
 * Objetivo:
 *   - Desplegar las ciudades con mayor cantidad de actividades.
 ****************************************************/
mostrar_top_ciudades([]).
mostrar_top_ciudades([(Ciudad, Conteo)|Resto]) :-
    format('   - ~w: ~w actividades~n', [Ciudad, Conteo]),
    mostrar_top_ciudades(Resto).

/****************************************************
 * Entradas:
 *   - Número N (entero), Lista original.
 * 
 * Salidas:
 *   - Nueva lista con los primeros N elementos de la lista original.
 *
 * Restricciones:
 *   - N debe ser un número no negativo.
 *
 * Objetivo:
 *   - Limitar el número de elementos de una lista a los primeros N elementos.
 ****************************************************/
take(_, [], []).
take(0, _, []).
take(N, [X|Xs], [X|Ys]) :- 
    N > 0, 
    N1 is N - 1, 
    take(N1, Xs, Ys).

/****************************************************
 * Entradas:
 *   - Ninguna.
 * 
 * Salidas:
 *   - Muestra la actividad con el costo más alto en el sistema.
 *
 * Restricciones:
 *   - Debe existir al menos una actividad registrada para realizar
 *     la comparación de costos.
 *
 * Objetivo:
 *   - Identificar y desplegar la actividad con el mayor costo.
 ****************************************************/
actividad_mas_cara :-
    findall((Actividad, Costo), actividad(Actividad, Costo, _, _, _), ListaActividades),
    sort(2, @>=, ListaActividades, [(ActividadCara, CostoMax)|_]),
    format('2. La actividad mas cara es "~w" con un costo de ~w.~n', [ActividadCara, CostoMax]).

/****************************************************
 * Entradas:
 *   - Ninguna.
 * 
 * Salidas:
 *   - Muestra la actividad con la menor duración en el sistema.
 *
 * Restricciones:
 *   - Debe existir al menos una actividad registrada para realizar
 *     la comparación de duración.
 *
 * Objetivo:
 *   - Identificar y desplegar la actividad con la duración más corta.
 ****************************************************/
actividad_menor_duracion :-
    findall((Actividad, Duracion), actividad(Actividad, _, Duracion, _, _), ListaActividades),
    sort(2, @=<, ListaActividades, [(ActividadCorta, DuracionMin)|_]),
    format('3. La actividad de menor duracion es "~w" con una duracion de ~w dias.~n', [ActividadCorta, DuracionMin]).

/****************************************************
 * Entradas:
 *   - Ninguna.
 * 
 * Salidas:
 *   - Muestra la categoría de actividades con la mayor cantidad de actividades.
 *
 * Restricciones:
 *   - Debe existir al menos una categoría y actividad registrada
 *     en el sistema para realizar el conteo.
 *
 * Objetivo:
 *   - Identificar y mostrar la categoría que contiene más actividades.
 ****************************************************/
categoria_mas_actividades :-
    categorias_actividades(ListaCategorias),
    contar_actividades_por_categoria(ListaCategorias, Conteos),
    sort(2, @>=, Conteos, [(CategoriaMax, MaxActividades)|_]),
    format('4. La categoria con mas actividades es "~w" con ~w actividades.~n', [CategoriaMax, MaxActividades]).

/****************************************************
 * Entradas:
 *   - Lista de categorías únicas.
 * 
 * Salidas:
 *   - Lista de tuplas (Categoría, Conteo) donde Conteo representa
 *     el número de actividades asociadas a cada categoría.
 *
 * Restricciones:
 *   - Ninguna.
 *
 * Objetivo:
 *   - Calcular el número de actividades en cada categoría.
 ****************************************************/
contar_actividades_por_categoria([], []).
contar_actividades_por_categoria([Categoria|Resto], [(Categoria, Conteo)|Conteos]) :-
    findall(_, (actividad(_, _, _, _, Tipos), member(Categoria, Tipos)), Actividades),
    length(Actividades, Conteo),
    contar_actividades_por_categoria(Resto, Conteos).
