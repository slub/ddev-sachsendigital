#!/usr/bin/env bash

if [ $# -ne 1 ]; then
    echo "Usage: $0 <docs-file>"
    echo
    echo "docs-file:"
    echo "  Path to file that lists which document URLs should be indexed."

    exit 1
fi

SCRIPTDIR=$(dirname "$0")
source "$SCRIPTDIR/util.sh"

DOCUMENTS=$(cat "$1")

for doc in $DOCUMENTS; do
    ddev typo3 kitodo:index --pid "$KITODO_PID" --solr "$KITODO_SOLR" --doc "\"$doc\"" --verbose
done
