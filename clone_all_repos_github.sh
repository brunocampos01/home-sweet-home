#!/bin/bash

# Configuration
USERNAME="brunocampos01"  # GitHub username
DEST_DIR="/home/$USER/projects"

# Make sure the destination directory exists
mkdir -p "$DEST_DIR"
cd "$DEST_DIR" || exit

# Use GITHUB_TOKEN env var for authenticated access if available
if [ -n "$GITHUB_TOKEN" ]; then
    AUTH_HEADER="Authorization: token $GITHUB_TOKEN"
    API_URL="https://api.github.com/user/repos?per_page=100"
    echo "Using authenticated API (includes private repos)"
else
    AUTH_HEADER=""
    API_URL="https://api.github.com/users/$USERNAME/repos?per_page=100"
    echo "Using public API (public repos only)"
fi

# Paginate through all repos
page=1
LIST_REPOS=""

while true; do
    if [ -n "$AUTH_HEADER" ]; then
        response=$(curl -s -w "\n%{http_code}" -H "Accept: application/vnd.github+json" \
            -H "$AUTH_HEADER" \
            "${API_URL}&page=${page}")
    else
        response=$(curl -s -w "\n%{http_code}" -H "Accept: application/vnd.github+json" \
            "${API_URL}&page=${page}")
    fi

    http_code=$(echo "$response" | tail -n1)
    body=$(echo "$response" | sed '$d')

    if [ "$http_code" -ne 200 ]; then
        echo "ERROR: GitHub API returned HTTP $http_code"
        echo "$body"
        exit 1
    fi

    repos=$(echo "$body" | grep -o 'git@[^"]*\.git')

    if [ -z "$repos" ]; then
        break
    fi

    LIST_REPOS="${LIST_REPOS}${repos}"$'\n'
    page=$((page + 1))
done

echo "List of repositories to download:"
echo "$LIST_REPOS"
echo ""

# Clone each repo
echo "$LIST_REPOS" | while read -r repo; do
    [ -z "$repo" ] && continue
    repo_name=$(basename "$repo" .git)
    if [ -d "$repo_name" ]; then
        echo "Skipping existing repo: $repo_name"
    else
        echo "Cloning $repo ..."
        git clone "$repo"
        echo "-----------------"
    fi
done
