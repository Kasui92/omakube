#!/bin/bash

# Center new windows in the middle of the screen
gsettings set org.gnome.mutter center-new-windows true

# Set Cascadia Mono as the default monospace font
gsettings set org.gnome.desktop.interface monospace-font-name 'CaskaydiaMono Nerd Font 10'

# Reveal week numbers in the Gnome calendar
gsettings set org.gnome.desktop.calendar show-weekdate true

# Turn off ambient sensors for setting screen brightness (they rarely work well!)
gsettings set org.gnome.settings-daemon.plugins.power ambient-enabled false

# Use 6 fixed workspaces instead of dynamic mode
gsettings set org.gnome.mutter dynamic-workspaces false
gsettings set org.gnome.desktop.wm.preferences num-workspaces 6

# Disable the hotkeys in the Dash to Dock extension (most likely culprit)
gsettings set org.gnome.shell.extensions.dash-to-dock hot-keys false

# Set xdg-terminal-exec as the default terminal for GNOME
gsettings set org.gnome.desktop.default-applications.terminal exec 'xdg-terminal-exec'
gsettings set org.gnome.desktop.default-applications.terminal exec-arg ''

# Disable the night light feature by default
gsettings set org.gnome.settings-daemon.plugins.color night-light-enabled false
# Set night light schedule to manual (so it doesn't turn on automatically)
# If you want to enable night light automatically, you can set the from/to in settings
gsettings set org.gnome.settings-daemon.plugins.color night-light-schedule-automatic false
gsettings set org.gnome.settings-daemon.plugins.color night-light-schedule-from 0.0
gsettings set org.gnome.settings-daemon.plugins.color night-light-schedule-to 0.0