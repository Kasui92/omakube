#!/bin/bash

# Install latest version of Firefox https://www.mozilla.org/firefox/
if ! grep -q "^deb .*\bmozillateam/ppa\b" /etc/apt/sources.list /etc/apt/sources.list.d/* 2>/dev/null; then
  sudo add-apt-repository -y ppa:mozillateam/ppa
fi

if [ ! -f /etc/apt/preferences.d/mozilla ]; then
  sudo tee /etc/apt/preferences.d/mozilla > /dev/null <<EOF
Package: *
Pin: release o=LP-PPA-mozillateam
Pin-Priority: 1001
EOF
fi

sudo apt-get update && sudo apt-get install -y firefox