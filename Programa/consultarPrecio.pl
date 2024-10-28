/****************************************************
 * Entradas:
 *   - Ninguna, aunque se solicita al usuario ingresar el monto.
 * 
 * Salidas:
 *   - Detalle de las actividades filtradas según el precio ingresado.
 *
 * Restricciones:
 *   - El monto ingresado debe ser un número.
 *
 * Objetivo:
 *   - Solicitar al usuario un monto y mostrar un menú para consultar actividades 
 *     que sean más baratas o más caras que el monto indicado.
 ****************************************************/
consultar_por_precio :-
    write('Ingrese el monto que desea consultar (solo numeros): '),
    read(Monto),
    es_numero(Monto),
    menu_consulta_precio(Monto).

/****************************************************
 * Entradas:
 *   - Monto: Número que indica el precio límite para las consultas.
 * 
 * Salidas:
 *   - Detalle de las actividades que cumplen con el criterio seleccionado.
 *
 * Restricciones:
 *   - El monto debe ser numérico y mayor a cero.
 *
 * Objetivo:
 *   - Ofrecer un menú interactivo que permita al usuario consultar actividades 
 *     con precios por debajo o por encima del monto ingresado, o regresar al menú principal.
 ****************************************************/
menu_consulta_precio(Monto) :-
    repeat,
    writeln('----------------------------------------'),
    writeln('|           Consulta por precio        |'),
    writeln('----------------------------------------'),
    writeln('| 1 | Consultar actividades mas baratas|'),
    writeln('| 2 | Consultar actividades mas caras  |'),
    writeln('| 3 | Regresar al menu principal       |'),
    writeln('----------------------------------------'),
    write('Seleccione el numero de opcion: '),
    read(Opcion),
    ( Opcion = 1 -> 
        actividades_mas_baratas(Monto), 
        menu_consulta_precio(Monto);
      Opcion = 2 -> 
        actividades_mas_caras(Monto), 
        menu_consulta_precio(Monto);
      Opcion = 3 -> writeln('Regresando al menu principal...'), !; 
      writeln('Opcion no valida, por favor intente nuevamente.'),
      fail
    ).

/****************************************************
 * Entradas:
 *   - Monto: Número que representa el precio límite superior.
 * 
 * Salidas:
 *   - Lista de actividades con precios más bajos que el monto.
 *
 * Restricciones:
 *   - El monto debe ser numérico y positivo.
 *
 * Objetivo:
 *   - Filtrar y mostrar actividades cuyo precio sea menor que el monto ingresado.
 ****************************************************/
actividades_mas_baratas(Monto) :-
    findall((Actividad, Destino, Costo, Duracion, Descripcion),
            (actividad(Actividad, Costo, Duracion, Descripcion, _),
             Costo < Monto,
             asociar_actividad(Destino, Actividad)),
            Actividades),
    (   
        Actividades \= [] ->
        mostrar_actividades_precio(Actividades);
        writeln('----------------------------------------'),
        writeln('No hay actividades disponibles que sean mas baratas que el monto ingresado.'),
        writeln('----------------------------------------')
    ).

/****************************************************
 * Entradas:
 *   - Monto: Número que representa el precio límite inferior.
 * 
 * Salidas:
 *   - Lista de actividades con precios más altos que el monto.
 *
 * Restricciones:
 *   - El monto debe ser numérico y positivo.
 *
 * Objetivo:
 *   - Filtrar y mostrar actividades cuyo precio sea mayor que el monto ingresado.
 ****************************************************/
actividades_mas_caras(Monto) :-
    findall((Actividad, Destino, Costo, Duracion, Descripcion),
            (actividad(Actividad, Costo, Duracion, Descripcion, _),
             Costo > Monto,
             asociar_actividad(Destino, Actividad)),
            Actividades),
    (   
        Actividades \= [] ->
        mostrar_actividades_precio(Actividades);
        writeln('----------------------------------------'),
        writeln('No hay actividades disponibles que sean mas caras que el monto ingresado.'),
        writeln('----------------------------------------')
    ).

/****************************************************
 * Entradas:
 *   - Lista de actividades: Cada actividad incluye los datos Actividad, Destino, 
 *     Costo, Duracion, y Descripcion.
 * 
 * Salidas:
 *   - Descripción detallada de cada actividad de la lista.
 *
 * Restricciones:
 *   - La lista debe contener actividades con sus detalles completos.
 *
 * Objetivo:
 *   - Mostrar al usuario cada actividad junto con sus detalles: destino, 
 *     descripción, costo y duración.
 ****************************************************/
mostrar_actividades_precio([]) :- !.
mostrar_actividades_precio([(Actividad, Destino, Costo, Duracion, Descripcion)|Resto]) :-
    writeln('----------------------------------------'),
    format('Actividad: ~w~n', [Actividad]),
    format('  Destino: ~w~n', [Destino]),
    format('  Descripcion: ~w~n', [Descripcion]),
    format('  Costo: ~w~n', [Costo]),
    format('  Duracion: ~w dias~n', [Duracion]),
    writeln('----------------------------------------'),
    mostrar_actividades_precio(Resto).
