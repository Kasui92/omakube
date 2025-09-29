#!/bin/bash

source $OMAKUB_INSTALL/preflight/guard.sh
source $OMAKUB_INSTALL/preflight/begin.sh
run_logged $OMAKUB_INSTALL/preflight/migrations.sh
