#!/usr/bin/env bash
set -euo pipefail

# Helper script to assist repository owners in safely removing large tracked files from git history.
# This script expects git-filter-repo to be installed. It runs on a mirror clone to avoid accidental
# local workspace corruption. It will prompt before running destructive operations.

ROOT_DIR="$(pwd)"

if ! command -v git-filter-repo >/dev/null 2>&1; then
  echo "git-filter-repo not found. Please install it first. See REWRITE_HISTORY_INSTRUCTIONS.md"
  exit 1
fi

echo "This script will help you create a mirror clone and run git-filter-repo to remove paths."
read -p "Enter the remote repo URL to mirror (or press Enter to use current origin): " REPO_URL
if [ -z "$REPO_URL" ]; then
  REPO_URL=$(git remote get-url origin)
fi

MIRROR_DIR="${PWD}/repo-mirror.git"
if [ -d "$MIRROR_DIR" ]; then
  read -p "Mirror dir exists ($MIRROR_DIR). Remove and recreate? [y/N] " yn
  case "$yn" in
    [Yy]*) rm -rf "$MIRROR_DIR" ;;
    *) echo "Aborting."; exit 1 ;;
  esac
fi

echo "Cloning mirror..."
git clone --mirror "$REPO_URL" "$MIRROR_DIR"
echo "Mirror cloned to $MIRROR_DIR"

echo "Create a file listing paths to remove. You can provide an absolute or relative path list file, or I'll help create one."
read -p "Do you want to (1) create paths-to-remove.txt interactively, (2) provide an existing file, or (3) abort? [1/2/3] " choice
case "$choice" in
  1)
    echo "Enter paths to remove (one per line). End with an empty line. Example: 'big_data/backup.zip' or 'vendor/huge.bundle'"
    TMPFILE="$(mktemp)"
    while true; do
      read -p "> " p
      [ -z "$p" ] && break
      echo "$p" >> "$TMPFILE"
    done
    PATHS_FILE="$TMPFILE"
    ;;
  2)
    read -p "Enter path to your existing paths-to-remove file: " provided
    if [ ! -f "$provided" ]; then
      echo "File not found: $provided"; exit 1
    fi
    PATHS_FILE="$provided"
    ;;
  *) echo "Aborting."; exit 1 ;;
esac

echo "Paths to remove (preview):"
cat "$PATHS_FILE" || true
read -p "Proceed to run git-filter-repo in mirror clone to remove these paths? This will rewrite history. [y/N] " go
if [[ ! "$go" =~ ^[Yy] ]]; then
  echo "Aborting."; exit 1
fi

cd "$MIRROR_DIR"
git filter-repo --invert-paths --paths-from-file "$PATHS_FILE"

echo "Filter complete in mirror. Verify results locally in $MIRROR_DIR. To push cleaned history, run:" 
echo "  cd $MIRROR_DIR"
echo "  git push --force --all"
echo "  git push --force --tags"

echo "When push is done, inform all contributors to reclone the repository."
