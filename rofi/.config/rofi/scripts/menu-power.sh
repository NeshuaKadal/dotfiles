#!/usr/bin/env bash

uptime=$(uptime -p | awk -F 'up ' '{print $2}')

options="\n\n\n"

choice=$(printf "$options" | rofi \
    -dmenu \
    -format i \
    -p "Power" \
    -theme ~/.config/rofi/modules/menu-power.rasi \
)

confirm() {
    res=$(printf "NO\nYES" | rofi -dmenu -format i -p "Confirm" -theme ~/.config/rofi/modules/menu-confirm-power.rasi)
    [[ "$res" == "1"  ]]
}

case "$choice" in
    0)
	hyprlock
	;;
    1)
	hyprlock & wait 1 & systemctl suspend
	;;

    2)
	if confirm; then
	    systemctl reboot
	fi
	;;
    3)
	if confirm; then
	    systemctl poweroff
	fi
	;;
esac
