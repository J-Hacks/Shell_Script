#!/bin/bash

# Variables
CPU_THRESHOLD=80
MEM_THRESHOLD=80
DISK_THRESHOLD=80
EMAIL="admin@example.com"

# Function to check CPU usage
check_cpu() {
  cpu_usage=$(top -bn1 | grep "Cpu(s)" | sed "s/.*, *\([0-9.]*\)%* id.*/\1/" | awk '{print 100 - $1}')
  if (( $(echo "$cpu_usage > $CPU_THRESHOLD" | bc -l) )); then
    echo "CPU usage is above threshold: $cpu_usage%" | mail -s "CPU Usage Alert" "$EMAIL"
  fi
}

# Function to check memory usage
check_memory() {
  mem_usage=$(free | grep Mem | awk '{print $3/$2 * 100.0}')
  if (( $(echo "$mem_usage > $MEM_THRESHOLD" | bc -l) )); then
    echo "Memory usage is above threshold: $mem_usage%" | mail -s "Memory Usage Alert" "$EMAIL"
  fi
}

# Function to check disk usage
check_disk() {
  disk_usage=$(df / | grep / | awk '{print $5}' | sed 's/%//')
  if [ "$disk_usage" -gt "$DISK_THRESHOLD" ]; then
    echo "Disk usage is above threshold: $disk_usage%" | mail -s "Disk Usage Alert" "$EMAIL"
  fi
}

# Main monitoring function
monitor() {
  check_cpu
  check_memory
  check_disk
}

# Schedule the monitoring script to run at regular intervals
while true; do
  monitor
  sleep 300 # Check every 5 minutes
done
