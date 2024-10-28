palabras_ignoradas(['el', 'la', 'los', 'las', 'un', 'una', 'unos', 'unas', 'de', 'en', 'por', 'para', 'con', 'a']).

/****************************************************
 * Entradas:
 *   - Ninguna.
 * 
 * Salidas:
 *   - Muestra una lista de actividades recomendadas basadas en una frase de búsqueda proporcionada por el usuario.
 *
 * Restricciones:
 *   - La frase de búsqueda debe contener palabras clave significativas, sin incluir palabras comunes como artículos o preposiciones.
 *
 * Objetivo:
 *   - Sugerir actividades al usuario que coincidan con palabras clave en una frase ingresada.
 ****************************************************/
recomendar_por_frase :-
    write('Ingrese una frase para la recomendacion: '),
    read(Frase),
    procesar_frase(Frase, PalabrasClave),
    buscar_actividades_por_palabras(PalabrasClave, Actividades),
    (   Actividades = [] 
    ->  writeln('No se encontraron actividades que coincidan con la frase ingresada.')
    ;   mostrar_recomendaciones(Actividades)
    ).

/****************************************************
 * Entradas:
 *   - Frase: cadena de texto ingresada por el usuario.
 * 
 * Salidas:
 *   - PalabrasClave: lista de palabras relevantes extraídas de la frase, excluyendo palabras comunes.
 *
 * Restricciones:
 *   - La frase debe ser una cadena de texto.
 *
 * Objetivo:
 *   - Extraer las palabras clave de la frase del usuario, eliminando palabras ignoradas.
 ****************************************************/
procesar_frase(Frase, PalabrasClave) :-
    downcase_atom(Frase, FraseMin),
    split_string(FraseMin, " ", "", Palabras),
    palabras_ignoradas(PalabrasIgnoradas),
    exclude({PalabrasIgnoradas}/[Palabra]>>member(Palabra, PalabrasIgnoradas), Palabras, PalabrasClave).

/****************************************************
 * Entradas:
 *   - PalabrasClave: lista de palabras clave a buscar.
 * 
 * Salidas:
 *   - Actividades: lista de actividades que contienen al menos una palabra clave en su descripción o tipo.
 *
 * Restricciones:
 *   - Debe existir al menos una actividad registrada en el sistema para proporcionar coincidencias.
 *
 * Objetivo:
 *   - Buscar actividades que coincidan con las palabras clave en su descripción o categorías.
 ****************************************************/
buscar_actividades_por_palabras(PalabrasClave, Actividades) :-
    findall((Actividad, Destino, Costo, Duracion, Descripcion),
            (actividad(Actividad, Costo, Duracion, Descripcion, ListaTipos),
             (   contiene_palabra_clave(PalabrasClave, Descripcion)
             ;   contiene_palabra_clave(PalabrasClave, ListaTipos)
             ),
             asociar_actividad(Destino, Actividad)),
            Actividades).

/****************************************************
 * Entradas:
 *   - PalabrasClave: lista de palabras clave.
 *   - Texto: texto en el que se busca la presencia de las palabras clave.
 * 
 * Salidas:
 *   - Verdadero si alguna palabra clave está contenida en el texto, falso en caso contrario.
 *
 * Restricciones:
 *   - Texto puede ser una cadena o una lista de cadenas.
 *
 * Objetivo:
 *   - Determinar si el texto contiene alguna de las palabras clave especificadas.
 ****************************************************/
contiene_palabra_clave(PalabrasClave, Texto) :-
    (   atomic(Texto) -> downcase_atom(Texto, TextoMin)
    ;   is_list(Texto) -> atomic_list_concat(Texto, ' ', TextoConcat), downcase_atom(TextoConcat, TextoMin)
    ),
    member(Palabra, PalabrasClave),
    sub_string(TextoMin, _, _, _, Palabra).

/****************************************************
 * Entradas:
 *   - Lista de actividades [(Actividad, Destino, Costo, Duracion, Descripcion)|Resto].
 * 
 * Salidas:
 *   - Muestra la información de cada actividad recomendada en formato de lista.
 *
 * Restricciones:
 *   - La lista de actividades no debe estar vacía.
 *
 * Objetivo:
 *   - Mostrar cada actividad recomendada, incluyendo su destino, descripción, costo y duración.
 ****************************************************/
mostrar_recomendaciones([(Actividad, Destino, Costo, Duracion, Descripcion)|Resto]) :-
    format('Actividad: ~w~n', [Actividad]),
    format('  Destino: ~w~n', [Destino]),
    format('  Descripcion: ~w~n', [Descripcion]),
    format('  Costo: ~w~n', [Costo]),
    format('  Duracion: ~w dias~n', [Duracion]),
    writeln('-----------------------------'),
    mostrar_recomendaciones(Resto).
