#!/bin/bash

echo "Add Icon Launcher Extension"


# Install Icon Launcher extension
gext install icon-launcher@omakasui.org

# Compile gsettings schemas in order to be able to set them
sudo cp ~/.local/share/gnome-shell/extensions/icon-launcher\@omakasui.org/schemas/org.gnome.shell.extensions.icon-launcher.gschema.xml /usr/share/glib-2.0/schemas/
sudo glib-compile-schemas /usr/share/glib-2.0/schemas/

# Configure Icon Launcher extension
ICON_PATH="$HOME/.local/share/omakub/applications/icons/Omakub.png"
gsettings set org.gnome.shell.extensions.icon-launcher custom-icon-path "$ICON_PATH"
gsettings set org.gnome.shell.extensions.icon-launcher custom-command "alacritty --config-file /home/$USER/.config/alacritty/pane.toml --class=Omakub --title=Omakub -e omakub"