#!/usr/bin/env bash
# import_export.sh — helper to import a local Godot HTML5 export into this repo's web-ready folder
# Usage:
#   chmod +x import_export.sh
#   ./import_export.sh /absolute/path/to/local/export/folder
# This script copies exported files into the web-ready folder and optionally triggers Netlify CLI deploy.

set -euo pipefail

SRC_DIR="$1"
DEST_DIR="$(cd "$(dirname "$0")" && pwd)"

if [ ! -d "$SRC_DIR" ]; then
  echo "Source directory does not exist: $SRC_DIR"
  exit 1
fi

echo "Copying files from $SRC_DIR to $DEST_DIR"
rsync -av --delete "$SRC_DIR/" "$DEST_DIR/"

echo "Files copied. Contents of $DEST_DIR:"
ls -la "$DEST_DIR"

read -p "Do you want to deploy to Netlify now? (y/N) " answer
if [[ "$answer" =~ ^[Yy]$ ]]; then
  if ! command -v netlify >/dev/null 2>&1; then
    echo "netlify CLI not found. Install with: npm i -g netlify-cli"
    exit 1
  fi
  cd "$DEST_DIR"
  netlify deploy --prod --dir=.
fi

echo "Done."