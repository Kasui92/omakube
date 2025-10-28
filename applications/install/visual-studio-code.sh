#!/bin/bash

cd /tmp
wget "https://code.visualstudio.com/sha/download?build=stable&os=linux-deb-x64" -O code.deb
sudo apt install ./code.deb -y
rm code.deb
cd -