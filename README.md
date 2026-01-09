# ansiblecfgs (v2)

In development.

## v1 to v2

### General

- [ ] README's
- [ ] Examples
- [ ] Testing

### Testing

- [ ] playbooks
  - [x] system
    - [x] setup

### Code

- [x] basic
- [x] certbot
  - [x] default
  - [x] wildcard-cloudflare
- [x] deploy-group
- [x] deploy-nginx-conf
  - [ ] Currently for reality_sfy only. Need to extend?
- [x] generate-cert
- [x] sing-box
  - [x] install
  - [x] install-openwrt
  - [x] reality-sfy
  - [x] reality
  - [x] shadowsocks
    - [ ] Make idempotent
  - [x] tls
  - [x] wireguard
- [x] xray
  - [x] install
  - [x] install-openwrt
  - [x] reality-sfy
  - [x] tls
  - [x] deploy-geo
- [x] polkit-manage-units
- [ ] deploy-teletrack

## Installing Ansible

### Ubuntu, WSL (Ubuntu)

```sh
cd ~
sudo apt install -y python3 python3-pip python3-venv sshpass # sshpass for password login to the server
mkdir ansible && cd ansible
python3 -m venv .venv
source .venv/bin/activate # use venv to interact with Ansible
pip install ansible passlib # passlib for creating a user with a password on the server
```

If you haven't logged into the server yet, do so because otherwise it will complain about `known_hosts`. Run: `ssh root@SERVER_IP`

## Usage

`ansible-playbook -i inventories/staging playbooks/system/setup`

or 

`make staging system/setup` (assumed that Ansible bin placed in `$HOME/ansible/.venv/bin`)