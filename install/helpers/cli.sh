#!/bin/bash

sudo apt install -y python3-pip pipx

# Install terminaltexteffects
pipx install terminaltexteffects

# Install gnome-extensions-cli
pipx install gnome-extensions-cli --system-site-packages

# Ensure pipx binaries are in PATH
pipx ensurepath

# Add pipx binaries to PATH for current session only
export PATH="$HOME/.local/bin:$PATH"