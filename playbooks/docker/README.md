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
            "tls": {
                "enabled": true,
                "server_name": "example.com"
            }
        },
```
