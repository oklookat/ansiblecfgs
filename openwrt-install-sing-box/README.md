# openwrt-install-sing-box (WIP, not tested)

Automates the installation and update of **sing-box** on OpenWRT devices with small disk space. It performs local compression of the binary with **UPX**, renders templates, and deploys everything to the router using SSH/SCP, without requiring Python on the OpenWRT host.

## Requirements

### localhost

* **Ansible**
* **Docker** (for compression)

### Docker

```
# Pull ARM64 Ubuntu container
docker run --rm -it --platform linux/arm64 ubuntu:22.04 /bin/bash

# Inside the container:
apt update && apt install -y wget xz-utils tar
```

## Usage

```bash
ansible-playbook -i inventory.yml playbook.yml
```

## Directory structure

- `compress/`
    - `temp-data/`: UPX and sing-box binaries from Docker.
    - `playbook.yml`: downloads & compresses sing-box.
- `templates/`
    - `temp-data/`: rendered templates.
    - `playbook.yml`: renders config/init scripts.
- `inventory.yml`: all variables.
- `playbook.yml`: main deployment playbook.

