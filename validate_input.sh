#!/bin/bash

# Directory and file to store the insurance details
directory="insurance_files"
database_file="${directory}/insurance_database.txt"

# Function to validate date format (YYYY-MM-DD)
validate_date() {
    date -d "$1" "+%Y-%m-%d" >/dev/null 2>&1
    return $?
}

# Function to capture vehicle insurance details
capture_vehicle_details() {
    while true; do
        read -p "Enter Vehicle No: " vehicle_no
        if [[ $vehicle_no =~ ^[A-Za-z0-9]+$ ]]; then
            break
        else
            echo "Invalid Vehicle No. Please enter alphanumeric characters only."
        fi
    done

    while true; do
        read -p "Enter Vehicle Type (2-wheeler/4-wheeler): " vehicle_type
        if [[ $vehicle_type == "2-wheeler" || $vehicle_type == "4-wheeler" ]]; then
            break
        else
            echo "Invalid Vehicle Type. Please enter '2-wheeler' or '4-wheeler'."
        fi
    done

    while true; do
        read -p "Enter Customer Name: " customer_name
        if [[ $customer_name =~ ^[A-Za-z\ ]+$ ]]; then
            break
        else
            echo "Invalid Customer Name. Please enter alphabetic characters and spaces only."
        fi
    done

    while true; do
        read -p "Enter Engine No: " engine_no
        if [[ $engine_no =~ ^[A-Za-z0-9]+$ ]]; then
            break
        else
            echo "Invalid Engine No. Please enter alphanumeric characters only."
        fi
    done

    while true; do
        read -p "Enter Chasis No: " chasis_no
        if [[ $chasis_no =~ ^[A-Za-z0-9]+$ ]]; then
            break
        else
            echo "Invalid Chasis No. Please enter alphanumeric characters only."
        fi
    done

    while true; do
        read -p "Enter Phone No: " phone_no
        if [[ $phone_no =~ ^[0-9]{10}$ ]]; then
            break
        else
            echo "Invalid Phone No. Please enter a 10-digit phone number."
        fi
    done

    while true; do
        read -p "Enter Premium Amount: " premium_amount
        if [[ $premium_amount =~ ^[0-9]+(\.[0-9]{1,2})?$ ]]; then
            break
        else
            echo "Invalid Premium Amount. Please enter a valid number (e.g., 1000 or 1000.50)."
        fi
    done

    while true; do
        read -p "Enter Type (Full Insurance/ThirdParty): " insurance_type
        if [[ $insurance_type == "Full Insurance" || $insurance_type == "ThirdParty" ]]; then
            break
        else
            echo "Invalid Type. Please enter 'Full Insurance' or 'ThirdParty'."
        fi
    done

    while true; do
        read -p "Enter From Date (YYYY-MM-DD): " from_date
        if validate_date "$from_date"; then
            break
        else
            echo "Invalid From Date. Please enter a valid date in YYYY-MM-DD format."
        fi
    done

    while true; do
        read -p "Enter To Date (YYYY-MM-DD): " to_date
        if validate_date "$to_date"; then
            break
        else
            echo "Invalid To Date. Please enter a valid date in YYYY-MM-DD format."
        fi
    done

    underwriter_id=$(date +%s)

    details="${vehicle_no}|${vehicle_type}|${customer_name}|${engine_no}|${chasis_no}|${phone_no}|${premium_amount}|${insurance_type}|${from_date}|${to_date}|${underwriter_id}"

    if [ ! -d "$directory" ]; then
        mkdir "$directory"
    fi

    echo "$details" >> "$database_file"

    echo "Insurance details saved to $database_file"
}

# Function to search for insurance details by vehicle number
search_vehicle_details() {
    read -p "Enter Vehicle No to search: " search_vehicle_no
    found=0

    if [ -f "$database_file" ]; then
        awk -F"|" -v search_vehicle_no="$search_vehicle_no" '
        $1 == search_vehicle_no {
            print "Vehicle No: " $1
            print "Vehicle Type: " $2
            print "Customer Name: " $3
            print "Engine No: " $4
            print "Chasis No: " $5
            print "Phone No: " $6
            print "Premium Amount: " $7
            print "Insurance Type: " $8
            print "From Date: " $9
            print "To Date: " $10
            print "Underwriter ID: " $11
            print "-------------------------"
            found=1
        }
        END {
            if (found == 0) {
                print "No records found for Vehicle No: " search_vehicle_no
            }
        }' "$database_file"
    else
        echo "No records found. Database file does not exist."
    fi
}

# Function to delete insurance details by vehicle number
delete_vehicle_details() {
    read -p "Enter Vehicle No to delete: " delete_vehicle_no
    found=0

    if [ -f "$database_file" ]; then
        tmp_file=$(mktemp)

        awk -F"|" -v delete_vehicle_no="$delete_vehicle_no" '
        $1 == delete_vehicle_no { found=1; next }
        { print }' "$database_file" > "$tmp_file"

        mv "$tmp_file" "$database_file"

        if [ $found -eq 1 ]; then
            echo "Record with Vehicle No: $delete_vehicle_no has been deleted."
        else
            echo "No records found for Vehicle No: $delete_vehicle_no."
        fi
    else
        echo "No records found. Database file does not exist."
    fi
}

# Function to print the entire database file as a table
print_database_as_table() {
    if [ -f "$database_file" ]; then
        echo "Vehicle No | Vehicle Type | Customer Name | Engine No | Chasis No | Phone No | Premium Amount | Insurance Type | From Date | To Date | Underwriter ID"
        echo "-----------------------------------------------------------------------------------------------------------------------------"
        awk -F"|" '
        {
            printf "%-11s | %-12s | %-13s | %-9s | %-9s | %-10s | %-14s | %-14s | %-10s | %-7s | %-14s\n", $1, $2, $3, $4, $5, $6, $7, $8, $9, $10, $11
        }' "$database_file"
    else
        echo "No records found. Database file does not exist."
    fi
}

# Main menu
while true; do
    echo "1. Capture Vehicle Insurance Details"
    echo "2. Search Vehicle Insurance Details"
    echo "3. Delete Vehicle Insurance Details"
    echo "4. Print Database as Table"
    echo "5. Exit"
    read -p "Choose an option: " choice

    case $choice in
        1)
            capture_vehicle_details
            ;;
        2)
            search_vehicle_details
            ;;
        3)
            delete_vehicle_details
            ;;
        4)
            print_database_as_table
            ;;
        5)
            exit 0
            ;;
        *)
            echo "Invalid option. Please choose again."
            ;;
    esac
done
