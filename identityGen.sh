#!/bin/bash

set -euo pipefail
IFS=$'\n\t'

# Define color escape codes

# Regular Colors
RED='\033[0;31m'       # Red
GREEN='\033[0;32m'     # Green
YELLOW='\033[0;33m'    # Yellow
BLUE='\033[0;34m'      # Blue
CYAN='\033[0;36m'      # Cyan
PURPLE='\033[0;35m'    # Purple
WHITE='\033[0;37m'     # White
RESET='\033[0m'        # Reset

# Bold Colors
REDB='\033[1;31m'      # Red
GREENB='\033[1;32m'    # Green
YELLOWB='\033[1;33m'   # Yellow
BLUEB='\033[1;34m'     # Blue
CYANB='\033[1;36m'     # Cyan
PURPLEB='\033[1;35m'   # Purple
WHITEB='\033[1;37m'    # White

# Array of color names
allcolors=("RED" "GREEN" "YELLOW" "BLUE" "CYAN" "PURPLE" "WHITE")

# Function to print banner with a random color
ascii_banner() {

    # Pick a random color from the allcolors array
    random_color="${allcolors[$((RANDOM % ${#allcolors[@]}))]}"

    # Convert the color name to the actual escape code
    case $random_color in
        "RED") color_code=$RED ;;
        "GREEN") color_code=$GREEN ;;
        "YELLOW") color_code=$YELLOW ;;
        "BLUE") color_code=$BLUE ;;
        "CYAN") color_code=$CYAN ;;
        "PURPLE") color_code=$PURPLE ;;
        "WHITE") color_code=$WHITE ;;
    esac

#--------) Display ASCII banner (--------#

   # Print the banner in the chosen color
    echo -e "${color_code}"
    cat << "EOF"
              _
             | |
             | |===( )   //////
             |_|   |||  | o o|
                    ||| ( c  )                  ____
                     ||| \= /                  ||   \_
                      ||||||                   ||     |
                      ||||||                ...||__/|-"
                      ||||||             __|________|__
                        |||             |______________|
                        |||             || ||      || ||
  identityGen.sh        |||             || ||      || ||
------------------------|||-------------||-||------||-||-------
                        |__>            || ||      || ||
EOF
    echo -e "${RESET}"  # Reset color
}

# Default output file
outfile="${2:-IDs}"

# Check if 'rig' command is available
if ! command -v rig &> /dev/null; then
    echo -e "${REDB}Error${RESET}: ${YELLOWB}rig command is not found${RESET}. ${BLUEB}Please install rig first${RESET}."
    exit 1
fi

ascii_banner

# Get the number of IDs to generate (from argument or prompt)
if [ $# -eq 0 ]; then
    echo -e "${WHITEB}"
    read -rp "Enter the number of IDs to generate: " num
else
    num=$1
fi

# Validate the number
if ! [[ "$num" =~ ^[0-9]+$ ]]; then
    echo "Error: Please provide a valid number."
    exit 1
fi

# Confirm overwrite if the output file exists
if [ -f "$outfile" ]; then
    echo -e "${YELLOWB}"
    read -rp "Warning: $outfile already exists. Overwrite? (y/n) " confirm
    echo -e "${RESET}"
    if [ "$confirm" != "y" ]; then
        echo "Aborting script."
        exit 1
    fi
    rm "$outfile"
fi

# Generate IDs using rig and store in temporary file
temp_file=$(mktemp)
rig -c "$num" > "$temp_file"

# Check rig exit status
if [ $? -ne 0 ]; then
    echo -e "${REDB}Error${RESET}: ${YELLOW}Failed to generate IDs using ${YELLOWB}rig${RESET}."
    rm "$temp_file"
    exit 1
fi

# Process and write to a safe output file
output_temp=$(mktemp)
while IFS= read -r line; do
    if [[ $line == *"xxx-xxxx"* ]]; then
        # Extract area code using regex
        areacode=$(echo "$line" | grep -oP '\(\K[0-9]{3}(?=\))')

        # Generate a phone number with the same area code
        phone_number=$(printf "(%s) %03d-%04d" "$areacode" "$((100 + RANDOM % 900))" "$((1000 + RANDOM % 9000))")

        echo -e "${CYANB}$phone_number${RESET}" >> "$output_temp"
    else
        echo -e "${WHITEB}$line${RESET}" >> "$output_temp"
    fi
done < "$temp_file"

# Move final result to target file
mv "$output_temp" "$outfile"

# Cleanup
rm "$temp_file"

echo -e "✅ ${BLUEB}ID generation complete${RESET}. ${CYANB}Output written to ${GREENB}$outfile."
echo
