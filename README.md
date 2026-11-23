# Skills de Lalo

Colección personal de skills para Claude (formato Agent Skills: una carpeta por skill con su `SKILL.md`).

## Skills

| Skill | Para qué |
|---|---|
| [`tutor-experto`](skills/tutor-experto/SKILL.md) | Aprender a fondo cualquier tema: diagnóstico, mapa de conceptos, práctica activa, exámenes HTML, presentaciones y repaso espaciado |

## Estructura

```
skills/
  <nombre-skill>/
    SKILL.md        # frontmatter (name, description) + instrucciones
    ...             # scripts, plantillas o referencias opcionales
scripts/
  package.sh        # empaqueta cada skill como .zip para subirla a claude.ai
.claude-plugin/     # permite instalar el repo como plugin en Claude Code
```

## Cómo usarlas

**Claude (web, desktop, móvil):**
1. `./scripts/package.sh` genera `dist/<skill>.zip`.
2. Sube el zip en Settings → Capabilities → Skills.

**Claude Code:**
- Como plugin: `/plugin marketplace add <owner>/<repo>` y luego `/plugin install lalo-skills@lalo-skills`.
- O copia/enlaza la carpeta: `ln -s "$PWD/skills/tutor-experto" ~/.claude/skills/tutor-experto`.

## Agregar una skill nueva

1. Crea `skills/<nombre>/SKILL.md` con `name` y `description` en el frontmatter. El `name` debe coincidir con el nombre de la carpeta.
2. Agrégala a la tabla de este README.
3. Commit, y vuelve a empaquetar si la usas en claude.ai.
