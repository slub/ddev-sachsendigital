#!/usr/bin/env bash

SCRIPTDIR=$(dirname "$0")
source "$SCRIPTDIR/util.sh"

DBFILE=$(db_file $1)

ddev export-db --gzip=false -f "$DBFILE"

echo
echo -e "\033[0;33mPlease cleanup dump before committing.\033[0m"
