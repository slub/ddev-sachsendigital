#!/usr/bin/env bash

# This script clones our custom TYPO3 extensions that are used for
# Sachsen.Digital into extensions/ subfolder

SCRIPTDIR=$(dirname "$0")
EXTDIR=$(realpath "$SCRIPTDIR/../extensions")

set -x

mkdir -p "$EXTDIR"

function clone_conf()
{
    REPO_NAME=$(basename "$2")
    DIR_NAME=${REPO_NAME%.git}
    
    ddev composer config "repositories.$1" path "./extensions/$DIR_NAME"
    git clone "$2" "$EXTDIR/$DIR_NAME"
}

clone_conf kitodo-presentation git@github.com:kitodo/kitodo-presentation.git
clone_conf slub-digitalcollections git@github.com:slub/slub_digitalcollections.git
clone_conf slub-web-ldp git@git.slub-dresden.de:slub-webseite/slub-web-ldp.git
