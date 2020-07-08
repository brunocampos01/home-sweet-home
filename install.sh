#!/bin/bash
# ----------------------------------- #
mkdir tmp/
cd tmp/


echo -e "Update packages \n"
sudo apt-get update && apt-get upgrade
echo
sleep 2
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
                 snapd\
                 libcurl4\
                 libcurl4-openssl-dev\
                 apt-transport-https\
                 ca-certificates\
                 curl\
                 wget\
                 p7zip-full\
                 software-properties-common\
                 ufw\
                 speedtest-cli\
                 bleachbit

# python
sudo apt install -y build-essential\
                 libssl-dev\
                 libffi-dev\
                 zlib1g-dev\
                 libgdbm-dev\
                 libreadline-dev\
                 python3\
                 python3-dev\
                 python3-venv\
                 python3-pip

python -m pip install -U pip\
						 setuptools\
						 wheel\
						 virtualenv\
						 pipenv\
                         flake8        

# terminator need Python
sudo apt install -y terminator
sleep 2
echo
echo -e "======================================== \n"
echo -e "Check Python Version:"
sudo python3 --version
sudo which python
echo
echo -e "======================================== \n"
echo -e "Snap Test:"
sudo snap install hello-world
echo
echo -e "======================================== \n"
echo -e "Generate ssh keys:"
cd ~/.ssh
ssh-keygen -t rsa -N "" -f id_rsa
cat id_rsa.pub
cd ~/tmp/
echo
sleep 2
echo -e "======================================== \n"
echo -e "UFW Status:"
sudo ufw enable
sudo ufw status verbose
echo -e "======================================== \n"
echo -e "Install Ccat (collored cat)"
wget https://github.com/jingweno/ccat/releases/download/v1.1.0/linux-amd64-1.1.0.tar.gz
tar xfz linux-amd64-1.1.0.tar.gz 
sudo cp linux-amd64-1.1.0/ccat /usr/local/bin/
sudo chmod +x /usr/local/bin/ccat
echo
sleep 2
echo -e "======================================== \n"
echo -e "Install Docker "
curl -fsSL https://get.docker.com -o get-docker.sh
sh get-docker.sh

curl -fsSL https://test.docker.com -o test-docker.sh
sh test-docker.sh

sh install.sh
make check
sleep 2
echo
echo -e "======================================== \n"
echo -e "Install Docker compose:"
sudo curl -L "https://github.com/docker/compose/releases/download/1.26.2/docker-compose-$(uname -s)-$(uname -m)" -o /usr/local/bin/docker-compose
sudo chmod +x /usr/local/bin/docker-compose
sudo ln -s /usr/local/bin/docker-compose /usr/bin/docker-compose

docker-compose --version
sleep 2
echo
echo -e "======================================== \n"
echo -e "Set Docker:"
sudo usermod -aG docker ${USER}
id -nG
sudo groupadd docker
sudo usermod -aG docker $USER
newgrp docker 
docker run hello-world
sleep 2
echo
echo -e "======================================== \n"
echo -e "Install the Default JRE/JDK and maven"
sudo apt install -y openjdk-8-jre\
                    openjdk-8-jdk\
                    maven
sleep 2
echo
echo -e "======================================== \n"
echo -e "Test JRE/JDK and maven"
java -version
javac -version
mvn -version
echo
echo -e "======================================== \n"
echo -e "Setup environment variables of Java and maven"
sudo export JAVA_HOME="/usr/lib/jvm/java-11-openjdk-amd64" > /etc/environment
source /etc/environment
echo $JAVA_HOME

sudo chmod +x /etc/profile.d/maven.sh

sudo export JAVA_HOME=/usr/lib/jvm/default-java > /etc/profile.d/maven.sh
sudo export M2_HOME=/opt/maven > /etc/profile.d/maven.sh
sudo export MAVEN_HOME=/opt/maven > /etc/profile.d/maven.sh
sudo export PATH=${M2_HOME}/bin:${PATH} > /etc/profile.d/maven.sh
sudo source /etc/profile.d/maven.sh
echo $JAVA_HOME
echo $MAVEN_HOME
echo $PATH
sleep 2
echo
echo -e "======================================== \n"
echo -e "Install Vim Extesions"
git clone https://github.com/gmarik/Vundle.vim.git ~/.vim/bundle/Vundle.vim
touch ~/.vimrc
ln ~/.vimrc ~/.vim/vimrc
vim +PluginInstall +qall
sleep 2
echo
echo -e "======================================== \n"
echo -e "Intall Chrome"
wget https://dl.google.com/linux/direct/google-chrome-stable_current_amd64.deb
sudo apt install -y ./google-chrome-stable_current_amd64.deb
sleep 2
echo
echo -e "======================================== \n"
echo -e "Snap:"
sudo snap install hello-world
sudo snap install snap-store
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
sudo snap install shutter
sudo snap install nmap
sudo snap install qalculate
sleep 2
echo
echo -e "======================================== \n"
echo -e "VSCode extesions"
code --version
code --install-extension ms-python.python
code --install-extension PKief.material-icon-theme
code --install-extension garytyler.darcula-pycharm
code --install-extension ms-azuretools.vscode-docker
code --install-extension ms-vscode-remote.remote-containers
code --install-extension vscjava.vscode-java-pac
code --install-extension ms-python.python
code --install-extension SonarSource.sonarlint-vscode # java lint
code --list-extensions
sleep 2
echo
echo -e "======================================== \n"
cd ..
sudo rm -r tmp/
echo -e "======================================== \n"
echo -e "Install Oh My BASH! "
sh -c "$(curl -fsSL https://raw.github.com/ohmybash/oh-my-bash/master/tools/install.sh)"
sleep 2
echo
echo -e "======================================== \n"
