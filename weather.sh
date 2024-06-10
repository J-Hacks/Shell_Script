#!/bin/bash

# Function to set a reminder
set_reminder() {
  echo "Enter the reminder message:"
  read message
  echo "Enter the time in seconds after which to remind:"
  read seconds
  sleep "$seconds"
  echo "Reminder: $message"
}

set_reminder
