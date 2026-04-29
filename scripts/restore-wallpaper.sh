#!/bin/bash

cache="${HOME}/.cache/current-wallpaper"
fallback="${HOME}/.config/wallpapers/forest1.png"

if [ -f "$cache" ] && [ -f "$(cat "$cache")" ]; then
    swaybg -i "$(cat "$cache")" -m fill &
else
    swaybg -i "$fallback" -m fill &
fi
