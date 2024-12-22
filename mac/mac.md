# MacOS
```
xcode-select --install

echo -e "======================================== \n"
echo -e "Instaling Brew"
echo -e "======================================== \n"

/bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"

sleep 2
echo
echo -e "======================================== \n"
echo -e "Instaling Iterm2"
echo -e "======================================== \n"

brew install --cask iterm2

sleep 2
echo
echo -e "======================================== \n"
echo -e "Installing Alt+Tab"
echo -e "======================================== \n"

brew install --cask alt-tab

sleep 2
echo
echo -e "======================================== \n"
echo -e "Installing Chrome"
echo -e "======================================== \n"

brew install --cask google-chrome

sleep 2
echo
echo -e "======================================== \n"
echo -e "Installing Java"
echo -e "======================================== \n"

brew install openjdk@8
brew install --cask anaconda

sleep 2
echo
echo -e "======================================== \n"
echo -e "Installing complements"
echo -e "======================================== \n"

brew install trash
brew install ncdu
brew install htop
brew install jq
brew install cmatrix
brew install blackhole-2ch # virtual driver audio, useful to rec internal audio
brew install --cask keepingyouawake # prevent your Mac from entering sleep mode
brew install --cask stats # system monitor in your menu bar


brew install --cask postman
brew install --cask pycharm-ce
brew install --cask visual-studio-code

sleep 2
echo
echo -e "======================================== \n"
echo -e "Installing yabai(Tiling Windows)"
echo -e "======================================== \n"

brew install --cask rectangle # good substitute for yabai
brew install koekeishiya/formulae/yabai
yabai --start-service
yabai --restart-service

sleep 2
echo
echo -e "======================================== \n"
echo -e "zsh-autosuggestions"
echo -e "======================================== \n"

git clone https://github.com/zsh-users/zsh-autosuggestions ${ZSH_CUSTOM:-~/.oh-my-zsh/custom}/plugins/zsh-autosuggestions

sleep 2
echo
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
cp .config/                             $HOME/ # yes

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

### Flameshot
- ctrl + shit + x
- [DMG](https://flameshot.org/docs/installation/installation-osx/)


---

# Set up
## .local/bin in $PATH
```
mkdir -p $HOME/.local/bin
set -Ua fish_user_paths $HOME/.local/bin

# test
zsh -c "echo $PATH"
```

## SSH keys
```
mkdir -p $HOME/.local/bin
set -Ua fish_user_paths $HOME/.local/bin

# test
zsh -c "echo $PATH"
```


- tiling windows using shortcut
https://www.youtube.com/watch?v=k94qImbFKWE&ab_channel=JoseanMartinez

- rectangule
- hyper terminal
- pyenv
- Stats

---

# Shortcuts
## Terminator
![image](https://github.com/brunocampos01/home-sweet-home/assets/12896018/15352aa7-2047-47e7-a30e-9aa11a466e88)


## Chrome: Refresh Page
![image](https://github.com/brunocampos01/home-sweet-home/assets/12896018/13dd2fa7-a309-47ff-9df0-c8d85a21cd40)

## To Analyse
- https://github.com/FelixKratz/SketchyBar
- https://github.com/koekeishiya/yabai/wiki/Installing-yabai-(latest-release)
