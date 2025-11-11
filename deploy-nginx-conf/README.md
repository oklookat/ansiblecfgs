# deploy-nginx-conf

- Copy nginx.conf from current dir to staging dir. Staging dir example: `/usr/share/deploy-staging`. See `deploy-group` playbook.
- Test it via `nginx`.
- Creates backup of `/etc/nginx/nginx.conf`.
- Replaces config.
- Restarts `nginx`.
