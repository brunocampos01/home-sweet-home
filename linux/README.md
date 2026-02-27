# Linux Setup

Automated bootstrap for Debian/Ubuntu systems.

## Install

```bash
sudo chmod +x initial_install.sh
./initial_install.sh
```

## What It Installs

| Category | Tools |
|----------|-------|
| Shell | Oh My Bash, Zork theme |
| Terminal | Hyper |
| Editors | Vim (+ Vundle plugins), VSCode |
| Languages | Python 3 |
| Containers | Docker, Docker Compose (plugin) |
| Data | Databricks CLI |
| IDEs | PyCharm Community (Flatpak), IntelliJ Community |
| Tools | DBeaver, Postman, Stacer, Spotify |
| Package managers | apt, snap, flatpak, pip |

## Config Files

Deployed to `$HOME` by `initial_install.sh`:

| File | Purpose |
|------|---------|
| [config/.bashrc](config/.bashrc) | Bash shell configuration |
| [config/.shell_aliases](config/.shell_aliases) | Shared aliases (sourced by both bash and zsh) |
| [config/.vimrc](config/.vimrc) | Vim configuration |
| [config/.gitconfig](config/.gitconfig) | Git user settings |
| [config/.conkyrc](config/.conkyrc) | Conky system monitor layout |
| [config/.pylintrc](config/.pylintrc) | PyLint rules |
| [config/jupyter_notebook_config.py](config/jupyter_notebook_config.py) | Jupyter Notebook settings |
| [config/terminal/terminator/](config/terminal/terminator/) | Terminator terminal layout |
| [config/terminal/zork/](config/terminal/zork/) | Zork Oh My Bash theme |

> **Note:** `config/.databrickscfg` and `config/.bash_eternal_history` are gitignored.
> Use the `.example` files as templates.

> **Note:** `.conkyrc` network interface names (`wlp6s0`, `enp5s0f2`) are machine-specific.
> Run `ip link show` to find the correct names on a new system.
