#!/usr/bin/env bash
set -euo pipefail

# ----------------------------------------------------------- #
# Obsidian setup (macOS)
#  1. clones the vault repo
#  2. installs Obsidian
#  3. installs every community plugin + theme the vault uses
#  4. registers the vault in Obsidian and opens it
#
# Plugin settings, theme choice, CSS snippets and core plugins
# live inside the vault repo (.obsidian/), so the clone brings
# the configuration; this script makes sure the code is there.
# ----------------------------------------------------------- #

VAULT_REPO="${VAULT_REPO:-brunocampos01/obsidian}"   # GitHub owner/repo of the vault
CLONE_DIR="${CLONE_DIR:-$HOME/projects/obsidian}"   # where the repo is cloned
VAULT_SUBDIR="${VAULT_SUBDIR:-obsidian}"            # vault folder inside the repo
VAULT_DIR="$CLONE_DIR/$VAULT_SUBDIR"
OBSIDIAN_CONFIG_DIR="$HOME/Library/Application Support/obsidian"

print_section() {
  echo
  echo "========================================"
  echo "$1"
  echo "========================================"
  echo
}

# ----------------------------------- #
print_section "1/5 Prerequisites (git, python3)"
# ----------------------------------- #
if ! xcode-select -p &>/dev/null; then
  echo "Installing Xcode Command Line Tools (git, python3)..."
  xcode-select --install || true
  echo "Finish the Command Line Tools installer, then run this script again."
  exit 1
fi
for cmd in git python3 curl; do
  command -v "$cmd" &>/dev/null || { echo "Missing '$cmd'"; exit 1; }
done
echo "OK"

# ----------------------------------- #
print_section "2/5 Clone vault repo ($VAULT_REPO)"
# ----------------------------------- #
if [[ -d "$CLONE_DIR/.git" ]]; then
  echo "Repo already at $CLONE_DIR, pulling latest..."
  git -C "$CLONE_DIR" pull --ff-only || echo "Warning: pull failed (local changes?), continuing with current checkout"
else
  mkdir -p "$(dirname "$CLONE_DIR")"
  if command -v gh &>/dev/null && gh auth status &>/dev/null; then
    gh repo clone "$VAULT_REPO" "$CLONE_DIR"
  elif git clone "git@github.com:$VAULT_REPO.git" "$CLONE_DIR" 2>/dev/null; then
    :
  else
    # private repo: git asks for user + personal access token (or uses the keychain)
    git clone "https://github.com/$VAULT_REPO.git" "$CLONE_DIR"
  fi
fi
[[ -d "$VAULT_DIR/.obsidian" ]] || { echo "Vault not found at $VAULT_DIR (check VAULT_SUBDIR)"; exit 1; }

# ----------------------------------- #
print_section "3/5 Install Obsidian"
# ----------------------------------- #
if [[ -d "/Applications/Obsidian.app" ]]; then
  echo "Already installed: /Applications/Obsidian.app"
elif command -v brew &>/dev/null; then
  brew install --cask obsidian
else
  DMG_URL="$(python3 - <<'EOF'
import json, urllib.request
req = urllib.request.Request("https://api.github.com/repos/obsidianmd/obsidian-releases/releases?per_page=10",
                             headers={"User-Agent": "obsidian-setup"})
for rel in json.load(urllib.request.urlopen(req, timeout=60)):
    if rel["prerelease"]:
        continue
    for a in rel["assets"]:
        if a["name"].endswith(".dmg"):
            print(a["browser_download_url"])
            raise SystemExit
EOF
)"
  [[ -n "$DMG_URL" ]] || { echo "Could not find the Obsidian .dmg"; exit 1; }
  TMP_DMG="$(mktemp -d)/Obsidian.dmg"
  echo "Downloading $DMG_URL"
  curl -fL --progress-bar -o "$TMP_DMG" "$DMG_URL"
  MOUNT_POINT="$(hdiutil attach -nobrowse -readonly "$TMP_DMG" | awk -F'\t' '/\/Volumes\//{print $NF}' | tail -1)"
  cp -R "$MOUNT_POINT/Obsidian.app" /Applications/
  hdiutil detach "$MOUNT_POINT" -quiet
  rm -f "$TMP_DMG"
fi

# ----------------------------------- #
print_section "4/5 Community plugins + theme"
# ----------------------------------- #
# Installs the latest release of every plugin listed in .obsidian/community-plugins.json
# (from the official Obsidian registry) when its code is missing. Existing data.json
# settings are never touched.
VAULT_DIR="$VAULT_DIR" python3 - <<'EOF'
import json, os, urllib.request

vault = os.environ["VAULT_DIR"]
cfg = os.path.join(vault, ".obsidian")
RAW = "https://raw.githubusercontent.com/obsidianmd/obsidian-releases/master"

def get(url):
    req = urllib.request.Request(url, headers={"User-Agent": "obsidian-setup"})
    return urllib.request.urlopen(req, timeout=120).read()

enabled_path = os.path.join(cfg, "community-plugins.json")
enabled = json.load(open(enabled_path)) if os.path.exists(enabled_path) else []
registry = {p["id"]: p["repo"] for p in json.loads(get(f"{RAW}/community-plugins.json"))}
for pid in enabled:
    pdir = os.path.join(cfg, "plugins", pid)
    if os.path.exists(os.path.join(pdir, "main.js")) and os.path.exists(os.path.join(pdir, "manifest.json")):
        print(f"ok (in repo)  {pid}")
        continue
    repo = registry.get(pid)
    if not repo:
        print(f"SKIP {pid}: not in the community registry")
        continue
    rel = json.loads(get(f"https://api.github.com/repos/{repo}/releases/latest"))
    os.makedirs(pdir, exist_ok=True)
    for a in rel["assets"]:
        if a["name"] in ("main.js", "manifest.json", "styles.css"):
            open(os.path.join(pdir, a["name"]), "wb").write(get(a["browser_download_url"]))
    print(f"installed     {pid} {rel['tag_name']}")

appearance_path = os.path.join(cfg, "appearance.json")
theme = json.load(open(appearance_path)).get("cssTheme") if os.path.exists(appearance_path) else None
if theme:
    tdir = os.path.join(cfg, "themes", theme)
    if os.path.exists(os.path.join(tdir, "theme.css")):
        print(f"ok (in repo)  theme {theme}")
    else:
        repo = next((t["repo"] for t in json.loads(get(f"{RAW}/community-css-themes.json")) if t["name"] == theme), None)
        if repo:
            os.makedirs(tdir, exist_ok=True)
            for f in ("theme.css", "manifest.json"):
                open(os.path.join(tdir, f), "wb").write(get(f"https://raw.githubusercontent.com/{repo}/HEAD/{f}"))
            print(f"installed     theme {theme}")
        else:
            print(f"SKIP theme {theme}: not in the community registry")
EOF

# ----------------------------------- #
print_section "5/5 Register vault and open Obsidian"
# ----------------------------------- #
# Obsidian rewrites obsidian.json on exit, so quit it before editing
osascript -e 'quit app "Obsidian"' &>/dev/null || true
sleep 2
mkdir -p "$OBSIDIAN_CONFIG_DIR"
VAULT_DIR="$VAULT_DIR" CONFIG_FILE="$OBSIDIAN_CONFIG_DIR/obsidian.json" python3 - <<'EOF'
import json, os, secrets, time

path, vault = os.environ["CONFIG_FILE"], os.path.realpath(os.environ["VAULT_DIR"])
cfg = json.load(open(path)) if os.path.exists(path) else {}
vaults = cfg.setdefault("vaults", {})
vid = next((k for k, v in vaults.items() if os.path.realpath(v.get("path", "")) == vault), None) or secrets.token_hex(8)
for v in vaults.values():
    v.pop("open", None)
vaults[vid] = {"path": vault, "ts": int(time.time() * 1000), "open": True}
json.dump(cfg, open(path, "w"))
print(f"vault registered: {vault}")
EOF

open -a Obsidian
echo
echo "Done. On first open Obsidian asks 'Do you trust the author of this vault?' -> click 'Trust author and enable plugins'."
