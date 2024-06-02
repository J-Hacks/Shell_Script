#!/bin/bash

# Function to check disk usage
check_disk_usage() {
  echo "Enter the disk usage threshold (e.g., 80 for 80%):"
  read threshold

  usage=$(df / | grep / | awk '{ print $5 }' | sed 's/%//g')
  if [ "$usage" -gt "$threshold" ]; then
    echo "Warning: Disk usage is at $usage%, which exceeds the threshold of $threshold%."
  else
    echo "Disk usage is at $usage%, which is within the threshold of $threshold%."
  fi
}

check_disk_usage
