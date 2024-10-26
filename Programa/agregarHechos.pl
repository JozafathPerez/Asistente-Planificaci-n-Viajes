/****************************************************
 * Entradas:
 *   - Ninguna
 * 
 * Salidas:
 *   - Muestra un menú para agregar nuevos hechos
 *   - Llama a las funciones correspondientes según la opción seleccionada
 *
 * Restricciones:
 *   - La opción seleccionada debe ser un número entre 1 y 4
 *
 * Objetivo:
 *   - Permitir al usuario agregar nuevos destinos, actividades, o asociar actividades a destinos
 ****************************************************/
agregar_hechos :-
    writeln('--------------------------------------'),
    writeln('|       Agregar Nuevos Hechos        |'),
    writeln('--------------------------------------'),
    writeln('| 1 | Agregar nuevo destino          |'),
    writeln('| 2 | Agregar nueva actividad        |'),
    writeln('| 3 | Asociar actividad a destino    |'),
    writeln('| 4 | Regresar al menu principal     |'),
    writeln('--------------------------------------'),
    write('Seleccione una opcion: '),
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
    writeln('Opcion no valida, intente de nuevo.'),
    agregar_hechos.
    
/****************************************************
 * Entradas:
 *   - Ninguna
 * 
 * Salidas:
 *   - Muestra las categorías disponibles para actividades
 *
 * Restricciones:
 *   - Las categorías deben estar definidas en el sistema
 *
 * Objetivo:
 *   - Permitir al usuario seleccionar categorías para una nueva actividad
 ****************************************************/
mostrar_categorias :-
    categorias_actividades(Categorias),
    writeln('Seleccione las categorias de la actividad (ingrese los numeros separados por comas):'),
    listar_categorias(Categorias, 1).

/****************************************************
 * Entradas:
 *   - Lista de categorías (Lista)
 *   - Número actual (Num) para enumerar las categorías
 * 
 * Salidas:
 *   - Muestra las categorías enumeradas
 *
 * Restricciones:
 *   - La lista no debe estar vacía
 *
 * Objetivo:
 *   - Enumerar y mostrar cada categoría de actividades
 ****************************************************/
listar_categorias([], _).
listar_categorias([Categoria|Resto], Num) :-
    format('~w. ~w~n', [Num, Categoria]),
    N is Num + 1,
    listar_categorias(Resto, N).

/****************************************************
 * Entradas:
 *   - Seleccion: Una cadena con números separados por comas
 * 
 * Salidas:
 *   - Lista de categorías seleccionadas
 *
 * Restricciones:
 *   - La selección debe ser válida y corresponder a índices de categorías existentes
 *
 * Objetivo:
 *   - Procesar la selección de categorías a partir de la entrada del usuario
 ****************************************************/
seleccionar_categorias(Seleccion, CategoriasSeleccionadas) :-
    categorias_actividades(ListaCategorias),
    split_string(Seleccion, ",", "", ListaStrings),
    maplist(atom_number, ListaStrings, ListaNumeros),
    findall(Cat, 
            (member(Num, ListaNumeros), nth1(Num, ListaCategorias, Cat)), 
            CategoriasSeleccionadas).

/****************************************************
 * Entradas:
 *   - Destino: El nombre del destino que se desea verificar
 * 
 * Salidas:
 *   - Verdadero si el destino existe, falso de lo contrario
 *
 * Restricciones:
 *   - Ninguna
 *
 * Objetivo:
 *   - Verificar si un destino ya está registrado en la base de datos
 ****************************************************/
existe_destino(Destino) :-
    destino(Destino, _).

/****************************************************
 * Entradas:
 *   - NombreActividad: El nombre de la actividad que se desea verificar
 * 
 * Salidas:
 *   - Verdadero si la actividad existe, falso de lo contrario
 *
 * Restricciones:
 *   - Ninguna
 *
 * Objetivo:
 *   - Verificar si una actividad ya está registrada en la base de datos
 ****************************************************/
existe_actividad(NombreActividad) :-
    actividad(NombreActividad, _, _, _, _).

/****************************************************
 * Entradas:
 *   - Ninguna
 * 
 * Salidas:
 *   - Mensaje indicando si se ha agregado un nuevo destino
 *
 * Restricciones:
 *   - El nombre del destino debe ser un atomo
 *   - La descripción debe ser un string
 *
 * Objetivo:
 *   - Permitir al usuario agregar un nuevo destino a la base de datos
 ****************************************************/
agregar_nuevo_destino :-
    write('Ingrese el nombre del destino: '),
    read(Destino),
    es_atom(Destino),
    (   existe_destino(Destino)
    ->  writeln('Error: El destino ya existe.')
    ;   write('Ingrese la descripcion del destino: '),
        read(Descripcion),
        es_string(Descripcion),
        assert(destino(Destino, Descripcion)),
        writeln('Destino agregado exitosamente!'),
        guardar_base
    ).

/****************************************************
 * Entradas:
 *   - Ninguna
 * 
 * Salidas:
 *   - Mensaje indicando si se ha agregado una nueva actividad
 *
 * Restricciones:
 *   - El nombre de la actividad debe ser un atomo
 *   - El costo y duración deben ser números
 *   - La descripción debe ser un string
 *
 * Objetivo:
 *   - Permitir al usuario agregar una nueva actividad a la base de datos
 ****************************************************/
agregar_nueva_actividad :-
    write('Ingrese el nombre de la actividad: '),
    read(NombreActividad),
    es_atom(NombreActividad),
    (   existe_actividad(NombreActividad)
    ->  writeln('Error: La actividad ya existe.')
    ;   write('Ingrese el costo de la actividad: '),
        read(Costo),
        es_numero(Costo),
        write('Ingrese la duracion de la actividad en dias: '),
        read(Duracion),
        es_numero(Duracion),
        write('Ingrese la descripcion de la actividad: '),
        read(Descripcion),
        es_string(Descripcion),
        mostrar_categorias,
        write('Seleccione las categorias (ejemplo: "1,3,5"): '),
        read(Seleccion),
        (   seleccionar_categorias(Seleccion, ListaTipos)
        ->  assert(actividad(NombreActividad, Costo, Duracion, Descripcion, ListaTipos)),
            writeln('Actividad agregada exitosamente!'),
            guardar_base
        ;   writeln('Error: Seleccion de categorias invalida.')
        )
    ).

/****************************************************
 * Entradas:
 *   - Ninguna
 * 
 * Salidas:
 *   - Mensaje indicando si se ha asociado una actividad a un destino
 *
 * Restricciones:
 *   - El nombre del destino y de la actividad deben ser atomos
 *
 * Objetivo:
 *   - Permitir al usuario asociar una actividad existente a un destino
 ****************************************************/
asociar_actividad_destino :-
    write('Ingrese el nombre del destino: '),
    read(Destino),
    es_atom(Destino),
    (   existe_destino(Destino)
    ->  write('Ingrese el nombre de la actividad: '),
        read(Actividad),
        es_atom(Actividad),
        (   existe_actividad(Actividad)
        ->  assert(asociar_actividad(Destino, Actividad)),
            writeln('Actividad asociada exitosamente!'),
            guardar_base
        ;   writeln('Error: La actividad no existe.')
        )
    ;   writeln('Error: El destino no existe.')
    ).