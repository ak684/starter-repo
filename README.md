# OpenHands Starter Repo Template

This is a repository template for use with [OpenHands SaaS](https://app.openhands.ai).
It configures the agent to always preserve its work via git branches, commits, and pushes.

## Quick Start

1. **Create a new repo** from this template (or fork it).
2. **Open a conversation** on OpenHands SaaS and select this repo.
3. The agent will follow the `AGENTS.md` instructions to branch, commit, and push all work.

## File Overview

```
AGENTS.md   # Agent instructions (always loaded into context)
```

## How It Works

### Agent Instructions (AGENTS.md)

The `AGENTS.md` file is automatically loaded into the agent's context at the start of every
conversation. It instructs the agent to:

- Create a new branch before making any changes.
- Commit after every meaningful change.
- Push after every commit.
- Never work on main/master directly.
- Report branch names when done.

## Customization

### Adding repo-specific instructions

If individual repos need their own agent instructions, add an `AGENTS.md` file at the root
of each repo. The agent loads instructions from the selected conversation repo automatically.
