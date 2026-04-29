#!/bin/bash

options="\
y\tYes\n\
n\tNo"

choice=$(printf "$options" | rofi \
    -dmenu \
    -matching prefix \
    -auto-select \
    -format i \
    -p "REBOOT?" \
    -theme "menu-simple.rasi")


case "$choice" in
	0) systemctl reboot ;;
	1) ;;
esac	
