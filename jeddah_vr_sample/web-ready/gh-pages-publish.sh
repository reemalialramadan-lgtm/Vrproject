#!/usr/bin/env bash
# Push the contents of this folder to the gh-pages branch.
# Steps: put your exported files here, then run this script.

REPO_ROOT="$(git rev-parse --show-toplevel 2>/dev/null || echo '.')"
FOLDER="$(pwd)"
BRANCH="gh-pages"
TMP_DIR=$(mktemp -d)

echo "Preparing to publish $FOLDER to $BRANCH"

git --work-tree="$TMP_DIR" init >/dev/null
cp -r "$FOLDER"/* "$TMP_DIR"/
cd "$TMP_DIR"

git add --all
git commit -m "Deploy web-ready build" || echo "No changes to commit"

# If repo exists and remote origin set, push
if git rev-parse --git-dir >/dev/null 2>&1; then
  git remote add origin "$(git config --get remote.origin.url)" 2>/dev/null || true
  echo "Pushing to remote $BRANCH (force)..."
  git push origin master:$BRANCH --force
else
  echo "No git remote found in repo. If you want to push to GitHub, ensure you run this from inside your project repo root."
fi

# cleanup
rm -rf "$TMP_DIR"

echo "Published to $BRANCH. Enable GitHub Pages to serve this branch in repo settings." 
