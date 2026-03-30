#!/bin/bash
# Script 3: Disk and Permission Auditor
# Author: Abhijit Tripathi | Reg: 24BCE10548

DIRS=("/etc" "/var/log" "/home" "/usr/bin" "/tmp" "/usr/lib/git-core")

echo "============================="
echo " Directory Audit Report"
echo "============================="

for DIR in "${DIRS[@]}"; do
    if [ -d "$DIR" ]; then
        PERMS=$(ls -ld "$DIR" | awk '{print $1, $3, $4}')
        SIZE=$(du -sh "$DIR" 2>/dev/null | cut -f1)
        echo "$DIR"
        echo "  Permissions/Owner: $PERMS"
        echo "  Size: $SIZE"
        echo "  ---"
    else
        echo "$DIR does not exist on this system"
    fi
done

GIT_CONFIG="/etc/gitconfig"
echo "--- Git Configuration File Check ---"
if [ -f "$GIT_CONFIG" ]; then
    echo "System gitconfig exists: $GIT_CONFIG"
    ls -l "$GIT_CONFIG"
else
    echo "No /etc/gitconfig found (normal if not configured)"
