#!/usr/bin/env bash

set -euo pipefail

RMD_FILE="cv.Rmd"
LIBRARY="font-awesome"

CURRENT_VERSION=$(
    grep -oE 'cdnjs\.cloudflare\.com/ajax/libs/font-awesome/[0-9]+\.[0-9]+\.[0-9]+' "$RMD_FILE" |
    head -n 1 |
    grep -oE '[0-9]+\.[0-9]+\.[0-9]+'
)

LATEST_VERSION=$(
    curl -fsSL "https://api.cdnjs.com/libraries/$LIBRARY?fields=version" |
    grep -oE '"version":"[^"]+"' |
    head -n 1 |
    cut -d'"' -f4
)

echo "Font Awesome: $CURRENT_VERSION -> $LATEST_VERSION"

if [[ "$CURRENT_VERSION" == "$LATEST_VERSION" ]]; then
    echo "Already up to date."
    exit 0
fi

echo "Update available."

if [[ "${1:-}" == "--update" ]]; then
    sed -i.bak \
        "s|font-awesome/$CURRENT_VERSION/css/all.min.css|font-awesome/$LATEST_VERSION/css/all.min.css|" \
        "$RMD_FILE"

    rm -f "${RMD_FILE}.bak"

    echo "Updated $RMD_FILE"
else
    echo
    echo "Run './check-fontawesome.sh --update' to update cv.Rmd."
fi
