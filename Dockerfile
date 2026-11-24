FROM caddy:2.11.9-alpine@sha256:003a97808e781aa9f7e75cc2f43d34d461099031faf5e20faefb9f61126836f0

# Copy Caddyfile configuration
COPY Caddyfile /etc/caddy/Caddyfile

# Copy the built Hugo site into Caddy's web root
COPY dvlup/public /usr/share/caddy
