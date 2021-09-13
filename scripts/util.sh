#!/usr/bin/env bash

KITODO_SOLR=1
KITODO_PID=2

function db_file()
{
    if [ -z $1 ]; then
        SCRIPTDIR=$(dirname "$0")
        DBFILE="$SCRIPTDIR/../data/db.sql"
    else
        DBFILE=$1
    fi

    realpath "$DBFILE"
}
