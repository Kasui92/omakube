stop_install_log

# Clean up temporary environment file
rm -f "$HOME/.local/state/omakub/.env_update"

echo_in_style() {
  echo "$1" | tte --canvas-width 0 --anchor-text c --frame-rate 640 print
}

clear
echo
tte -i ~/.local/share/omakub/logo.txt --canvas-width 0 --anchor-text c --frame-rate 920 laseretch
echo

# Display installation time if available
if [[ -f $OMAKUB_INSTALL_LOG_FILE ]] && grep -q "Total:" "$OMAKUB_INSTALL_LOG_FILE" 2>/dev/null; then
  echo
  TOTAL_TIME=$(tail -n 20 "$OMAKUB_INSTALL_LOG_FILE" | grep "^Total:" | sed 's/^Total:[[:space:]]*//')
  if [ -n "$TOTAL_TIME" ]; then
    echo_in_style "Installed in $TOTAL_TIME"
  fi
else
  echo_in_style "Finished installing"
fi

# Exit gracefully if user chooses not to reboot
if gum confirm --padding "0 0 0 $((PADDING_LEFT + 32))" --show-help=false --default --affirmative "Reboot Now" --negative "" ""; then
  # Clear screen to hide any shutdown messages
  clear

  # Use systemctl if available, otherwise fallback to reboot command
  if command -v systemctl &>/dev/null; then
    sudo systemctl reboot --no-wall 2>/dev/null
  else
    sudo reboot 2>/dev/null
  fi
fi
