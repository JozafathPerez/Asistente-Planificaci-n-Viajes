guardar_base :-
    tell('BC.pl'),  % Abrir archivo para escribir
    listing(destino/2),  % Guardar destinos
    listing(actividad/5),  % Guardar actividades
    listing(asociar_actividad/2),  % Guardar asociaciones
    told.  % Cerrar archivo

es_atom(Valor) :-
    (   atom(Valor)
    ->  true
    ;   writeln('Error: El valor debe ser un atomo.'), false
    ).

es_string(Valor) :-
    (   string(Valor)
    ->  true
    ;   writeln('Error: El valor debe ser un string.'), false
    ).

es_numero(Valor) :-
    (   number(Valor)
    ->  true
    ;   writeln('Error: El valor debe ser un numero.'), false
    ).

categorias_actividades([
    'arte',
    'historia',
    'panorama',
    'romantico',
    'naturaleza',
    'experiencia',
    'cultura',
    'arquitectura',
    'diversion',
    'gastronomia',
    'educativo',
    'aventura'
]).

% Para la docuemntación chaval  n borar
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