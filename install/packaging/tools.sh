#!/bin/bash

# Install Alacritty
source ~/.local/share/omakub/applications/install/alacritty.sh

# Install Fastfetch
sudo add-apt-repository -y ppa:zhangsongcui3371/fastfetch
sudo apt update -y
sudo apt install -y fastfetch

# Install mise
sudo install -dm 755 /etc/apt/keyrings
wget -qO - https://mise.jdx.dev/gpg-key.pub | gpg --dearmor | sudo tee /etc/apt/keyrings/mise-archive-keyring.gpg 1>/dev/null
echo "deb [signed-by=/etc/apt/keyrings/mise-archive-keyring.gpg arch=$(dpkg --print-architecture)] https://mise.jdx.dev/deb stable main" | sudo tee /etc/apt/sources.list.d/mise.list
sudo apt update
sudo apt install -y mise

# Install Zellij
source ~/.local/share/omakub/applications/install/zellij.sh

# Install Docker
source ~/.local/share/omakub/applications/install/docker.sh

# Install LazyDocker
source ~/.local/share/omakub/applications/install/lazydocker.sh

# Install GitHub CLI
source ~/.local/share/omakub/applications/install/github-cli.sh

# Install LazyGit
source ~/.local/share/omakub/applications/install/lazygit.sh

# Install Starship
source ~/.local/share/omakub/applications/install/starship.sh