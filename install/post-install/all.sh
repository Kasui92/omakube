#!/bin/bash
run_logged $OMAKUB_INSTALL/post-install/revert-no-sleep.sh
run_logged $OMAKUB_INSTALL/post-install/warnings.sh
source $OMAKUB_INSTALL/post-install/finished.sh
