:- dynamic destino/2.

destino(paris, "Ciudad de la Luz").
destino(nueva_york, "La Gran Manzana").
destino(panama, "El pais del canal").

:- dynamic actividad/5.

actividad(museo_louvre, 25, 2, "Visitar el Museo del Louvre", [arte, historia]).
actividad(paseo_en_bici, 30, 3, "Paseo en bicicleta por la ciudad", [aventura, naturaleza]).
actividad(paseo_en_canoa, 20, 1, "Canoas extremas", [arte, panorama, naturaleza]).

:- dynamic asociar_actividad/2.

asociar_actividad(paris, museo_louvre).
asociar_actividad(paris, paseo_en_bici).
asociar_actividad(nueva_york, paseo_en_bici).
asociar_actividad(panama, paseo_en_canoa).

