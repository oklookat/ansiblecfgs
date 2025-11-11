# reality-sfy-sing-box

Basic installation and setup of REALITY, steal from yourself, sing-box server.

- Imports: `install-sing-box`, `install-certbot`, `certbot-default`.
- Sets basic configs for nginx and sing-box.
  - sing-box version, where config tested: `1.12.*`.
- Enables `sing-box`, `nginx`.

1. In the directory with the playbook, create a file `index.html` with your custom HTML (REALITY will fall back to this).

2. Obtain a domain, make sure it points to your VPS IP.
