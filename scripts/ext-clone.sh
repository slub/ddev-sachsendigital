#!/usr/bin/env bash

# This script clones our custom TYPO3 extenions that are used for
# Sachsen.Digital into extensions/ subfolder

SCRIPTDIR=$(dirname "$0")
EXTDIR=$(realpath "$SCRIPTDIR/../extensions")

set -x

mkdir -p "$EXTDIR"
cd "$EXTDIR"
git clone git@github.com:kitodo/kitodo-presentation.git
git clone git@git.slub-dresden.de:slub-webseite/slub-web-ldp.git
