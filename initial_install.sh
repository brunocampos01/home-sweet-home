#!/bin/bash
# ----------------------------------- #
# My Apps
# ----------------------------------- #

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
)

python_dep=(
    python3
    python3-dev
    python3-doc
    python3-venv
    python3-pip
)

snap_apps=(
    hello-world
    snap-store
    postman
    dbeaver-ce
    evince
    remmina
    vlc
    spotify
    kolourpaint
    curl
    nmap
    qalculate
    bitwarden
    youtube-dl
    gydl
    telegram-desktop
    simplescreenrecorder
    studio
)

sdk_apps=(
    maven
    sbt
    scala
    spark
    java 8.0.282-open
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

mkdir tmp/
cd tmp/

echo -e "======================================== \n"
echo -e "Update and upgrade"
echo -e "======================================== \n"
sudo apt update && apt upgrade
sleep 2
echo
echo -e "======================================== \n"
echo -e "Installing Debian apps"
echo -e "======================================== \n"

for app in ${deb_app[@]}; do
    sudo apt install "$app" -y
done

for app in ${python_dep[@]}; do
    sudo apt install "$app" -y
done

sleep 2
echo
echo -e "======================================== \n"
echo -e "Installing Python Packages"
echo -e "======================================== \n"

python3 -m pip install -U setuptools\
						  wheel\
                          pip-tools

sleep 2
echo
echo -e "======================================== \n"
echo -e "Installing Vim Extensions"
echo -e "======================================== \n"

git clone https://github.com/gmarik/Vundle.vim.git ~/.vim/bundle/Vundle.vim
touch ~/.vimrc
ln ~/.vimrc ~/.vim/vimrc
vim +PluginInstall +qall

sleep 2
echo
echo -e "======================================== \n"
echo -e "Installing Ctop"
echo -e "======================================== \n"
sudo wget https://github.com/bcicen/ctop/releases/download/0.7.6/ctop-0.7.6-linux-amd64 -O /usr/local/bin/ctop
sudo chmod +x /usr/local/bin/ctop

sleep 2
echo
echo -e "======================================== \n"
echo -e "Installing Ccat (collored cat)"
echo -e "======================================== \n"
wget https://github.com/jingweno/ccat/releases/download/v1.1.0/linux-amd64-1.1.0.tar.gz
tar xfz linux-amd64-1.1.0.tar.gz
sudo cp linux-amd64-1.1.0/ccat /usr/local/bin/
sudo chmod +x /usr/local/bin/ccat

sleep 2
echo
echo -e "======================================== \n"
echo -e "Installing Chrome"
echo -e "======================================== \n"
wget https://dl.google.com/linux/direct/google-chrome-stable_current_amd64.deb
sudo apt install -y ./google-chrome-stable_current_amd64.deb

sleep 2
echo
echo -e "======================================== \n"
echo -e "Installing balena-etcher (pendrive - boot)"
echo -e "======================================== \n"
# wget https://github.com/balena-io/etcher/releases/download/v1.18.8/balena-etcher_1.18.8_amd64.deb
# sudo apt install -y ./balena-etcher_1.18.8_amd64.deb
sudo sh -c "echo 'deb https://dl.bintray.com/resin-io/debian stable etcher' >> /etc/apt/sources.list.d/etcher.list"
sudo apt-key adv --keyserver hkp://pgp.mit.edu:80 --recv-keys 379CE192D401AB61
sudo apt-get update
sudo apt-get install etcher-electron

sleep 2
echo
echo -e "======================================== \n"
echo -e "Installing Termintor"
echo -e "======================================== \n"
sudo apt install -y terminator

sleep 2
echo
echo -e "======================================== \n"
echo -e "Installing Linux System Optimizer & Monitoring"
echo -e "======================================== \n"
sudo add-apt-repository ppa:oguzhaninan/stacer -y
sudo apt-get update
sudo apt-get install stacer -y

sleep 2
echo
echo -e "======================================== \n"
echo -e "Audio Recorder"
echo -e "======================================== \n"
sudo apt-add-repository ppa:audio-recorder/ppa
sudo apt update
sudo apt install audio-recorder

sleep 2
echo
echo -e "======================================== \n"
echo -e "Snap installation and Test"
echo -e "======================================== \n"
sudo mv /etc/apt/preferences.d/nosnap.pref ~/Documents/nosnap.backup
sudo apt update
sudo apt install snapd
sudo snap install hello-world

sleep 2
echo
echo -e "======================================== \n"
echo -e "Flatpak installation and Test"
echo -e "======================================== \n"
# https://flatpak.org/setup/Ubuntu
sudo add-apt-repository ppa:flatpak/stable
sudo apt update
sudo apt install flatpak
sudo apt install gnome-software-plugin-flatpak -y
flatpak remote-add --if-not-exists flathub https://flathub.org/repo/flathub.flatpakrepo

sleep 2
echo
echo -e "======================================== \n"
echo -e "Installing Snap apps"
echo -e "======================================== \n"
# Snap installl app
for app in ${snap_apps[@]}; do
    sudo snap install "$app"
done

sleep 2
echo
echo -e "======================================== \n"
echo -e "Installing Pycharm Community"
echo -e "======================================== \n"
flatpak install flathub com.jetbrains.PyCharm-Community

sleep 2
echo
echo -e "======================================== \n"
echo -e "Installing VSCode"
echo -e "======================================== \n"
cd /tmp && curl https://packages.microsoft.com/keys/microsoft.asc | gpg --dearmor > packages.microsoft.gpg && sudo install -o root -g root -m 644 packages.microsoft.gpg /etc/apt/keyrings/packages.microsoft.gpg && cd $HOME
echo "deb [arch=amd64 signed-by=/etc/apt/keyrings/packages.microsoft.gpg] https://packages.microsoft.com/repos/code stable main" | sudo tee /etc/apt/sources.list.d/vscode.list
sudo apt update
sudo apt install code

sleep 2
echo
echo -e "======================================== \n"
echo -e "Installing VSCode extensions"
echo -e "======================================== \n"
code --version
code --install-extension ms-python.python
code --install-extension ms-python.flake8
code --install-extension ms-python.isort
code --install-extension PKief.material-icon-theme
# code --install-extension garytyler.darcula-pycharm
code --install-extension ms-azuretools.vscode-docker
code --install-extension ms-vscode-remote.remote-containers
code --install-extension vscjava.vscode-java-pac
# code --install-extension SonarSource.sonarlint-vscode # java lint
code --install-extension AykutSarac.jsoncrack-vscode
code --list-extensions

sleep 2
echo
echo -e "======================================== \n"
echo -e "Installing SDKMAN (JRE/JDK, scala, spark, maven, sbt)"
echo -e "======================================== \n"
curl -s "https://get.sdkman.io" | bash
source "$HOME/.sdkman/bin/sdkman-init.sh"
sdk version

sleep 2
echo
echo -e "======================================== \n"
echo -e "Installing SDKMAN apps"
echo -e "======================================== \n"
for app in ${sdk_apps[@]}; do
    sdk install "$app"
done

# tests
java -version
javac -version
mvn -version

 echo
 sleep 2
 echo -e "======================================== \n"
 echo -e "Installing Docker"
 echo -e "======================================== \n"
 curl -fsSL https://get.docker.com -o get-docker.sh
 sh get-docker.sh
 curl -fsSL https://test.docker.com -o test-docker.sh
 sh test-docker.sh
 sh install.sh
 make check

sleep 2
echo
echo -e "======================================== \n"
echo -e "Installing Docker Compose"
echo -e "======================================== \n"
sudo curl -L "https://github.com/docker/compose/releases/download/1.26.2/docker-compose-$(uname -s)-$(uname -m)" -o /usr/local/bin/docker-compose
sudo chmod +x /usr/local/bin/docker-compose
sudo ln -s /usr/local/bin/docker-compose /usr/bin/docker-compose
docker-compose --version

sleep 2
echo
echo -e "======================================== \n"
echo -e "Generate ssh keys"
echo -e "======================================== \n"
mkdir ~/.ssh
cd ~/.ssh
ssh-keygen -t rsa -N "" -f id_rsa
cat id_rsa.pub

sleep 2
echo
echo -e "======================================== \n"
echo -e "Preparing UFW"
echo -e "======================================== \n"
sudo ufw enable
sudo ufw status verbose

sleep 2
echo
echo -e "======================================== \n"
echo -e "Set Docker"
echo -e "======================================== \n"
echo -e "Open New Terminal and execute Docker postinstallation: https://docs.docker.com/engine/install/linux-postinstall/#manage-docker-as-a-non-root-user "

sleep 60
echo
echo -e "======================================== \n"
echo -e "Set screenshot"
echo -e "======================================== \n"
echo -e "flameshot as default (Prt Sc): hhttps://flameshot.org/docs/guide/key-bindings/"

sleep 60
echo
echo -e "======================================== \n"
echo -e "Set SSH Github"
echo -e "======================================== \n"
echo -e "Open this link: https://github.com/settings/ssh/new"
echo -e "Title: $(hostname)"
echo -e "Key:\n$(cat ~/.ssh/id_rsa.pub)"

sleep 2
echo
echo -e "======================================== \n"
echo -e "Set lm-sensors"
echo -e "======================================== \n"
sudo sensors-detect
sudo service kmod start
# watch sensors

sleep 2
echo
echo -e "======================================== \n"
echo -e "Remove apps"
echo -e "======================================== \n"
for app in ${to_remove[@]}; do
  sudo apt remove "$app" -y
done
sudo apt autoremove -y && sudo apt autoclean -y

cd ..
sudo rm -r tmp/

sleep 2
echo
echo -e "======================================== \n"
echo -e "Audit System"
echo -e "======================================== \n"
sudo lynis audit system

sleep 2
echo
echo -e "======================================== \n"
echo -e "Installing Oh My BASH! "
echo -e "======================================== \n"
bash -c "$(curl -fsSL https://raw.githubusercontent.com/ohmybash/oh-my-bash/master/tools/install.sh)"

sleep 2
echo
echo -e "======================================== \n"
echo -e "Ubuntu Customization "
echo -e "======================================== \n"
sudo apt-add-repository universe
sudo apt install gnome-tweaks

sleep 2
echo
echo -e "======================================== \n"
echo -e "Downloading predefined configurations"
echo -e "======================================== \n"
mkdir $HOME/.config/terminator/
cp --force --verbose config/terminal/terminator/config    $HOME/.config/terminator/ # yes
cp --force --verbose config/terminal/zork/zork.theme.sh   $HOME/.oh-my-bash/themes/zork/ # yes
mkdir $HOME/.jupyter/
cp config/jupyter_notebook_config.py    $HOME/.jupyter/ # yes
cp config/.bashrc                       $HOME/ # yes
cp config/.bash_eternal_history         $HOME/ # yes
cp config/.vimrc                        $HOME/ # yes
cp config/.gitconfig                    $HOME/ # yes

sleep 2
echo
echo -e "======================================== \n"
