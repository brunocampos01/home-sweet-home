# home-sweet-home
![License](https://img.shields.io/badge/Code%20License-MIT-blue.svg)

Personal dotfiles and automated development environment setup for Linux, macOS, and Windows.

---

## Structure

```
home-sweet-home/
├── linux/                        # Linux/Debian setup
│   ├── README.md
│   └── config/                   # Dotfiles deployed to $HOME
│       ├── .bashrc
│       ├── .shell_aliases        # Shared aliases (bash + zsh)
│       ├── .vimrc
│       ├── .gitconfig
│       ├── .conkyrc
│       ├── .pylintrc
│       ├── jupyter_notebook_config.py
│       ├── .databrickscfg.example
│       ├── .bash_eternal_history.example
│       └── terminal/
│           ├── terminator/       # Terminator layout
│           └── zork/             # Oh My Bash theme
├── mac/                          # macOS setup
│   ├── README.md
│   ├── initial_install.sh        # macOS bootstrap (Homebrew)
│   └── config/                   # Dotfiles deployed to $HOME
│       ├── .zshrc
│       ├── terminal/
│       │   ├── yabai/            # Yabai window manager
│       │   └── my_theme.zsh-theme
│       ├── skhd/                 # Hotkey daemon
│       ├── lsd/                  # ls replacement
│       ├── htop/
│       ├── jgit/
├── old_scripts/                  # Deprecated scripts (kept for reference)
├── linux/
│   ├── README.md
│   ├── initial_install.sh        # Linux/Debian bootstrap
│   ├── install_games_debian.sh   # Gaming setup for Debian
│   ├── clone_all_repos_github.sh # Clone all GitHub repos
│   └── config/                   # Dotfiles deployed to $HOME
│       ├── .bashrc
│       ├── .shell_aliases        # Shared aliases (bash + zsh)
│       ├── .zshrc
│       ├── .vimrc
│       ├── .gitconfig
│       ├── .conkyrc
│       ├── .pylintrc
│       ├── jupyter_notebook_config.py
│       ├── .databrickscfg.example
│       ├── .bash_eternal_history.example
│       └── terminal/
│           └── zork/             # Oh My Bash theme
└── windows/
    └── initial_install.ps1       # Windows bootstrap (Chocolatey + winget)
```

---

## Quick Start

### Linux / Debian

```bash
# 1. Get the repo
mkdir -p ~/projects && cd ~/projects
wget https://github.com/brunocampos01/home-sweet-home/archive/refs/heads/master.zip
unzip master.zip && cd home-sweet-home-master/

# 2. Run the installer
sudo chmod +x linux/initial_install.sh
./linux/initial_install.sh
```

### Windows

```powershell
# 1. Get the repo
mkdir projects; cd projects
Invoke-WebRequest -Uri https://github.com/brunocampos01/home-sweet-home/archive/refs/heads/master.zip -OutFile master.zip
Expand-Archive -Path master.zip -DestinationPath .; cd home-sweet-home-master

# 2. Run the installer
powershell -ExecutionPolicy Bypass -File .\windows\initial_install.ps1
```

### macOS

```bash
# 1. Get the repo
mkdir -p ~/projects && cd ~/projects
wget https://github.com/brunocampos01/home-sweet-home/archive/refs/heads/master.zip
unzip master.zip && cd home-sweet-home-master/

# 2. Run the installer
chmod +x mac/initial_install.sh
./mac/initial_install.sh
```

---

## Post-Install

```bash
# Set hostname
hostnamectl set-hostname <computer_name>

# Clone all GitHub repos
sudo chmod +x linux/clone_all_repos_github.sh
./linux/clone_all_repos_github.sh
```

---

## Platform Details

| Platform | Script | Details |
|----------|--------|---------|
| Linux/Debian | [linux/initial_install.sh](linux/initial_install.sh) | apt, snap, flatpak, Docker, VSCode, data stack |
| Windows | [windows/initial_install.ps1](windows/initial_install.ps1) | Chocolatey packages + winget (Claude Code, Cursor) |
| macOS | [mac/initial_install.sh](mac/initial_install.sh) | Homebrew: shell, IDEs, Docker, yabai, skhd, data stack |
| Gaming (Debian) | [linux/install_games_debian.sh](linux/install_games_debian.sh) | Steam, Lutris, Wine, Bottles |

---

<p align="left">
    <br/>
    <a href="mailto:brunocampos01@gmail.com" target="_blank"><img src="https://github.com/brunocampos01/brunocampos01/blob/main/images/email.png" width="30"></a>
    <a href="https://stackoverflow.com/users/8329698/bruno-campos" target="_blank"><img src="https://github.com/brunocampos01/brunocampos01/blob/main/images/stackoverflow.png" width="30"></a>
    <a href="https://www.linkedin.com/in/brunocampos01" target="_blank"><img src="https://github.com/brunocampos01/brunocampos01/blob/main/images/linkedin.png" width="30"></a>
    <a href="https://github.com/brunocampos01" target="_blank"><img src="https://github.com/brunocampos01/brunocampos01/blob/main/images/github.png" width="30"></a>
    <a href="https://medium.com/@brunocampos01" target="_blank"><img src="https://github.com/brunocampos01/brunocampos01/blob/main/images/medium.png" width="30"></a>
    <a rel="license" href="http://creativecommons.org/licenses/by-sa/4.0/"><img alt="Creative Commons License" style="border-width:0" src="https://i.creativecommons.org/l/by-sa/4.0/88x31.png" align="right"/></a>
    <br/>
</p>
