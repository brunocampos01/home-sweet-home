#!/bin/bash
# Author: brunocampos01
# Script: ./download_youtube.sh
# ----------------------------------- #
# Install and rum clipgrab
# Input: N/A
# Output: run clipgrab 
# ----------------------------------- #

echo -e "Download youtube vídeos (CLIPGRAB) \n"
echo
echo -e "======================================== \n"


echo -e "Add ppa repository \n"
sudo add-apt-repository ppa:clipgrab-team/ppa
echo
echo -e "======================================== \n"


echo -e "Install Dependences \n"
sudo apt-get install ffmpeg
echo
echo -e "======================================== \n"

echo -e "Update packages \n"
sudo apt-get update
echo
echo -e "======================================== \n"


echo -e "Install CLIPGRAB \n"
sudo apt-get install clipgrab
echo
echo -e "======================================== \n"


echo -e "Run application \n"
clipgrab
echo
echo -e "======================================== \n"

echo -e "Visit site\n"
echo -e https://clipgrab.org/
echo -e "======================================== \n"

