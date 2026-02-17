# Agent Instructions

**IMPORTANT: At the very start of every conversation, before doing anything else,
say exactly: "Hello! repo.md loaded successfully." This confirms these instructions
are active.**

You are working in a workspace managed by this orchestration repo.

## CRITICAL: Git Workflow — Never Lose Work

You MUST follow this git workflow for EVERY task. No exceptions.

### Before Making Any Changes

1. **Navigate into the correct repository directory** before running any git commands.

2. **Create a new branch** from the current branch BEFORE making any changes:
   ```bash
   git checkout -b openhands/<short-description>
   ```
   Use a descriptive branch name like `openhands/fix-login-bug` or `openhands/add-user-endpoint`.

3. **Verify you are on the new branch** before editing any files:
   ```bash
   git branch --show-current
   ```

### While Working

4. **Commit early and often.** After every meaningful change (a function written, a bug fixed,
   a test added), stage and commit:
   ```bash
   git add <specific-files>
   git commit -m "description of what changed and why"
   ```
   Do NOT wait until the end to commit. Small, frequent commits preserve your work.

5. **Push the branch after every commit** so the work is saved remotely:
   ```bash
   git push -u origin openhands/<branch-name>
   ```
   After the first push with `-u`, subsequent pushes can just use `git push`.

### When Done

6. **Final push**: Ensure all changes are committed and pushed:
   ```bash
   git status  # Verify clean working tree
   git push
   ```

7. **Report the branch name** to the user so they can review and merge.

### Rules

- NEVER work directly on `main` or `master`. Always create a branch.
- NEVER use `git add .` or `git add -A`. Always add specific files to avoid committing
  secrets, build artifacts, or unrelated files.
- NEVER force push (`git push --force`).
- NEVER amend commits that have already been pushed.
- If a push fails, retry up to 3 times before reporting the error.
- If you encounter merge conflicts, report them to the user rather than resolving blindly.

## Workspace Layout

The workspace is organized as follows:

```
<this-repo>/                    # Workspace root
  .openhands/                   # OpenHands configuration
    skills/repo.md              # This file (agent instructions)
```

## General Guidelines

- Read and understand existing code before making changes.
- Follow existing code style and conventions in each repository.
- Run any available linters or tests before pushing (check each repo for instructions).
- If a repo has its own `.openhands/skills/repo.md`, follow those repo-specific
  instructions in addition to these workspace-level instructions.
