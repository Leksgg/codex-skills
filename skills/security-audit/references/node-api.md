# Node/TS y APIs

- Traza registro de rutas y orden de middlewares. Comprueba autorización sobre el recurso y tenant, incluidas rutas administrativas y WebSockets.
- Revisa asignación masiva, valores de rol/precio aceptados del cliente y serialización excesiva de entidades.
- En JWT comprueba firma, algoritmos permitidos, emisor/audiencia cuando apliquen y caducidad. Revisa recuperación de cuentas, rate limiting y uso único de tokens.
- Busca SQL sin parametrizar, procesos con shell, carga dinámica de código, mezclas de objetos no fiables y expresiones regulares controladas por el usuario. Confirma entrada y alcance antes de reportar.
- En archivos, resolver una ruta no garantiza confinamiento. Comprueba el límite de segmento y enlaces simbólicos si el modelo de amenazas permite crearlos.
- En peticiones salientes, comprueba política de destinos, DNS y redirecciones. Evita aceptar URLs internas por validar solo el texto inicial.
- En webhooks, sigue el SDK o protocolo oficial para firma, cuerpo original, antigüedad e idempotencia.
- Revisa límites de body/archivos, manejo de errores y logs. La ausencia de una cabecera o middleware concreto no demuestra por sí sola una vulnerabilidad.
- Comprueba operaciones atómicas para saldo, stock y cupones; busca ventanas entre validar y modificar.
- Consulta versiones bloqueadas y fuentes oficiales al evaluar dependencias. Los escáneres con registro remoto requieren red y transmiten información de paquetes.
