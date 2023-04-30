# https://flatpak.org/setup/Ubuntu
sudo add-apt-repository ppa:flatpak/stable
sudo apt update
sudo apt install flatpak
sudo apt install gnome-software-plugin-flatpak
flatpak remote-add --if-not-exists flathub https://flathub.org/repo/flathub.flatpakrepo

# ---------------------------------------------------------------
# Reboot
# ---------------------------------------------------------------


# ---------------------------------------------------------------
# Install Nvidia Drivers
# ---------------------------------------------------------------
nvidia-detector



# ---------------------------------------------------------------
# Install Platforms
# ---------------------------------------------------------------
# Lutris
flatpak install flathub net.lutris.Lutris

# steam
wget http://repo.steampowered.com/steam/archive/precise/steam_latest.deb
sudo dpkg -i steam_latest.deb
sudo apt-get install -f


# bottles
flatpak install Bottles


# ---------------------------------------------------------------
# Install Libraries
# ---------------------------------------------------------------
# Wine
sudo dpkg --add-architecture i386 && sudo apt update && sudo apt install -y wine64 wine32 libasound2-plugins:i386 libsdl2-2.0-0:i386 libdbus-1-3:i386 libsqlite3-0:i386

# Wine caffe
wget https://github.com/bottlesdevs/wine/releases/download/caffe-7.20/caffe-7.20-x86_64.tar.xz
