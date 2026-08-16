# caddy

<https://caddyserver.com>

Caddy server.

[All variables](../../roles/caddy/defaults/main.yml).

## install

Installs Caddy server.

## deploy_configs

Deploys Caddy configs: Caddyfile, and site *.caddy files.

Required variables:

- `caddy_domain` for default config.

- `caddy_configs` for custom configs.
