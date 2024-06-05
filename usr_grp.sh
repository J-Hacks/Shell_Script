#!/bin/bash

create_user() {
  echo "Enter the username to create:"
  read username
  sudo useradd "$username"
  sudo passwd "$username"
  echo "User $username created and password set."

  echo "Enter the group to assign to the user:"
  read group
  sudo usermod -aG "$group" "$username"
  echo "User $username assigned to group $group."
}

create_user
