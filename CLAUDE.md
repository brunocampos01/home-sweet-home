# CLAUDE.md

This file provides guidance to Claude Code (claude.ai/code) when working with code in this repository.

## Project Overview

Personal dotfiles and environment setup repository for bootstrapping development environments across Linux/Debian, macOS, and Windows.

## Running Scripts

```bash
# Linux — full environment setup
sudo chmod +x initial_install.sh && ./initial_install.sh

# Windows (PowerShell as Admin)
powershell -ExecutionPolicy Bypass -File .\windows_install.ps1
powershell -ExecutionPolicy Bypass -File .\powerline_in_powershell.ps1

# Post-install — clone all GitHub repos
# Linux:
sudo chmod +x clone_all_repos_github.sh && ./clone_all_repos_github.sh
# Windows (requires GitHub PAT set in $TOKEN inside script):
powershell -ExecutionPolicy Bypass -File .\clone_all_repos_github.ps1
```

## Code Style

Per `.editorconfig`: 4-space indentation (tabs for Makefiles and `.bat`), UTF-8, LF line endings, max 79 char lines, trailing whitespace trimmed, final newline required. HTML/JSON use 2-space indent.

## Platform Architecture

Each OS has a fully independent setup path — no shared logic between platforms:

- **Linux/Debian** (`initial_install.sh`): APT → Python → Vim/Vundle → Docker → SDKMAN (Java/Scala/Spark/Maven) → snap/flatpak apps → SSH keys → UFW firewall → lynis security audit → Oh My Bash. Ends by copying dotfiles from `config/` to `$HOME`.
- **macOS** (`mac/README.md`): Homebrew-based. Configs live under `mac/.config/` (yabai, skhd, lsd, iterm2). Uses zsh + powerlevel10k.
- **Windows** (`windows_install.ps1`): Chocolatey for most packages, winget for Claude Code and Slack. `powerline_in_powershell.ps1` installs Starship prompt with config at `~/.config/starship.toml`.

## Config Deployment Pattern

Install scripts copy dotfiles from `config/` into `$HOME` (Linux) or `mac/.config/` into `$HOME/.config/` (macOS). This repo is the source of truth — edit configs here, then re-run the relevant copy commands.
