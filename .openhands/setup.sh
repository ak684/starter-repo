#!/bin/bash
# OpenHands Workspace Setup Script
# =================================
# Clones repositories listed in repos.conf into the workspace.
# Automatically uses the git token from the origin remote URL for authentication.

set -e

SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
WORKSPACE_DIR="$(dirname "$SCRIPT_DIR")"
REPOS_CONF="$SCRIPT_DIR/repos.conf"

echo "=== OpenHands Workspace Setup ==="
echo "Workspace: $WORKSPACE_DIR"

# --- Extract git token from origin remote URL ---
# OpenHands injects a token into the origin URL like:
#   https://ghu_XXXXX@github.com/org/repo.git
# We extract it so we can clone other repos with the same token.
ORIGIN_URL=$(git -C "$WORKSPACE_DIR" remote get-url origin 2>/dev/null || true)
GIT_TOKEN=""
if [[ "$ORIGIN_URL" =~ https://([^@]+)@github\.com ]]; then
    GIT_TOKEN="${BASH_REMATCH[1]}"
    echo "Found git authentication token from origin remote."
fi

# --- Clone repositories from repos.conf ---
if [ ! -f "$REPOS_CONF" ]; then
    echo "No repos.conf found at $REPOS_CONF — skipping repo cloning."
    exit 0
fi

echo "Reading repositories from repos.conf..."

while IFS= read -r line || [ -n "$line" ]; do
    # Skip comments and blank lines
    line="$(echo "$line" | sed 's/#.*//' | xargs)"
    [ -z "$line" ] && continue

    # Parse: <org/repo> [branch]
    REPO=$(echo "$line" | awk '{print $1}')
    BRANCH=$(echo "$line" | awk '{print $2}')
    DIR_NAME=$(echo "$REPO" | awk -F'/' '{print $NF}')
    TARGET_DIR="$WORKSPACE_DIR/$DIR_NAME"

    if [ -d "$TARGET_DIR" ]; then
        echo "  [skip] $REPO — already exists at $TARGET_DIR"
        continue
    fi

    # Build clone URL with token if available
    if [ -n "$GIT_TOKEN" ]; then
        CLONE_URL="https://${GIT_TOKEN}@github.com/${REPO}.git"
    else
        CLONE_URL="https://github.com/${REPO}.git"
    fi

    echo "  [clone] $REPO -> $TARGET_DIR"
    if git clone "$CLONE_URL" "$TARGET_DIR" 2>/dev/null; then
        # Checkout specific branch if specified
        if [ -n "$BRANCH" ]; then
            echo "  [checkout] $REPO -> $BRANCH"
            (cd "$TARGET_DIR" && git checkout "$BRANCH")
        fi
        echo "  [done] $REPO"
    else
        echo "  [error] Failed to clone $REPO — check the repo name and permissions."
        echo "          If this is a private repo, ensure your git provider token has access."
    fi
done < "$REPOS_CONF"

echo "=== Setup Complete ==="
