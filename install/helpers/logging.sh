start_install_log() {
  sudo touch "$OMAKUB_INSTALL_LOG_FILE"
  sudo chmod 666 "$OMAKUB_INSTALL_LOG_FILE"

  export OMAKUB_START_TIME=$(date '+%Y-%m-%d %H:%M:%S')
  echo "=== Omakub Installation Started: $OMAKUB_START_TIME ===" >>"$OMAKUB_INSTALL_LOG_FILE"
}

stop_install_log() {
  if [[ -n ${OMAKUB_INSTALL_LOG_FILE:-} ]]; then
    OMAKUB_END_TIME=$(date '+%Y-%m-%d %H:%M:%S')
    echo "=== Omakub Installation Completed: $OMAKUB_END_TIME ===" >>"$OMAKUB_INSTALL_LOG_FILE"
    echo "" >>"$OMAKUB_INSTALL_LOG_FILE"
    echo "=== Installation Time Summary ===" >>"$OMAKUB_INSTALL_LOG_FILE"

    if [ -n "$OMAKUB_START_TIME" ]; then
      OMAKUB_START_EPOCH=$(date -d "$OMAKUB_START_TIME" +%s)
      OMAKUB_END_EPOCH=$(date -d "$OMAKUB_END_TIME" +%s)
      OMAKUB_DURATION=$((OMAKUB_END_EPOCH - OMAKUB_START_EPOCH))

      OMAKUB_MINS=$((OMAKUB_DURATION / 60))
      OMAKUB_SECS=$((OMAKUB_DURATION % 60))

      echo "Omakub:     ${OMAKUB_MINS}m ${OMAKUB_SECS}s" >>"$OMAKUB_INSTALL_LOG_FILE"

      if [ -n "$ARCH_DURATION" ]; then
        TOTAL_DURATION=$((ARCH_DURATION + OMAKUB_DURATION))
        TOTAL_MINS=$((TOTAL_DURATION / 60))
        TOTAL_SECS=$((TOTAL_DURATION % 60))
        echo "Total:       ${TOTAL_MINS}m ${TOTAL_SECS}s" >>"$OMAKUB_INSTALL_LOG_FILE"
      fi
    fi
    echo "=================================" >>"$OMAKUB_INSTALL_LOG_FILE"
  fi
}

run_logged() {
  local script="$1"
  local script_name=$(basename "$script" .sh)
  export CURRENT_SCRIPT="$script"

  # ANSI escape codes
  local ANSI_CLEAR_LINE="\033[K"        # Clear from cursor to end of line
  local ANSI_CARRIAGE_RETURN="\r"       # Return to start of line
  local ANSI_GREEN="\033[32m"           # Green color
  local ANSI_RED="\033[31m"             # Red color
  local ANSI_RESET="\033[0m"            # Reset all attributes

  # Check if there are any PATH updates to apply
  if [[ -f "$HOME/.local/state/omakub/.env_update" ]]; then
    source "$HOME/.local/state/omakub/.env_update"
  fi

  echo "[$(date '+%Y-%m-%d %H:%M:%S')] Starting: $script" >>"$OMAKUB_INSTALL_LOG_FILE"
  # Create a temporary file to capture the exit code
  local temp_exit_file=$(mktemp)
  # Execute the script in background with updated environment
  (
    # Source environment updates in the subshell too
    [[ -f "$HOME/.local/state/omakub/.env_update" ]] && source "$HOME/.local/state/omakub/.env_update"
    bash -c "source '$script'" </dev/null >>"$OMAKUB_INSTALL_LOG_FILE" 2>&1
    echo $? > "$temp_exit_file"
  ) &
  local bg_pid=$!
  # Show spinner while script runs
  gum spin --spinner dot --title "Installing $script_name..." -- bash -c "
    while kill -0 $bg_pid 2>/dev/null; do
      sleep 0.1
    done
  "
  # Wait for background process to complete and get exit code
  wait $bg_pid 2>/dev/null
  local exit_code=$(cat "$temp_exit_file")
  rm -f "$temp_exit_file"
  if [ $exit_code -eq 0 ]; then
    # Success - replace the spinner line with completion status
    printf "${ANSI_CARRIAGE_RETURN}${ANSI_CLEAR_LINE}${PADDING_LEFT_SPACES}${ANSI_GREEN}✓${ANSI_RESET}  Completed $script_name\n"
    echo "[$(date '+%Y-%m-%d %H:%M:%S')] Completed: $script" >>"$OMAKUB_INSTALL_LOG_FILE"
    unset CURRENT_SCRIPT
    return 0
  else
    # Failure - replace the spinner line with error status
    printf "${ANSI_CARRIAGE_RETURN}${ANSI_CLEAR_LINE}${PADDING_LEFT_SPACES}${ANSI_RED}✗${ANSI_RESET}  Failed $script_name\n"
    echo "[$(date '+%Y-%m-%d %H:%M:%S')] Failed: $script (exit code: $exit_code)" >>"$OMAKUB_INSTALL_LOG_FILE"
    return $exit_code
  fi
}