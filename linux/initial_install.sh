#!/usr/bin/env bash
set -euo pipefail
# ----------------------------------- #
# Linux/Debian Development Environment Setup
# ----------------------------------- #

print_section() {
    echo
    echo -e "======================================== \n"
    echo -e "$1"
    echo -e "======================================== \n"
}

deb_app=(
    vim
    tree
    git
    gitk
    git-lfs
    htop
    ncdu
    lame
    lynis
    jq
    gparted
    apt-transport-https
    ca-certificates
    wget
    p7zip-full
    rar
    unrar
    flameshot
    hddtemp # HDD temperature
    lm-sensors # CPU temperature
    psensor # graphic interface
    gnome-tweaks
    ubuntu-restricted-extras
    build-essential
    software-properties-common
    ufw
    speedtest-cli
    bleachbit
    libappindicator3-1 # audio lib
    folder-color
    trash-cli
    ffmpeg # anki
    mpv # anki
    libxcb-xinerama0 # anki
    libxcb-cursor0 # anki
    libnss3 # anki
    evince
    remmina
    vlc
    kolourpaint
    curl
    nmap
    qalculate-gtk
)

python_dep=(
    python3
    python3-dev
    python3-doc
    python3-venv
    python3-pip
)

snap_apps=(
    snap-store
    # bitwarden
    # youtube-dl
    # gydl
    # telegram-desktop
    # simplescreenrecorder
    # studio
)


to_remove=(
#     firefox
#     firefox-locale-ar
#     firefox-locale-de
#     firefox-locale-en
#     firefox-locale-es
#     firefox-locale-fr
#     firefox-locale-it
#     firefox-locale-ja
#     firefox-locale-pt
#     firefox-locale-ru
#     firefox-locale-zh-hans
#     firefox-locale-zh-hant
    geary
    libreoffice
    libreoffice-base-core
    libreoffice-common
    libreoffice-core
    libreoffice-help-common
    libreoffice-style-colibre
    libreoffice-style-tango
    gnome-screenshot
)

SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
mkdir -p tmp/
cd tmp/

print_section "Update and upgrade"
sudo apt update && sudo apt upgrade -y
sleep 2
print_section "Installing Debian apps"

for app in ${deb_app[@]}; do
    sudo apt install "$app" -y
done

for app in ${python_dep[@]}; do
    sudo apt install "$app" -y
done

sleep 2
print_section "Installing Python Packages"

python3 -m pip install -U setuptools\
						  wheel\
                          pip-tools

sleep 2
print_section "Installing Vim Extensions"

git clone https://github.com/gmarik/Vundle.vim.git ~/.vim/bundle/Vundle.vim
touch ~/.vimrc
ln ~/.vimrc ~/.vim/vimrc
vim +PluginInstall +qall

sleep 2
print_section "Installing Ctop"
sudo wget https://github.com/bcicen/ctop/releases/download/0.7.6/ctop-0.7.6-linux-amd64 -O /usr/local/bin/ctop
sudo chmod +x /usr/local/bin/ctop

sleep 2
print_section "Installing Ccat (colored cat)"
wget https://github.com/jingweno/ccat/releases/download/v1.1.0/linux-amd64-1.1.0.tar.gz
tar xfz linux-amd64-1.1.0.tar.gz
sudo cp linux-amd64-1.1.0/ccat /usr/local/bin/
sudo chmod +x /usr/local/bin/ccat

sleep 2
print_section "Installing Chrome"
wget https://dl.google.com/linux/direct/google-chrome-stable_current_amd64.deb
sudo apt install -y ./google-chrome-stable_current_amd64.deb

sleep 2
print_section "Installing balena-etcher (pendrive - boot)"
# wget https://github.com/balena-io/etcher/releases/download/v1.18.8/balena-etcher_1.18.8_amd64.deb
# sudo apt install -y ./balena-etcher_1.18.8_amd64.deb
# sudo sh -c "echo 'deb https://dl.bintray.com/resin-io/debian stable etcher' >> /etc/apt/sources.list.d/etcher.list"
# sudo apt-key adv --keyserver hkp://pgp.mit.edu:80 --recv-keys 379CE192D401AB61
# sudo apt-get update
# sudo apt-get install etcher-electron

sleep 2
print_section "Installing Hyper"
wget -O hyper.deb https://releases.hyper.is/download/deb
sudo dpkg -i hyper.deb
sudo apt -f install

sleep 2
print_section "Installing Linux System Optimizer & Monitoring"
sudo add-apt-repository ppa:oguzhaninan/stacer -y
sudo apt-get install stacer -y

sleep 2
print_section "Audio Recorder"
sudo apt-add-repository ppa:audio-recorder/ppa
sudo apt install audio-recorder

sleep 2
print_section "Snap installation and Test"
sudo mv /etc/apt/preferences.d/nosnap.pref ~/Documents/nosnap.backup
sudo apt install snapd
sudo snap install hello-world

sleep 2
print_section "Flatpak installation and Test"
# https://flatpak.org/setup/Ubuntu
sudo add-apt-repository ppa:flatpak/stable
sudo apt install flatpak
sudo apt install gnome-software-plugin-flatpak -y
flatpak remote-add --if-not-exists flathub https://flathub.org/repo/flathub.flatpakrepo

sleep 2
print_section "Installing Snap apps"
# Snap installl app
for app in ${snap_apps[@]}; do
    sudo snap install "$app"
done

sleep 2
print_section "Installing Spotify"
curl -sS https://download.spotify.com/debian/pubkey_7A3A762FAFD4A51F.gpg | sudo gpg --dearmor -o /usr/share/keyrings/spotify.gpg
echo "deb [signed-by=/usr/share/keyrings/spotify.gpg] http://repository.spotify.com stable non-free" | sudo tee /etc/apt/sources.list.d/spotify.list
sudo apt update && sudo apt install -y spotify-client

sleep 2
print_section "Installing DBeaver Community"
wget -O - https://dbeaver.io/debs/dbeaver.gpg.key | sudo gpg --dearmor -o /usr/share/keyrings/dbeaver.gpg
echo "deb [signed-by=/usr/share/keyrings/dbeaver.gpg] https://dbeaver.io/debs/dbeaver-ce /" | sudo tee /etc/apt/sources.list.d/dbeaver.list
sudo apt update && sudo apt install -y dbeaver-ce

sleep 2
print_section "Installing Postman"
flatpak install -y flathub com.getpostman.Postman

sleep 2
print_section "Installing PyCharm Community"
flatpak install flathub com.jetbrains.PyCharm-Community

sleep 2
print_section "Installing VSCode"
cd /tmp && curl https://packages.microsoft.com/keys/microsoft.asc | gpg --dearmor > packages.microsoft.gpg && sudo install -o root -g root -m 644 packages.microsoft.gpg /etc/apt/keyrings/packages.microsoft.gpg && cd "$HOME"
echo "deb [arch=amd64 signed-by=/etc/apt/keyrings/packages.microsoft.gpg] https://packages.microsoft.com/repos/code stable main" | sudo tee /etc/apt/sources.list.d/vscode.list
sudo apt update && sudo apt install code

sleep 2
print_section "Installing VSCode extensions"
code --version
code --install-extension ms-python.python
code --install-extension PKief.material-icon-theme
code --install-extension garytyler.darcula-pycharm
code --install-extension AykutSarac.jsoncrack-vscode
code --list-extensions


sleep 2
print_section "Installing Docker"
curl -fsSL https://get.docker.com -o get-docker.sh
sh get-docker.sh

sleep 2
print_section "Installing Docker Compose"
# Docker Compose v2 ships as a Docker CLI plugin (no separate binary needed)
sudo apt install -y docker-compose-plugin
docker compose version

sleep 2
print_section "Generate ssh keys"
mkdir -p ~/.ssh
if [[ ! -f ~/.ssh/id_rsa ]]; then
    ssh-keygen -t rsa -N "" -f ~/.ssh/id_rsa
fi
cat ~/.ssh/id_rsa.pub

sleep 2
print_section "Preparing UFW"
sudo ufw enable
sudo ufw status verbose

sleep 2
print_section "Set Docker"
echo -e "Open New Terminal and execute Docker postinstallation: https://docs.docker.com/engine/install/linux-postinstall/#manage-docker-as-a-non-root-user "

sleep 60
print_section "Set screenshot"
echo -e "flameshot as default (Prt Sc): https://flameshot.org/docs/guide/key-bindings/"

sleep 60
print_section "Set SSH Github"
echo -e "Open this link: https://github.com/settings/ssh/new"
echo -e "Title: $(hostname)"
echo -e "Key:\n$(cat ~/.ssh/id_rsa.pub)"

sleep 2
print_section "Set lm-sensors"
sudo sensors-detect
sudo service kmod start
# watch sensors

sleep 2
print_section "Remove apps"
for app in ${to_remove[@]}; do
  sudo apt remove "$app" -y
done
sudo apt autoremove -y && sudo apt autoclean -y

cd ..
sudo rm -r tmp/

sleep 2
print_section "Audit System"
sudo lynis audit system

sleep 2
print_section "Installing Oh My BASH!"
bash -c "$(curl -fsSL https://raw.githubusercontent.com/ohmybash/oh-my-bash/master/tools/install.sh)"

sleep 2
print_section "Ubuntu Customization"
sudo apt-add-repository universe
sudo apt install gnome-tweaks

sleep 2
print_section "Deploying configuration files"
mkdir -p "$HOME/.oh-my-bash/themes/zork/"
mkdir -p "$HOME/.jupyter/"
cp --force --verbose "$SCRIPT_DIR/linux/config/terminal/zork/zork.theme.sh" "$HOME/.oh-my-bash/themes/zork/"
cp --force --verbose "$SCRIPT_DIR/linux/config/jupyter_notebook_config.py"  "$HOME/.jupyter/"
cp --force --verbose "$SCRIPT_DIR/linux/config/.bashrc"                     "$HOME/"
cp --force --verbose "$SCRIPT_DIR/linux/config/.shell_aliases"              "$HOME/"
cp --force --verbose "$SCRIPT_DIR/linux/config/.vimrc"                      "$HOME/"
cp --force --verbose "$SCRIPT_DIR/linux/config/.gitconfig"                  "$HOME/"
# Initialize history file from template only if it doesn't exist yet
[[ ! -f "$HOME/.bash_eternal_history" ]] && \
    cp "$SCRIPT_DIR/linux/config/.bash_eternal_history.example" "$HOME/.bash_eternal_history"

sleep 2
print_section "Done"
echo "Restart your terminal or run: source ~/.bashrc"
