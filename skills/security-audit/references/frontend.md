# React, Next.js y frontend

- Sigue entradas que llegan a HTML crudo, Markdown con HTML, URLs activas y ejecución dinámica. Comprueba sanitización según el contexto y versión del renderizador.
- Determina qué datos acaban en bundles, respuestas y props. Los prefijos públicos indican exposición; la gravedad depende de si el valor es secreto y de los permisos reales.
- Comprueba autorización en APIs y server actions alcanzables. Guards y botones ocultos no protegen las operaciones del servidor.
- En Next.js verifica rutas, middleware y acciones según la versión del proyecto; no infieras protección únicamente por la ubicación del archivo.
- Evalúa cookies, CSRF y origen de peticiones en conjunto. `SameSite` no reemplaza automáticamente todos los controles CSRF, especialmente con dominios hermanos o cambios mediante GET.
- En `postMessage`, comprueba origen, emisor y estructura antes de actuar.
- Revisa destinos de redirección y recursos remotos del servidor. Confirma si el optimizador o proxy puede alcanzar destinos sensibles.
- Cabeceras, source maps y SRI requieren contexto: evita presentar su ausencia como explotación demostrada.
