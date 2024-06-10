#!/bin/bash

# Function to set an alarm
set_alarm() {
  echo "Enter the alarm time in HH:MM format (24-hour):"
  read alarm_time

  while true; do
    current_time=$(date +%H:%M)
    if [ "$current_time" == "$alarm_time" ]; then
      echo "Alarm! It's $alarm_time."
      break
    fi
    sleep 30
  done
}

set_alarm
