# Docker

Сontainerization of everything.

This repository is slowly moving to Docker because it makes it easier to build complex setups without polluting the host system. Main goal in ansiblecfgs v3 to leave only system/setup and Docker.

## install

Installs Docker, nftables firewall.

`ansible-playbook -i inventories/prod playbooks/docker/install.yml --limit myvps`

- Removes old versions.
- Adds Docker repo, installs Docker.
- Change `firewall-backend` to `nftables`.
- Creates `{{ docker_dir }}`.
- Starts docker.

## caddy_naive_singbox

Compose file: Caddy naive fork + upstream to sing-box mixed inbound.

```bash
ansible-playbook -i inventories/prod playbooks/docker/caddy_naive_singbox.yml --limit myvps
```

Required variables:

```yaml
# docker
docker_caddy_domain: "example.com"
docker_template_caddy_caddyfile: "mysecrets/caddyfile.naive.j2" # for custom caddyfile
docker_template_singbox_config: "mysecrets/mixed.json.j2" # for custom mixed config, mixed only

# + lego variables for certificates docker_caddy_domain (see below)
# Yes, caddy have own mechanism to obtain and renew certificates,
# but I prefer to separate responsibilities so as not to depend on the web server and to have a single point for managing certificates
```

sing-box client outbound example:

```json
        {
            "type": "naive",
            "tag": "proxy",
            "server": "192.168.1.1",
            "server_port": 443,
            "username": "username",
            "password": "password",
            "insecure_concurrency": 1,
            "udp_over_tcp": true,
            "quic": false,
            "tls": {
                "enabled": true,
                "server_name": "example.com"
            }
        },
```

## lego_install

[lego](https://github.com/go-acme/lego) obtains and renews certifiactes.

`ansible-playbook -i inventories/prod playbooks/docker/lego_install.yml --limit myvps`

Required variables:

```yaml
docker_lego_email: "example@example.com"
docker_lego_cloudflare_api_token: "cloudflare api token, with dns zone read/write permission"
docker_lego_domains:
  - example.com
  - "*.example.com"
  - "helloworld.local"

# Not required, but useful:
# Command to execute if certificates updated:
docker_lego_reload_hooks:
    - docker exec caddy caddy reload --config /etc/caddy/Caddyfile # default
```

Only Cloudflare DNS challenge supported.
With a little tweaking, it would be possible to get support for any other challenges, but that's not necessary yet.

After installing, timer and service (`renew.service`, `renew.timer`) will be created on docker host. Every 12 hours
will be check (`runner.sh`): certificates need updating? If yes, script runs lego via `docker run`, updates
certificates, and runs `docker_lego_reload_hooks` (`reload.sh`).

Certificates stored in `{{ docker_lego_storage }}/certificates`, and can be mounted to other containers.

Example:

- `{{ docker_lego_storage }}/certificates/example.com.crt`
- `{{ docker_lego_storage }}/certificates/example.com.key`

Debug:

```bash
sudo systemctl start lego-renew.service # explicit start checking
systemctl status lego-renew.timer
journalctl -u lego-renew.service -f # realtime logs
```
