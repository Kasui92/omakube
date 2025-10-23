#!/bin/bash

# Exit immediately if a command exits with a non-zero status
set -eEo pipefail

# Define Omakub locations
export OMAKUB_PATH="$HOME/.local/share/omakub"
export OMAKUB_INSTALL="$OMAKUB_PATH/install"
export OMAKUB_INSTALL_LOG_FILE="/var/log/omakub-install.log"
export PATH="$OMAKUB_PATH/bin:$PATH"

# Install
source "$OMAKUB_INSTALL/helpers/all.sh"
source "$OMAKUB_INSTALL/preflight/all.sh"
source "$OMAKUB_INSTALL/packaging/all.sh"
source "$OMAKUB_INSTALL/config/all.sh"
source "$OMAKUB_INSTALL/login/all.sh"
source "$OMAKUB_INSTALL/post-install/all.sh"