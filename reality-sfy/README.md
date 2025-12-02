# reality-sfy

Basic installation and setup of REALITY, steal from yourself, [Xray](https://github.com/XTLS/Xray-core) server. It is assumed that `Basic` has been run prior to this.

- Installs nginx, installs Xray via [Xray-install](https://github.com/XTLS/Xray-install).
- Sets basic configs for nginx and Xray.
- Installs certbot (via pip) with automatic updates (via cron) and certificate retrieval.

1. In the directory with the playbook, create a file `index.html` with your custom HTML (REALITY will fall back to this).

2. Obtain a domain and make sure it points to your VPS IP.
