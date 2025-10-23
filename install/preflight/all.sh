#!/bin/bash

source $OMAKUB_INSTALL/preflight/guard.sh
source $OMAKUB_INSTALL/preflight/begin.sh
source $OMAKUB_INSTALL/preflight/no-sleep.sh
source $OMAKUB_INSTALL/preflight/identification.sh
run_logged $OMAKUB_INSTALL/preflight/migrations.sh
