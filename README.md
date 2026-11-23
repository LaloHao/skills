# Personal skills

A personal collection of skills for Claude, in the [Agent Skills](https://docs.claude.com/en/docs/agents-and-tools/agent-skills/overview) format: one folder per skill, each with its own `SKILL.md`.

## Skills

| Skill | What it does |
|---|---|
| [`expert-tutor`](skills/expert-tutor/SKILL.md) | A 1:1 tutor for learning any topic in depth: diagnosis, concept map, active practice, HTML exams, slide decks, and spaced repetition. Replies in the language you write in. |

## Installation

### Claude Code: as a plugin (recommended)

The repo is also a plugin marketplace. Inside Claude Code:

```
/plugin marketplace add <owner>/<repo>
/plugin install personal-skills@personal-skills
```

Replace `<owner>/<repo>` with the GitHub path of this repository (or a local path to your clone). To update later, run `/plugin marketplace update personal-skills`.

### Claude Code: manually

Copy or symlink the skill folder into your personal skills directory (available in every project):

```bash
git clone https://github.com/<owner>/<repo>.git
ln -s "$PWD/<repo>/skills/expert-tutor" ~/.claude/skills/expert-tutor
```

Or, to enable it for a single project only, place it in that project's `.claude/skills/expert-tutor/`.

### Claude apps (web, desktop, mobile)

1. Package the skills:
   ```bash
   ./scripts/package.sh
   ```
   This creates `dist/<skill>.zip` for every skill.
2. In Claude, go to **Settings → Capabilities → Skills** and upload `dist/expert-tutor.zip`.
3. Make sure the skill is toggled on.

## Usage: `expert-tutor`

### Starting a session

Claude loads the skill automatically when you say you want to learn something. For example:

> I want to become an expert in Kubernetes networking in 4 weeks. I have about 1 hour a day.

> Quiero aprender a fondo PKI y certificados X.509.

In Claude Code you can also invoke it directly with `/expert-tutor` (or `/personal-skills:expert-tutor` if you installed it as a plugin).

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
3. Commit, and re-package it if you use it in the Claude apps.
