#!/bin/bash

# Install terminaltexteffects
pipx install terminaltexteffects

# Install gnome-extensions-cli
pipx install gnome-extensions-cli --system-site-packages

# Ensure pipx binaries are in PATH
pipx ensurepath

# Add pipx binaries to PATH for current and future sessions
export PATH="$HOME/.local/bin:$PATH"

# Also update PATH in the parent shell environment by writing to a temp file
# that can be sourced by the main installation script
mkdir -p "$HOME/.local/state/omakub"
echo "export PATH=\"\$HOME/.local/bin:\$PATH\"" >> "$HOME/.local/state/omakub/.env_update"