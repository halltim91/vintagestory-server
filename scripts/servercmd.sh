#!/bin/bash

# Allows user to send server commands without being in the server screen

commands=$1

# Split commands by ';' 
IFS=';' read -ra commands <<< "$commands"
  

if screen -list | grep -q "$SCREEN_NAME"; then
    for cmd in "${commands[@]}"; do
        cmd=$(echo "$cmd" | xargs) # Trim

        if [ -z "$cmd" ]; then # Skip empty
            continue
        fi

        echo "Sending command: $cmd"
        screen -S $SCREEN_NAME -X stuff "$cmd$(printf \\r)"
        
        # short delay between commands to actually do stuff
        sleep 0.5
    done
else
    echo "Screen session '$SCREEN_NAME' not found."
    return 1
fi

