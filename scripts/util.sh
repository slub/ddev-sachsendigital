#!/usr/bin/env bash

function db_file()
{
    if [ -z $1 ]; then
        SCRIPTDIR=$(dirname "$0")
        DBFILE="$SCRIPTDIR/../db.sql"
    else
        DBFILE=$1
    fi

    realpath "$DBFILE"
}
