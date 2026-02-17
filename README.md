# OpenHands Starter Repo Template

This is a repository template for use with [OpenHands SaaS](https://app.openhands.ai).
It configures the agent to always preserve its work via git branches, commits, and pushes.

## Quick Start

1. **Create a new repo** from this template (or fork it).
2. **Open a conversation** on OpenHands SaaS and select this repo.
3. The agent will follow the `repo.md` instructions to branch, commit, and push all work.

## File Overview

```
.openhands/
  skills/repo.md   # Agent instructions (always loaded into context)
```

## How It Works

### Agent Instructions (repo.md)

The `repo.md` file is automatically loaded into the agent's context at the start of every
conversation. It instructs the agent to:

- Create a new branch before making any changes.
- Commit after every meaningful change.
- Push after every commit.
- Never work on main/master directly.
- Report branch names when done.

## Customization

### Adding repo-specific instructions

If individual repos need their own agent instructions, add a `.openhands/skills/repo.md`
file inside each repo. The agent loads instructions from the selected conversation repo
automatically.
