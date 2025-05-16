#!/bin/bash

# A Simple Bash Script that generate random birthdays

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

BLINK='\e[5m'	       # Blink

# Declare array of months
months=(January February March April May June July August September October November December)

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
              (        (
             ( )      ( )          (
      (       Y        Y          ( )
     ( )     |"|      |"|          Y
      Y      | |      | |         |"|
     |"|     | |.-----| |---.___  | |
     | |  .--| |,~~~~~| |~~~,,,,'-| |
     | |-,,~~'-'___   '-'       ~~| |._
    .| |~       // ___            '-',,'.
   /,'-'     <_// // _  __             ~,\
  / ;     ,-,     \\_> <<_______________;_)
  | ;    {(_)} _,      . |================|
  | '-._ ~~,,,           | ,,             |
  |     '-.__ ~~~~~~~~~~~|________________|   
  |\         `'----------|
  | '=._                 | ./birthday.sh .
  :     '=.__            |   .     . .
   \         `'==========|.  .      .  .
    '-._                 |  .  . .    .
        '-.__            | .  .   . .
             `'----------|. .   .  

      ┌┐ ┬┬─┐┌┬┐┬ ┬┌┬┐┌─┐┬ ┬┌─┐┬ ┬
      ├┴┐│├┬┘ │ ├─┤ ││├─┤└┬┘└─┐├─┤
      └─┘┴┴└─ ┴ ┴ ┴─┴┘┴ ┴ ┴o└─┘┴ ┴
EOF
    echo -e "${RESET}"  # Reset color
}

# Ascii Art Display


# Function to generate a random date
generate_random_birthday() {
    # Select a random month
    month_index=$(( RANDOM % 12 ))
    month=${months[$month_index]}

    # Set days in month (assuming non-leap year for simplicity)
    case $month in
        January|March|May|July|August|October|December)
            max_days=31
            ;;
        April|June|September|November)
            max_days=30
            ;;
        February)
            # Check if leap year for February
            year=$(($RANDOM % 31 + 1990)) # Generate between 1990 and 2020
            if (( (year % 4 == 0 && year % 100 != 0) || (year % 400 == 0) )); then
                max_days=29
            else
                max_days=28
            fi
            ;;
    esac

    # Select a random day
    day=$(( RANDOM % max_days + 1 ))

    # Randomly generate a year between 1990 and 2023
    year=$(( RANDOM % 34 + 1990 ))

    # Format day with suffix (st, nd, rd, th)
    if [[ $day -eq 1 || $day -eq 21 || $day -eq 31 ]]; then
        suffix="st"
    elif [[ $day -eq 2 || $day -eq 22 ]]; then
        suffix="nd"
    elif [[ $day -eq 3 || $day -eq 23 ]]; then
        suffix="rd"
    else
        suffix="th"
    fi

    echo -e "${WHITEB}       $month, $day$suffix $year${RESET}"

}

# Main script execution
ascii_banner
echo -e "${BLUEB} Here ${YELLOWB}Are ${GREENB}Your ${PURPLEB}${BLINK}9 ${RESET}${CYANB}Random ${REDB}Birthdays${BLUE}...${RESET}"
echo
for ((i = 0; i < 9; i++)); do
    generate_random_birthday
done
