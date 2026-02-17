# OpenHands Starter Repo Template

This is an orchestration repository for use with [OpenHands SaaS](https://app.openhands.ai).
It configures the agent to always preserve its work via git branches, commits, and pushes,
and can automatically clone multiple project repositories into the workspace on startup.

## Quick Start

1. **Create a new repo** from this template (or fork it).
2. **Edit `.openhands/repos.conf`** — add the repositories you want cloned into the workspace.
3. **Open a conversation** on OpenHands SaaS and select this repo.
4. The agent will:
   - Run `setup.sh` to clone your listed repos.
   - Follow the `repo.md` instructions to branch, commit, and push all work.

## File Overview

```
.openhands/
  microagents/repo.md   # Agent instructions (always loaded into context)
  setup.sh              # Runs on workspace init; clones repos from repos.conf
  repos.conf            # List of repos to clone (one per line)
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

### Multi-Repo Setup (setup.sh + repos.conf)

OpenHands is single-repo-per-conversation. This template works around that by using
`setup.sh` to clone additional repos into the workspace at startup.

- `repos.conf` lists repos in `org/name` format, one per line.
- Optionally specify a branch: `org/name branch-name`
- `setup.sh` reads the config and clones each repo into the workspace root.

**Private repos**: The git clone uses the authentication token that OpenHands provides
for the connected git provider. If a repo fails to clone, check that the user's token
has access.

## Customization

### Adding repo-specific instructions

If individual repos need their own agent instructions, add a `.openhands/microagents/repo.md`
file inside each repo. The agent loads instructions from the selected conversation repo
(this orchestration repo) automatically. For sub-repos, you can reference their instructions
in the workspace-level `repo.md`, or instruct the agent to read them.

### Adding setup dependencies

Add any additional setup commands to `setup.sh`:

```bash
# Example: install a shared tool
pip install some-tool

# Example: run a setup script in a cloned repo
cd "$WORKSPACE_DIR/my-backend" && make setup
```

### Linting and pre-commit hooks

If your repos use pre-commit hooks, add the installation to `setup.sh`:

```bash
pip install pre-commit
cd "$WORKSPACE_DIR/my-repo" && pre-commit install
```
