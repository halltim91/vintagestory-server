# Vintage Story Server

Dockerized Vintage Story server setup.
This image allows full server and game configuration through environment variables in your docker-compose.yml, with easy support for mods integration.

## Volumes

- `/data/server-file` Vintage Story server files
- `/mods` (Optional) A shared mods folder. Useful for multiple server instances that use the same mod set.

## Environment Variables

#### General Variables
 - **TZ** Time zone
 - **MOD_LIST** (optional) List of mod download URLs to download into container. List is space delimited. can be used instead of or alongside the mod volume

#### Server Configuration Variables
- **SERVER_BRANCH** Name of the branch [`stable`|`unstable`] (default: `stable`)
- **SERVER_VERSION** Vintage Story server version
- **SERVER_PORT** Server port (default: `42420`)
- **SERVER_NAME** Public name of your server
- **SERVER_DESCRIPTION** Public description of your server
- **SERVER_MOTD** The message shown to players when they join. Placeholder {0} will be replaced with Player's nickname
- **SERVER_MAX_CLIENTS** Maximum number of players
- **SERVER_PASS_TIME_WHEN_EMPTY** Determines whether time continues to pass when no players are connected (default: false)
- **SERVER_PASSWORD** Password of your server used to connect to it
- **SERVER_WHITELIST** Whether to only allow whitelisted players to connect to your server [`off`|`on`] d (default: `off`)
- **SERVER_PUBLIC** Show your server in public server listing
- **SERVER_SERVER_LANGUAGE** Determines language of server messages
- **SERVER_PVP** Allow PvP (default: `true`)
- **SERVER_FIRE_SPREAD** Allow fire spread (default: `true`)
- **SERVER_WORLD_SEED** World seed
- **SERVER_DIE_ABOVE_MEMORY_USAGE** Maximum RAM usage in megabytes before the server shuts down. Warnings are issued at 90% of this value every 60 seconds. (default: `50000`)
- **SERVER_MAX_CLIENTS_IN_QUEUE**  Sets the maximum number of players allowed in the connection queue when the server is full (must be set to a value above 0 to activate)
- **SERVER_LOGIN_FLOOD_PROTECTION** Automatically bans IPs that send invalid packets or attempt to connect excessively, bans are temporary and cleared on server restart or after a set time (default: `false`)
- **SERVER_MAP_SIZE_X** Map size X (default: `1024000`)
- **SERVER_MAP_SIZE_Y** Map size Y (default: `256`)
- **SERVER_MAP_SIZE_Z** Map size Z (default: `1024000`)
- **SERVER_DEFAULT_ROLE** Default role for new players [`suvisitor`, `crvisitor`, `limitedsuplayer`, `limitedcrplayer`, `suplayer`, `crplayer`, `sumod`, `crmod`, `admin`]

#### World Configuration Variables

- **WORLDCONFIG_GAMEMODE** [`survival`, `creative`] (default: `survival`)
- **WORLDCONFIG_STARTING_CLIMATE** [`hot`, `warm`, `temperate`, `cool`, `icy`] (default: `temperate`)
- **WORLDCONFIG_SPAWN_RADIUS** [`10000`, `5000`, `2500`, `1000`, `500`, `250`, `100`, `50`, `25`, `0`] (default: `50`)
- **WORLDCONFIG_GRACE_TIMER** [`10`, `5`, `4`, `3`, `2`, `1`, `0`] (default: `0`)
- **WORLDCONFIG_DEATH_PUNISHMENT** [`drop`, `keep`] (default: `drop`)
- **WORLDCONFIG_DROPPED_ITEMS_TIMER** [`300`, `600`, `1200`, `1800`, `3600`] (default: `600`)
- **WORLDCONFIG_SEASONS** [`enabled`, `spring`, `summer`, `fall`, `winter`] (default: `enabled`)
- **WORLDCONFIG_PLAYERLIVES** [`1`, `2`, `3`, `4`, `5`, `10`, `20`, `-1`] (default: `-1`)
- **WORLDCONFIG_LUNG_CAPACITY** [`10000`, `20000`, `30000`, `40000`, `60000`, `120000`, `3600000`] (default: `40000`)
- **WORLDCONFIG_DAYS_PER_MONTH** [`30`, `20`, `12`, `9`, `6`, `3`] (default: `9`)
- **WORLDCONFIG_HARSH_WINTERS** [`true`, `false`] (default: `true`)
- **WORLDCONFIG_BLOCK_GRAVITY** [`sandgravel`, `sandgravelsoil`] (default: `sandgravel`)
- **WORLDCONFIG_CAVE_INS** [`off`, `on`] (default: `off`)
- **WORLDCONFIG_ALLOW_UNDERGROUND_FARMING** [`true`, `false`] (default: `false`)
- **WORLDCONFIG_NO_LIQUID_SOURCE_TRANSPORT** [`true`, `false`] (default: `false`)
- **WORLDCONFIG_BODY_TEMPERATURE_RESISTANCE** [`-40`, `-30`, `-25`, `-20`, `-15`, `-10`, `-5`, `0`, `5`, `10`, `15`, `20`] (default: `0`)
- **WORLDCONFIG_CREATURE_HOSTILITY** [`aggressive`, `passive`, `off`] (default: `aggressive`)
- **WORLDCONFIG_CREATURE_STRENGTH** [`4`, `2`, `1.5`, `1`, `0.5`, `0.25`] (default: `1`)
- **WORLDCONFIG_CREATURE_SWIM_SPEED** [`0.5`, `0.75`, `1`, `1.25`, `1.5`, `1.75`, `2`, `3`] (default: 2)
- **WORLDCONFIG_PLAYER_HEALTH_POINTS** [`5`, `10`, `15`, `20`, `25`, `30`, `35`] (default: `15`)
- **WORLDCONFIG_PLAYER_HUNGER_SPEED** [`2`, `1.5`, `1.25`, `1`, `0.75`, `0.5`, `0.25`] (default: `1`)
- **WORLDCONFIG_PLAYER_HEALTH_REGEN_SPEED** [`2`, `1.5`, `1.25`, `1`, `0.75`, `0.5`, `0.25`] (default: `1`)
- **WORLDCONFIG_PLAYER_MOVE_SPEED** [`2`, `1.75`, `1.5`, `1.25`, `1`, `0.75`] (default: `1.5`)
- **WORLDCONFIG_FOOD_SPOIL_SPEED** [`4`, `3`, `2`, `1.5`, `1.25`, `1`, `0.75`, `0.5`, `0.25`] (default: `1`)
- **WORLDCONFIG_SAPLING_GROWTH_RATE** [`16`, `8`, `4`, `2`, `1.5`, `1`, `0.75`, `0.5`, `0.25`] (default: `1`)
- **WORLDCONFIG_TOOL_DURABILITY** [`4`, `3`, `2`, `1.5`, `1.25`, `1`, `0.75`, `0.5`] (default: `1`)
- **WORLDCONFIG_TOOL_MINING_SPEED** [`3`, `2`, `1.5`, `1.25`, `1`, `0.75`, `0.5`, `0.25`] (default: `1`)
- **WORLDCONFIG_PROPICK_NODE_SEARCH_RADIUS** [`0`, `2`, `4`, `6`, `8`] (default: `0`)
- **WORLDCONFIG_MICROBLOCK_CHISELING** [`off`, `stonewood`, `all`] (default: `stonewood`)
- **WORLDCONFIG_ALLOW_COORDINATE_HUD** [`true`, `false`] (default: `true`)
- **WORLDCONFIG_ALLOW_MAP** [`true`, `false`] (default: `true`)
- **WORLDCONFIG_COLOR_ACCURATE_WORLDMAP** [`true`, `false`] (default: `false`)
- **WORLDCONFIG_LORE_CONTENT** [`true`, `false`] (default: `true`)
- **WORLDCONFIG_CLUTTER_OBTAINABLE** [`ifrepaired`, `yes`, `no`] (default: `ifrepaired`)
- **WORLDCONFIG_LIGHTNING_FIRES** [`true`, `false`] (default: `false`)
- **WORLDCONFIG_TEMPORAL_STABILITY** [`true`, `false`] (default: `true`)
- **WORLDCONFIG_TEMPORAL_STORMS** [`off`, `veryrare`, `rare`, `sometimes`, `often`, `veryoften`] (default: `sometimes`)
- **WORLDCONFIG_TEMPSTORM_DURATION_MUL** [`2`, `1.5`, `1.25`, `1`, `0.75`, `0.5`, `0.25`] (default: `1`)
- **WORLDCONFIG_TEMPORAL_RIFTS** [`off`, `invisible`, `visible`] (default: `visible`)
- **WORLDCONFIG_TEMPORAL_GEAR_RESPAWN_USES** [`-1`, `20`, `10`, `5`, `4`, `3`, `2`, `1`] (default: `1`)
- **WORLDCONFIG_TEMPORAL_STORM_SLEEPING** [`0`, `1`] (default: `1`)
- **WORLDCONFIG_WORLD_CLIMATE** [`realistic`, `patchy`] (default: `realistic`)
- **WORLDCONFIG_LANDCOVER** [`0.0`-`1.0`] (default: `1`)
- **WORLDCONFIG_OCEANSCALE** [`0.1`, `0.25`, `0.5`, `0.75`, `1`, `1.25`, `1.5`, `1.75`, `2`, `3`, `4`] (default: `1`)
- **WORLDCONFIG_UPHEAVEL_COMMONNESS** [`0.0`-`1.0`] (default: `0.3`)
- **WORLDCONFIG_GEOLOGIC_ACTIVITY** [`0`, `0.05`, `0.1`, `0.2`, `0.4`] (default: `0.05`)
- **WORLDCONFIG_LANDFORM_SCALE** [`0.2`, `0.4`, `0.6`, `0.8`, `1.0`, `1.2`, `1.4`, `1.6`, `1.8`, `2`, `3`] (default: `1.0`)
- **WORLDCONFIG_WORLD_WIDTH** (default: `1024000`)
- **WORLDCONFIG_WORLD_LENGTH**  (default: `1024000`)
- **WORLDCONFIG_WORLD_EDGE** [`blocked`, `traversable` ] (default: `traversable`)
- **WORLDCONFIG_POLAR_EQUATOR_DISTANCE** [`800000`, `400000`, `200000`, `100000`, `50000`, `25000`, `15000`, `10000`, `5000`] (default: `50000`)
- **WORLDCONFIG_GLOBAL_TEMPERATURE** [`4`, `2`, `1.5`, `1`, `0.75`, `0.5`, `0.25`] (default: `1`)
- **WORLDCONFIG_GLOBAL_PRECIPITATION** [`4`, `2`, `1.5`, `1`, `0.5`, `0.25`, `0.1`] (default: `1`)
- **WORLDCONFIG_GLOBAL_FORESTATION** [`-1.0`-`1.0`] (default: `0`)
- **WORLDCONFIG_GLOBAL_DEPOSIT_SPAWN_RATE** [`3`, `2`, `1.8`, `1.6`, `1.4`, `1.2`, `1`, `0.8`, `0.6`, `0.4`, `0.2`] (default: `1`)
- **WORLDCONFIG_SURFACE_COPPER_DEPOSITS** [`0.0`-`1.0`] (default: `0.12`)
- **WORLDCONFIG_SURFACE_TIN_DEPOSITS** [`0.0`-`1.0`] (default: `0.007`)
- **WORLDCONFIG_SNOW_ACCUM** [`true`, `false`] (default: `true`)
- **WORLDCONFIG_ALLOW_LAND_CLAIMING** [`true`, `false`] (default: `true`)
- **WORLDCONFIG_CLASS_EXCLUSIVE_RECIPES** [`true`, `false`] (default: `true`)
- **WORLDCONFIG_AUCTION_HOUSE** [`true`, `false`] (default: `true`)

## System User

- **UID** User ID (default: `1000`)
- **GID** Group ID (default: `1000`)

## Expose

- 42420

## Mods
Mods can be incorporated by adding a mod volumn to the container. This would be good for multiple instances that can share the same mod collections.

Alternatively with the `MOD_LIST` environment variable, create a string with a list of URLs to the download links of mods (`https://mods.vintagestory.at/download/42769/sweet-mod-1.0.0.zip`) separated by spaces. these mods will get automatically be downloaded and extracted into the /data/server-file/Mods folder. 

## Server Commands
Commands can be sent to the server from inside the container using the  `servercmd` command. If you need to send multiple commands, you can send a list of commands delimited with with `;`.

```bash
servercmd "/command 1; /command 2; ..."
```

Server commands can also be sent from outside the container using docker exec
```bash
sudo docker exec [containerName] servercmd "/command 1; /command 2; ..."
```

Havent figured out a good way to get the output from running the command, but checking the server

## Docker Compose

Example of docker compose file

```yaml
version: "3.8"

services:
  vintage-story:
    container_name: vsserver
    image: pepecitron/vintagestory-server
    restart: unless-stopped
    stdin_open: true
    tty: true
    environment:
      TZ: America/Los_Angeles
      SERVER_PASSWORD: "secret"
    ports:
      - "42420:42420"
    volumes:
      - ./data:/data/server-file
      - ./mods:/mods
```