% Predicado principal que obtiene los datos y llama a generar_itinerario_monto
generar_itinerario_monto :-
actividades_por_categoria(aventura, Actividades), imprimir_lista(Actividades).

% Predicado principal para pedir datos al usuario
pedir_datos(Monto, Categoria, CantidadPersonas, PreferenciaEstancias) :-
    pedir_monto(Monto),
    write('Ingrese la categoria de preferencia (ej. cultural, aventura, relajacion): '), 
    read(Categoria),
    pedir_cantidad_personas(CantidadPersonas),
    write('Prefiere estancias largas o cortas? (larga/corta): '), 
    read(PreferenciaEstancias).

% Predicado auxiliar para solicitar y validar que el monto sea un número
pedir_monto(Monto) :-
    write('Ingrese el monto maximo disponible: '),
    read(EntradaMonto),
    (   es_numero(EntradaMonto)
    ->  Monto = EntradaMonto
    ;   writeln('Por favor, ingrese un monto numerico valido.'),
        pedir_monto(Monto) % Llamada recursiva para volver a pedir el monto
    ).

% Predicado auxiliar para solicitar y validar que la cantidad de personas sea un número
pedir_cantidad_personas(CantidadPersonas) :-
    write('Ingrese la cantidad de personas: '),
    read(EntradaCantidad),
    (   es_numero(EntradaCantidad)
    ->  CantidadPersonas = EntradaCantidad
    ;   writeln('Por favor, ingrese una cantidad numerica valida de personas.'),
        pedir_cantidad_personas(CantidadPersonas) % Llamada recursiva para volver a pedir la cantidad
    ).

% Ejemplo de definición de generar_itinerario_monto/4
generar_itinerario(Monto, Categoria, CantidadPersonas, PreferenciaEstancias) :-
    % Aquí implementarías la lógica para generar el itinerario de acuerdo a los parámetros
    format('Generando itinerario con:~n - Monto maximo: ~w~n - Categoria: ~w~n - Cantidad de personas: ~w~n - Preferencia: ~w~n', 
           [Monto, Categoria, CantidadPersonas, PreferenciaEstancias]).

% Predicado para obtener lista de actividades con categorias iguales a la indicada
actividades_por_categoria(Categoria, Actividades) :-
    findall(
        Actividad,
        (actividad(Actividad, Costo, Duracion, Descripcion, ListaTipos), member(Categoria, ListaTipos)),
        Actividades
    ).

% Predicado para obtener la lista de actividades afines a una categoría dada
actividades_afines(Categoria, Actividades) :-
    findall(Nombre, 
            (afinidad(Categoria, AfinCategoria),  % Encuentra una categoría afín
             actividad(Nombre, _, _, _, Categorias), 
             member(AfinCategoria, Categorias)),   % Verifica si la actividad tiene esta categoría afín
            ActividadesUnicas),
    list_to_set(ActividadesUnicas, Actividades).  % Elimina duplicados


% Predicado para imprimir cada elemento de una lista en una nueva línea
imprimir_lista([]).
imprimir_lista([Cabeza | Cola]) :-
    writeln(Cabeza),
    imprimir_lista(Cola).