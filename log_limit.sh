#!/bin/bash

LOG_DIR="/var/log/myapp"
ARCHIVE_DIR="/var/log/myapp/archive"
LOG_FILE="$LOG_DIR/myapp.log"
MAX_SIZE=1000000 # Max log size in bytes (1MB)

# Function to rotate logs
rotate_logs() {
  if [ ! -d "$ARCHIVE_DIR" ]; then
    mkdir -p "$ARCHIVE_DIR"
  fi

  log_size=$(stat -c%s "$LOG_FILE")

  if [ "$log_size" -ge "$MAX_SIZE" ]; then
    timestamp=$(date +%Y-%m-%d_%H-%M-%S)
    mv "$LOG_FILE" "$ARCHIVE_DIR/myapp_$timestamp.log"
    gzip "$ARCHIVE_DIR/myapp_$timestamp.log"
    touch "$LOG_FILE"
    echo "Logs rotated."
  else
    echo "Log size is within limit."
  fi
}

# Execute log rotation
rotate_logs
