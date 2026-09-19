# codex-skills

Skills personales para Codex, adaptadas de [Leksgg/claude-skills](https://github.com/Leksgg/claude-skills), revisión `facf55f5f764a631ad2c6cc588d19c21e1b768a5`. Se conserva la licencia MIT original.

| Skill | Para qué sirve | Activación |
| --- | --- | --- |
| `reuse-first` | Buscar y reutilizar código antes de añadir piezas nuevas. | Por contexto o `$reuse-first describe la tarea`. |
| `secure-coding` | Revisar la seguridad del código sensible que se modifica. | Por contexto o `$secure-coding`. |
| `security-audit` | Auditar un repo, una ruta o los cambios de una rama, con hallazgos verificables. | Explícita: `$security-audit`, `$security-audit diff main`, `$security-audit src/api`. |
| `caveman` | Responder con brevedad sin reducir la calidad del trabajo. | Al pedir respuestas breves o `$caveman lite`, `$caveman full`, `$caveman ultra`; `$caveman off` desactiva. |

`reuse-first` mejora la mantenibilidad; no promete acelerar la ejecución. `caveman` reduce el texto de las respuestas, no garantiza menor consumo total de tokens.

## Instalar en Windows

Desde este repositorio:

```powershell
powershell -NoProfile -ExecutionPolicy Bypass -File .\scripts\install.ps1
```

Crea enlaces de directorio (junctions) en `%USERPROFILE%\.agents\skills`, ubicación de skills personales de Codex. No descarga nada ni modifica configuración, permisos o credenciales. Rechaza colisiones con instalaciones distintas. Los cambios del repo quedan accesibles mediante los enlaces; vuelve a ejecutar el instalador al añadir una skill.

Las skills deberían estar disponibles a partir del siguiente turno. Si no aparecen en el selector de skills, reinicia Codex. La selección automática depende de la tarea y de la descripción, no garantiza activación en cada modificación.

```powershell
# Ver lo que haría, sin cambios
.\scripts\install.ps1 -WhatIf
# Quitar únicamente los enlaces que apuntan a las skills de este repo
.\scripts\install.ps1 -Uninstall
# Destino alternativo para pruebas o instalación específica
.\scripts\install.ps1 -Destination 'C:\ruta\proyecto\.agents\skills'
```

La desinstalación no borra las skills originales. No muevas este repositorio mientras sus enlaces estén instalados.

En macOS/Linux, crea enlaces simbólicos de las carpetas de `skills/` dentro de `~/.agents/skills/`, sin reemplazar instalaciones existentes.

## Adaptación y validación

- Instrucciones en español y referencias por stack cargadas solo cuando proceden.
- `AGENTS.md` como guía del repositorio e invocaciones `$nombre` para Codex.
- Política de auditoría explícita en `skills/security-audit/agents/openai.yaml`; se conserva el modo manual de la original.
- Las autorizaciones ya dadas por el usuario se respetan; una auditoría por sí sola no autoriza cambios.
- Las evaluaciones del repo original ejecutan Claude y no se presentan como evaluaciones de Codex.

Prueba del instalador, en un destino aislado dentro de `.validation/`:

```powershell
powershell -NoProfile -ExecutionPolicy Bypass -File .\scripts\test-install.ps1
```

Valida cada carpeta con `quick_validate.py` de la skill de sistema `skill-creator` (requiere Python y PyYAML). Esa comprobación valida el formato, no la calidad de decisiones del modelo.

Documentación: [skills en Codex](https://developers.openai.com/es-419/docs/build-skills).
