#!/usr/bin/env bash

SCRIPTDIR=$(dirname "$0")
source "$SCRIPTDIR/util.sh"

DBFILE=$(db_file $1)

ddev import-db --src="$DBFILE"
