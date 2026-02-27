# macOS Setup

Automated setup for macOS using Homebrew.

# MacOS
```
sudo chmod +x mac/initial_install.sh
./mac/initial_install.sh
```

## Predefined Configs
```
echo -e "======================================== \n"
echo -e "Downloading predefined configurations"
echo -e "======================================== \n"

mkdir $HOME/.jupyter/
cp config/jupyter_notebook_config.py    $HOME/.jupyter/ # yes
cp config/.vimrc                        $HOME/ # yes
cp config/.gitconfig                    $HOME/ # yes
cp -r .config/                          $HOME/ # yes

sleep 2
echo
echo -e "======================================== \n"
echo -e "Set up terminal"
echo -e "======================================== \n"
# doc: https://github.com/romkatv/powerlevel10k
cd .oh-my-zsh/themes
git clone git@github.com:romkatv/powerlevel10k.git
p10k configure

sleep 2
echo
```
---


The script will install Homebrew automatically if it isn't present.

## What It Installs

| Category | Tools |
|----------|-------|
| Shell | Zsh, Oh My Zsh, Powerlevel10k, zsh-syntax-highlighting, zsh-autosuggestions |
| Terminal | Hyper |
| Editors & IDEs | VSCode, PyCharm CE, IntelliJ CE, Cursor |
| CLI tools | lsd, ccat, htop, ncdu, jq, tree, wget, vim |
| Languages | Python 3 |
| Containers | Docker Desktop |
| Window management | yabai (tiling WM), skhd (hotkey daemon) |
| Dev tools | DBeaver, Postman, Claude Code |
| Fonts | MesloLGS NF (required for Powerlevel10k) |
| Productivity | Spotify, VLC, Chrome |

## Config Files Deployed

| Source | Destination | Purpose |
|--------|-------------|---------|
| [config/.zshrc](config/.zshrc) | `~/.zshrc` | Zsh (Oh My Zsh + Powerlevel10k) |
| `linux/config/.shell_aliases` | `~/.shell_aliases` | Shared aliases (bash + zsh) |
| [config/terminal/yabai/yabairc](config/terminal/yabai/yabairc) | `~/.config/yabai/yabairc` | Yabai tiling window manager |
| [config/skhd/skhdrc](config/skhd/skhdrc) | `~/.config/skhd/skhdrc` | skhd hotkey daemon |
| [config/lsd/config.yaml](config/lsd/config.yaml) | `~/.config/lsd/config.yaml` | lsd (ls replacement) |
| [config/htop/htoprc](config/htop/htoprc) | `~/.config/htop/htoprc` | htop configuration |
| [config/jgit/config](config/jgit/config) | `~/.config/jgit/config` | JGit settings |
| [config/terminal/my_theme.zsh-theme](config/terminal/my_theme.zsh-theme) | `~/.oh-my-zsh/custom/themes/` | Custom Zsh theme |
| `linux/config/.gitconfig` | `~/.gitconfig` | Git user settings |
| `linux/config/.vimrc` | `~/.vimrc` | Vim configuration |
| `linux/config/jupyter_notebook_config.py` | `~/.jupyter/` | Jupyter settings |

## Post-Install

```bash
# Finalize Powerlevel10k prompt
p10k configure

# Restart shell
source ~/.zshrc
```
