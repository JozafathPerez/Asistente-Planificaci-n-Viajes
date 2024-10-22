afinidad(arte, cultura).
afinidad(historia, arquitectura).
afinidad(panorama, diversion).
afinidad(romantico, gastronomia).
afinidad(naturaleza, educativo).
afinidad(experiencia, aventura).

% Regla para la relación bidireccional de afinidades
afinidad(X, Y) :- afinidad(Y, X).
