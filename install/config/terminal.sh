#!/bin/bash

# Migrate alacritty config format if needed
alacritty migrate 2>/dev/null || true

# Copy custom desktop entry for alacritty with X-TerminalArg* keys
mkdir -p ~/.local/share/xdg-terminals
cp "$OMAKUB_PATH/applications/desktop/Alacritty.desktop" ~/.local/share/xdg-terminals/

# Update ubuntu-xdg-terminals.list to prioritize the proper terminal
  cat > ~/.config/ubuntu-xdg-terminals.list << EOF
# Terminal emulator preference order for xdg-terminal-exec
# The first found and valid terminal will be used
Alacritty.desktop
EOF