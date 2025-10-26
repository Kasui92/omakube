#!/bin/bash

UNINSTALLER=$(ls -1 $OMAKUB_PATH/uninstall)

CHOICE=$(gum choose "$UNINSTALLER" "<< Back" --height $(( $(echo "$UNINSTALLER" | wc -l) + 2 )) --header "Uninstall application")

if [[ "$CHOICE" == "<< Back"* ]] || [[ -z "$CHOICE" ]]; then
  # Don't uninstall anything
  echo ""
else
  [ -n "$CHOICE" ] && gum confirm "Run uninstaller?" && source $CHOICE && gum spin --spinner globe --title "Uninstall completed!" -- sleep 3
fi

clear
source $OMAKUB_PATH/bin/omakub
