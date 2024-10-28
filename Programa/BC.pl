:- dynamic destino/2.

destino(paris, "Ciudad de la Luz").
destino(nueva_york, "La Gran Manzana").
destino(cuidad_de_panama, "La Ciudad del canal").
destino(roma, "La Ciudad Eterna").
destino(tokio, "La Capital del Sol Naciente").
destino(sidney, "La Ciudad del Puerto").
destino(atenas, "Cuna de la Civilizacion Occidental").
destino(barcelona, "Ciudad de Gaudi").
destino(venecia, "La Ciudad de los Canales").
destino(cusco, "Capital del Imperio Inca").
destino(dubai, "La Ciudad del Futuro").
destino(londres, "La Ciudad de la Reina").
destino(limon, "Lo mejor de limon es su gente").

:- dynamic actividad/5.

actividad(museo_louvre, 25, 2, "Visitar el Museo del Louvre", [arte, historia]).
actividad(paseo_en_bici, 30, 3, "Paseo en bicicleta por la ciudad", [aventura, naturaleza]).
actividad(paseo_en_canoa, 20, 1, "Paseo en canoas extremas", [arte, panorama, naturaleza]).
actividad(coliseo_roma, 50, 1, "Explorar el Coliseo de Roma", [historia, arquitectura]).
actividad(sumo_tokio, 35, 2, "Ver una demostracion de sumo en Tokio", [cultura, experiencia]).
actividad(opera_sidney, 120, 2, "Disfrutar de una obra en la Opera de Sidney", [cultura, arquitectura]).
actividad(templo_parthenon, 40, 1, "Visitar el Partenon en Atenas", [historia, arquitectura]).
actividad(caminar_ramblas, 10, 1, "Caminar por las Ramblas de Barcelona", [panorama, cultura]).
actividad(gondola_venecia, 80, 1, "Paseo en gondola por Venecia", [romantico, naturaleza]).
actividad(machu_picchu, 100, 2, "Explorar Machu Picchu", [aventura, historia]).
actividad(burj_khalifa, 75, 1, "Subir al Burj Khalifa en Dubai", [arquitectura, experiencia]).
actividad(museo_britanico, 0, 3, "Visitar el Museo Britanico", [educativo, historia]).
actividad(picnic_central_park, 15, 2, "Picnic en Central Park", [naturaleza, panorama]).
actividad(cena_paris, 150, 1, "Cena romantica en Paris", [romantico, gastronomia]).
actividad(maraton_nueva_york, 200, 1, "Participar en el maraton de Nueva York", [aventura, experiencia]).
actividad(murallas_cusco, 60, 2, "Visitar las murallas incas en Cusco", [historia, aventura]).
actividad(desierto_dubai, 120, 4, "Safari por el desierto en Dubai", [aventura, naturaleza]).
actividad(bosque_aokigahara, 10, 3, "Recorrer el bosque Aokigahara", [naturaleza, panorama]).
actividad(basilica_sagrada_familia, 30, 1, "Visitar la Sagrada Familia", [arquitectura, cultura]).
actividad(puente_londres, 20, 1, "Cruzar el Puente de Londres", [historia, arquitectura]).
actividad(canal_panama, 60, 2, "Recorrido por el Canal de Panama", [educativo, experiencia]).
actividad(teatro_shakespeare, 45, 2, "Ver una obra en el Teatro de Shakespeare", [cultura, arte]).
actividad(paseo_en_bote, 5, 1, "Vamos a conocer a Uvita en bote", [aventura]).

:- dynamic asociar_actividad/2.

asociar_actividad(paris, museo_louvre).
asociar_actividad(paris, paseo_en_bici).
asociar_actividad(paris, cena_paris).
asociar_actividad(nueva_york, paseo_en_bici).
asociar_actividad(nueva_york, picnic_central_park).
asociar_actividad(nueva_york, maraton_nueva_york).
asociar_actividad(cuidad_de_panama, canal_panama).
asociar_actividad(roma, coliseo_roma).
asociar_actividad(tokio, sumo_tokio).
asociar_actividad(tokio, bosque_aokigahara).
asociar_actividad(sidney, opera_sidney).
asociar_actividad(atenas, templo_parthenon).
asociar_actividad(barcelona, caminar_ramblas).
asociar_actividad(barcelona, basilica_sagrada_familia).
asociar_actividad(venecia, gondola_venecia).
asociar_actividad(cusco, machu_picchu).
asociar_actividad(cusco, murallas_cusco).
asociar_actividad(dubai, burj_khalifa).
asociar_actividad(dubai, desierto_dubai).
asociar_actividad(londres, museo_britanico).
asociar_actividad(londres, puente_londres).
asociar_actividad(londres, teatro_shakespeare).
asociar_actividad(limon, paseo_en_bote).

