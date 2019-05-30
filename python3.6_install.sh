#!/bin/bash
# Author: Bruno Campos
# Script: ./python3.6.sh
# ----------------------------------- #
# Install python3.6
# Input: N/A
# Output: python3.6
# ----------------------------------- #

echo
echo -e "======================================== \n"
sudo apt-get install build-essential checkinstall libreadline-gplv2-dev libncursesw5-dev libssl-dev libsqlite3-dev tk-dev libgdbm-dev libc6-dev libbz2-dev

echo
echo -e "======================================== \n"
echo "Indo para /usr/src"
cd /usr/src
pwd

echo
echo -e "======================================== \n"
sudo wget https://www.python.org/ftp/python/3.6.0/Python-3.6.0.tgz
sudo tar xzf Python-3.6.0.tgz
cd Python-3.6.0
pwd
sudo ./configure
sudo make altinstall

echo
echo -e "======================================== \n"
sudo python3.6 -V
echo
echo -e "======================================== \n"