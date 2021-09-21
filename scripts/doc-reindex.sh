#!/usr/bin/env bash

SCRIPTDIR=$(dirname "$0")
source "$SCRIPTDIR/util.sh"

ddev typo3 kitodo:reindex --pid "$KITODO_PID" --solr "$KITODO_SOLR" --all --verbose
