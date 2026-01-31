#!/bin/bash

# Warning on x11 sessions to use Wayland instead
if [ "$XDG_SESSION_TYPE" = "x11" ]; then
  echo -e "\e[33m\nWarning: You are currently using an X11 session. It is recommended to switch to a Wayland session for the best experience with $OMAKUB_BRAND.\e[0m"
  echo -e "\e[33mYou can select the Wayland session at the login screen by clicking on the gear icon and choosing 'Ubuntu (Wayland)'.\e[0m"
  echo
fi