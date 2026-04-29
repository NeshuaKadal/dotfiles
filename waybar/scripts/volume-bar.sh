#!/bin/bash

trap 'exit 0' SIGPIPE

print_bar() {

    # Get volume number of default output, and convert into a percent
    VOLUME=$(wpctl get-volume @DEFAULT_AUDIO_SINK@ | awk '{printf "%d", $2 * 100}')
    (( VOLUME > 100 )) && VOLUME=100

    # Set bar width and get amount filled / empty
    BAR_SIZE=20
    BAR_FILLED=$(( VOLUME * BAR_SIZE / 100 ))
    BAR_EMPTY=$(( BAR_SIZE - BAR_FILLED ))

    # Change color based on volume
    if ((VOLUME >= 90 )); 	then 	COLOR="#E67E80"
    elif ((VOLUME >= 80 )); then 	COLOR="#E69875"
    elif ((VOLUME >= 70 )); then 	COLOR="#DBBC7F"
    else 				COLOR="#A7C080"
    fi

    # Set bar colons and spaces
    BAR="[<span color='$COLOR'>"
    for ((i = 0; i < BAR_FILLED; i++)) do BAR+=":"; done
    for ((i = 0; i < BAR_EMPTY; i++)) do BAR+=" "; done
    BAR+="</span>]"

    echo "{\"text\": \"󰕾 ${BAR} ${VOLUME}%\"}" 2>/dev/null || kill $$
}

# Print once on startup
print_bar

# Update when a sink event fires
pactl subscribe 2>/dev/null | while read -r line; do
    if [[ "$line" == *"sink"* ]]; then
	print_bar
    fi
done
