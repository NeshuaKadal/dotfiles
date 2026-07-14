#!/usr/bin/env bash

options="\
 Calculator	\n\
 Clipboard	\n\
 Emoji		\n\
 Restart App	\n\
 Screenshot	\n\
"

choice=$(printf "$options" | rofi \
    -dmenu \
    -format i \
    -p "Utilities" \
    -theme ~/.config/rofi/modules/menu-utilities.rasi \
)

case "$choice" in
    0)
	~/.config/rofi/scripts/menu-calculator.sh
	;;
    1)
	
	;;
    2)
	
	;;
    3)
	~/.config/rofi/scripts/menu-restart-app.sh
	;;
    4)
	~/.config/rofi/scripts/menu-screenshot.sh
	;;
esac
