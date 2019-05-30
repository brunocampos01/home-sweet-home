#!/bin/bash
# Autor: brunocampos01	
# Script: ./install Conky.sh
# Visit: https://www.noobslab.com/2012/07/conky-collection-for-ubuntulinux.html for themes
# How to install: https://www.shellhacks.com/install-configure-conky-linux-mint-ubuntu-debian/
# ----------------------------------- #
echo -e "Install Conky \n"
sudo apt-get install conky conky-all
echo
echo -e "======================================== \n"


echo -e "Install some extra staff \n"
sudo sudo apt-get install curl ; \
                          lm-sensors ; \
                          hddtemp
echo
echo -e "======================================== \n"


echo -e "start Conky in a background \n"
conky -d
echo
echo -e "======================================== \n"


echo -e "Complete: \n"
echo -e "-----------------------------"
echo -e "Name: conky"
echo -e "Command: conky -p 15"
echo -e "Comment: A system monitor\n"
echo -e "-----------------------------"
echo -e "Gnome interface \n"
gnome-session-properties

echo -e "restart Conky"
pkill -HUP conky
echo
echo -e "======================================== \n"


echo -e "Configuration:"
pkill -HUP conky
echo -e "Conky will firstly try to look for a local ~/.conkyrc file and if it doesn’t exist, then it will read the default one – /etc/conky/conky.conf."
echo -e "======================================== \n"
