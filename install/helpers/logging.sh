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

  echo "[$(date '+%Y-%m-%d %H:%M:%S')] Starting: $script" >>"$OMAKUB_INSTALL_LOG_FILE"

  # Use gum spin to show progress - output to stderr to avoid interfering with line replacement
  if gum spin --spinner dot --title "Installing $script_name..." -- bash -c "source '$script'" </dev/null >>"$OMAKUB_INSTALL_LOG_FILE" 2>&1; then
    # Success - replace the spinner line with completion status
    printf "\r\033[K\033[32m✓\033[0m Completed $script_name\n"
    echo "[$(date '+%Y-%m-%d %H:%M:%S')] Completed: $script" >>"$OMAKUB_INSTALL_LOG_FILE"
    unset CURRENT_SCRIPT
    return 0
  else
    # Failure - replace the spinner line with error status
    local exit_code=$?
    printf "\r\033[K\033[31m✗\033[0m Failed $script_name\n"
    echo "[$(date '+%Y-%m-%d %H:%M:%S')] Failed: $script (exit code: $exit_code)" >>"$OMAKUB_INSTALL_LOG_FILE"
    return $exit_code
  fi
}
