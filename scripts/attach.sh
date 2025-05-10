#!bin/bash

# Allows easy access to the screen running the server from outside of the container

exec su - vintagestory -c "screen -D -RR"