agregar_hechos :-
    writeln('--------------------------------------'),
    writeln('|       Agregar Nuevos Hechos        |'),
    writeln('--------------------------------------'),
    writeln('1. Agregar nuevo destino'),
    writeln('2. Agregar nueva actividad'),
    writeln('3. Asociar actividad a destino'),
    writeln('4. Regresar al menú principal'),
    write('Seleccione una opción: '),
    read(Opcion),
    opcion_agregar(Opcion).

opcion_agregar(1) :-
    agregar_nuevo_destino,
    agregar_hechos.

opcion_agregar(2) :-
    agregar_nueva_actividad,
    agregar_hechos.

opcion_agregar(3) :-
    asociar_actividad_destino,
    agregar_hechos.

opcion_agregar(4).

opcion_agregar(_) :-
    writeln('Opción no válida, intente de nuevo.'),
    agregar_hechos.
    
% Mostrar categorías válidas para actividades y permitir seleccionar por número
mostrar_categorias :-
    categorias_actividades(Categorias),
    writeln('Seleccione las categorías de la actividad (ingrese los números separados por comas):'),
    listar_categorias(Categorias, 1).

listar_categorias([], _).
listar_categorias([Categoria|Resto], Num) :-
    format('~w. ~w~n', [Num, Categoria]),
    N is Num + 1,
    listar_categorias(Resto, N).

% Validación de categorías seleccionadas
seleccionar_categorias(Seleccion, CategoriasSeleccionadas) :-
    categorias_actividades(ListaCategorias),
    split_string(Seleccion, ",", "", ListaStrings),
    maplist(atom_number, ListaStrings, ListaNumeros),
    findall(Cat, 
            (member(Num, ListaNumeros), nth1(Num, ListaCategorias, Cat)), 
            CategoriasSeleccionadas).

% Función para verificar la existencia de un destino
existe_destino(Destino) :-
    destino(Destino, _).

% Función para verificar la existencia de una actividad
existe_actividad(NombreActividad) :-
    actividad(NombreActividad, _, _, _, _).

% Agregar nuevo destino con validación
agregar_nuevo_destino :-
    write('Ingrese el nombre del destino: '),
    read(Destino),
    (   existe_destino(Destino)
    ->  writeln('Error: El destino ya existe.')
    ;   write('Ingrese la descripción del destino: '),
        read(Descripcion),
        assert(destino(Destino, Descripcion)),
        writeln('Destino agregado exitosamente!'),
        guardar_base
    ).

% Agregar nueva actividad con validación de categorías
agregar_nueva_actividad :-
    write('Ingrese el nombre de la actividad: '),
    read(NombreActividad),
    (   existe_actividad(NombreActividad)
    ->  writeln('Error: La actividad ya existe.')
    ;   write('Ingrese el costo de la actividad: '),
        read(Costo),
        write('Ingrese la duración de la actividad en días: '),
        read(Duracion),
        write('Ingrese la descripción de la actividad: '),
        read(Descripcion),
        mostrar_categorias,
        write('Seleccione las categorías (ejemplo: "1,3,5"): '),
        read(Seleccion),
        (   seleccionar_categorias(Seleccion, ListaTipos)
        ->  assert(actividad(NombreActividad, Costo, Duracion, Descripcion, ListaTipos)),
            writeln('Actividad agregada exitosamente!'),
            guardar_base
        ;   writeln('Error: Selección de categorías inválida.')
        )
    ).


% Asociar actividad a destino con validación de existencia de ambos
asociar_actividad_destino :-
    write('Ingrese el nombre del destino: '),
    read(Destino),
    (   existe_destino(Destino)
    ->  write('Ingrese el nombre de la actividad: '),
        read(Actividad),
        (   existe_actividad(Actividad)
        ->  assert(asociar_actividad(Destino, Actividad)),
            writeln('Actividad asociada exitosamente!'),
            guardar_base
        ;   writeln('Error: La actividad no existe.')
        )
    ;   writeln('Error: El destino no existe.')
    ).

