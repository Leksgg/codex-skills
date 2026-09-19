# codex-skills

Repositorio de skills personales para Codex. Cada carpeta `skills/<nombre>` contiene un `SKILL.md` con `name` y `description`. Mantén el nombre de carpeta y el frontmatter sincronizados.

- Escribe instrucciones en español, breves y ajustadas a la tarea. Usa `AGENTS.md` y `$nombre` en los ejemplos de Codex.
- Conserva `security-audit` con invocación explícita en `agents/openai.yaml`. Las demás skills se seleccionan por contexto.
- No añadas permisos, hooks, lecturas de credenciales o llamadas de red ocultas. Documenta las operaciones de red si forman parte de una skill.
- Mantén las referencias de seguridad concretas y evita atribuir una gravedad sin comprobar alcance, acceso e impacto.
- El instalador crea junctions y rechaza colisiones; la desinstalación elimina solo enlaces al destino exacto esperado, sin borrado recursivo.
- Al cambiar el instalador, ejecuta `scripts/test-install.ps1`. Al cambiar skills, valida su formato y revisa sus referencias. No presentes validación estructural como prueba de comportamiento del modelo.
- Mantén el origen y la licencia MIT. Añade nuevas skills a la tabla del README.
