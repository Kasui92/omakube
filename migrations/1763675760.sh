#!/bin/bash

echo "Adding Night Light toggle hotkey (Super+Control+N)..."

# Disable the night light feature by default
gsettings set org.gnome.settings-daemon.plugins.color night-light-enabled false

# Set night light toggle to Super+Control+N
omakub-keybinding-add 'Night Light Toggle' 'omakub-cmd-nightlight' '<Super><Control>n'