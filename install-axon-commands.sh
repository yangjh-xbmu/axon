#!/usr/bin/env bash
set -euo pipefail

# Installer for Axon commands
# Clones the repo, and copies the commands to the target project.

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

# Define source and destination for commands
SOURCE_COMMANDS_DIR="$CLONE_DIR/axon/commands"
DEST_COMMANDS_DIR="$TARGET_DIR/.claude/commands/axon"

if [ ! -d "$SOURCE_COMMANDS_DIR" ]; then
    echo "Error: 'axon/commands' directory not found in the cloned repository."
    rm -rf "$CLONE_DIR"
    exit 1
fi

echo "Installing commands to $DEST_COMMANDS_DIR..."

# Create destination directory
mkdir -p "$DEST_COMMANDS_DIR"

# Copy commands, overwriting existing files
cp -rf "$SOURCE_COMMANDS_DIR/." "$DEST_COMMANDS_DIR/"

# Clean up the cloned repository
rm -rf "$CLONE_DIR"

echo ""
echo "Installation complete."
echo "Axon commands have been installed to $DEST_COMMANDS_DIR."
echo "You can now use commands like /init in this project."
