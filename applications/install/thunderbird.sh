#!/bin/bash

# Install latest version of Thunderbird https://www.mozilla.org/thunderbird/
# Thunderbird is a free email application that's easy to set up and customize - and it's loaded with great features! https://www.thunderbird.net
if ! grep -q "^deb .*\bmozillateam/ppa\b" /etc/apt/sources.list /etc/apt/sources.list.d/* 2>/dev/null; then
  sudo add-apt-repository -y ppa:mozillateam/ppa
fi

if [ ! -f /etc/apt/preferences.d/mozilla-thunderbird ]; then
  sudo tee /etc/apt/preferences.d/mozilla-thunderbird > /dev/null <<EOF
Package: *
Pin: release o=LP-PPA-mozillateam
Pin-Priority: 1001
EOF
fi

sudo apt-get update && sudo apt-get install -y thunderbird