#!/bin/bash

options="\
y\tYes\n\
n\tNo"

choice=$(printf "$options" | rofi \
    -dmenu \
    -matching prefix \
    -auto-select \
    -format i \
    -p "SHUTDOWN?" \
    -theme "menu-simple.rasi")

case "$choice" in
	0) systemctl poweroff ;;
	1) ;;
esac	
