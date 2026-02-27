#!/usr/bin/env bash
set -euo pipefail

# Configuration
USERNAME="brunocampos01"  # GitHub username
DEST_DIR="/home/$USER/projects"

# Make sure the destination directory exists
mkdir -p "$DEST_DIR"
cd "$DEST_DIR" || exit

# Fetch all repo SSH clone URLs across all pages
LIST_REPOS=""
page=1
while true; do
  response=$(curl -sf -H "Accept: application/vnd.github+json" \
    "https://api.github.com/users/$USERNAME/repos?per_page=100&page=${page}") || {
    echo "ERROR: GitHub API request failed (page ${page}). Check your network and rate limits." >&2
    exit 1
  }
  page_repos=$(echo "$response" | grep -o 'git@[^"]*\.git' || true)
  [[ -z "$page_repos" ]] && break
  LIST_REPOS="${LIST_REPOS}${page_repos}"$'\n'
  (( page++ ))
done

echo "List of repositories to download:"
echo "$LIST_REPOS"
echo ""

# Clone each repo (mapfile avoids subshell so variables persist)
mapfile -t repos <<< "$LIST_REPOS"
for repo in "${repos[@]}"; do
  [[ -z "$repo" ]] && continue
  repo_name=$(basename "$repo" .git)
  if [ -d "$repo_name" ]; then
    echo "Skipping existing repo: $repo_name"
  else
    echo "Cloning $repo ..."
    git clone "$repo"
    echo "-----------------"
  fi
done
