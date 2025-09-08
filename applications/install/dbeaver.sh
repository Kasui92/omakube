#!/bin/bash

# A Database management tool https://dbeaver.io/s
cd /tmp
wget https://dbeaver.io/files/dbeaver-ce_latest_amd64.deb -O dbeaver.deb
sudo apt install ./dbeaver.deb -y
rm dbeaver.deb
cd -


