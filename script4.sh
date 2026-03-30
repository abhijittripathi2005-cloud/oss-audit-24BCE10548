#!/bin/bash
# Script 4: Log File Analyzer
# Author: Abhijit Tripathi | Reg: 24BCE10548
# Usage: ./log_analyzer.sh /var/log/syslog [KEYWORD]

LOGFILE=$1
KEYWORD=${2:-"error"}
COUNT=0
ATTEMPTS=0
MAX_ATTEMPTS=3

if [ -z "$LOGFILE" ]; then
    echo "Usage: $0 <logfile> [keyword]"
    exit 1
fi

# do-while style retry if file missing or empty
while true; do
    ATTEMPTS=$((ATTEMPTS + 1))
    if [ ! -f "$LOGFILE" ]; then
        echo "Attempt $ATTEMPTS: File $LOGFILE not found."
    elif [ ! -s "$LOGFILE" ]; then
        echo "Attempt $ATTEMPTS: File is empty."
    else
        break
    fi
    [ $ATTEMPTS -ge $MAX_ATTEMPTS ] && { echo "Max attempts reached."; exit 1; }
    sleep 1
done

echo "Scanning $LOGFILE for: '$KEYWORD'"

while IFS= read -r LINE; do
    if echo "$LINE" | grep -iq "$KEYWORD"; then
        COUNT=$((COUNT + 1))
    fi
done < "$LOGFILE"

echo "Keyword '$KEYWORD' found $COUNT times in $LOGFILE"
echo "--- Last 5 matching lines ---"
grep -i "$KEYWORD" "$LOGFILE" | tail -5
