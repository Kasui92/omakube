# Track if we're already handling an error to prevent double-trapping
ERROR_HANDLING=false

# Display recent log lines from the install log
show_log_tail() {
  if [[ -f $OMAKUB_INSTALL_LOG_FILE ]]; then
    echo "Recent installation log:"
    tail -10 "$OMAKUB_INSTALL_LOG_FILE" | sed 's/\x1b\[[0-9;]*m//g' | while IFS= read -r line; do
      echo "  $line"
    done
    echo
  fi
}

# Display the failed command or script name
show_failed_script_or_command() {
  if [[ -n ${CURRENT_SCRIPT:-} ]]; then
    gum style "Failed script: $CURRENT_SCRIPT"
  else
    gum style "Failed command: $BASH_COMMAND"
  fi
}

# Simple output restoration
restore_outputs() {
  exec 1>/dev/tty 2>/dev/tty
}

# Error handler
catch_errors() {
  # Prevent recursive error handling
  if [[ $ERROR_HANDLING == true ]]; then
    return
  else
    ERROR_HANDLING=true
  fi

  # Store exit code immediately before it gets overwritten
  local exit_code=$?

  restore_outputs
  clear_logo

  gum style --foreground 1 "Omakub installation stopped!"
  show_log_tail

  gum style "This command halted with exit code $exit_code:"
  show_failed_script_or_command

  # Offer options menu
  while true; do
    options=()

    # Base options
    options+=("Retry installation")
    options+=("View full log")
    options+=("Exit")

    choice=$(gum choose "${options[@]}" --header "What would you like to do?" --height 6)

    case "$choice" in
    "Retry installation")
      # Reset error handling state
      ERROR_HANDLING=false

      # Disable terminal queries and clean state thoroughly
      printf '\033]11;?\007' >/dev/null 2>&1 || true  # Clear any pending color queries
      stty sane 2>/dev/null || true
      reset 2>&1 | cat  # Capture escape sequences

      # Clear screen properly
      printf "\033[H\033[2J"

      # Re-execute installation script
      exec bash ~/.local/share/omakub/install.sh
      break
      ;;
    "View full log")
      if command -v less &>/dev/null; then
        less "$OMAKUB_INSTALL_LOG_FILE"
      else
        tail "$OMAKUB_INSTALL_LOG_FILE"
      fi
      ;;
    "Exit" | "")
      exit 1
      ;;
    esac
  done
}

# Exit handler - ensures cleanup happens on any exit
exit_handler() {
  local exit_code=$?

  # Only run if we're exiting with an error and haven't already handled it
  if [[ $exit_code -ne 0 && $ERROR_HANDLING != true ]]; then
    catch_errors
  fi
}

# Set up traps
trap catch_errors ERR INT TERM
trap exit_handler EXIT
