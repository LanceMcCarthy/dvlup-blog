FROM caddy:2.11.7-alpine@sha256:eb4d35b7452d1ab6171fbdbe8d9275b2301dad6dad92115d91e19fb9b24d510f

# Copy Caddyfile configuration
COPY Caddyfile /etc/caddy/Caddyfile

# Copy the built Hugo site into Caddy's web root
COPY dvlup/public /usr/share/caddy
