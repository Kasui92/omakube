#!/bin/bash

echo "Setting up xdg-terminal-exec for gtk-launch terminal support"

# Remove old symlink if it exists -- if someone ran the previous migration early
if [ -L /usr/local/bin/xdg-terminal-exec ]; then
  sudo rm /usr/local/bin/xdg-terminal-exec
fi

omakub-pkg-add xdg-terminal-exec

# Set up xdg-terminals.list based on current $TERMINAL (if not set, then set to alacritty later)
TERMINAL=${TERMINAL:-alacritty}
if [ -n "$TERMINAL" ]; then
  case "$TERMINAL" in
    alacritty)
      desktop_id="Alacritty.desktop"
      ;;
    kitty)
      desktop_id="kitty.desktop"
      ;;
  esac

  if [ -n "$desktop_id" ]; then
    mkdir -p ~/.config

    # Determine the correct config file name based on desktop environment
    if [ -n "$XDG_CURRENT_DESKTOP" ]; then
      # Use the first desktop name from XDG_CURRENT_DESKTOP (e.g., "ubuntu:GNOME" -> "ubuntu")
      desktop_prefix=$(echo "$XDG_CURRENT_DESKTOP" | cut -d':' -f1 | tr '[:upper:]' '[:lower:]')
      config_file="$HOME/.config/${desktop_prefix}-xdg-terminals.list"
    else
      # Fallback to generic name
      config_file="$HOME/.config/xdg-terminals.list"
    fi

    # Remove all existing xdg-terminals.list files first to ensure clean state
    rm -f "$HOME/.config"/*-xdg-terminals.list "$HOME/.config/xdg-terminals.list" 2>/dev/null

    # Create the current config file with only the selected terminal
    cat > "$config_file" << EOF
# Terminal emulator preference order for xdg-terminal-exec
# The first found and valid terminal will be used
$desktop_id
EOF
  fi
fi

# Copy custom desktop entries with proper X-TerminalArg* keys
if command -v alacritty > /dev/null 2>&1; then
  mkdir -p ~/.local/share/xdg-terminals ~/.local/share/applications
  cp /usr/share/applications/Alacritty.desktop "$HOME/.local/share/xdg-terminals/Alacritty.desktop"
  cp /usr/share/applications/Alacritty.desktop "$HOME/.local/share/applications/Alacritty.desktop"
fi

# Update TERMINAL variable in bash environment
omakub-env-set TERMINAL "xdg-terminal-exec"

# Update Hotkeys to use xdg-terminal-exec
omakub-keybinding-remove 'New Terminal Window'
omakub-keybinding-add 'New Terminal Window' 'xdg-terminal-exec' '<Primary><Alt>t'