#!/bin/bash
# Author: Bruno Campos
# ----------------------------------- #
mkdir tmp/
cd tmp/


echo -e "Update packages \n"
sudo apt-get update && apt-get upgrade
echo
echo -e "======================================== \n"

echo -e "Install dependences\n"
sudo apt install -y unixodbc-dev\
                 vim \
                 tree\
                 git\
                 gitk\
                 htop\
                 ncdu\
                 jq\
                 snapd \
                 apt-transport-https \
                 ca-certificates \
                 curl \
                 wget \
                 software-properties-common \
                 ufw

# python
sudo apt install build-essential \
                 libssl-dev \
                 libffi-dev \
                 zlib1g-dev \
                 libgdbm-dev \
                 libreadline-dev \
                 python3 \
                 python3-dev \
                 python3-venv \
                 python3-pip -y

python -m pip install -U pip \
						 setuptools \
						 wheel \
						 virtualenv \
						 pipenv
                         flake8
						
echo
echo -e "======================================== \n"
echo -e "Check Python Version "
sudo python3 --version
sudo which python
echo
echo -e "======================================== \n"
echo -e "Snapd Test"
sudo snap install hello-world
echo
echo -e "======================================== \n"
echo -e "UFW Status"
sudo ufw enable
sudo ufw status verbose
echo
echo -e "======================================== \n"
echo -e "Install Terminator "
sudo apt install terminator
echo
echo -e "======================================== \n"
echo -e "Install Ccat (collored cat)"
wget https://github.com/jingweno/ccat/releases/download/v1.1.0/linux-amd64-1.1.0.tar.gz
tar xfz linux-amd64-1.1.0.tar.gz 
sudo cp linux-amd64-1.1.0/ccat /usr/local/bin/
sudo chmod +x /usr/local/bin/ccat
echo -e "======================================== \n"
echo -e "Install Docker "
curl -fsSL https://get.docker.com -o get-docker.sh
sh get-docker.sh

curl -fsSL https://test.docker.com -o test-docker.sh
sh test-docker.sh

sh install.sh
make check
cd ..

echo
echo -e "======================================== \n"
echo -e "Install the Default JRE/JDK and maven"
sudo apt install default-jre
sudo apt install default-jdk
sudo apt install maven
echo
echo -e "======================================== \n"
echo -e "Install Vim Extesions"
git clone https://github.com/gmarik/Vundle.vim.git ~/.vim/bundle/Vundle.vim
touch ~/.vimrc
ln ~/.vimrc ~/.vim/vimrc
vim +PluginInstall +qall

echo
echo -e "======================================== \n"
echo -e "Test JRE/JDK and maven"
java -version
javac -version
mvn -version
echo
echo -e "======================================== \n"
echo -e "Setup environment variables of Java and maven"
export JAVA_HOME="/usr/lib/jvm/java-11-openjdk-amd64" > /etc/environment
source /etc/environment
echo $JAVA_HOME

sudo chmod +x /etc/profile.d/maven.sh

export JAVA_HOME=/usr/lib/jvm/default-java > /etc/profile.d/maven.sh
export M2_HOME=/opt/maven > /etc/profile.d/maven.sh
export MAVEN_HOME=/opt/maven > /etc/profile.d/maven.sh
export PATH=${M2_HOME}/bin:${PATH} > /etc/profile.d/maven.sh
source /etc/profile.d/maven.sh
echo $JAVA_HOME
echo $MAVEN_HOME
echo $PATH

echo
echo -e "======================================== \n"
echo -e "Intall Chrome"
wget https://dl.google.com/linux/direct/google-chrome-stable_current_amd64.deb
sudo apt install ./google-chrome-stable_current_amd64.deb

echo -e "======================================== \n"
echo -e "Snapd"
sudo snap install snap-store
sudo snap install hello-world
sudo snap install pycharm-community --classic
sudo snap install intellij-idea-community --classic
sudo snap install code --classic
sudo snap install postman
sudo snap install dbeaver-ce
sudo snap install evince
sudo snap install remmina

sudo snap install vlc
sudo snap install ffmpeg
sudo snap install spotify
sudo snap install youtube-dl
sudo snap install shutter
sudo snap install nmap
sudo snap install qalculate
echo
echo -e "======================================== \n"
echo -e "VSCode extesions"
code --install-extension ms-python.python
code --install-extension PKief.material-icon-theme
code --install-extension ms-azuretools.vscode-docker
code --install-extension vscjava.vscode-java-pac
code --install-extension ms-python.python
code --list-extensions
echo -e "======================================== \n"

sudo rm -r tmp/
