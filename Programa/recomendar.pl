palabras_ignoradas(['el', 'la', 'los', 'las', 'un', 'una', 'unos', 'unas', 'de', 'en', 'por', 'para', 'con', 'a']).

% Predicado principal para recomendación por frase
recomendar_por_frase :-
    write('Ingrese una frase para la recomendacion: '),
    read(Frase),
    procesar_frase(Frase, PalabrasClave),
    buscar_actividades_por_palabras(PalabrasClave, Actividades),
    (   Actividades = [] 
    ->  writeln('No se encontraron actividades que coincidan con la frase ingresada.')
    ;   mostrar_recomendaciones(Actividades)
    ).

% Procesa la frase eliminando las palabras ignoradas
procesar_frase(Frase, PalabrasClave) :-
    downcase_atom(Frase, FraseMin),
    split_string(FraseMin, " ", "", Palabras),
    palabras_ignoradas(PalabrasIgnoradas),
    exclude({PalabrasIgnoradas}/[Palabra]>>member(Palabra, PalabrasIgnoradas), Palabras, PalabrasClave).

% Busca actividades que coincidan con alguna palabra clave en la descripción o categorías
buscar_actividades_por_palabras(PalabrasClave, Actividades) :-
    findall((Actividad, Destino, Costo, Duracion, Descripcion),
            (actividad(Actividad, Costo, Duracion, Descripcion, ListaTipos),
             (   contiene_palabra_clave(PalabrasClave, Descripcion)
             ;   contiene_palabra_clave(PalabrasClave, ListaTipos)
             ),
             asociar_actividad(Destino, Actividad)),
            Actividades).

% Verifica si alguna palabra clave está presente en el texto o lista de categorías
contiene_palabra_clave(PalabrasClave, Texto) :-
    (   atomic(Texto) -> downcase_atom(Texto, TextoMin)
    ;   is_list(Texto) -> atomic_list_concat(Texto, ' ', TextoConcat), downcase_atom(TextoConcat, TextoMin)
    ),
    member(Palabra, PalabrasClave),
    sub_string(TextoMin, _, _, _, Palabra).

% Muestra las recomendaciones de actividades encontradas
mostrar_recomendaciones([(Actividad, Destino, Costo, Duracion, Descripcion)|Resto]) :-
    format('Actividad: ~w~n', [Actividad]),
    format('  Destino: ~w~n', [Destino]),
    format('  Descripcion: ~w~n', [Descripcion]),
    format('  Costo: ~w~n', [Costo]),
    format('  Duracion: ~w dias~n', [Duracion]),
    writeln('-----------------------------'),
    mostrar_recomendaciones(Resto).
