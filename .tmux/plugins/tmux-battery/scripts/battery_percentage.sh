#!/usr/bin/env bash

CURRENT_DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )"

source "$CURRENT_DIR/helpers.sh"

# colors {{{
good_color="green"
middle_color="yellow"
warn_color="red"
 
# Apply the correct color to the battery status prompt
apply_colors() {
# Green
if [[ "$BATTERY_STATUS" -ge 75 ]]; then
    COLOR="#[fg=$good_color]"

# Yellow
elif [[ "$BATTERY_STATUS" -ge 25 ]] && [[ $BATTERY_STATUS -lt 75 ]]; then
    COLOR="#[fg=$middle_color]"

# Red
elif [[ "$BATTERY_STATUS" -lt 25 ]]; then
    COLOR="#[fg=$warn_color]"
fi
}
# }}}

print_battery_percentage() {
	# percentage displayed in the 2nd field of the 2nd row
	if command_exists "pmset"; then
		BATTERY_STATUS="$(pmset -g batt | grep -o '[0-9]*%' | tr -d %)"
        apply_colors
        printf "%s%s%s" "$COLOR" "$BATTERY_STATUS" "#[default]"
	elif command_exists "upower"; then
		for battery in $(upower -e | grep battery); do
			upower -i $battery | grep percentage | awk '{print $2}'
		done | xargs echo
	elif command_exists "acpi"; then
		acpi -b | grep -Eo "[0-9]+%"
	fi
}

main() {
	print_battery_percentage
}
main
