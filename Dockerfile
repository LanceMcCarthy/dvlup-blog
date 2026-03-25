FROM caddy:2-alpine

# Copy Caddyfile configuration
COPY Caddyfile /etc/caddy/Caddyfile

# Copy the built Hugo site into Caddy's web root
COPY dvlup/public /usr/share/caddy
