#!/usr/bin/env bash

playing=$(mpc -f "%artist% - %album%\n%title%" current)

options="\
  Power	\n\
  System	\n\
󰑶  Utilities	\n\
:: Apps		\n\
  Music	\n\
󰥶  Wallpaper	\n\
"

choice=$(printf "$options" | rofi \
-dmenu \
-format i \
-mesg "$playing" \
-p "Start" \
-theme ../modules/menu-main.rasi \
)

case "$choice" in
    0) ~/.config/rofi/scripts/menu-power.sh ;;
    1) ~/.config/rofi/scripts/menu-system.sh ;;
    2) ~/.config/rofi/scripts/menu-utilities.sh ;;
    3) ~/.config/rofi/scripts/menu-drun.sh ;;
    4) ~/.config/rofi/scripts/menu-music.sh ;;
    5) ~/.config/rofi/scripts/menu-wallpaper.sh ;;
esac
