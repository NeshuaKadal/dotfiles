#!/usr/bin/env bash

uptime=$(uptime -p | awk -F 'up ' '{print $2}')

options="\
 Lock		\n\
 Suspend	\n\
 Reboot	\n\
 Shutdown	\n\
"

choice=$(printf "$options" | rofi \
    -dmenu \
    -format i \
    -p "$HOSTNAME" \
    -mesg "Uptime: $uptime" \
    -theme ../modules/menu-power.rasi \
)

confirm() {
    res=$(printf "No\nYes" | rofi -dmenu -format i -p "Are you sure?" -theme ../modules/menu-confirm.rasi)
    [[ "$res" == "1"  ]]
}

case "$choice" in
    0)
	hyprlock
	;;
    1)
	systemctl suspend
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
