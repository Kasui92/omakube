#!/bin/bash

# This script installs many packages and can take a long time
export OMAKUB_SCRIPT_TIMEOUT=1200  # 20 minutes

# Install all base packages
mapfile -t packages < <(grep -v '^#' "$OMAKUB_INSTALL/omakub-base.packages" | grep -v '^$')
sudo apt install -y "${packages[@]}"
