# reality-sfy (LEGACY)

**Not updating now, prefer to use `reality-sfy-sing-box`**.

Basic installation and setup of REALITY, steal from yourself, [Xray](https://github.com/XTLS/Xray-core) server. It is assumed that `Basic` has been run prior to this.

- Installs nginx and Xray (via [Xray-install](https://github.com/XTLS/Xray-install)).
- Sets basic configs for nginx and Xray.
- Installs certbot (via pip) with automatic updates (via cron) and certificate retrieval.
- Key affected files and directories: `/usr/local/etc/xray/config.json`, `/etc/nginx/nginx.conf`, `/usr/share/nginx/html/index.html`, `/opt/certbot`.

1. In the directory with the playbook, create a file `index.html` with your custom HTML (REALITY will fall back to this).

2. Obtain a domain and make sure it points to your VPS IP.
