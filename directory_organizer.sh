#!/bin/bash

# Function to organize files by extension
organize_files() {
  echo "Enter the directory to organize:"
  read dir

  if [ ! -d "$dir" ]; then
    echo "Directory does not exist."
    return
  fi

  for file in "$dir"/*; do
    if [ -f "$file" ]; then
      ext="${file##*.}"
      mkdir -p "$dir/$ext"
      mv "$file" "$dir/$ext"
    fi
  done
  echo "Files organized by extension."
}

organize_files
