#!/bin/bash

# Configuration
USERNAME="brunocampos01"  # GitHub username
DEST_DIR="/home/$USER/projects"

# Make sure the destination directory exists
mkdir -p "$DEST_DIR"
cd "$DEST_DIR" || exit

# Get list of SSH clone URLs for all your repos using GitHub API
LIST_REPOS=$(curl -s -H "Accept: application/vnd.github+json" \
  "https://api.github.com/users/$USERNAME/repos?per_page=100&page=1" |
  grep -o 'git@[^"]*\.git')

echo "List of repositories to download:"
echo "$LIST_REPOS"
echo ""

# Clone each repo
echo "$LIST_REPOS" | while read -r repo; do
  repo_name=$(basename "$repo" .git)
  if [ -d "$repo_name" ]; then
    echo "Skipping existing repo: $repo_name"
  else
    echo "Cloning $repo ..."
    git clone "$repo"
  fi
done
