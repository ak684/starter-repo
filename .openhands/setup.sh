#!/bin/bash
# OpenHands Workspace Setup Script
# =================================
# This script runs automatically when an OpenHands conversation starts.
# It reads repos.conf and clones each listed repository into the workspace.

set -e

SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
WORKSPACE_DIR="$(dirname "$SCRIPT_DIR")"
REPOS_CONF="$SCRIPT_DIR/repos.conf"

echo "=== OpenHands Workspace Setup ==="
echo "Workspace: $WORKSPACE_DIR"

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

    echo "  [clone] $REPO -> $TARGET_DIR"
    if git clone "https://github.com/$REPO.git" "$TARGET_DIR" 2>/dev/null; then
        # Checkout specific branch if specified
        if [ -n "$BRANCH" ]; then
            echo "  [checkout] $REPO -> $BRANCH"
            cd "$TARGET_DIR" && git checkout "$BRANCH" && cd "$WORKSPACE_DIR"
        fi
        echo "  [done] $REPO"
    else
        echo "  [error] Failed to clone $REPO — check the repo name and permissions."
        echo "          If this is a private repo, ensure your git provider token has access."
    fi
done < "$REPOS_CONF"

echo "=== Setup Complete ==="
