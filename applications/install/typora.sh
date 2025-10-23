#!/bin/bash

cd /tmp
wget -O typora.deb "https://downloads.typora.io/linux/typora_1.10.8_amd64.deb"
sudo apt install -y /tmp/typora.deb
rm typora.deb
cd -