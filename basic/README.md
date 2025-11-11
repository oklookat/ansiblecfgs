# basic

Basic VPS setup.

First, you need SSH keys. If you dont have it, generate it with `ssh-keygen -t rsa -b 4096 -C "your email"`.

- Update, upgrade.
- Sets DNS to Cloudflare.
- Changes the root password.
- Creates a new user with a password.
- SSH
  - Changes port.
  - Disables root login.
  - Allows login only via keys.
  - Disables other minor settings.
- Disables password login in cloud-init.
- Copies `id_rsa.pub` (SSH key) from your home directory to the server.
- Changes firewall to `nftables`, allows `80 (TCP/UDP)`, `443 (TCP/UDP)`, `new SSH port (TCP)`.
- Enables BBR, IPv6 support, and other tweaks.

After setup, you can log into the server (now always log in this way):

`ssh NEW_USER_NAME@SERVER_IP -p NEW_SSH_PORT`

## Fails

## Reboot

In last step, will be `reboot`, it will be unsucsessful. Need to fix it, but idk how.

Anyway, you can log into the server (now always log in this way):

## Interactive update

`Upgrade all packages` can be failed, when interactive required. Example: new `sshd` config, `grub` update. Idk how to fix it, so sometimes you need to `apt upgrade` manually.
