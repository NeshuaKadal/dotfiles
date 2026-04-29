#!/bin/bash

options="\
l\tLock\n\
s\tShutdown\n\
r\tReboot"

choice=$(printf "$options" | rofi \
    -dmenu \
    -matching prefix \
    -auto-select \
    -format i \
    -p "POWER" \
    -theme "menu-simple.rasi")

case "$choice" in
    0) 	hyprlock 				;;
    1) ~/.config/rofi/menu-shutdown.sh 	;;
    2) 	~/.config/rofi/menu-reboot.sh 	;;
esac
