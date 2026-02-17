# Agent Instructions

## Git Workflow

Follow this git workflow for every task:

1. **Create a branch** before making changes:
   ```bash
   git checkout -b openhands/<short-description>
   ```

2. **Commit and push frequently** to preserve work:
   ```bash
   git add <specific-files>
   git commit -m "description of change"
   git push -u origin openhands/<branch-name>
   ```

3. **Report the branch name** when done.

### Rules

- Never work directly on `main` or `master`.
- Never use `git add .` — always add specific files.
- Never force push or amend pushed commits.
