#!/bin/bash

options="\
p\tPower\n\
c\tConnection\n\
m\tMusic\n\
a\tApps\n\
w\tWallpaper\n\
s\tScreenshot\n\
t\tTools"

choice=$(printf "$options" | rofi \
    -dmenu \
    -matching prefix \
    -auto-select \
    -format i \
    -p "ATIUM" \
    -theme "menu-simple.rasi")

case "$choice" in
    0) ~/.config/rofi/menu-power.sh 		;;
    1) ~/.config/rofi/menu-connection.sh 	;;
    2) ~/.config/rofi/menu-music.sh 		;;
    3) ~/.config/rofi/menu-apps.sh 		;;
    4) ~/.config/rofi/menu-wallpaper.sh 	;;
    5) ~/.config/rofi/menu-screenshot.sh 	;;
    6) ~/.config/rofi/menu-tools.sh 		;; 
esac
