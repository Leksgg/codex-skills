---
name: secure-coding
description: "Aplica comprobaciones de seguridad al crear o modificar autenticación, sesiones, permisos, consultas a BD, subidas, secretos, CORS, webhooks, pagos o flujos con entrada no fiable, aunque el usuario no hable de seguridad. Limita la revisión al cambio y su contexto; una auditoría completa es security-audit."
---

# Secure coding

Revisa los controles que afectan al flujo modificado. Conserva las bibliotecas y convenciones seguras del proyecto y consulta documentación oficial cuando un control dependa de la versión o del proveedor.

- **Entrada:** valida tipos y campos permitidos en el borde. No pases objetos arbitrarios del cliente a consultas o actualizaciones; impide que fije dueño, rol, saldo o precio autoritativo.
- **Permisos:** comprueba en servidor el acceso a cada recurso y tenant. Autenticación y ocultar botones no sustituyen autorización.
- **Sesiones:** usa las primitivas de autenticación del framework. Verifica firma y claims aplicables de JWT, caducidad y uso único de tokens de recuperación; genera tokens con aleatoriedad criptográfica. Protege cookies y evalúa CSRF para operaciones con autenticación ambiental.
- **Consultas y procesos:** parametriza valores SQL y valida operadores y nombres de campo. Evita shell al ejecutar procesos; los argumentos también necesitan validación frente a opciones peligrosas.
- **Rutas:** comprueba pertenencia al directorio permitido con límites de segmento, no con un prefijo de texto simple. Considera enlaces simbólicos cuando un atacante pueda crearlos.
- **Salida:** escapa según el contexto; sanitiza HTML cuando sea necesario y valida esquemas de URLs. No expongas campos sensibles al serializar objetos.
- **Red:** limita destinos de peticiones a URLs del usuario; revisa resolución DNS, direcciones privadas y cada redirección. Valida destinos de redirecciones de la aplicación. CORS no es autorización.
- **Archivos:** limita tamaño, valida contenido en servidor, genera claves y comprueba propiedad al leer/escribir. Aísla contenido activo subido respecto del origen autenticado.
- **Secretos y logs:** usa los mecanismos del entorno; evita secretos en código, bundles, respuestas o logs. No abras almacenes privados de credenciales para realizar esta comprobación.
- **Webhooks:** usa el método oficial de verificación y la representación de cuerpo que requiera; considera replay e idempotencia. Aplica límites a endpoints caros y de autenticación.
- **Estado compartido:** usa operaciones atómicas o transacciones para dinero, stock y consumo de tokens de un solo uso.

Verifica el caso de abuso relevante cuando el cambio lo justifique, además del flujo válido. Si aparece un problema ajeno al alcance, informa con ubicación sin convertir la tarea en una auditoría completa. Resume los controles relevantes en una línea; no afirmes que todo el sistema es seguro.
