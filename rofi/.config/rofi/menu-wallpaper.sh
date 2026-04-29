#!/bin/bash

wall_dir="${HOME}/Pictures/Wallpapers"
cache_dir="${HOME}/.cache/wallpaper-previews"
rofi_args=(-p "󰋩  Wallpaper" -theme "menu-wallpaper.rasi")

if [ ! -d "${cache_dir}" ] ; then
        mkdir -p "${cache_dir}"
    fi

for img in "$wall_dir"/*.{jpg,jpeg,png,webp}; do
    if [ -f "$img" ]; then
	filename=$(basename "$img")
	if [ ! -f "${cache_dir}/${filename}" ] ; then
	    magick "$img" -strip -thumbnail 200x300^ -gravity center -extent 200x300 "${cache_dir}/${filename}"
	fi
    fi
done

wall_selection=$(find "${wall_dir}" -maxdepth 1 -type f \
    \( -iname "*.jpg" -o -iname "*.jpeg" -o -iname "*.png" -o -iname "*.webp" \) \
    -exec basename {} \; | sort | while read -r A ; do 
	echo -en "$A\x00icon\x1f""${cache_dir}"/"$A\n"
    done | rofi -dmenu -i "${rofi_args[@]}")

[[ -n "$wall_selection" ]] || exit 1

pkill swaybg
swaybg -i "${wall_dir}/${wall_selection}" -m fill &
disown

echo "${wall_dir}/${wall_selection}" > "${HOME}/.cache/current-wallpaper"

exit 0
