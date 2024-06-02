#!/bin/bash

# Function to check HTTP status code
check_status_code() {
  echo "Enter the URL to check:"
  read url
  status_code=$(curl -o /dev/null -s -w "%{http_code}\n" "$url")
  echo "HTTP Status Code: $status_code"
}

check_status_code
