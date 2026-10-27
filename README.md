# Dvlup Blog - Wordpress to Hugo Replacement

I exported my original blog using [WordPress to Hugo Exporter](https://github.com/SchumacherFM/wordpress-to-hugo-exporter), this repo contains the source for the site.

- Live Blog => [https://dvlup.com](https://dvlup.com) (a docker container, running on a raspberry pi 4!)

The website is now a Docker image that can be hosted in any environment. The site is a now:

- Compiled and distributed as a docker image
- Spun up as a container with Docker Compose (see docker-compose.yml)
- Running on a Raspberry Pi 4
- Served behind a reverse proxy that handles the SSL

It literally costs me pennies a year to operate, and is a fun self-hosting scenario.

## Building and maintaining dependencies

Install Hugo Extended 0.168.0 and Node.js 26 (CI uses the latest patch of this
major version), then run:

```powershell
git submodule update --init --recursive
cd dvlup
npm ci
npm audit
npm run build
```

The site uses Tailwind CSS 4 and its PostCSS plugin. Fuse.js and KaTeX are
installed from the lockfile and served locally through Hugo mounts; do not
restore the old vendored Fuse.js or KaTeX CDN links. Tailwind 4 requires modern
browsers (Safari 16.4+, Chrome 111+, Firefox 128+).

Both deployment workflows verify the Hugo download checksum, install locked
dependencies, and stop on npm audit findings. The Docker image pins Caddy
2.11.7 on Alpine by digest and supports amd64 and arm64. Dependabot checks npm,
Docker, GitHub Actions, and the theme submodule weekly. When upgrading Hugo,
update `HUGO_VERSION` in both workflows and the version documented here.

Dependency updates do not block scanners or denial-of-service traffic. The
public reverse proxy and host OS must also be kept patched; filtering and rate
limits belong at that proxy. Rebuild and redeploy the image to apply the Caddy
update to the running site.