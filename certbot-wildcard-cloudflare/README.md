# certbot-wildcard-cloudflare

Assumed that `certbot` installed via `install-cerbot` playbook.

<https://certbot.eff.org/instructions?ws=nginx&os=pip&tab=wildcard>

Provider: `cloudflare-dns`

- Installs `certbot` cloudflare-dns plugin.
- Puts Cloudflare API token to `/root/.secrets/certbot/cloudflare.ini`
- Gets **wildcard** certificate
- `nginx`, `pip`, autorenewal, autoupdate.

Required:

- You domain managed by Cloudflare.
- Cloudflare User API Token with `Edit zone DNS` permission.

All of this you can get in Cloudflare Dashboard.
