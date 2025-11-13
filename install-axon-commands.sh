#!/usr/bin/env bash
set -euo pipefail

# Installer for Axon commands and configurations
# Clones the repo, and copies the .claude directory contents to the target project.

# Default values
TARGET_DIR=${1:-.}
REPO_URL="https://github.com/yangjh-xbmu/axon.git"
CLONE_DIR="/tmp/axon-temp-install"

# --- Main Logic ---
echo "Cloning Axon repository from $REPO_URL..."

# Clean up previous clone if it exists
if [ -d "$CLONE_DIR" ]; then
  rm -rf "$CLONE_DIR"
fi

# Clone the repository
if ! git clone --depth 1 "$REPO_URL" "$CLONE_DIR"; then
  echo "Error: Failed to clone repository from $REPO_URL."
  exit 1
fi

# Define source and destination for .claude contents
SOURCE_DIR="$CLONE_DIR/.claude"
DEST_DIR="$TARGET_DIR/.claude"

if [ ! -d "$SOURCE_DIR" ]; then
    echo "Error: '.claude' directory not found in the cloned repository."
    rm -rf "$CLONE_DIR"
    exit 1
fi

echo "Syncing .claude directory to $DEST_DIR..."

# Create destination directory
mkdir -p "$DEST_DIR"

# Copy contents, overwriting existing files
cp -rf "$SOURCE_DIR/." "$DEST_DIR/"

# Clean up the cloned repository
rm -rf "$CLONE_DIR"

echo ""
echo "Installation complete."
echo "The .claude directory has been synced from the Axon repository."
