---
name: reuse-first
description: Busca código y dependencias existentes antes de añadir funciones, componentes, módulos o utilidades a un proyecto. Úsala al crear piezas reutilizables o cuando el usuario pida evitar duplicación, reutilizar o comprobar si algo ya existe. No requiere búsquedas amplias para cambios triviales.
---

# Reuse first

Antes de implementar una pieza nueva, busca si ya existe una solución con la misma responsabilidad y semántica.

## Busca de forma proporcionada

1. Identifica entradas, salidas y responsabilidad de la pieza; toma como punto de partida la tarea indicada tras `$reuse-first`, si la hay.
2. Consulta el `AGENTS.md` aplicable y el mapa del proyecto. Busca con `rg --files` y `rg` en código compartido y features similares, usando términos del dominio, sinónimos y primitivas que puedan estar envueltas en helpers.
3. Lee firmas, implementación relevante y llamadas de los candidatos. No deduzcas compatibilidad solo por el nombre.
4. Comprueba las dependencias instaladas y las APIs del lenguaje o framework compatibles con las versiones del proyecto. Evita añadir otra dependencia para algo ya resuelto.

Para un helper pequeño suelen bastar unas pocas búsquedas. Excluye dependencias descargadas, artefactos generados y salidas de compilación.

## Decide

- Reutiliza directamente cuando coincidan contrato, dominio y comportamiento.
- Si basta una extensión pequeña, revisa sus consumidores y conserva su comportamiento anterior.
- Extrae duplicación existente solo cuando forme parte del cambio solicitado.
- Si no hay un candidato adecuado, crea la pieza siguiendo las convenciones del repo.

No reutilices por parecido accidental: reglas iguales hoy pueden tener significados distintos. Descarta helpers obsoletos, código de tests, dependencias circulares o adaptaciones que necesiten demasiadas ramas. Respeta una petición explícita de implementación nueva.

Comprueba el comportamiento afectado con las verificaciones pertinentes del proyecto. No añadas tests que solo reproduzcan la implementación ni amplíes el alcance para limpiar todo el repo.

Incluye una línea útil en el resultado, por ejemplo: `Reutilizado: formatCurrency (src/lib/format.ts).` Si no había solución, indica brevemente qué buscaste y dónde creaste la nueva pieza.
