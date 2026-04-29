#!/bin/bash

options="\
a\tAudio\n\
b\tBluetooth\n\
n\tNetwork"

choice=$(printf "$options" | rofi \
    -dmenu \
    -matching prefix \
    -auto-select \
    -format i \
    -p "CONNECTION" \
    -theme "menu-simple.rasi")

case "$choice" in
    0) foot -f JetBrainsMonoNerdFont-Regular.ttf:size=8 --title=wiremix -e wiremix 	;;
    1) foot -f JetBrainsMonoNerdFont-Regular.ttf:size=8 --title=bluetui -e bluetui 	;;
    2) foot -f JetBrainsMonoNerdFont-Regular.ttf:size=8 --title=gazelle -e gazelle 	;;
esac
