# Cloudflare

Consulta documentación oficial para detalles de plataforma y versiones; usa las skills de Cloudflare disponibles si una corrección requiere su flujo especializado.

- Comprueba todas las rutas públicas del Worker y las alternativas de acceso al origen. La presencia de un header de Access no demuestra que su JWT se haya validado.
- Distingue variables públicas de secretos mediante configuración versionada y bindings, sin abrir `.dev.vars` ni listar credenciales.
- En R2 verifica exposición del bucket, propiedad de claves, autorización al firmar URLs y método/caducidad. No presupongas que una URL firmada limita tamaño o contenido: verifica qué condiciones se aplican realmente.
- En KV/D1 y Durable Objects comprueba aislamiento por usuario o tenant. Elegir un identificador de objeto no otorga autorización.
- Revisa autenticación de upgrades WebSocket y permisos de mensajes posteriores.
- Comprueba si caché compartida puede devolver respuestas privadas a otra identidad.
- CORS no limita clientes no navegador ni sustituye autorización. Un comodín aislado no demuestra acceso a datos privados.
- Si existe Turnstile, comprueba verificación en servidor y manejo de errores. Revisa autenticidad e idempotencia de webhooks; distingue estos de mensajes que llegan mediante bindings internos.
