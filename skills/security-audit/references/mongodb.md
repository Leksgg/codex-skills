# MongoDB / Mongoose

- Traza si entrada que debería ser escalar puede llegar como objeto con operadores. Verifica el parser, esquema y versión usados; no presupongas cómo interpreta query strings el framework.
- Prefiere validación explícita de tipo y campos. Los filtros de saneamiento son defensa adicional; marcar datos como confiables puede desactivar protecciones.
- Revisa operadores o expresiones construidos con entrada no fiable, patrones costosos y nombres de campo controlables.
- En lecturas y actualizaciones por id, comprueba propietario o tenant dentro del flujo de autorización. Revisa asignación masiva de `role`, `owner` y `balance`.
- Examina proyecciones, serialización, agregaciones y uso de `lean()`: determina qué campos salen realmente y qué transformaciones quedan omitidas.
- Identifica consultas sin límites en rutas expuestas y operaciones no atómicas sobre estado sensible.
- No infieras configuración de Atlas ni permisos efectivos de BD a partir de su ausencia en el repo. Declara esos controles como no verificados cuando no haya evidencia.
