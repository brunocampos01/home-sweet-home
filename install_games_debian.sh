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
# ...


# ---------------------------------------------------------------
# Install Platforms
# ---------------------------------------------------------------
# Lutris
flatpak install flathub net.lutris.Lutris

# steam
wget http://repo.steampowered.com/steam/archive/precise/steam_latest.deb
sudo dpkg -i steam_latest.deb
sudo apt-get install -f
