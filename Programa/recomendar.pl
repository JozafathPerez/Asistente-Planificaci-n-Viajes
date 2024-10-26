% Lista de palabras a ignorar en el análisis de la frase
palabras_ignoradas(['el', 'la', 'los', 'las', 'un', 'una', 'unos', 'unas', 'de', 'en', 'por', 'para', 'con', 'a']).

% Predicado principal para recomendar actividades por frase
recomendar_por_frase :-
    writeln('Ingrese una frase para la recomendación:'),
    read_line_to_string(user_input, Frase),
    procesar_frase(Frase, PalabrasClave),
    buscar_actividades_por_palabras(PalabrasClave, Actividades),
    mostrar_recomendaciones(Actividades).

% Procesar la frase eliminando palabras ignoradas y extrayendo palabras clave
procesar_frase(Frase, PalabrasClave) :-
    split_string(Frase, " ", "", Palabras),
    palabras_ignoradas(PalabrasIgnoradas),
    exclude(\=(PalabrasIgnoradas), Palabras, PalabrasClave).

% Buscar actividades que coincidan con las palabras clave
buscar_actividades_por_palabras(PalabrasClave, Actividades) :-
    findall((Actividad, Destino, Costo, Duracion, Descripcion),
            (actividad(Actividad, Costo, Duracion, Descripcion, ListaTipos),
             (   contiene_palabra_clave(PalabrasClave, Descripcion)
             ;   contiene_palabra_clave(PalabrasClave, ListaTipos)
             ),
             asociar_actividad(Destino, Actividad)),
            Actividades).

% Verifica si alguna de las palabras clave está en el texto
contiene_palabra_clave(PalabrasClave, Texto) :-
    member(Palabra, PalabrasClave),
    sub_string(Texto, _, _, _, Palabra).

% Mostrar las actividades recomendadas con detalles
mostrar_recomendaciones([]) :-
    writeln('No se encontraron actividades que coincidan con la frase ingresada.').

mostrar_recomendaciones([(Actividad, Destino, Costo, Duracion, Descripcion)|Resto]) :-
    format('Actividad: ~w~n', [Actividad]),
    format('  Destino: ~w~n', [Destino]),
    format('  Descripción: ~w~n', [Descripcion]),
    format('  Costo: ~w~n', [Costo]),
    format('  Duración: ~w días~n', [Duracion]),
    writeln('-----------------------------'),
    mostrar_recomendaciones(Resto).
