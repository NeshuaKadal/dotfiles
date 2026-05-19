#!/usr/bin/env bash

options="Selection\nFull Screen\nActive Window"
rofi='rofi -dmenu -format i -p "Screenshot" -theme ../modules/base.rasi'

choice=$(printf "$options" | $rofi)

case "$choice" in
    0) niri msg action screenshot --show-pointer=false ;;
    1) niri msg action screenshot-screen --show-pointer=false ;;
    2) niri msg action screenshot-window --show-pointer=false ;;
esac
