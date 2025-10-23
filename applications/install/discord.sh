#!/bin/bash

cd /tmp
wget https://discord.com/api/download?platform=linux -O discord.deb
sudo apt install ./discord.deb -y
rm discord.deb
cd -