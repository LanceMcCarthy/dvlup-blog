FROM caddy:2-alpine

# Copy the built Hugo site into Caddy's web root
COPY dvlup/public /usr/share/caddy
