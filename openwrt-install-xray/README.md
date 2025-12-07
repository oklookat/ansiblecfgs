# openwrt-install-xray

Automates the installation and update of **xray-core** on OpenWRT devices with small disk space. It performs local compression of the binary with **UPX**, renders templates, and deploys everything to the router using SSH/SCP, without requiring Python on the OpenWRT host.

## Usage

```bash
ansible-playbook -i inventory.yml playbook.yml
```

## Directory structure

- `compress/`
  - `workdir/`: UPX and Xray binaries from Docker.
  - `playbook.yml`: downloads & compresses Xray.
- `templates/`
  - `workdir/`: rendered templates.
  - `playbook.yml`: renders config/init scripts.
- `inventory.yml`: all variables.
- `playbook.yml`: main deployment playbook.
