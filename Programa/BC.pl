:- dynamic destino/2.

destino(paris, "Ciudad de la Luz").
destino(nueva_york, "La Gran Manzana").
destino(panama, "El pais del canal").

:- dynamic actividad/5.

actividad(museo_louvre, 25, 2, "Visitar el Museo del Louvre", [experiencia, historia]).
actividad(paseo_en_bici, 30, 3, "Paseo en bicicleta por la ciudad", [aventura, naturaleza]).
actividad(paseo_en_canoa, 20, 1, "Canoas extrema", [aventura, deportes]).
actividad(cena_romantica, 50, 2, "Cena romántica en restaurante", [romantico, gastronomia]).
actividad(camping_montana, 40, 6, "Camping en la montaña", [experiencia, aventura]).
actividad(black_star, 25, 2, "Visitar el Museo del Oro", [arquitectura]).


:- dynamic asociar_actividad/2.

asociar_actividad(paris, museo_louvre).
asociar_actividad(paris, paseo_en_bici).
asociar_actividad(nueva_york, paseo_en_bici).
asociar_actividad(panama, paseo_en_canoa).



