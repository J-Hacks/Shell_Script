#!/bin/bash

LOG_FILE="/var/log/syslog"
KEYWORD="error"
OUTPUT_FILE="error_log.txt"

grep "$KEYWORD" "$LOG_FILE" > "$OUTPUT_FILE"
echo "Lines containing '$KEYWORD' have been extracted to $OUTPUT_FILE."
