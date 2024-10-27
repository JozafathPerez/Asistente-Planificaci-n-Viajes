% Predicado principal para generar el itinerario.
% generar_itinerario(Categoria, CriterioOrden, Presupuesto, NumeroPersonas, Itinerario)
% Categoria: la categoría inicial.
% CriterioOrden: el criterio de ordenamiento (largo o corto).
% Presupuesto: el presupuesto total disponible.
% NumeroPersonas: el número de personas para el que se calcula el costo.
% Itinerario: la lista de actividades ordenadas y filtradas según el presupuesto y el número de personas.
generar_itinerario(Categoria, CriterioOrden, Presupuesto, NumeroPersonas, Itinerario) :-
    % Obtener y ordenar actividades de categoría igual
    actividades_categoria(Categoria, CriterioOrden, ActividadesIguales),

    % Obtener categorías afines y ordenar sus actividades
    categorias_afines(Categoria, CategoriasAfines),
    actividades_por_categorias(CategoriasAfines, CriterioOrden, ActividadesAfines),

    % Obtener categorías adicionales y ordenar sus actividades
    categorias_adicionales(Categoria, CategoriasAdicionales),
    actividades_por_categorias(CategoriasAdicionales, CriterioOrden, ActividadesAdicionales),

    % Obtener categorías afines de adicionales y ordenar sus actividades
    categorias_afines_de_adicionales(Categoria, CategoriasAfines, CategoriasAdicionales, CategoriasAfinesAdicionales),
    actividades_por_categorias(CategoriasAfinesAdicionales, CriterioOrden, ActividadesAfinesAdicionales),

    % Concatenar todas las listas en orden de prioridad y eliminar duplicados
    append([ActividadesIguales, ActividadesAfines, ActividadesAdicionales, ActividadesAfinesAdicionales], ActividadesTotales),
    list_to_set(ActividadesTotales, ActividadesSinDuplicados),

    % Filtrar las actividades según el presupuesto y el número de personas
    filtrar_por_presupuesto(ActividadesSinDuplicados, Presupuesto, NumeroPersonas, Itinerario).

% Predicado para filtrar actividades según el presupuesto y el número de personas
% filtrar_por_presupuesto(Actividades, Presupuesto, NumeroPersonas, ActividadesFiltradas)
filtrar_por_presupuesto(Actividades, Presupuesto, NumeroPersonas, ActividadesFiltradas) :-
    filtrar(Actividades, Presupuesto, NumeroPersonas, 0, ActividadesFiltradas).

% Predicado recursivo para filtrar actividades
% filtrar(Actividades, Presupuesto, NumeroPersonas, Acumulado, ActividadesFiltradas)
filtrar([], _, _, _, []).  
filtrar([Nombre-Duracion-Costo | Resto], Presupuesto, NumeroPersonas, Acumulado, [Nombre-Duracion-Costo | ActividadesFiltradas]) :-
    % Calcular el costo total de la actividad para el número de personas
    CostoTotal is Costo * NumeroPersonas,
    % Comprobar si se puede añadir la actividad sin exceder el presupuesto
    Acumulado + CostoTotal =< Presupuesto,
    % Agregar la actividad y continuar filtrando el resto
    NuevoAcumulado is Acumulado + CostoTotal,
    filtrar(Resto, Presupuesto, NumeroPersonas, NuevoAcumulado, ActividadesFiltradas).
filtrar([_ | Resto], Presupuesto, NumeroPersonas, Acumulado, ActividadesFiltradas) :-
    % Si no se puede añadir la actividad, continuar con el resto
    filtrar(Resto, Presupuesto, NumeroPersonas, Acumulado, ActividadesFiltradas).

% Predicado para obtener actividades por categoría y ordenarlas según el criterio dado.
% actividades_categoria(Categoria, CriterioOrden, ActividadesOrdenadas)
actividades_categoria(Categoria, CriterioOrden, ActividadesOrdenadas) :-
    findall(Nombre-Duracion-Costo,
            (actividad(Nombre, Costo, Duracion, _, Categorias),
             member(Categoria, Categorias)),
            Actividades),
    ordenar_por_criterio(Actividades, CriterioOrden, ActividadesOrdenadas).

% Predicado para obtener actividades de una lista de categorías y ordenarlas
% actividades_por_categorias(Categorias, CriterioOrden, ActividadesOrdenadas)
actividades_por_categorias(Categorias, CriterioOrden, ActividadesOrdenadas) :-
    findall(Nombre-Duracion-Costo,
            (member(Categoria, Categorias),
             actividad(Nombre, Costo, Duracion, _, ActividadCategorias),
             member(Categoria, ActividadCategorias)),
            Actividades),
    ordenar_por_criterio(Actividades, CriterioOrden, ActividadesOrdenadas).

% Predicado para ordenar actividades según un criterio y orden específico
% ordenar_por_criterio(Actividades, Criterio, ActividadesOrdenadas)
ordenar_por_criterio(Actividades, largo, ActividadesOrdenadas) :-
    predsort(compare_duracion_desc, Actividades, ActividadesOrdenadas). % Mayor a menor
ordenar_por_criterio(Actividades, corto, ActividadesOrdenadas) :-
    predsort(compare_duracion_asc, Actividades, ActividadesOrdenadas). % Menor a mayor

% Comparadores para la duración
compare_duracion_asc(<, _-D1-_, _-D2-_) :- D1 =< D2.
compare_duracion_asc(>, _-D1-_, _-D2-_) :- D1 > D2.

compare_duracion_desc(<, _-D1-_, _-D2-_) :- D1 >= D2.
compare_duracion_desc(>, _-D1-_, _-D2-_) :- D1 < D2.