% Ejemplo de base de conocimiento 

% Destinos
destino(paris, 'Ciudad de la Luz').
destino(nueva_york, 'La Gran Manzana').

% Actividades
actividad(museo_louvre, 25, 2, 'Visitar el Museo del Louvre', ['arte', 'historia']).
actividad(paseo_en_bici, 30, 3, 'Paseo en bicicleta por la ciudad', ['aventura', 'naturaleza']).

% Asociación de actividades a destinos
asociar_actividad(paris, museo_louvre).
asociar_actividad(paris, paseo_en_bici).
