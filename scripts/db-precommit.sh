#!/usr/bin/env bash

SCRIPTDIR=$(dirname "$0")

"$SCRIPTDIR/db-cleanup.sh"
"$SCRIPTDIR/db-export.sh"
