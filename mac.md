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
echo -e "Installing yabai(Tiling Windows)"
echo -e "======================================== \n"

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

cd .oh-my-zsh/themes 
git clone git@github.com:romkatv/powerlevel10k.git



mkdir $HOME/.jupyter/
cp config/jupyter_notebook_config.py    $HOME/.jupyter/ # yes
cp config/.bashrc                       $HOME/ # yes
cp config/.bash_eternal_history         $HOME/ # yes
cp config/.vimrc                        $HOME/ # yes
cp config/.gitconfig                    $HOME/ # yes

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


tiling windows using shortcut
https://www.youtube.com/watch?v=k94qImbFKWE&ab_channel=JoseanMartinez

---

# Shortcuts
## Terminator
![image](https://github.com/brunocampos01/home-sweet-home/assets/12896018/15352aa7-2047-47e7-a30e-9aa11a466e88)


## Chrome: Refresh Page
![image](https://github.com/brunocampos01/home-sweet-home/assets/12896018/13dd2fa7-a309-47ff-9df0-c8d85a21cd40)


