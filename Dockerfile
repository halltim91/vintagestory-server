FROM mcr.microsoft.com/dotnet/runtime:7.0

# Env var
ENV SERVER_BRANCH="stable" \
    SERVER_VERSION="1.20.10" \
    SERVER_PORT="42420" \
    WORLDCONFIG_PROPICK_NODE_SEARCH_RADIUS="6" \
    UID="1000" \
    GID="1000" \
    SCREEN_NAME="server"


# Install dependencies
RUN apt-get update && \
    apt-get install --no-install-recommends -y wget netcat jq moreutils screen nano tzdata unzip && \
    apt-get clean autoclean && \
    apt-get autoremove -y && \
    rm -rf /var/lib/apt/lists/* && \
    mkdir /data && mkdir /data/server-file && \
    touch /data/server-file/.version

# Add User
RUN useradd -u $UID -U -m -s /bin/false vintagestory && usermod -G users vintagestory && \
    chown -R vintagestory:vintagestory /data

# Expose ports
EXPOSE 42420

# Healthcheck
HEALTHCHECK --start-period=1m --interval=5s CMD nc -z  127.0.0.1 $SERVER_PORT

VOLUME ["/data/server-file"]
VOLUME ["/mods"]

COPY serverconfig.json /data/default-serverconfig.json
COPY scripts/ /data/scripts/
RUN chmod -R +x /data/scripts

# Add the servercmd command
COPY scripts/servercmd.sh /usr/local/bin/servercmd
RUN chmod +x /usr/local/bin/servercmd

# Add attach command
COPY scripts/attach.sh /usr/local/bin/attach
RUN chmod +x /usr/local/bin/attach

ENTRYPOINT ["/data/scripts/entry.sh"]
