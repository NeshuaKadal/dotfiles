#!/bin/bash

options="\
n\tNext\n\
p\tPrev\n\
t\tToggle\n\
s\tStop\n\
z\tRepeat\n\
x\tRandom"

choice=$(printf "$options" | rofi \
    -dmenu \
    -matching prefix \
    -auto-select \
    -format i \
    -p "MUSIC" \
    -theme "menu-simple.rasi")

case "$choice" in
    0) mpc next ;;
    1) mpc prev ;;
    2) mpc toggle ;;
    3) mpc stop ;;
    4) mpc repeat ;;
    5) mpc random ;;
esac
