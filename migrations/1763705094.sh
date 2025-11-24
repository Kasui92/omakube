#!/bin/bash

echo "Update applications hotkeys..."

gsettings set org.gnome.settings-daemon.plugins.media-keys home "['<Shift><Super>f']"
gsettings set org.gnome.settings-daemon.plugins.media-keys www "[]"
gsettings set org.gnome.settings-daemon.plugins.media-keys help "[]"
gsettings set org.gnome.settings-daemon.plugins.media-keys terminal "[]"
omakub-keybinding-add 'New Terminal Window' 'xdg-terminal-exec' '<Super>Return'
omakub-keybinding-add 'New Default Terminal Window' 'x-terminal-emulator' '<Control><Alt>t'
omakub-keybinding-add 'New Browser Window' 'omakub-launch-browser --new-window' '<Shift><Super>b'
omakub-keybinding-add 'New Incognito Browser Window' 'omakub-launch-browser --private' '<Shift><Alt><Super>b'
omakub-keybinding-add 'Activity' 'omakub-launch-tui btop' '<Super><Shift>t'
gsettings set org.gnome.shell.extensions.tactile show-settings "['<Super><Control>t']"