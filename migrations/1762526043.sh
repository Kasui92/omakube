#!/bin/bash

echo "Install Omakub Menu Topbar Extension"

# Install Omakub Topbar extension
git clone https://github.com/Kasui92/omakub-menu-topbar-extension.git /tmp/omakub-ext
cd /tmp/omakub-ext
make local
cd -
rm -rf /tmp/omakub-ext

# Remove Omakub desktop icon from dock favorites
gsettings set org.gnome.shell favorite-apps "$(gsettings get org.gnome.shell favorite-apps | sed "s/'omakub.desktop', //g" | sed "s/, 'omakub.desktop'//g")"

# Remove Omakub desktop from applications menu
rm -f ~/.local/share/applications/omakub.desktop