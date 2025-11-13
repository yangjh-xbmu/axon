#!/usr/bin/env bash
set -euo pipefail

# Simplified installer for Axon commands
# Usage: curl ... | bash -s [namespace] [source_base_url]
# Default namespace: axon
# Default source: https://raw.githubusercontent.com/yangjh-xbmu/axon/main

NAMESPACE=${1:-axon}
SOURCE=${2:-https://raw.githubusercontent.com/yangjh-xbmu/axon/main}
TARGET_DIR="./.claude/commands/$NAMESPACE"

echo "Installing Axon commands to $TARGET_DIR..."

mkdir -p "$TARGET_DIR"

# List of commands to install
COMMANDS=("init.md")

for cmd_file in "${COMMANDS[@]}"; do
  url="$SOURCE/commands/$cmd_file"
  dest="$TARGET_DIR/$cmd_file"
  
  echo "Downloading $url to $dest"
  if ! curl -fsSL "$url" -o "$dest"; then
    echo "Error: Failed to download $url"
    exit 1
  fi
  
  if [[ ! -s "$dest" ]]; then
    echo "Error: Downloaded file $dest is empty. Please check the source URL."
    rm "$dest"
    exit 1
  fi
done

echo ""
echo "Installation complete."
echo "You can now use the /init command in this project (scope: project:$NAMESPACE)."
