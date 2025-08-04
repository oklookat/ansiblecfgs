# Ansible Configurations

## Installing Ansible

### Ubuntu, WSL-Ubuntu

```sh
cd ~
sudo apt install -y python3
sudo apt install -y python3-pip
sudo apt install -y python3-venv
sudo apt install -y sshpass # for password login to the server
mkdir ansible && cd ansible
python3 -m venv venv
source venv/bin/activate # use venv to interact with Ansible
pip install ansible
pip install passlib # to create a user with a password on the server
```

If you haven't logged into the server yet, do so because otherwise it will complain about `known_hosts`. Run: `ssh root@SERVER_IP`

## General Instructions for All Configurations

1. Copy the directory.
2. Fill out `inventory.ini`.
3. Fill out the `vars` section in `playbook.yml`.
4. Follow the steps required for the specific configuration.
5. Enter the venv environment.
6. Run: `ansible-playbook -i inventory.ini playbook.yml`

## Basic

Basic VPS setup. This may not be suitable for all VPS.

- Sets DNS to Cloudflare.
- Changes the root password.
- Creates a new user with a password.
- Changes the SSH port, disables root login, allows login only via SSH keys, and disables other minor settings (see the config).
- Disables password login in cloud-init (may not be present on all servers, so the script might give an error).
- Copies `id_rsa` from your home directory to the server. **If `id_rsa` is missing, generate it with `ssh-keygen -t rsa -b 4096 -C "your email"`.**
- Disables UFW and configures iptables to allow HTTP, HTTPS, SSH (see the config).
- Enables BBR, TCP Fast Open, and other tweaks.

After reboot (it will be unsucsessful, because ssh and credentials changed), you can log into the server (always log in this way):

`ssh NEW_USER_NAME@SERVER_IP -p NEW_SSH_PORT`

## reality-sfy

Basic installation and setup of REALITY, steal from yourself, [Xray](https://github.com/XTLS/Xray-core) server. It is assumed that `Basic` has been run prior to this.

- Installs nginx and Xray (via [Xray-install](https://github.com/XTLS/Xray-install)).
- Sets basic configs for nginx and Xray.
- Installs certbot (via pip) with automatic updates (via cron) and certificate retrieval.
- Key affected files and directories: `/usr/local/etc/xray/config.json`, `/etc/nginx/nginx.conf`, `/usr/share/nginx/html/index.html`, `/opt/certbot`.

1. In the directory with the playbook, create a file `index.html` with your custom HTML (REALITY will fall back to this).

2. Obtain a domain and make sure it points to your VPS IP.

## reality-sfy-sing-box

Basic installation and setup of REALITY, steal from yourself, [sing-box](https://github.com/SagerNet/sing-box) server. It is assumed that `Basic` has been run prior to this.

- Installs nginx and sing-box (via [APT](https://sing-box.sagernet.org/installation/package-manager)).
- Sets basic configs for nginx and sing-box.
  - sing-box version, where config tested: 1.11.10
- Installs certbot (via pip) with automatic updates (via cron) and certificate retrieval.
- Key affected files and directories: `/etc/sing-box/config.json`, `/etc/nginx/nginx.conf`, `/usr/share/nginx/html/index.html`, `/opt/certbot`.

1. In the directory with the playbook, create a file `index.html` with your custom HTML (REALITY will fall back to this).

2. Obtain a domain and make sure it points to your VPS IP.

## wireguard-sing-box

- Basic VPS setup.

- Basic setup of WireGuard + sing-box server.

- For your reference: [example sing-box client config](./wireguard-sing-box/sing-box-client.json).
