#!/bin/bash

echo "Setting up xdg-terminal-exec for gtk-launch terminal support"

# Remove old symlink if it exists -- if someone ran the previous migration early
if [ -L /usr/local/bin/xdg-terminal-exec ]; then
  sudo rm /usr/local/bin/xdg-terminal-exec
fi

omakub-pkg-add xdg-terminal-exec

# Set up xdg-terminals.list based on current $TERMINAL
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
    cat > ~/.config/ubuntu-xdg-terminals.list << EOF
# Terminal emulator preference order for xdg-terminal-exec
# The first found and valid terminal will be used
$desktop_id
EOF
  fi
fi

# Copy custom desktop entries with proper X-TerminalArg* keys
if command -v alacritty > /dev/null 2>&1; then
  mkdir -p ~/.local/share/xdg-terminals ~/.local/share/applications
  cp "$OMAKUB_PATH/applications/desktop/Alacritty.desktop" ~/.local/share/xdg-terminals/
  cp "$OMAKUB_PATH/applications/desktop/Alacritty.desktop" ~/.local/share/applications/
fi

# Update TERMINAL variable in bash environment
omakub-env-set TERMINAL "xdg-terminal-exec"

# Update Hotkeys to use xdg-terminal-exec
omakub-keybinding-remove 'New Terminal Window'
omakub-keybinding-add 'New Terminal Window' 'xdg-terminal-exec' '<Primary><Alt>t'