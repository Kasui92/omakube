#!/bin/bash

sudo rm /etc/apt/sources.list.d/1password.list
sudo rm /usr/share/keyrings/1password-archive-keyring.gpg
sudo apt remove --purge -y 1password 1password-cli
