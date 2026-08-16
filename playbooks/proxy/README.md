# proxy

Collection of proxy-related things, like proxy chains, or something.

## caddy_naive_singbox

Chain: `client` -> `caddy-naive` -> `sing-box` -> Internet.

- `lego` for certificate management.
- `caddy` (naive fork) as server, `upstream` to `sing-box`.
- `sing-box` with `mixed` inbound.

Required variables:

```yaml
caddy_domain: "example.com"

# not required, but useful
caddy_naive_username: "" # default: random string
caddy_naive_password: "" # default: random string
caddy_caddyfile: "mysecrets/caddyfile.naive.j2" # for custom caddyfile
caddy_site_caddyfile: "mysecrets/{{ caddy_domain }}.naive.j2"
singbox_template_config: "mysecrets/mixed.json.j2" # for custom mixed config, mixed only
```

`sing-box` client outbound example:

```json
        {
            "type": "naive",
            "tag": "proxy",
            "server": "ip of your server",
            "server_port": 443,
            "username": "username",
            "password": "password",
            "insecure_concurrency": 1,
            "tls": {
                "enabled": true,
                "server_name": "caddy_domain"
            }
        },
```
