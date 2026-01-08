# ansiblecfgs (v2)

In development.

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
