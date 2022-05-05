#!/usr/bin/env bash

SCRIPTDIR=$(dirname "$0")

# Create and start containers
ddev start

# Install dependencies
ddev composer install

# Import database dump
"$SCRIPTDIR/db-import.sh"

# Download images (institutions)
"$SCRIPTDIR/download-images.sh"
