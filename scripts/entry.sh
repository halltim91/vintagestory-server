#!/bin/bash

set -e

# Ensure User and Group IDs
if [ ! "$(id -u vintagestory)" -eq "$UID" ]; then usermod -o -u "$UID" vintagestory ; fi
if [ ! "$(id -g vintagestory)" -eq "$GID" ]; then groupmod -o -g "$GID" vintagestory ; fi

VERSION_FILE="/data/server-file/.version" # Path to version file
SERVER_DLL="/data/VintagestoryServer.dll" # Path to server dll

# Function to determine if string is a boolean
is_boolean() {
	case "$1" in
		true|false) return 0 ;;
		*) return 1 ;;
	esac
}

# Function to determine if string is a boolean
is_number() {
	[[ "$1" =~ ^-?[0-9]+([.][0-9]+)?$ ]]
}

# Download and extract the server if the version is different or VintagestoryServer.dll is missing
if [ ! -f "$VERSION_FILE" ] || [ ! "$SERVER_VERSION" = "$(cat $VERSION_FILE || echo '')" ] || [ ! -f "$SERVER_DLL" ]; then
	echo "Downloading server version $SERVER_VERSION..."
	cd /data
	wget https://cdn.vintagestory.at/gamefiles/$SERVER_BRANCH/vs_server_linux-x64_$SERVER_VERSION.tar.gz
	tar xzf vs_server_linux-x64_*.tar.gz
	rm vs_server_linux-x64_*.tar.gz
	echo "$SERVER_VERSION" > "$VERSION_FILE"
else
	echo "Server already up-to-date"
fi

#Download any mods in the MODS_LIST
/data/scripts/downloadMods.sh

chown -R vintagestory:vintagestory /data

echo "Applying Server Configuration"

# Apply server configuration
serverconfig="/data/server-file/serverconfig.json"

if [ ! -f "$serverconfig" ]; then
	cp /data/default-serverconfig.json "$serverconfig"
fi

# A list of env var name -> jq path mappings
declare -A settings=(
	[SERVER_PORT]=".Port|tonumber"
	[SERVER_NAME]=".ServerName"
	[SERVER_DESCRIPTION]=".ServerDescription"
	[SERVER_MOTD]=".WelcomeMessage"
	[SERVER_MAX_CLIENTS]=".MaxClients|tonumber"
	[SERVER_PASS_TIME_WHEN_EMPTY]=".PassTimeWhenEmpty|boolean"
	[SERVER_PASSWORD]=".Password"
	[SERVER_PUBLIC]=".AdvertiseServer|boolean"
	[SERVER_SERVER_LANGUAGE]=".ServerLanguage"
	[SERVER_PVP]=".AllowPvP|boolean"
	[SERVER_FIRE_SPREAD]=".AllowFireSpread|boolean"
	[SERVER_WORLD_SEED]=".WorldConfig.Seed"
	[SERVER_DIE_ABOVE_MEMORY_USAGE]=".DieAboveMemoryUsageMb|tonumber"
	[SERVER_MAX_CLIENTS_IN_QUEUE]=".MaxClientsInQueue|tonumber"
	[SERVER_LOGIN_FLOOD_PROTECTION]=".LoginFloodProtection|boolean"
	[SERVER_MAP_SIZE_X]=".MapSizeX|tonumber"
	[SERVER_MAP_SIZE_Y]=".MapSizeY|tonumber"
	[SERVER_MAP_SIZE_Z]=".MapSizeZ|tonumber"
	[SERVER_STARTUP_COMMANDS]=".StartupCommands"
	[SERVER_WHITELIST]=".WhitelistMode"
	# WorldConfig subproperties
	[WORLDCONFIG_GAMEMODE]=".WorldConfig.WorldConfiguration.gameMode"
	[WORLDCONFIG_STARTING_CLIMATE]=".WorldConfig.WorldConfiguration.startingClimate"
	[WORLDCONFIG_SPAWN_RADIUS]=".WorldConfig.WorldConfiguration.spawnRadius|tonumber"
	[WORLDCONFIG_GRACE_TIMER]=".WorldConfig.WorldConfiguration.graceTimer|tonumber"
	[WORLDCONFIG_DEATH_PUNISHMENT]=".WorldConfig.WorldConfiguration.deathPunishment"
	[WORLDCONFIG_DROPPED_ITEMS_TIMER]=".WorldConfig.WorldConfiguration.droppedItemsTimer|tonumber"
	[WORLDCONFIG_SEASONS]=".WorldConfig.WorldConfiguration.seasons"
	[WORLDCONFIG_PLAYERLIVES]=".WorldConfig.WorldConfiguration.playerlives|tonumber"
	[WORLDCONFIG_LUNG_CAPACITY]=".WorldConfig.WorldConfiguration.lungCapacity|tonumber"
	[WORLDCONFIG_DAYS_PER_MONTH]=".WorldConfig.WorldConfiguration.daysPerMonth|tonumber"
	[WORLDCONFIG_HARSH_WINTERS]=".WorldConfig.WorldConfiguration.harshWinters"
	[WORLDCONFIG_BLOCK_GRAVITY]=".WorldConfig.WorldConfiguration.blockGravity"
	[WORLDCONFIG_CAVE_INS]=".WorldConfig.WorldConfiguration.caveIns"
	[WORLDCONFIG_ALLOW_UNDERGROUND_FARMING]=".WorldConfig.WorldConfiguration.allowUndergroundFarming|boolean"
	[WORLDCONFIG_NO_LIQUID_SOURCE_TRANSPORT]=".WorldConfig.WorldConfiguration.noLiquidSourceTransport|boolean"
	[WORLDCONFIG_BODY_TEMPERATURE_RESISTANCE]=".WorldConfig.WorldConfiguration.bodyTemperatureResistance|tonumber"
	[WORLDCONFIG_CREATURE_HOSTILITY]=".WorldConfig.WorldConfiguration.creatureHostility"
	[WORLDCONFIG_CREATURE_STRENGTH]=".WorldConfig.WorldConfiguration.creatureStrength"
	[WORLDCONFIG_CREATURE_SWIM_SPEED]=".WorldConfig.WorldConfiguration.creatureSwimSpeed|tonumber"
	[WORLDCONFIG_PLAYER_HEALTH_POINTS]=".WorldConfig.WorldConfiguration.playerHealthPoints|tonumber"
	[WORLDCONFIG_PLAYER_HUNGER_SPEED]=".WorldConfig.WorldConfiguration.playerHungerSpeed|tonumber"
	[WORLDCONFIG_PLAYER_HEALTH_REGEN_SPEED]=".WorldConfig.WorldConfiguration.playerHealthRegenSpeed|tonumber"
	[WORLDCONFIG_PLAYER_MOVE_SPEED]=".WorldConfig.WorldConfiguration.playerMoveSpeed|tonumber"
	[WORLDCONFIG_FOOD_SPOIL_SPEED]=".WorldConfig.WorldConfiguration.foodSpoilSpeed|tonumber"
	[WORLDCONFIG_SAPLING_GROWTH_RATE]=".WorldConfig.WorldConfiguration.saplingGrowthRate|tonumber"
	[WORLDCONFIG_TOOL_DURABILITY]=".WorldConfig.WorldConfiguration.toolDurability|tonumber"
	[WORLDCONFIG_TOOL_MINING_SPEED]=".WorldConfig.WorldConfiguration.toolMiningSpeed|tonumber"
	[WORLDCONFIG_PROPICK_NODE_SEARCH_RADIUS]=".WorldConfig.WorldConfiguration.propickNodeSearchRadius|tonumber"
	[WORLDCONFIG_MICROBLOCK_CHISELING]=".WorldConfig.WorldConfiguration.microblockChiseling"
	[SERVER_DEFAULT_ROLE]=".DefaultRoleCode"
)

# Loop through settings
for key in "${!settings[@]}"; do
	val=$(eval echo \$$key)
	path=${settings[$key]}
	
	if [ -n "$val" ]; then
		if echo "$path" | grep -q "|boolean"; then
			if ! is_boolean "$val"; then
				echo "Warning: Value '$val' in '$key' is not a valid boolean (true/false). Using default value..."
				continue;
			fi
			jq_path=$(echo "$path" | sed 's/|boolean//')
			jq "$jq_path = $val" "$serverconfig" | sponge "$serverconfig"
		elif echo "$path" | grep -q "|tonumber"; then
			if ! is_number "$val"; then
				echo "Warning: Value '$val' in '$key' is not a valid number. Using default value..."
				continue;
			fi
			jq_path=$(echo "$path" | sed 's/|tonumber//')
			jq "$jq_path = (\$val|tonumber)" --arg val "$val" "$serverconfig" | sponge "$serverconfig"
		else
			jq_path="$path"
			jq "$jq_path = \$val" --arg val "$val" "$serverconfig" | sponge "$serverconfig"
		fi
	fi
done

cleanup(){
	echo "Stopping server..."
	servercmd "/stop"
}

trap cleanup SIGTERM SIGINT

# Launch server in a screen
echo "Launching server..."
cd /data
screen -S $SCREEN_NAME -dm bash -c "su vintagestory -s /bin/sh -c 'dotnet VintagestoryServer.dll --dataPath /data/server-file'"

while true; do
	sleep 1
done
