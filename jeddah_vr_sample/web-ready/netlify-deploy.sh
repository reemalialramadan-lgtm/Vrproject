#!/usr/bin/env bash
# Quick helper script to deploy the Godot HTML5 build folder to Netlify using netlify-cli.
# Usage: Place your exported HTML5 files in this folder and run:
#   chmod +x netlify-deploy.sh
#   ./netlify-deploy.sh

BUILD_DIR="$(pwd)"
if ! command -v netlify >/dev/null 2>&1; then
  echo "netlify CLI not found. Install with: npm i -g netlify-cli"
  exit 1
fi

read -p "Use interactive deploy or production? (i/p) " mode
if [ "$mode" = "p" ]; then
  echo "Deploying to production..."
  netlify deploy --prod --dir="$BUILD_DIR"
else
  echo "Deploying to draft (interactive)..."
  netlify deploy --dir="$BUILD_DIR"
fi

echo "Done. Check the Netlify URL output above."
