
/****************************************************
 * Entradas:
 *   - Sin entradas explícitas.
 * 
 * Salidas:
 *   - Genera y muestra un itinerario filtrado por días según las preferencias de usuario.
 *
 * Restricciones:
 *   - El número de días debe ser un valor numérico válido.
 *
 * Objetivo:
 *   - Solicitar al usuario información para generar un itinerario con actividades que no
 *     excedan el número de días indicado y, si lo desea, regenerarlo con otro criterio de orden.
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

/****************************************************
 * Entradas:
 *   - Respuesta: respuesta del usuario para regenerar o no el itinerario.
 *   - Categoria: categoría de actividades para el itinerario.
 *   - Dias: número máximo de días para el itinerario.
 * 
 * Salidas:
 *   - Muestra un itinerario regenerado o un mensaje de agradecimiento.
 *
 * Restricciones:
 *   - La respuesta debe ser 's' o 'n' para indicar si se desea regenerar.
 *
 * Objetivo:
 *   - Manejar la respuesta del usuario y regenerar el itinerario si es necesario.
 ****************************************************/
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
 *   - Categoria: categoría de actividades a considerar.
 *   - CriterioOrden: criterio de orden para las actividades (corto o largo).
 * 
 * Salidas:
 *   - Itinerario: lista de actividades generada por prioridad de categoría.
 *
 * Restricciones:
 *   - CriterioOrden debe ser un valor válido ('corto' o 'largo').
 *
 * Objetivo:
 *   - Generar un itinerario de actividades clasificadas y ordenadas por preferencia de categorías.
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
 *   - Categoria: categoría de actividades a considerar.
 *   - CriterioOrden: criterio de orden para las actividades (corto o largo).
 *   - MaxDias: cantidad máxima de días disponibles para el itinerario.
 * 
 * Salidas:
 *   - ItinerarioFiltrado: lista de actividades dentro del límite de días especificado.
 *
 * Restricciones:
 *   - CriterioOrden debe ser un valor válido ('corto' o 'largo').
 *   - MaxDias debe ser un número positivo.
 *
 * Objetivo:
 *   - Generar y filtrar un itinerario para que las actividades no excedan el número máximo de días.
 ****************************************************/  
generar_itinerario_con_dias(Categoria, CriterioOrden, MaxDias, ItinerarioFiltrado) :-
    generar_itinerario_dias(Categoria, CriterioOrden, ItinerarioSinFiltrar),
    filtrar_por_dias(ItinerarioSinFiltrar, MaxDias, ItinerarioFiltrado).

/****************************************************
 * Entradas:
 *   - Lista de actividades con sus duraciones.
 *   - MaxDias: número máximo de días permitidos para el itinerario.
 * 
 * Salidas:
 *   - ItinerarioFiltrado: lista de actividades que se ajustan al límite de días.
 *
 * Restricciones:
 *   - MaxDias debe ser un número positivo.
 *
 * Objetivo:
 *   - Filtrar las actividades para que el itinerario no exceda el límite de días especificado.
 ****************************************************/
filtrar_por_dias([], _, []).  % Caso base: si la lista está vacía, el resultado también lo está
filtrar_por_dias([Nombre-Duracion-Costo | RestoActividades], MaxDias, [Nombre-Duracion-Costo | RestoFiltrado]) :-
    MaxDias >= Duracion,  % Solo si la actividad no supera el límite de días
    NuevoMaxDias is MaxDias - Duracion,
    filtrar_por_dias(RestoActividades, NuevoMaxDias, RestoFiltrado).
filtrar_por_dias([_-Duracion-_ | RestoActividades], MaxDias, RestoFiltrado) :-
    MaxDias < Duracion,  % Si la actividad supera el límite, se ignora
    filtrar_por_dias(RestoActividades, MaxDias, RestoFiltrado).