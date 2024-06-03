#!/bin/bash

DB_USER="root"
DB_PASSWORD="password"
DB_NAME="mydatabase"
BACKUP_DIR="/var/backups/mysql"
DATE=$(date +%Y-%m-%d_%H-%M-%S)
BACKUP_FILE="$BACKUP_DIR/$DB_NAME-$DATE.sql"

# Function to back up the database
backup_database() {
  echo "Backing up database $DB_NAME..."
  mkdir -p "$BACKUP_DIR"
  mysqldump -u "$DB_USER" -p"$DB_PASSWORD" "$DB_NAME" > "$BACKUP_FILE"
  
  if [ $? -ne 0 ]; then
    echo "Database backup failed."
    exit 1
  fi
  
  echo "Database backup completed: $BACKUP_FILE"
}

# Function to restore the database
restore_database() {
  echo "Enter the path of the backup file to restore:"
  read restore_file
  
  if [ ! -f "$restore_file" ]; then
    echo "Backup file not found."
    exit 1
  fi
  
  echo "Restoring database $DB_NAME..."
  mysql -u "$DB_USER" -p"$DB_PASSWORD" "$DB_NAME" < "$restore_file"
  
  if [ $? -ne 0 ]; then
    echo "Database restore failed."
    exit 1
  fi
  
  echo "Database restore completed."
}

# Display the menu
while true; do
  echo "Select an option:"
  echo "1. Back up database"
  echo "2. Restore database"
  echo "3. Exit"
  read choice

  case $choice in
    1)
      backup_database
      ;;
    2)
      restore_database
      ;;
    3)
      echo "Exiting."
      exit
      ;;
    *)
      echo "Invalid choice, please select again."
      ;;
  esac
done
