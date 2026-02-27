#!/usr/bin/env zsh
set -euo pipefail

# ==========================
# Configuration
# ==========================
USERNAME="brunocampos01"
: "${GITHUB_TOKEN:?GITHUB_TOKEN env var is required (export GITHUB_TOKEN=...)}"
TOKEN="$GITHUB_TOKEN"
DEST_DIR="$HOME/projects"

# Use SSH clone URLs (recommended). If you prefer HTTPS, set CLONE_FIELD="clone_url"
CLONE_FIELD="ssh_url"

# ==========================
# Prepare folder
# ==========================
mkdir -p "$DEST_DIR"
cd "$DEST_DIR"

# ==========================
# Helpers
# ==========================
api_get_all_pages() {
  # $1 = visibility (public|private)
  local visibility="$1"
  local page=1
  local all='[]'

  while true; do
    local url="https://api.github.com/user/repos?visibility=${visibility}&per_page=100&page=${page}"

    local resp
    resp="$(curl -sS \
      -H "Authorization: token ${TOKEN}" \
      -H "Accept: application/vnd.github+json" \
      "$url")"

    local count
    count="$(echo "$resp" | jq 'length')"

    if [[ "$count" -eq 0 ]]; then
      break
    fi

    all="$(jq -s '.[0] + .[1]' <(echo "$all") <(echo "$resp"))"
    page=$((page + 1))
  done

  echo "$all"
}

sync_repositories() {
  # $1 = JSON array of repos
  local repos_json="$1"

  echo "$repos_json" | jq -c '.[]' | while read -r repo; do
    local repo_name clone_url repo_path
    repo_name="$(echo "$repo" | jq -r '.name')"
    clone_url="$(echo "$repo" | jq -r ".${CLONE_FIELD}")"
    repo_path="${DEST_DIR}/${repo_name}"

    if [[ -d "$repo_path" ]]; then
      echo "Updating: $repo_name"
      cd "$repo_path"

      if [[ -d ".git" ]]; then
        git pull
      else
        echo "Folder exists but not a git repo. Skipping..."
      fi

      cd "$DEST_DIR"
    else
      echo "Cloning: $repo_name"
      git clone "$clone_url"
    fi

    echo "-----------------------------"
  done
}

# ==========================
# PART 1 — PUBLIC REPOS
# ==========================
echo ""
echo "===== Downloading PUBLIC repositories ====="

public_repos="$(api_get_all_pages "public")"
public_count="$(echo "$public_repos" | jq 'length')"
echo "Found ${public_count} public repos"
sync_repositories "$public_repos"

# ==========================
# PART 2 — PRIVATE REPOS
# ==========================
echo ""
echo "===== Downloading PRIVATE repositories ====="

private_repos="$(api_get_all_pages "private")"
private_count="$(echo "$private_repos" | jq 'length')"
echo "Found ${private_count} private repos"
sync_repositories "$private_repos"

echo ""
echo "Done ✅"
