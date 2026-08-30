# Docker

<https://docker.com>

## install

Installs Docker.

- Removes old versions.
- Adds Docker repo, installs Docker.
- Firewall backend: nftables, ipv6.
- Starts docker.

## firewall

Published ports (like ports: - "443:3000") automatically updates nft rules.

But if you need manual rules, and you manually change nftables configs, and execute

`sudo nft -f /etc/nftables.conf`

Docker automatic rules also be removed, and Docker networks will be broken.

To avoid this, you need to stop Docker, flush rules, then enable Docker, to create rules automatically. This can be achieved via script like:

```sh
#!/bin/sh

set -e

sudo systemctl stop docker
sudo systemctl stop docker.socket

if sudo nft -f /etc/nftables.conf; then
    sudo systemctl start docker
else
    echo "ERROR: nftables configuration failed!" >&2
    sudo systemctl start docker
    exit 1
fi
```
