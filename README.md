# Dvlup Blog - Wordpress to Hugo Replacement

I exported my original blog using [WordPress to Hugo Exporter](https://github.com/SchumacherFM/wordpress-to-hugo-exporter), this repo contains the source for the site.

- Live Blog => [https://dvlup.com](https://dvlup.com) (a docker container, running on a raspberry pi 4!)

The website is now a Docker image that can be hosted in any environment. The site is a now:

- Compiled and distributed as a docker image
- Spun up as a container with Docker Compose (see docker-compose.yml)
- Running on a Raspberry Pi 4
- Served behind a reverse proxy that handles the SSL

It literally costs me pennies a year to operate, and is a fun self-hosting scenario.