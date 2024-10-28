
/****************************************************
 * Entradas:
 *   - 
 * 
 * Salidas:
 *   - 
 *
 * Restricciones:
 *   - 
 *
 * Objetivo:
 *   - 
 ****************************************************/
generar_itinerario_dias_menu :-
    write('Seleccione una categoria: '),
    read(Categoria),
    write('Ingrese el numero de dias: '),
    read(Dias),
    es_numero(Dias),
    
    % Generar el itinerario con criterio "corto"
    generar_itinerario_con_dias(Categoria, corto, Dias, Itinerario),
    escribir_itinerario(Itinerario),
    
    % Preguntar si desea regenerar el itinerario
    write('Desea regenerar el itinerario por estancia mas larga? (s/n): '),
    read(Respuesta),
    manejar_respuesta_regeneracion(Respuesta, Categoria, Dias).

% Manejar respuesta del usuario para regenerar el itinerario
manejar_respuesta_regeneracion('s', Categoria, Dias) :-
    generar_itinerario_con_dias(Categoria, largo, Dias, ItinerarioLargo),
    write('Itinerario generado con estancia larga: '), nl,
    escribir_itinerario(ItinerarioLargo).

manejar_respuesta_regeneracion('n', _, _) :-
    write('Gracias por usar el generador de itinerarios.'), nl.

% Manejar el caso en el que el usuario introduce una respuesta inválida
manejar_respuesta_regeneracion(_, Categoria, Dias) :-
    write('Respuesta no valida. Por favor, introduzca "s" o "n".'), nl,
    write('Desea regenerar el itinerario por estancia mas larga? (s/n): '),
    read(NuevaRespuesta),
    manejar_respuesta_regeneracion(NuevaRespuesta, Categoria, Dias).
   

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
generar_itinerario_dias(Categoria, CriterioOrden, Itinerario) :-
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
    list_to_set(ActividadesTotales, Itinerario).
/****************************************************
 * Entradas:
 *   - 
 * 
 * Salidas:
 *   - 
 *
 * Restricciones:
 *   - 
 *
 * Objetivo:
 *   - 
 ****************************************************/    
% Predicado principal que filtra actividades por un límite de días
generar_itinerario_con_dias(Categoria, CriterioOrden, MaxDias, ItinerarioFiltrado) :-
    generar_itinerario_dias(Categoria, CriterioOrden, ItinerarioSinFiltrar),
    filtrar_por_dias(ItinerarioSinFiltrar, MaxDias, ItinerarioFiltrado).

/****************************************************
 * Entradas:
 *   - 
 * 
 * Salidas:
 *   - 
 *
 * Restricciones:
 *   - 
 *
 * Objetivo:
 *   - 
 ****************************************************/
% Predicado auxiliar que filtra la lista de actividades sin exceder el límite de días
filtrar_por_dias([], _, []).  % Caso base: si la lista está vacía, el resultado también lo está
filtrar_por_dias([Nombre-Duracion-Costo | RestoActividades], MaxDias, [Nombre-Duracion-Costo | RestoFiltrado]) :-
    MaxDias >= Duracion,  % Solo si la actividad no supera el límite de días
    NuevoMaxDias is MaxDias - Duracion,
    filtrar_por_dias(RestoActividades, NuevoMaxDias, RestoFiltrado).
filtrar_por_dias([_-Duracion-_ | RestoActividades], MaxDias, RestoFiltrado) :-
    MaxDias < Duracion,  % Si la actividad supera el límite, se ignora
    filtrar_por_dias(RestoActividades, MaxDias, RestoFiltrado).