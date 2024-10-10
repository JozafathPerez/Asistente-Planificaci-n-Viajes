% Consulta las actividades de un destino y calcula costo y duración total
consultar_actividades_destino(Destino, Actividades, CostoTotal, DuracionTotal) :-
    findall(Actividad, asociar_actividad(Destino, Actividad), Actividades),
    calcular_costo_y_duracion(Actividades, CostoTotal, DuracionTotal).

% Calcula el costo y la duración totales de una lista de actividades
calcular_costo_y_duracion([], 0, 0).
calcular_costo_y_duracion([Actividad|Resto], CostoTotal, DuracionTotal) :-
    actividad(Actividad, Costo, Duracion, _, _),
    calcular_costo_y_duracion(Resto, CostoResto, DuracionResto),
    CostoTotal is Costo + CostoResto,
    DuracionTotal is Duracion + DuracionResto.
