# lego

[lego](https://github.com/go-acme/lego) - certificate manager.

`ansible-playbook -i inventories/prod playbooks/lego/example.yml --limit myvps`

Only Cloudflare DNS challenge supported.
With a little tweaking, it would be possible to get support for any other challenges, but that's not necessary yet.

After installing, timer and service (`renew.service`, `renew.timer`) will be created on docker host. Every 12 hours
will be check (`runner.sh`): certificates need updating? If yes, script runs lego via `docker run`, updates
certificates, and runs `lego_reload_hooks` (`reload.sh`).

Certificates stored in `{{ lego_certificates_dir }}`, and can be mounted to other containers.

## install

Installs lego and scripts.

Required variables:

```yaml
lego_email: "example@example.com"
lego_cloudflare_api_token: "cloudflare api token, with dns zone read/write permission"
lego_domains:
  - example.com
  - "*.example.com"
  - "helloworld.local"

# Not required, but useful:
# Command to execute if certificates updated:
lego_reload_hooks:
    - docker exec caddy caddy reload --config /etc/caddy/Caddyfile # default
```

## render_reload

Renders additional reload scripts for custom chains.

Example: if certificates updated, reload caddy and sing-box containers.

## Debug

```bash
sudo systemctl start lego-renew.service # explicit start checking
systemctl status lego-renew.timer
journalctl -u lego-renew.service -f # realtime logs
```
