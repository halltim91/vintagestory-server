#!/bin/bash

# Check if MODS_LIST environment variable is set
if [ -z "$MOD_LIST" ]; then
	echo "No mods to download"
else
	mkdir -p /data/server-file/Mods

	# Iterate over each mod URL (space-separated)
	for mod_url in $MOD_LIST; do
		
		mod_filename=$(basename "$mod_url")
		mod_name="${mod_filename%.zip}"

		# Check if the mod is already downloaded
		if [ -f "/data/server-file/Mods/$mod_name" ]; then
			echo "Mod already downloaded: $mod_name. Skipping download."
		else
			echo "Downloading mod: $mod_url"

			# Download the mod into /data/server-file/Mods
			wget "$mod_url" -O /data/server-file/Mods/"$mod_filename"

			# Extract the mod contents
			if [ $? -eq 0 ]; then
				echo "Download successful: $mod_filename"
				unzip -o /data/server-file/Mods/"$mod_filename" -d /data/server-file/Mods/"$mod_name"

				# Clean up the zip file after extraction
				rm /data/server-file/Mods/"$mod_filename"
			else
				echo "Failed to download mod: $mod_url"
			fi
		fi
	done
fi