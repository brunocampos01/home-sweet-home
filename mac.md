# MacOS
```
brew install --cask google-chrome

echo -e "======================================== \n"
echo -e "Instaling Brew"
echo -e "======================================== \n"

/bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"

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
```

## Predefined Configs
```
echo -e "======================================== \n"
echo -e "Downloading predefined configurations"
echo -e "======================================== \n"

mkdir $HOME/.config/terminator/
cp --force --verbose config/terminal/terminator/config    $HOME/.config/terminator/ # yes
cp --force --verbose config/terminal/mac/my_theme.zsh-theme   $HOME/.oh-my-zsh/themes/ # yes
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


---

# Shortcuts
## Terminator
![image](https://github.com/brunocampos01/home-sweet-home/assets/12896018/15352aa7-2047-47e7-a30e-9aa11a466e88)


## Chrome: Refresh Page
![image](https://github.com/brunocampos01/home-sweet-home/assets/12896018/13dd2fa7-a309-47ff-9df0-c8d85a21cd40)


