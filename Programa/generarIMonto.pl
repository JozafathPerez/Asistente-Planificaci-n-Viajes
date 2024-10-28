/****************************************************
 * Entradas:
 *   - Monto: cantidad de dinero que se desea gastar
 *   - NumeroPersonas: cantidad de personas que realizarán el itinerario
 *   - Categoria: categoría de actividades a considerar
 *   - CriterioOrden: criterio de orden para las actividades(corto o largo) 
 * Salidas:
 *   - Escribe en consola las actividades que se pueden realizar
 *
 * Restricciones:
 *   - Monto y NumeroPersonas deben ser números enteros
 *   - El criterio de orden debe ser "corto" o "largo"
 *
 * Objetivo:
 *   - Mostrar menu para ingresar datos
 ****************************************************/
generar_itinerario_monto :-
    write('Ingrese el monto que desea gastar: '),
    read(Monto),
    es_numero(Monto),
    write('Ingrese el numero de personas: '),
    read(NumeroPersonas),
    es_numero(NumeroPersonas),
    write('Seleccione una categoria: '),
    read(Categoria),
    
    % Validar el criterio de orden
    write('Seleccione un criterio de orden (corto/largo): '),
    read(CriterioOrden),
    validar_criterio_orden(CriterioOrden, Categoria, Monto, NumeroPersonas).

% Validar que el criterio de orden sea "corto" o "largo"
validar_criterio_orden(corto, Categoria, Monto, NumeroPersonas) :-
    generar_itinerario(Categoria, corto, Monto, NumeroPersonas, Itinerario),
    escribir_itinerario(Itinerario).

validar_criterio_orden(largo, Categoria, Monto, NumeroPersonas) :-
    generar_itinerario(Categoria, largo, Monto, NumeroPersonas, Itinerario),
    escribir_itinerario(Itinerario).

validar_criterio_orden(_, Categoria, Monto, NumeroPersonas) :-
    write('Criterio de orden no válido. Debe ser "corto" o "largo".'), nl,
    % Volver a solicitar el criterio de orden
    write('Seleccione un criterio de orden (corto/largo): '),
    read(NuevoCriterioOrden),
    validar_criterio_orden(NuevoCriterioOrden, Categoria, Monto, NumeroPersonas).

/****************************************************
 * Entradas:
 *   - Categoria: categoría de actividades a considerar
 *   - CriterioOrden: criterio de orden para las actividades(corto o largo) 
 * Salidas:
 *   - Lista de categorías afines a la categoría dada
 *
 * Objetivo:
 *   - Obtener las categorías afines a la categoría dada
 ****************************************************/
categorias_afines(Categoria, CategoriasAfines) :-
    findall(CatAfin, (afinidad(Categoria, CatAfin) ; afinidad(CatAfin, Categoria)), CategoriasAfinesDuplicadas),
    list_to_set(CategoriasAfinesDuplicadas, CategoriasAfines).  % Eliminar duplicados

/****************************************************
 * Entradas:
 *   - Categoria: categoría de actividades a considerar
 * Salidas:
 *   - CategoriasAdicionales: lista de categorías adicionales relacionadas
 *
 * Objetivo:
 *   - Obtener categorías adicionales relacionadas con la categoría dada y sus afines
 ****************************************************/
categorias_adicionales(Categoria, CategoriasAdicionales) :-
    categorias_afines(Categoria, CategoriasAfines),  % Obtener las categorías afines
    findall(CatAdicional, 
            (actividad(_, _, _, _, Categorias),           % Revisar cada actividad
             member(Cat, Categorias),                     % Para cada categoría en la actividad
             (Cat = Categoria; member(Cat, CategoriasAfines)),  % La categoría es la buscada o una afin
             member(CatAdicional, Categorias),            % Tomar cada categoría adicional de la actividad
             CatAdicional \= Categoria,                   % Excluir la categoría buscada
             \+ member(CatAdicional, CategoriasAfines)),  % Excluir categorías afines
            CategoriasAdicionalesDuplicadas),
    list_to_set(CategoriasAdicionalesDuplicadas, CategoriasAdicionales).  % Eliminar duplicados

/****************************************************
 * Entradas:
 *   - Categoria: categoría de actividades a considerar
 * Salidas:
 *   - CategoriasAfinesAdicionales: lista de categorías afines de categorías adicionales
 *
 * Objetivo:
 *   - Obtener las categorías afines de las categorías adicionales relacionadas
 ****************************************************/
categorias_afines_de_adicionales(Categoria, CategoriasAfines, CategoriasAdicionales, CategoriasAfinesAdicionales) :-
    % Reunir todas las categorías excluidas (la buscada, sus afines y las adicionales)
    append([Categoria | CategoriasAfines], CategoriasAdicionales, CategoriasExcluidas),
    
    % Encontrar afines de cada categoría adicional que no estén en las categorías excluidas
    findall(CatAfin,
            (member(CatAdicional, CategoriasAdicionales),  % Para cada categoría adicional
             categorias_afines(CatAdicional, AfinesCatAdicional), % Obtener sus afines
             member(CatAfin, AfinesCatAdicional),         % Ver cada afinidad de la categoría adicional
             \+ member(CatAfin, CategoriasExcluidas)),    % Excluir ya presentes
            CategoriasAfinesAdicionalesDuplicadas),
    
    % Eliminar duplicados de la lista final
    list_to_set(CategoriasAfinesAdicionalesDuplicadas, CategoriasAfinesAdicionales).

/****************************************************
 * Entradas:
 *   - Categoria: categoría de actividades a considerar
 * Salidas:
 *   - CategoriasAfinesAdicionales: lista de categorías afines de categorías adicionales
 *
 * Objetivo:
 *   - Obtener las categorías afines de las categorías adicionales relacionadas
 ****************************************************/
categorias_afines_y_adicionales(Categoria, CategoriasAdicionales, CategoriasAfinesAdicionales) :-
    % Obtener las categorías afines de la categoría buscada
    categorias_afines(Categoria, CategoriasAfines),
    
    % Obtener las categorías adicionales a partir de la categoría buscada y sus afines
    categorias_adicionales(Categoria,CategoriasAdicionales),
    
    % Obtener las categorías afines de las categorías adicionales
    categorias_afines_de_adicionales(Categoria, CategoriasAfines, CategoriasAdicionales, CategoriasAfinesAdicionales).

/****************************************************
 * Entradas:
 *   - Categoria: categoría de actividades a considerar
 *   - CriterioOrden: criterio de orden para las actividades (corto o largo)
 *   - Presupuesto: cantidad de dinero total disponible
 *   - NumeroPersonas: cantidad de personas que realizarán el itinerario
 * Salidas:
 *   - Itinerario: lista de actividades que se ajustan al presupuesto
 *
 * Objetivo:
 *   - Generar un itinerario de actividades que se ajusten al presupuesto y criterios especificados
 ****************************************************/
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

/****************************************************
 * Entradas:
 *   - Actividades: lista de actividades con sus costos y duración
 *   - Presupuesto: cantidad de dinero disponible
 *   - NumeroPersonas: cantidad de personas que realizarán las actividades
 * Salidas:
 *   - ActividadesFiltradas: lista de actividades que se ajustan al presupuesto
 *
 * Objetivo:
 *   - Filtrar actividades según el presupuesto y el número de personas
 ****************************************************/
filtrar_por_presupuesto(Actividades, Presupuesto, NumeroPersonas, ActividadesFiltradas) :-
    filtrar(Actividades, Presupuesto, NumeroPersonas, 0, ActividadesFiltradas).

/****************************************************
 * Entradas:
 *   - Actividades: lista de actividades con costos y duración
 *   - Presupuesto: cantidad de dinero total disponible
 *   - NumeroPersonas: cantidad de personas que realizarán las actividades
 * Salidas:
 *   - ActividadesFiltradas: lista de actividades dentro del presupuesto
 *
 * Objetivo:
 *   - Filtrar actividades según el presupuesto y el número de personas
 ****************************************************/
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

/****************************************************
 * Entradas:
 *   - Categoria: Categoría específica de actividades a buscar (e.g., "historia").
 *   - CriterioOrden: Criterio de ordenación ("largo" o "corto") para las actividades.
 * 
 * Salidas:
 *   - ActividadesOrdenadas: Lista de actividades que pertenecen a la categoría especificada, ordenadas según el criterio.
 *
 * Objetivo:
 *   - Obtener una lista de actividades filtradas por una categoría específica, ordenadas de acuerdo con el criterio especificado.
 ****************************************************/
actividades_categoria(Categoria, CriterioOrden, ActividadesOrdenadas) :-
    findall(Nombre-Duracion-Costo,
            (actividad(Nombre, Costo, Duracion, _, Categorias),
             member(Categoria, Categorias)),
            Actividades),
    ordenar_por_criterio(Actividades, CriterioOrden, ActividadesOrdenadas).

/****************************************************
 * Entradas:
 *   - Categorias: Lista de categorías en las cuales buscar actividades (e.g., ["historia", "aventura"]).
 *   - CriterioOrden: Criterio de ordenación ("largo" o "corto") para las actividades.
 * 
 * Salidas:
 *   - ActividadesOrdenadas: Lista de actividades que pertenecen a las categorías especificadas, ordenadas según el criterio.
 *
 * Objetivo:
 *   - Generar una lista de actividades que pertenecen a varias categorías, ordenadas de acuerdo con el criterio especificado.
 ****************************************************/
actividades_por_categorias(Categorias, CriterioOrden, ActividadesOrdenadas) :-
    findall(Nombre-Duracion-Costo,
            (member(Categoria, Categorias),
             actividad(Nombre, Costo, Duracion, _, ActividadCategorias),
             member(Categoria, ActividadCategorias)),
            Actividades),
    ordenar_por_criterio(Actividades, CriterioOrden, ActividadesOrdenadas).

/****************************************************
 * Entradas:
 *   - Actividades: lista de actividades con su duración
 *   - CriterioOrden: criterio de orden para las actividades (corto o largo)
 * Salidas:
 *   - ActividadesOrdenadas: lista de actividades ordenadas según el criterio
 *
 * Objetivo:
 *   - Ordenar las actividades según la duración (corto o largo)
 ****************************************************/
ordenar_por_criterio(Actividades, largo, ActividadesOrdenadas) :-
    predsort(compare_duracion_desc, Actividades, ActividadesOrdenadas). % Mayor a menor
ordenar_por_criterio(Actividades, corto, ActividadesOrdenadas) :-
    predsort(compare_duracion_asc, Actividades, ActividadesOrdenadas). % Menor a mayor

% Comparadores para la duración
compare_duracion_asc(<, _-D1-_, _-D2-_) :- D1 =< D2.
compare_duracion_asc(>, _-D1-_, _-D2-_) :- D1 > D2.

compare_duracion_desc(<, _-D1-_, _-D2-_) :- D1 >= D2.
compare_duracion_desc(>, _-D1-_, _-D2-_) :- D1 < D2.

/****************************************************
 * Entradas:
 *   - Itinerario: lista de actividades generadas
 * Salidas:
 *   - Impresión en consola de las actividades del itinerario
 *
 * Objetivo:
 *   - Imprimir el itinerario en consola o indicar si no se encontraron actividades
 ****************************************************/
escribir_itinerario([]) :-
    writeln("No se encontraron actividades dentro del presupuesto disponible.").

escribir_itinerario([Nombre-Duracion-Costo | Resto]) :-
    writeln("Itinerario de Actividades:"),
    escribir_actividades([Nombre-Duracion-Costo | Resto]).

/****************************************************
 * Entradas:
 *   - Lista de actividades con nombre, duración y costo
 * Salidas:
 *   - Impresión en consola de cada actividad
 *
 * Objetivo:
 *   - Imprimir los detalles de cada actividad en el itinerario
 ****************************************************/
escribir_actividades([]).
escribir_actividades([Nombre-Duracion-Costo | Resto]) :-
    format("Actividad: ~w, Duracion: ~w, Costo por persona: ~w~n", [Nombre, Duracion, Costo]),
    escribir_actividades(Resto).
