# CLAUDE.md

This file provides guidance to Claude Code (claude.ai/code) when working with code in this repository.

## Purpose

This is a personal dotfiles and system bootstrap repository for automating Linux/macOS/Windows development environment setup. It installs applications, deploys configuration files (dotfiles), and configures shell environments. It is **not** a traditional software project — there are no build systems, test suites, or CI pipelines.

## Installation Commands

**Linux/Debian:**
```bash
sudo chmod +x linux/initial_install.sh
./linux/initial_install.sh
```

**macOS:**
```bash
chmod +x mac/initial_install.sh
./mac/initial_install.sh
```

**Windows:**
```powershell
powershell -ExecutionPolicy Bypass -File .\windows\initial_install.ps1
```

**Post-install:**
```bash
hostnamectl set-hostname <computer_name>
sudo chmod +x linux/clone_all_repos_github.sh
./linux/clone_all_repos_github.sh
```

**Gaming setup (optional, Debian):**
```bash
./linux/install_games_debian.sh
```

## Repository Structure

- [linux/initial_install.sh](linux/initial_install.sh) — Linux/Debian bootstrap: apt, snap, flatpak, Docker, VSCode, deploys `linux/config/` to `$HOME`.
- [linux/clone_all_repos_github.sh](linux/clone_all_repos_github.sh) — Clones all GitHub repos; paginates API to handle >100 repos.
- [linux/install_games_debian.sh](linux/install_games_debian.sh) — Gaming setup: Steam, Lutris, Wine, Bottles.
- [linux/config/](linux/config/) — Linux dotfiles deployed to `$HOME`: `.bashrc`, `.shell_aliases`, `.vimrc`, `.gitconfig`, `.conkyrc`, `.pylintrc`, `jupyter_notebook_config.py`.
- [linux/config/.shell_aliases](linux/config/.shell_aliases) — **Single source of truth for aliases**, sourced by both `.bashrc` and `.zshrc`. Put shared aliases here.
- [linux/config/terminal/](linux/config/terminal/) — Zork Oh My Bash theme.
- [mac/initial_install.sh](mac/initial_install.sh) — macOS bootstrap: Homebrew formulae + casks, Oh My Zsh, Powerlevel10k, yabai, skhd, deploys `mac/config/` to `$HOME`.
- [mac/config/](mac/config/) — macOS dotfiles: `.zshrc`, yabai, skhd, lsd, htop, jgit.
- [windows/initial_install.ps1](windows/initial_install.ps1) — Windows bootstrap: Chocolatey packages + winget (Claude Code, Cursor).
- [old_scripts/](old_scripts/) — Deprecated scripts, kept for reference only.

## Key Technology Installed

The `initial_install.sh` provisions:
- **Shell:** Oh My Bash, Zork theme
- **Languages:** Python 3
- **Data stack:** Databricks CLI
- **Dev tools:** Docker, Docker Compose, Git LFS, Vim, VSCode (via snap/flatpak)
- **Package managers used:** apt, snap, flatpak, pip

## Workflow Notes

- Linux config files live in `linux/config/` and are copied to `$HOME` by `linux/initial_install.sh`.
- macOS config files live in `mac/config/` and are deployed by `mac/initial_install.sh` (see [mac/README.md](mac/README.md)).
- `linux/config/.databrickscfg` and `linux/config/.bash_eternal_history` are **gitignored**. Use the `.example` files as templates.
- **Shared aliases go in `linux/config/.shell_aliases`**, not in `.bashrc` or `.zshrc` directly. Both rc files source it.
- `.conkyrc` network interface names (`wlp6s0`, `enp5s0f2`) are machine-specific — run `ip link show` to find the correct names on a new system.
- `old_scripts/` is intentionally kept; do not delete without verifying nothing references those scripts.
- There is no linter or formatter enforced on the shell scripts themselves.
