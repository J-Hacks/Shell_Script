#!/bin/bash

# Function to create a new user
create_user() {
  echo "Enter the username to create:"
  read username
  sudo useradd "$username"
  echo "User $username created."
}

# Function to delete a user
delete_user() {
  echo "Enter the username to delete:"
  read username
  sudo userdel -r "$username"
  echo "User $username deleted."
}

# Function to reset a user's password
reset_password() {
  echo "Enter the username to reset password:"
  read username
  sudo passwd "$username"
}

# Display the menu
while true; do
  echo "Select an option:"
  echo "1. Create a new user"
  echo "2. Delete a user"
  echo "3. Reset a user's password"
  echo "4. Exit"
  read choice

  case $choice in
    1)
      create_user
      ;;
    2)
      delete_user
      ;;
    3)
      reset_password
      ;;
    4)
      echo "Exiting."
      exit
      ;;
    *)
      echo "Invalid choice, please select again."
      ;;
  esac
done
