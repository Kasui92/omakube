#!/bin/bash

# Install latest version of Zen Browser https://zen-browser.app
cd /tmp
curl -s https://updates.zen-browser.app/install.sh -o zen-install.sh 2>/dev/null
chmod +x zen-install.sh 2>/dev/null
bash zen-install.sh >/dev/null 2>&1
rm -f zen-install.sh 2>/dev/null
cd -