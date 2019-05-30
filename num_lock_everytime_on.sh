#!/bin/bash
# Autor: brunocampos01	
# Script: ./num_lock_on.sh
# ----------------------------------- #
# Script num_lock_on
# input: N/A
# output: num_lock_on
# ----------------------------------- #

echo -e "Prerequeriments \n"
sudo apt-get install gedit
echo
echo -e "======================================== \n"


echo -e "numlockx \n"
sudo apt-get install numlockx
echo
echo -e "======================================== \n"


echo -e "Update packages \n"
sudo apt-get update && apt-get upgrade
echo
echo -e "======================================== \n"


echo -e "Open config LightDM \n"
echo -e "---------------------------------------- \n"
echo -e "Add in final file, the line: "
echo -e "greeter-setup-script=/usr/bin/numlockx on \n"
echo -e "After close and save file."
echo -e "---------------------------------------- \n\n\n"
sudo gedit /usr/share/lightdm/lightdm.conf.d/50-unity-greeter.conf
echo -e "======================================== \n"


echo -e " Add and complete: \n"
echo -e "-----------------------------"
echo -e "Name: numlockx"
echo -e "Command: sleep 20 && numlockx on"
echo -e "Comment: activate numlock\n"
echo -e "-----------------------------"
gnome-session-properties
echo -e "======================================== \n"
