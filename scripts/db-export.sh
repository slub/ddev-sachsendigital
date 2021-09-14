#!/usr/bin/env bash

SCRIPTDIR=$(dirname "$0")
source "$SCRIPTDIR/util.sh"

DBFILE=$(db_file $1)

# The `head` command is to remove timestamp
ddev export-db --gzip=false | head --lines=-2 > "$DBFILE"

echo
echo -e "\033[0;33mBefore committing, please check that the dump is sane.\033[0m"
