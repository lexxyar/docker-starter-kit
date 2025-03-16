# Docker-based: Laravel starter kit development

This Docker starter kit contains all you need to start developing wep app with php or python. Starter kit contain `MariaDB` database container, `NGINX` web server container with php dev preflight configuration, `PHP` container with base DB drivers, `Python` container with `uvicorn` and other (maybe useless) stuff.

Added `PhpMyAdmin` container to work with database.

For `Laravel` developing kit contains: `Redis` for caching, `Mailpit` for mail intercepting, `supervisor` for Laravel background tasks (e.g. `queue:work`), `Mino S3` to simulate AWS object storage.

On top of this, starter kit contains `traefik`, which is allowed to apply `TLS` certificates on local machine. Read forward to understand, how to create and register certificate to use `HTTPS`. 

# HTTPS for server

## Generate SSL certificate

```shell
openssl req -x509 -nodes -days 365 -newkey rsa:2048 -keyout mydomain.local.key -out mydomain.local.crt -subj "/CN=mydomain.local" -addext "subjectAltName=DNS:mydomain.local,DNS:*.mydomain.local"
```

Move files to `./docker/ssl` and if you use yore specific names for certificate, make sure, that you change certificate filenames in `./docker/traefik/dynamic.yaml` file.

## Add certificate to certificate storage

```shell
sudo security add-trusted-cert -d -r trustAsRoot -p ssl -p basic -k ~/Library/Keychains/Login.keychain ./docker/ssl/mydomain.local.crt
```

## Remove certificate (just in case)

```shell
sudo security delete-certificate -c "mydomain.local"
```

## Add trusts for certificate

In MacOS spotlite print `keychain` or `связка ключей`, open app, find yore certificate, dbl click. In opened window
expand `Trust` (`Доверие`) and set `Always trust` (`Всегда доверять`)

## Apply

**IMPORTANT!** To apply certificate, restart yore browser. 

# Supervisor

Supervisor container will not start with empty project. Create and configure `laravel` project, then restart
`supervisor` container.

# Local DNS names
Insert yore site names in `/etc/hosts` for local development.
