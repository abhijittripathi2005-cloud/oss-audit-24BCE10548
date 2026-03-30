#!/bin/bash
# Script 2: FOSS Package Inspector
# Author: Abhijit Tripathi | Reg: 24BCE10548

PACKAGE="git"

# Check if git is installed using dpkg (Debian/Ubuntu)
if dpkg -l "$PACKAGE" &>/dev/null; then
    echo "$PACKAGE is installed."
    echo "--- Package details ---"
    dpkg -s "$PACKAGE" | grep -E 'Version|Status|Maintainer|Homepage'
else
    echo "$PACKAGE is NOT installed."
fi

echo ""
echo "--- Open Source Philosophy Note ---"

case $PACKAGE in
    git)   echo "Git: built in a crisis, open-sourced by principle." ;;
    httpd|apache2) echo "Apache: the web server that built the open internet." ;;
