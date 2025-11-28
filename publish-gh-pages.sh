#!/usr/bin/env bash
set -euo pipefail

# publish-gh-pages.sh
# Safely publish the contents of `jeddah_vr_sample/web-ready/` to the
# `gh-pages` branch on `origin`. Run this from the repository root.

ROOT_DIR="$(cd "$(dirname "$0")" && pwd)"
cd "$ROOT_DIR"

if ! git rev-parse --is-inside-work-tree >/dev/null 2>&1; then
  echo "Error: current directory is not inside a git repository."
  echo "Run this script from the repo root (e.g. inside Codespace or locally)."
  exit 1
fi

ORIGIN_URL=$(git remote get-url origin 2>/dev/null || true)
if [ -z "$ORIGIN_URL" ]; then
  echo "Error: no 'origin' remote found. Add a remote and try again."
  exit 1
fi

REPO_OWNER=$(basename "${ORIGIN_URL%.*}")
REPO_NAME=$(basename "${ORIGIN_URL%.*}")
if [[ "$ORIGIN_URL" =~ github.com[:/]+([^/]+)/([^/.]+) ]]; then
  REPO_OWNER=${BASH_REMATCH[1]}
  REPO_NAME=${BASH_REMATCH[2]}
fi

echo "About to publish 'jeddah_vr_sample/web-ready' to 'gh-pages' on origin."
read -r -p "Continue and overwrite remote gh-pages branch? [y/N] " confirm
if [[ "$confirm" != "y" && "$confirm" != "Y" ]]; then
  echo "Aborted by user."
  exit 0
fi

# Ensure source exists and copy to a safe temporary location before switching branches
if [ ! -d "jeddah_vr_sample/web-ready" ]; then
  echo "Error: source folder 'jeddah_vr_sample/web-ready' not found. Aborting."
  exit 1
fi

TMP_DIR=$(mktemp -d)
cp -a jeddah_vr_sample/web-ready "$TMP_DIR/web-ready"

# Create an orphan gh-pages branch and replace its contents with the web-ready site
git fetch origin
git checkout --orphan gh-pages
git reset --hard

# Remove tracked files (leave .git)
git rm -rf . >/dev/null 2>&1 || true

# Copy site files from the temporary safe copy
cp -a "$TMP_DIR/web-ready/." .

# Cleanup temporary files
rm -rf "$TMP_DIR"

git add --all
if git diff --staged --quiet; then
  echo "No changes to publish."
else
  git commit -m "Publish web-ready to gh-pages"
fi

git push origin gh-pages --force

echo "Pushed gh-pages to origin."
if [ -n "$REPO_OWNER" ] && [ -n "$REPO_NAME" ]; then
  echo "Your site should be available at: https://${REPO_OWNER}.github.io/${REPO_NAME}/"
fi
#!/usr/bin/env bash
set -euo pipefail

# publish-gh-pages.sh
# Safely publish the contents of `jeddah_vr_sample/web-ready/` to the
# `gh-pages` branch on `origin`. Run this from the repository root.

ROOT_DIR="$(cd "$(dirname "$0")" && pwd)"
cd "$ROOT_DIR"

if ! git rev-parse --is-inside-work-tree >/dev/null 2>&1; then
  echo "Error: current directory is not inside a git repository."
  echo "Run this script from the repo root (e.g. inside Codespace or locally)."
  exit 1
fi

ORIGIN_URL=$(git remote get-url origin 2>/dev/null || true)
if [ -z "$ORIGIN_URL" ]; then
  echo "Error: no 'origin' remote found. Add a remote and try again."
  exit 1
fi

REPO_OWNER=$(basename "${ORIGIN_URL%.*}")
REPO_NAME=$(basename "${ORIGIN_URL%.*}")
if [[ "$ORIGIN_URL" =~ github.com[:/]+([^/]+)/([^/.]+) ]]; then
  REPO_OWNER=${BASH_REMATCH[1]}
  REPO_NAME=${BASH_REMATCH[2]}
fi

echo "About to publish 'jeddah_vr_sample/web-ready' to 'gh-pages' on origin."
read -r -p "Continue and overwrite remote gh-pages branch? [y/N] " confirm
if [[ "$confirm" != "y" && "$confirm" != "Y" ]]; then
  echo "Aborted by user."
  exit 0
fi

# Create an orphan gh-pages branch and replace its contents with the web-ready site
git fetch origin
git checkout --orphan gh-pages
git reset --hard

# Remove tracked files (leave .git)
git rm -rf . >/dev/null 2>&1 || true

# Copy site files
cp -a jeddah_vr_sample/web-ready/. .

git add --all
if git diff --staged --quiet; then
  echo "No changes to publish."
else
  git commit -m "Publish web-ready to gh-pages"
fi

git push origin gh-pages --force

echo "Pushed gh-pages to origin."
if [ -n "$REPO_OWNER" ] && [ -n "$REPO_NAME" ]; then
  echo "Your site should be available at: https://${REPO_OWNER}.github.io/${REPO_NAME}/"
fi
