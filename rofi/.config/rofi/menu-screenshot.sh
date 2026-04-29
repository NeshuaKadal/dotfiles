#!/bin/bash

options="\
s\tSelection\n\
f\tFull Screen\n\
w\tActive Window"

choice=$(printf "$options" | rofi \
    -dmenu \
    -matching prefix \
    -auto-select \
    -format i \
    -p "SCREENSHOT" \
    -theme "menu-simple.rasi")

case "$choice" in
    0) niri msg action screenshot --show-pointer=false ;;
    1) niri msg action screenshot-screen --show-pointer=false ;;
    2) niri msg action screenshot-window --show-pointer=false ;;
esac
