# CLAUDE.md

This file provides guidance to Claude Code (claude.ai/code) when working with code in this repository.

## Project Overview

Personal dotfiles and environment setup repository. Contains installation scripts, shell configurations, and editor configs for bootstrapping development environments across Linux/Debian, macOS, and Windows.

## Repository Structure

- **`initial_install.sh`** — Main Linux/Debian setup script (APT packages, Python, Docker, SDKMAN, dev tools, security)
- **`windows_install.ps1`** — Windows package installation via Chocolatey + winget
- **`powerline_in_powershell.ps1`** — PowerShell Starship prompt setup
- **`clone_all_repos_github.sh`** — Clones all user GitHub repos via API
- **`config/`** — Shell configs (.bashrc, .zshrc, .vimrc, .gitconfig, .pylintrc) and terminal themes
- **`mac/`** — macOS-specific configs (iTerm2, yabai window manager, skhd, lsd)
- **`old_scripts/`** — Archived/legacy setup scripts

## Running Scripts

```bash
# Linux
sudo chmod +x initial_install.sh && ./initial_install.sh

# Windows (PowerShell)
powershell -ExecutionPolicy Bypass -File .\windows_install.ps1
powershell -ExecutionPolicy Bypass -File .\powerline_in_powershell.ps1
```

## Code Style

Per `.editorconfig`: 4-space indentation, UTF-8, LF line endings, max 79 char lines, trailing whitespace trimmed, final newline required. HTML/JSON use 2-space indent.

## Platform Architecture

Each OS has an independent setup path — Linux uses APT + SDKMAN, macOS uses Homebrew (see `mac/README.md`), Windows uses Chocolatey/winget. Shell configs in `config/` target Linux; macOS equivalents live under `mac/`.
