#!/bin/bash

# Allows user to send server commands without being in the server screen

commands=$1

# Split commands by |
IFS=';' read -ra commands <<< "$commands"

for cmd in "${commands[@]}"; do
    cmd=$(echo "$cmd" | xargs) # Trim

    if [ -z "$cmd" ]; then # Skip empty
        continue
    fi

    if screen -list | grep -q "$screen_name"; then
        echo "Sending command: $cmd"
        su vintagestory -s /bin/sh -p -c "screen -S $SCREEN_NAME -X stuff \"$cmd$(printf \\r)\""
        
        # short delay between commands to actually do stuff
        sleep 0.5
    else
        echo "Screen session '$SCREEN_NAME' not found."
        return 1
    fi
done