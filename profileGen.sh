#!/bin/bash
set -euo pipefail
IFS=$'\n\t'

# ========== Colors ==========
RED='\033[0;31m'; GREEN='\033[0;32m'; YELLOW='\033[0;33m'
BLUE='\033[0;34m'; CYAN='\033[0;36m'; PURPLE='\033[0;35m'
WHITE='\033[0;37m'; RESET='\033[0m'

REDB='\033[1;31m'; GREENB='\033[1;32m'; YELLOWB='\033[1;33m'
BLUEB='\033[1;34m'; CYANB='\033[1;36m'; PURPLEB='\033[1;35m'
WHITEB='\033[1;37m'; BLINK='\e[5m'

months=(January February March April May June July August September October November December)
allcolors=("RED" "GREEN" "YELLOW" "BLUE" "CYAN" "PURPLE" "WHITE")

# ========== ASCII Banner ==========
ascii_banner() {
    random_color="${allcolors[$((RANDOM % ${#allcolors[@]}))]}"
    case $random_color in
        "RED") color_code=$RED ;;
        "GREEN") color_code=$GREEN ;;
        "YELLOW") color_code=$YELLOW ;;
        "BLUE") color_code=$BLUE ;;
        "CYAN") color_code=$CYAN ;;
        "PURPLE") color_code=$PURPLE ;;
        "WHITE") color_code=$WHITE ;;
    esac

    echo -e "${color_code}"
    cat << "EOF"
      ,
(`-.-/(           .:::::.,
 `-.__)             ``:\:: .               /7_.-,
     '. -.       -  - `:::'           .- (  `_.=
       \  `--._   /   _?'`      ___.-'   -`"'
        \         -  / )----'''' -    .-'
         `--..   `--' ,'           .-'
              `\   --'       )---''
                )           )
                |          _|
                (           \
                 L          /
                 |          \
                 )__     _   \
                  \ `---' `--'
                   L         \
                   |   \      \
                    \   L     )
                     L_ (      \
                     |   \  .  J
                     |    `.    \
                  _.-`--='  \    )
                 (   _-'     `--'\
                  '"'        / ' J
                            (,_./
EOF
    echo -e "${RESET}"
}

# ========== Random Birthday ==========
generate_random_birthday() {
    month_index=$(( RANDOM % 12 ))
    month=${months[$month_index]}

    case $month in
        January|March|May|July|August|October|December) max_days=31 ;;
        April|June|September|November) max_days=30 ;;
        February)
            year=$((RANDOM % 31 + 1990))
            if (( (year % 4 == 0 && year % 100 != 0) || (year % 400 == 0) )); then
                max_days=29
            else
                max_days=28
            fi
            ;;
    esac

    day=$((RANDOM % max_days + 1))
    year=$((RANDOM % 34 + 1990))

    case $day in
        1|21|31) suffix="st" ;;
        2|22) suffix="nd" ;;
        3|23) suffix="rd" ;;
        *) suffix="th" ;;
    esac

    echo -e "${WHITEB}$month $day$suffix, $year${RESET}"
}

# ========== Main Logic ==========

ascii_banner

# Arguments and Output file
outfile="${2:-Profiles}"
if ! command -v rig &> /dev/null; then
    echo -e "${REDB}Error${RESET}: ${YELLOWB}rig command is not found${RESET}. ${BLUEB}Please install rig first${RESET}."
    exit 1
fi

if [ $# -eq 0 ]; then
    echo -e "${WHITEB}"
    read -rp "Enter the number of Profiles to generate: " num
    echo -e "${RESET}"
else
    num=$1
fi

if ! [[ "$num" =~ ^[0-9]+$ ]]; then
    echo "Error: Please provide a valid number."
    exit 1
fi

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

temp_file=$(mktemp)
rig -c "$num" > "$temp_file" || { echo "Error: rig failed."; rm "$temp_file"; exit 1; }

output_temp=$(mktemp)

echo -e "${BLUEB} Generating ${RED}$num ${CYANB}Profiles${RESET}...${RESET}"
echo

while IFS= read -r line; do
    if [[ $line == *"xxx-xxxx"* ]]; then
        areacode=$(echo "$line" | grep -oP '\(\K[0-9]{3}(?=\))')
        phone_number=$(printf "(%s) %03d-%04d" "$areacode" "$((100 + RANDOM % 900))" "$((1000 + RANDOM % 9000))")
        echo -e "${CYANB}$phone_number${RESET}" >> "$output_temp"
        generate_random_birthday >> "$output_temp"
        echo "" >> "$output_temp"
    else
        echo "$line" >> "$output_temp"
    fi
done < "$temp_file"

mv "$output_temp" "$outfile"
rm "$temp_file"

echo -e "${GREENB}✅ Profile generation complete. ${BLUE}Output written to ${outfile}.${RESET}"
echo
