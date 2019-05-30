
#!/bin/bash
# Autor: brunocampos01	
# Script install poweline-shell
# ----------------------------------- #

echo -e "Pre-requeriments (PIP) \n"
sudo su
apt install python-pip
apt install git
echo
echo -e "======================================== \n"


echo -e "Install powerline-shell ans status (PIP) \n"
pip install powerline-status powerline-shell
echo
echo -e "======================================== \n"

echo -e "fonts-powerline (APT) \n"
sudo apt-get install fonts-powerline
echo
echo -e "======================================== \n"

echo -e "Insert function in bashrc \n"
vim ~/.bashrc
echo
echo

# Bash powerline
function _update_ps1() {
   PS1=$(powerline-shell $?)
}

if [[ $TERM != linux && ! $PROMPT_COMMAND =~ _update_ps1 ]]; then
   PROMPT_COMMAND="_update_ps1; $PROMPT_COMMAND"
fi

# Enable Powerline on Bash Shell
powerline-daemon -q
POWERLINE_BASH_CONTINUATION=1
POWERLINE_BASH_SELECT=1
source /home/campos/.local/lib/python3.7/site-packages/powerline/bindings/bash/powerline.sh

echo
echo
echo -e "======================================== \n"


echo -e "Create file with default config \n"
mkdir -p ~/.config/powerline-shell && powerline-shell --generate-config > ~/.config/powerline-shell/config.json

echo
echo -e "======================================== \n"

echo -e "install fonts-powerline \n"
sudo apt install fonts-powerline
echo
echo -e "======================================== \n"


echo -e " Visit: \n"
echo
echo -e "https://github.com/b-ryan/powerline-shell#bash"
echo -e "https://powerline.readthedocs.io/en/latest/installation.html"





