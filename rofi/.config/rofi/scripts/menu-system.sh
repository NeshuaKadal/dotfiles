#!/usr/bin/env bash

options="\
󰕾 Audio				\n\
󰂯 Bluetooth				\n\
󰒢 Network				\n\
"

rofi="rofi 				\
-dmenu 					\
-format i 				\
-p "System" 				\
-theme ~/.config/rofi/modules/menu-system.rasi 	\
"

choice=$(printf "$options" | $rofi)

case "$choice" in
    0) foot -f JetBrainsMonoNerdFont-Regular:size=10 --title=float0 -e wiremix ;;
    1) foot -f JetBrainsMonoNerdFont-Regular:size=10 --title=float0 -e bluetui ;;
    2) foot -f JetBrainsMonoNerdFont-Regular:size=10 --title=float0 -e gazelle ;;
esac
