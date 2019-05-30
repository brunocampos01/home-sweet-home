#!/bin/bash
# Autor: brunocampos01	
# Script: ./install_nautilus_admin.sh
# ----------------------------------- #
# Script install nautilus_admin
# input: N/A
# output: 
# ----------------------------------- #

echo -e "Add nautilus_admin \n"
sudo apt-get install nautilus-admin; S
echo
echo -e "======================================== \n"

echo -e "Update packages \n"
sudo apt-get update && apt-get upgrade
echo
echo -e "======================================== \n"


echo -e "you must restart Nautilus ! \n"
nautilus -q | sleep 5
echo
echo -e "======================================== \n"



