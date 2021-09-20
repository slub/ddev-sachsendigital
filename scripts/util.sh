#!/usr/bin/env bash

KITODO_SOLR=1
KITODO_PID=2

function file_or_default()
{
    if [ -z $1 ]; then
        SCRIPTDIR=$(dirname "$0")
        DBFILE=$2
    else
        DBFILE=$1
    fi

    realpath "$DBFILE"
}

function db_file()
{
    file_or_default $1 "$SCRIPTDIR/../data/db.sql"
}
