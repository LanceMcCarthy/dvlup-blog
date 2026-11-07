FROM caddy:2.11.7-alpine@sha256:e70b164da81ef698b3ad19af799ea6086ce6d9e48ed4079eb9fe26f6fbf14ee5

# Copy Caddyfile configuration
COPY Caddyfile /etc/caddy/Caddyfile

# Copy the built Hugo site into Caddy's web root
COPY dvlup/public /usr/share/caddy
