#!/usr/bin/env bash
set -euo pipefail

# ----------------------------------- #
# macOS Development Environment Setup
# ----------------------------------- #

print_section() {
  echo
  echo "========================================"
  echo "$1"
  echo "========================================"
  echo
}

# Resolve repo root so the script works no matter where it's executed from
SCRIPT_DIR="$(cd -- "$(dirname -- "${BASH_SOURCE[0]}")" &>/dev/null && pwd)"
REPO_ROOT="$(cd -- "$SCRIPT_DIR/.." &>/dev/null && pwd)"

copy_file() {
  local src="$1"
  local dst="$2"
  if [[ -f "$src" ]]; then
    mkdir -p "$(dirname "$dst")"
    cp -fv "$src" "$dst"
  else
    echo "Warning: missing file '$src' (skipping)"
  fi
}

copy_into_dir() {
  local src="$1"
  local dst_dir="$2"
  if [[ -f "$src" ]]; then
    mkdir -p "$dst_dir"
    cp -fv "$src" "$dst_dir/"
  else
    echo "Warning: missing file '$src' (skipping)"
  fi
}

brew_install_formula() {
  local token="$1"
  local name="${token##*/}" # handles taps like koekeishiya/formulae/skhd -> skhd
  if brew list --formula "$name" &>/dev/null; then
    echo "Already installed (formula): $token"
  else
    brew install "$token" || echo "Warning: failed to install $token, continuing..."
  fi
}

brew_install_cask() {
  local cask="$1"

  # Special case: google-chrome often exists already (manual install) and Homebrew errors.
  if [[ "$cask" == "google-chrome" ]]; then
    if brew list --cask google-chrome &>/dev/null; then
      echo "Already installed (cask): google-chrome"
      return 0
    fi
    if [[ -d "/Applications/Google Chrome.app" ]]; then
      echo "Google Chrome.app already exists in /Applications; skipping Homebrew cask install."
      return 0
    fi
  fi

  if brew list --cask "$cask" &>/dev/null; then
    echo "Already installed (cask): $cask"
  else
    brew install --cask "$cask" || echo "Warning: failed to install $cask, continuing..."
  fi
}

brew_apps=(
  # Shell & terminal
  zsh
  zsh-syntax-highlighting
  zsh-autosuggestions

  # CLI tools
  git
  git-lfs
  wget
  curl
  jq
  tree
  htop
  ncdu
  trash-cli
  vim
  lsd
  ccat
  speedtest-cli
  lynis
  node

  # Window management (yabai is optional; keep commented if you don't want it)
  # koekeishiya/formulae/yabai
  koekeishiya/formulae/skhd

  alt-tab
  cmatrix
  blackhole-2ch # virtual driver audio, useful to rec internal audio
  keepingyouawake # prevent your Mac from entering sleep mode
  stats # system monitor in your menu bar
  slack

)

brew_cask_apps=(
  # Browsers
  google-chrome

  # Terminals
  hyper

  # Editors & IDEs
  visual-studio-code
  pycharm-ce
  cursor

  # Dev tools
  postman
  dbeaver-community
  shottr # screenshot tool

  # Productivity
  spotify
  vlc

  # Fonts (required for Powerlevel10k)
  font-meslo-lg-nerd-font
)

vscode_extensions=(
  ms-python.python
  PKief.material-icon-theme
  garytyler.darcula-pycharm
  AykutSarac.jsoncrack-vscode
)

# -------------------------------------------- #

print_section "Checking prerequisites"
if ! command -v brew &>/dev/null; then
  echo "Homebrew not found. Installing..."
  /bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"
  # Add Homebrew to PATH for Apple Silicon
  if [[ -f "/opt/homebrew/bin/brew" ]]; then
    eval "$(/opt/homebrew/bin/brew shellenv)"
  fi
fi
brew --version

print_section "Tapping required repositories"
brew tap koekeishiya/formulae >/dev/null 2>&1 || true
brew tap homebrew/cask-fonts >/dev/null 2>&1 || true

print_section "Updating Homebrew"
brew update && brew upgrade

print_section "Installing Homebrew formulae"
for app in "${brew_apps[@]}"; do
  brew_install_formula "$app"
done

print_section "Installing Homebrew cask apps"
for app in "${brew_cask_apps[@]}"; do
  brew_install_cask "$app"
done

print_section "Installing Python packages"
if command -v python3 &>/dev/null; then
  python3 -m pip install -U setuptools wheel pip-tools || echo "Warning: pip install failed, continuing..."
else
  echo "python3 not found — skipping Python packages."
fi

print_section "Installing Oh My Zsh"
if [[ ! -d "$HOME/.oh-my-zsh" ]]; then
  sh -c "$(curl -fsSL https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/tools/install.sh)" "" --unattended
else
  echo "Oh My Zsh already installed, skipping."
fi

print_section "Installing Powerlevel10k theme"
if [[ ! -d "${ZSH_CUSTOM:-$HOME/.oh-my-zsh/custom}/themes/powerlevel10k" ]]; then
  git clone --depth=1 https://github.com/romkatv/powerlevel10k.git \
    "${ZSH_CUSTOM:-$HOME/.oh-my-zsh/custom}/themes/powerlevel10k"
else
  echo "Powerlevel10k already installed, skipping."
fi

print_section "Installing zsh-autosuggestions plugin"
if [[ ! -d "${ZSH_CUSTOM:-$HOME/.oh-my-zsh/custom}/plugins/zsh-autosuggestions" ]]; then
  git clone https://github.com/zsh-users/zsh-autosuggestions \
    "${ZSH_CUSTOM:-$HOME/.oh-my-zsh/custom}/plugins/zsh-autosuggestions"
else
  echo "zsh-autosuggestions already installed, skipping."
fi

print_section "Deploying configuration files"
# Shell
copy_file "$REPO_ROOT/mac/config/.zshrc"                   "$HOME/.zshrc"
copy_file "$REPO_ROOT/linux/config/.shell_aliases"         "$HOME/.shell_aliases"
copy_file "$REPO_ROOT/linux/config/.vimrc"                 "$HOME/.vimrc"
copy_file "$REPO_ROOT/linux/config/.gitconfig"             "$HOME/.gitconfig"

# Zsh eternal history
if [[ ! -f "$HOME/.zsh_eternal_history" ]]; then
  touch "$HOME/.zsh_eternal_history"
fi

# Tool configs
mkdir -p "$HOME/.config/skhd"
mkdir -p "$HOME/.config/lsd"
mkdir -p "$HOME/.config/htop"
mkdir -p "$HOME/.config/jgit"
mkdir -p "$HOME/.jupyter"

copy_file "$REPO_ROOT/mac/config/skhd/skhdrc"              "$HOME/.config/skhd/skhdrc"
copy_file "$REPO_ROOT/mac/config/lsd/config.yaml"          "$HOME/.config/lsd/config.yaml"
copy_file "$REPO_ROOT/mac/config/htop/htoprc"              "$HOME/.config/htop/htoprc"
copy_file "$REPO_ROOT/mac/config/jgit/config"              "$HOME/.config/jgit/config"
copy_file "$REPO_ROOT/linux/config/jupyter_notebook_config.py" "$HOME/.jupyter/jupyter_notebook_config.py"

# Custom Zsh theme
mkdir -p "${ZSH_CUSTOM:-$HOME/.oh-my-zsh/custom}/themes"
copy_into_dir "$REPO_ROOT/mac/config/terminal/my_theme.zsh-theme" \
  "${ZSH_CUSTOM:-$HOME/.oh-my-zsh/custom}/themes"

print_section "Installing Vim extensions (Vundle)"
if [[ ! -d "$HOME/.vim/bundle/Vundle.vim" ]]; then
  git clone https://github.com/gmarik/Vundle.vim.git "$HOME/.vim/bundle/Vundle.vim"
fi
if command -v vim &>/dev/null; then
  vim +PluginInstall +qall || echo "Warning: Vim PluginInstall failed, continuing..."
else
  echo "vim not found — skipping PluginInstall."
fi

print_section "Installing VSCode extensions"
# Ensure `code` is available (VS Code CLI)
if ! command -v code &>/dev/null; then
  if [[ -x "/Applications/Visual Studio Code.app/Contents/Resources/app/bin/code" ]]; then
    export PATH="/Applications/Visual Studio Code.app/Contents/Resources/app/bin:$PATH"
  fi
fi

if command -v code &>/dev/null; then
  for ext in "${vscode_extensions[@]}"; do
    code --install-extension "$ext" || echo "Warning: failed to install VSCode extension $ext, continuing..."
  done
  code --list-extensions || true
else
  echo "VS Code CLI ('code') not found — skipping extension installs."
fi

print_section "Installing Claude Code (via npm)"
if command -v npm &>/dev/null; then
  npm install -g @anthropic-ai/claude-code || echo "Warning: npm install failed, continuing..."
else
  echo "npm not found — Node.js may not be installed correctly. Try: brew install node"
fi

print_section "Generating SSH keys"
mkdir -p "$HOME/.ssh"

# Prefer ed25519 if no keys exist yet; otherwise keep existing keys.
if [[ ! -f "$HOME/.ssh/id_ed25519" && ! -f "$HOME/.ssh/id_rsa" ]]; then
  ssh-keygen -t ed25519 -N "" -f "$HOME/.ssh/id_ed25519"
fi

if [[ -f "$HOME/.ssh/id_ed25519.pub" ]]; then
  cat "$HOME/.ssh/id_ed25519.pub"
elif [[ -f "$HOME/.ssh/id_rsa.pub" ]]; then
  cat "$HOME/.ssh/id_rsa.pub"
else
  echo "No public SSH key found."
fi

print_section "Starting window manager services (skhd; yabai optional)"
if command -v skhd &>/dev/null; then
  brew services start skhd || true
else
  echo "skhd not found — skipping service start."
fi

# if command -v yabai &>/dev/null; then
#   yabai --start-service || brew services start yabai || true
# else
#   echo "yabai not installed — skipping yabai service start."
# fi

print_section "Security audit (lynis)"
# Running Lynis with sudo can trigger Homebrew 'root not supported' checks inside Lynis.
# Run without sudo by default to avoid interactive prompts and root-related brew errors.
if command -v lynis &>/dev/null; then
  lynis audit system || echo "Warning: Lynis audit returned non-zero status; check logs for details."
else
  echo "lynis not found — skipping security audit."
fi

print_section "Set SSH GitHub"
echo "Open: https://github.com/settings/ssh/new"
echo "Title: $(hostname)"
if [[ -f "$HOME/.ssh/id_ed25519.pub" ]]; then
  echo -e "Key:\n$(cat "$HOME/.ssh/id_ed25519.pub")"
elif [[ -f "$HOME/.ssh/id_rsa.pub" ]]; then
  echo -e "Key:\n$(cat "$HOME/.ssh/id_rsa.pub")"
fi

print_section "Homebrew cleanup"
brew cleanup || true

print_section "Done"
echo "Restart your terminal or run: source ~/.zshrc"
echo "Then run: p10k configure"
