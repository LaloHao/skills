# Personal skills

A personal collection of skills for Claude, in the [Agent Skills](https://docs.claude.com/en/docs/agents-and-tools/agent-skills/overview) format: one folder per skill, each with its own `SKILL.md`.

## Skills

| Skill | What it does |
|---|---|
| [`tutor`](skills/tutor/SKILL.md) | A 1:1 tutor for learning any topic in depth: diagnosis, concept map, active practice, HTML exams, slide decks, and spaced repetition. Replies in the language you write in. |

## Installation

### With `npx skills` (recommended)

The [`skills`](https://github.com/vercel-labs/skills) CLI installs skills straight from this GitHub repo into Claude Code and other agents (Cursor, OpenCode, …). Nothing is published to npm; `npx` just runs the CLI.

```bash
npx skills add lalohao/skills
```

Useful options:

| Option | What it does |
|---|---|
| `-s, --skill <name>` | Install only one skill, e.g. `--skill tutor` |
| `-g, --global` | Install for your user (all projects) instead of the current project |
| `-a, --agent <agent>` | Target a specific agent, e.g. `-a claude-code` |
| `-y` | Skip prompts |

For example, to install only the tutor, globally, for Claude Code:

```bash
npx skills add lalohao/skills --skill tutor -g -a claude-code
```

### Claude Code: as a plugin

The repo is also a plugin marketplace. Inside Claude Code:

```
/plugin marketplace add lalohao/skills
/plugin install personal-skills@personal-skills
```

### Claude Code: manually

Copy or symlink the skill folder into your personal skills directory (available in every project):

```bash
git clone https://github.com/lalohao/skills.git
ln -s "$PWD/skills/skills/tutor" ~/.claude/skills/tutor
```

Or, to enable it for a single project only, place it in that project's `.claude/skills/tutor/`.

### Claude apps (web, desktop, mobile)

1. Package the skills:
   ```bash
   ./scripts/package.sh
   ```
   This creates `dist/<skill>.zip` for every skill.
2. In Claude, go to **Settings → Capabilities → Skills** and upload `dist/tutor.zip`.
3. Make sure the skill is toggled on.

## Updating

Changes reach other machines once they're pushed to GitHub. How you pull them in depends on how you installed:

| Installed with | How to update |
|---|---|
| `npx skills` | `npx skills check` to see what's new, `npx skills update` to install it. The CLI copies files, so it never updates on its own. |
| Claude Code plugin | `/plugin marketplace update personal-skills`, then restart Claude Code. |
| `git clone` + symlink | `git -C <path-to-clone> pull`. The symlink picks up the change right away. |
| Claude apps | Re-run `./scripts/package.sh` and upload the new zip in **Settings → Capabilities → Skills**, replacing the old one. Skills belong to your account, so every device gets the new version. |

On your own machines, `git clone` + symlink is the easiest to keep current. `npx skills` is better for sharing with other people.

## Usage: `tutor`

### Starting a session

Claude loads the skill automatically when you say you want to learn something. For example:

> I want to become an expert in Kubernetes networking in 4 weeks. I have about 1 hour a day.

> Quiero aprender a fondo PKI y certificados X.509.

In Claude Code you can also invoke it directly with `/tutor` (or `/personal-skills:tutor` if you installed it as a plugin).

The tutor replies in the language you write in and switches if you switch. Everything it creates (notebook, exams, slides, flashcards) uses that language too.

### What to expect

1. **Calibration:** it asks for your concrete goal, timeline, and background, then gives you a short diagnostic quiz. Say "I don't know" instead of guessing.
2. **Map and plan:** it builds a concept map (✅ mastered / 🟡 partial / ❌ missing), a prioritized session plan, and expert milestones, and saves them in a **study notebook** artifact.
3. **Teaching loop:** each session opens with review questions, then for each concept: you predict, it gives a short explanation, you work through examples, and you explain the concept back to it.
4. **Assessment:** quick quizzes per concept, HTML exams per module, and a final mastery exam.
5. **Closing:** you summarize the key ideas, it updates the notebook, and it offers Anki flashcards.

When you come back to a topic later, it finds the existing notebook and picks up where you left off.

### Commands

Type any of these during a session. The equivalent in your own language also works (for example, "pista" for **hint**).

| Command | What it does |
|---|---|
| `hint` | Next hint, without revealing the solution |
| `answer` | Full solution with reasoning |
| `deeper` | Go one level down (internals, specs, edge cases) |
| `quiz` | Quick check |
| `exam` | HTML exam for the current module |
| `simulator` | Interactive explorer for the current concept |
| `slides` | Summary or teach-back slide deck |
| `roleplay` | It plays a client, staff engineer, or interviewer and asks you hard questions |
| `lab` | Next hands-on lab |
| `status` | Updated concept map and what comes next |
| `anki` | CSV with all flashcards so far, ready to import into Anki |
| `wrap up` | Close the session |

### Requirements

The skill works in plain chat, but it does more when the session supports artifacts (notebook, HTML exams, simulators, slides), file sharing (Anki CSV), scheduled tasks (spaced review reminders), and web search (checking facts against official docs). If a feature isn't available, the tutor uses the next best option.

## Repository layout

```
skills/
  <skill-name>/
    SKILL.md        # frontmatter (name, description) + instructions
    ...             # optional scripts, templates, or references
scripts/
  package.sh        # packages each skill as a .zip for claude.ai
.claude-plugin/     # makes the repo installable as a Claude Code plugin
```

## Adding a new skill

1. Create `skills/<name>/SKILL.md` with `name` and `description` in the frontmatter. The `name` must match the folder name.
2. Add it to the table above.
3. Bump `version` in `.claude-plugin/plugin.json` so plugin installs detect the update.
4. Commit and push, and re-package it if you use it in the Claude apps.

The same goes for changes to an existing skill: bump the version, then commit and push.
