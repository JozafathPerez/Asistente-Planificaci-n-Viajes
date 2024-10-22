% Archivo hechos.pl
% Aquí puedes definir el predicado agregar_hechos/0

agregar_hechos :-
    writeln('--------------------------------------'),
    writeln('|       Agregar Nuevos Hechos        |'),
    writeln('--------------------------------------'),
    writeln('1. Agregar nuevo destino'),
    writeln('2. Agregar nueva actividad'),
    writeln('3. Asociar actividad a destino'),
    writeln('4. Regresar al menu principal'),
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
    writeln('Opción no válida, intente de nuevo.'),
    agregar_hechos.

agregar_nuevo_destino :-
    write('Ingrese el nombre del destino: '),
    read(Destino),
    write('Ingrese la descripción del destino: '),
    read(Descripcion),
    assert(destino(Destino, Descripcion)),
    writeln('Destino agregado exitosamente!').

agregar_nueva_actividad :-
    write('Ingrese el nombre de la actividad: '),
    read(NombreActividad),
    write('Ingrese el costo de la actividad: '),
    read(Costo),
    write('Ingrese la duración de la actividad en días: '),
    read(Duracion),
    write('Ingrese la descripción de la actividad: '),
    read(Descripcion),
    write('Ingrese la lista de tipos/categorías de la actividad: '),
    read(ListaTipos),
    assert(actividad(NombreActividad, Costo, Duracion, Descripcion, ListaTipos)),
    writeln('Actividad agregada exitosamente!').

asociar_actividad_destino :-
    write('Ingrese el nombre del destino: '),
    read(Destino),
    write('Ingrese el nombre de la actividad: '),
    read(Actividad),
    assert(asociar_actividad(Destino, Actividad)),
    writeln('Actividad asociada exitosamente!').
