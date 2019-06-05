#!/bin/bash
# ----------------------------------- #
# Author: Bruno Campos
# Script: ./python3.6.sh
# ----------------------------------- #
# Install python3.6
# Input: N/A
# Output: python3.6
# ----------------------------------- #

echo -e "Update packages \n"
sudo apt-get update && apt-get upgrade
echo
echo -e "======================================== \n"

echo -e "Install dependences\n"
sudo apt-get install tk-dev \
                     libc6-dev \
                     libbz2-dev \
                     libssl-dev \
                     libgdbm-dev \
                     checkinstall \
                     libsqlite3-dev \
                     build-essential \
                     libncursesw5-dev \
                     libreadline-gplv2-dev
echo
echo -e "======================================== \n"

echo -e "Open /usr/src"
cd /usr/src
pwd
echo
echo -e "======================================== \n"

echo -e "Download Binary Python"
sudo wget https://www.python.org/ftp/python/3.6.0/Python-3.6.0.tgz
sudo tar xzf Python-3.6.0.tgz
cd Python-3.6.0
pwd
echo
echo -e "======================================== \n"

echo -e "Configure and make install "
sudo ./configure
sudo make altinstall
echo
echo -e "======================================== \n"

echo -e "Check Version "
sudo python3 --version
sudo which python
echo
echo -e "======================================== \n"
