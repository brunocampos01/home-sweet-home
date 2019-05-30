#!/bin/bash
# Autor: brunocampos01	
# Script: ./install_java.sh
# ----------------------------------- #
# Script install JAVA version 11
# input: N/A
# output: Version do java
# ----------------------------------- #

echo -e "Add ppa repository \n"
sudo add-apt-repository ppa:linuxuprising/java
echo
echo -e "======================================== \n"

echo -e "Update packages \n"
sudo apt-get update && apt-get upgrade
echo
echo -e "======================================== \n"


echo -e "Install Java \n"
sudo apt-get install software-properties-common
sudo apt-get install oracle-java11-installer | sleep 3
echo
echo -e "======================================== \n"


echo -e "Version language Java \n"
java -version | sleep 3
echo
echo -e "======================================== \n"


echo -e "Version compiler Java \n"
javac -version | sleep 3
echo
echo -e "======================================== \n"
