#!/usr/bin/env bash

SCRIPTDIR=$(dirname "$0")

if [ $# -ne 1 ]; then
    echo "Usage: $0 <solr-base-url>"
    echo
    echo "solr-base-url:"
    echo "  Full URL of the Solr endpoint (e.g. 'http://localhost:8983/solr')"

    exit 1
fi

BASE_URL=$1
DATA_DIR="$SCRIPTDIR/../data"

if [ -z "$BASE_URL" ]; then
    echo "Please enter the Solr base URL."
    exit 1
fi

function collection()
{
    COLL_KEY=$1
    COLL_NAME=$2

    echo $COLL_NAME

    # fl = field list
    # fq = filter query
    # wt = writer type

    DOCS=$(wget -q -O- "$BASE_URL/dlfCore0/select?fl=location&fq=toplevel:true&q=collection:(\"$COLL_NAME\")&rows=5000&wt=csv")

    if [ $? -eq 0 ]; then
        DOCS_PATH=$(realpath "$DATA_DIR/$COLL_KEY")
        echo "$DOCS" | tail +2 > $DOCS_PATH
        echo -e " -> \033[0;32m$DOCS_PATH\033[0m"
    else
        echo -e " -> \033[0;31mError\033[0m"
    fi

    echo
}

collection ldp_bacharchiv "LDP: Bach-Archiv Leipzig - Sammlung Manfred Gorke"
collection ldp_stadtarchiv_dresden "LDP: Bestände des Stadtarchivs Dresden"
collection ldp_stuhlbaumuseum "LDP: Bestände des Deutschen Stuhlbaumuseums Rabenau"
