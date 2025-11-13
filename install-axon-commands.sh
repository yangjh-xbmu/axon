#!/usr/bin/env bash
set -euo pipefail

NAMESPACE="axon"
TARGET="."
SOURCE=""
SOURCE_DIR=""
FORCE=0
ALL=0
FILES=""
QUIET=0
SHOW_HELP=0

while [[ $# -gt 0 ]]; do
  case "$1" in
    --target)
      TARGET="$2"
      shift 2
      ;;
    --namespace)
      NAMESPACE="$2"
      shift 2
      ;;
    --source)
      SOURCE="$2"
      shift 2
      ;;
    --source-dir)
      SOURCE_DIR="$2"
      shift 2
      ;;
    --all)
      ALL=1
      shift
      ;;
    --files)
      FILES="$2"
      shift 2
      ;;
    --force)
      FORCE=1
      shift
      ;;
    --quiet)
      QUIET=1
      shift
      ;;
    -h|--help)
      SHOW_HELP=1
      shift
      ;;
    *)
      echo "Unknown option: $1"
      exit 1
      ;;
  esac
done

if [[ $SHOW_HELP -eq 1 ]]; then
  echo "Usage: install-axon-commands.sh [options]"
  echo "  --target <dir>        Target project root (default .)"
  echo "  --namespace <name>    Commands sub-namespace (default axon)"
  echo "  --source <baseURL>    Remote base raw URL containing commands/"
  echo "  --source-dir <dir>    Local source repo root containing commands/"
  echo "  --all                 Copy entire commands directory (local mode)"
  echo "  --files <csv>         Comma-separated list relative to commands/"
  echo "  --force               Overwrite existing files"
  echo "  --quiet               Minimal output"
  echo "  -h, --help            Show help"
  exit 0
fi

TARGET_DIR="$TARGET/.claude/commands/$NAMESPACE"
mkdir -p "$TARGET_DIR"

installed=()

if [[ -n "$SOURCE_DIR" && $ALL -eq 1 ]]; then
  tar -C "$SOURCE_DIR/commands" -cf - . | tar -C "$TARGET_DIR" -xpf -
  mapfile -t installed < <(cd "$TARGET_DIR" && find . -type f -name "*.md" | sed 's/^\.\///')
else
  list=("init.md")
  if [[ -n "$FILES" ]]; then
    IFS=',' read -r -a list <<< "$FILES"
  fi
  for f in "${list[@]}"; do
    ddir="$TARGET_DIR/$(dirname "$f")"
    mkdir -p "$ddir"
    dest="$TARGET_DIR/$f"
    if [[ $FORCE -eq 0 && -f "$dest" ]]; then
      [[ $QUIET -eq 1 ]] || echo "Already exists: $dest"
      continue
    fi
    if [[ -n "$SOURCE_DIR" ]]; then
      src="$SOURCE_DIR/commands/$f"
      if [[ ! -f "$src" ]]; then
        echo "Missing source: $src"
        exit 1
      fi
      cp "$src" "$dest"
    else
      base="${SOURCE:-https://raw.githubusercontent.com/you/axon/main}"
      url="$base/commands/$f"
      curl -fsSL "$url" -o "$dest"
    fi
    if [[ ! -s "$dest" ]]; then
      echo "Install failed: $dest missing or empty"
      exit 1
    fi
    installed+=("$f")
    [[ $QUIET -eq 1 ]] || echo "Installed: $dest"
  done
fi

if [[ ${#installed[@]} -eq 0 ]]; then
  [[ $QUIET -eq 1 ]] || echo "Installed directory: $TARGET_DIR"
else
  [[ $QUIET -eq 1 ]] || echo "Installed files: ${installed[*]}"
fi

[[ $QUIET -eq 1 ]] || echo "Use in Claude Code: /init (scope project:$NAMESPACE)"
