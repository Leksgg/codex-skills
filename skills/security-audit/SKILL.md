---
name: security-audit
description: Audita la seguridad de un repositorio, una ruta o los cambios de una rama cuando el usuario lo pide. Verifica origen, recorrido e impacto de cada vulnerabilidad y presenta hallazgos priorizados y correcciones propuestas. Soporta Node/TS, MongoDB, Cloudflare y React/Next.
---

# Security audit

Audita código propio o autorizado y distingue vulnerabilidades verificadas de hipótesis. Invoca con `$security-audit`, `$security-audit diff main` o `$security-audit src/api`.

## Delimita y reconoce

- Sin argumento: repositorio completo, priorizando superficies expuestas y activos sensibles.
- `diff [base]`: cambios desde el ancestro común con la base, más cambios staged, unstaged y archivos nuevos pertinentes. Determina la rama base desde el repo; si no hay base válida, informa del límite sin inventar una comparación.
- Ruta: esa ruta y el contexto necesario para seguir los flujos.

Lee el `AGENTS.md` aplicable, manifiestos, rutas y configuración versionada. Identifica stack, entradas, autenticación, activos y fronteras de confianza. No ejecutes scripts del proyecto para reconocerlo. No abras archivos locales de credenciales ni vuelques variables de entorno. En código o historial versionado, muestra posibles secretos solo enmascarados.

Lee únicamente las referencias pertinentes:

- [Node y APIs](references/node-api.md): APIs Node/TS y procesos.
- [MongoDB](references/mongodb.md): consultas y modelos MongoDB/Mongoose.
- [Cloudflare](references/cloudflare.md): Workers, R2, KV, D1 y Durable Objects.
- [Frontend](references/frontend.md): React, Next.js y límites cliente/servidor.

## Investiga y verifica

Prioriza autorización, autenticación, inyección, XSS, SSRF, secretos, archivos, caché, lógica de negocio y dependencias. Sigue el flujo real de cada candidato:

1. Qué entrada controla el atacante y qué acceso necesita.
2. Cómo llega esa entrada a la operación peligrosa y qué controles la interceptan.
3. Si la ruta está registrada y es alcanzable en el entorno evaluado.
4. Qué obtiene el atacante y cuál es el alcance demostrado.

Marca `Confirmada` si el recorrido queda demostrado y `Probable` si falta una condición concreta verificable. Descarta coincidencias de texto sin vía de ataque. No declares crítica una clave sin determinar su tipo, permisos y exposición; algunas claves son públicas por diseño.

Consulta fuentes oficiales para comportamiento dependiente de versiones. Una auditoría de dependencias como `npm audit --omit=dev` hace una petición al registro y transmite información de dependencias: declara ese efecto y respeta restricciones de red. Un aviso de dependencia no demuestra por sí solo explotabilidad en la aplicación.

Limita pruebas a entornos locales autorizados. Si ejecutar una prueba exige red, procesos, datos o permisos fuera del alcance concedido, presenta el razonamiento y lo que falta sin lanzar la prueba.

## Entrega

Presenta en el chat superficie revisada y hallazgos ordenados por impacto y explotabilidad. Cada hallazgo debe contener:

- Identificador, gravedad y título concreto.
- Archivo y línea.
- Ruta de ataque, controles ausentes e impacto.
- Confianza y condiciones pendientes, si las hay.
- Corrección mínima propuesta.

Separa lo revisado sin hallazgos de lo no revisado. Ajusta la gravedad al acceso requerido, impacto y alcance; una recomendación de endurecimiento no equivale a una vulnerabilidad explotable. No guardes un informe sensible en el repo salvo petición expresa.

## Correcciones

Una petición de auditoría por sí sola autoriza revisión y propuestas. Si el usuario ya pidió corregir los hallazgos, aplica los cambios dentro de ese alcance sin volver a pedir el mismo permiso. Si solo pidió auditar, termina con propuestas identificables para que pueda elegir.

Comprueba cada corrección con un caso que reproduzca el fallo cuando sea viable. Indica las acciones externas pendientes, como rotar un secreto; eliminarlo del código no lo invalida.
