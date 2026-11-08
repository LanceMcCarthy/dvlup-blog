FROM caddy:2.11.8-alpine@sha256:f6228111e5fafa1a5238258d0858e103f10599b8d1659a146e7726681a002bb9

# Copy Caddyfile configuration
COPY Caddyfile /etc/caddy/Caddyfile

# Copy the built Hugo site into Caddy's web root
COPY dvlup/public /usr/share/caddy
