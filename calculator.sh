#!/bin/bash

# Function to perform addition
addition() {
  result=$(echo "$1 + $2" | bc)
  echo "Result: $result"
}

# Function to perform subtraction
subtraction() {
  result=$(echo "$1 - $2" | bc)
  echo "Result: $result"
}

# Function to perform multiplication
multiplication() {
  result=$(echo "$1 * $2" | bc)
  echo "Result: $result"
}

# Function to perform division
division() {
  if [ "$2" == "0" ]; then
    echo "Error: Division by zero is not allowed."
  else
    result=$(echo "scale=2; $1 / $2" | bc)
    echo "Result: $result"
  fi
}

# Get user input
echo "Enter two numbers: "
read num1
read num2

# Display the menu
while true; do
  echo "Select an operation:"
  echo "1. Addition"
  echo "2. Subtraction"
  echo "3. Multiplication"
  echo "4. Division"
  echo "5. Exit"
  read choice

  case $choice in
    1)
      addition "$num1" "$num2"
      ;;
    2)
      subtraction "$num1" "$num2"
      ;;
    3)
      multiplication "$num1" "$num2"
      ;;
    4)
      division "$num1" "$num2"
      ;;
    5)
      echo "Exiting the calculator."
      exit
      ;;
    *)
      echo "Invalid choice, please select again."
      ;;
  esac
done
