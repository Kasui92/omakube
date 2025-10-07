#!/bin/bash

# Alt+F4 is very cumbersome
gsettings set org.gnome.desktop.wm.keybindings close "['<Super>w']"

# Make it easy to maximize like you can fill left/right
gsettings set org.gnome.desktop.wm.keybindings maximize "['<Super>Up']"

# Make it easy to resize undecorated windows
gsettings set org.gnome.desktop.wm.keybindings begin-resize "['<Super>BackSpace']"

# For keyboards that only have a start/stop button for music, like Logitech MX Keys Mini
gsettings set org.gnome.settings-daemon.plugins.media-keys next "['<Shift>AudioPlay']"

# Full-screen with title/navigation bar
gsettings set org.gnome.desktop.wm.keybindings toggle-fullscreen "['<Shift>F11']"

# Open File Manager (Nautilus) with Super+F (for File)
gsettings set org.gnome.settings-daemon.plugins.media-keys home "['<Super>f']"

# Open Web Browser (Chromium) with Super+B (for Browser)
gsettings set org.gnome.settings-daemon.plugins.media-keys www "['<Super>b']"

# Remove terminal keybinding (usually Ctrl+Alt+T) to avoid conflicts
gsettings set org.gnome.settings-daemon.plugins.media-keys terminal "[]"

# Use alt for pinned apps
gsettings set org.gnome.shell.keybindings switch-to-application-1 "['<Alt>1']"
gsettings set org.gnome.shell.keybindings switch-to-application-2 "['<Alt>2']"
gsettings set org.gnome.shell.keybindings switch-to-application-3 "['<Alt>3']"
gsettings set org.gnome.shell.keybindings switch-to-application-4 "['<Alt>4']"
gsettings set org.gnome.shell.keybindings switch-to-application-5 "['<Alt>5']"
gsettings set org.gnome.shell.keybindings switch-to-application-6 "['<Alt>6']"
gsettings set org.gnome.shell.keybindings switch-to-application-7 "['<Alt>7']"
gsettings set org.gnome.shell.keybindings switch-to-application-8 "['<Alt>8']"
gsettings set org.gnome.shell.keybindings switch-to-application-9 "['<Alt>9']"

# Use super for workspaces
gsettings set org.gnome.desktop.wm.keybindings switch-to-workspace-1 "['<Super>1']"
gsettings set org.gnome.desktop.wm.keybindings switch-to-workspace-2 "['<Super>2']"
gsettings set org.gnome.desktop.wm.keybindings switch-to-workspace-3 "['<Super>3']"
gsettings set org.gnome.desktop.wm.keybindings switch-to-workspace-4 "['<Super>4']"
gsettings set org.gnome.desktop.wm.keybindings switch-to-workspace-5 "['<Super>5']"
gsettings set org.gnome.desktop.wm.keybindings switch-to-workspace-6 "['<Super>6']"

# Reserve slots for input source switching
gsettings set org.gnome.desktop.wm.keybindings switch-input-source "@as []"

# Empty the custom keybindings to start fresh
gsettings set org.gnome.settings-daemon.plugins.media-keys custom-keybindings "[]"

# Set apps launcher (wofi) to Super+Space
omakub-keybinding-add 'Apps Launcher' 'omakub-apps' '<Super>space'

# Set flameshot (with the sh fix for starting under Wayland) on alternate print screen key
omakub-keybinding-add 'Flameshot' 'sh -c -- "flameshot gui"' '<Control>Print'

# Start a new terminal window
omakub-keybinding-add 'New Terminal Window' 'omakub-launch-terminal' '<Primary><Alt>t'

# Start a new gnome-terminal window
omakub-keybinding-add 'New Gnome Terminal Window' 'gnome-terminal --window' '<Shift><Primary><Alt>t'

# Start a new Browser Window (rather than just switch to the already open one)
omakub-keybinding-add 'New Browser Window' 'omakub-launch-browser --new-window' '<Shift><Super>b'

# Turn brightness down on Apple monitor (requires ASDControl installed)
omakub-keybinding-add 'Apple Brightness Down (ASDControl)' "sh -c 'asdcontrol \$(asdcontrol --detect /dev/usb/hiddev* 2>/dev/null | grep ^/dev/usb/hiddev | cut -d: -f1) -- -5000'" '<Control>F1'

# Turn brightness up on Apple monitor (requires ASDControl installed)
omakub-keybinding-add 'Apple Brightness Up (ASDControl)' "sh -c 'asdcontrol \$(asdcontrol --detect /dev/usb/hiddev* 2>/dev/null | grep ^/dev/usb/hiddev | cut -d: -f1) -- +5000'" '<Control>F2'

# Turn brightness up to max on Apple monitor (requires ASDControl installed)
omakub-keybinding-add 'Apple Brightness Max (ASDControl)' "sh -c 'asdcontrol \$(asdcontrol --detect /dev/usb/hiddev* 2>/dev/null | grep ^/dev/usb/hiddev | cut -d: -f1) -- +60000'" '<Control><Shift>F2'

# Set omakub menu to Alt+Super+Space
omakub-keybinding-add 'Omakub Menu' 'omakub-menu' '<Alt><Super>space'

# Set omakub theme switcher to Super+Shift+Control+Space
omakub-keybinding-add 'Omakub Themes' 'omakub-menu theme' '<Super><Shift><Control>space'

# Set omakub next background to Super+Shift+Control
omakub-keybinding-add 'Omakub Background Next' 'omakub-theme-bg-next' '<Super><Control>space'