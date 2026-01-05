#!/bin/bash

run_logged $OMAKUB_INSTALL/config/config.sh
run_logged $OMAKUB_INSTALL/config/git.sh
run_logged $OMAKUB_INSTALL/config/branding.sh
run_logged $OMAKUB_INSTALL/config/xcompose.sh
run_logged $OMAKUB_INSTALL/config/mise-work.sh
run_logged $OMAKUB_INSTALL/config/mimetypes.sh
run_logged $OMAKUB_INSTALL/config/terminal.sh
run_logged $OMAKUB_INSTALL/config/localdb.sh
run_logged $OMAKUB_INSTALL/config/hardware/fix-fkeys.sh
run_logged $OMAKUB_INSTALL/config/hardware/fix-framework-text-scaling.sh
run_logged $OMAKUB_INSTALL/config/gnome/app-grid.sh
run_logged $OMAKUB_INSTALL/config/gnome/dock.sh
source $OMAKUB_INSTALL/config/gnome/request-confirm.sh
run_logged $OMAKUB_INSTALL/config/gnome/extensions.sh
run_logged $OMAKUB_INSTALL/config/gnome/hotkeys.sh
run_logged $OMAKUB_INSTALL/config/gnome/settings.sh
run_logged $OMAKUB_INSTALL/config/theme.sh