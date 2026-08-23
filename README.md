# ansiblecfgs (v3)

Automate everything.

The main principle in v3: basic system setup, and everything else in Docker containers.

Main variable where data places: `caddy_dir`.

Requirements: Linux or WSL host, full version of `ansible` (not just `ansible-core`).

## Usage

- Fill `inventories/prod` directory with your hosts, and `group_vars`.

- Select playbook you needed. If your VPS is clean, you usually needed [`system`](./playbooks/system) playbook first.

- Fill variables required by playbook.

- Run playbook. Example: `ansible-playbook -i inventories/prod playbooks/system/setup.yml --limit myhost`

## Documentation

See [playbooks](./playbooks) directory, and each playbook `README.md`.

## Example Ansible installation

See more in [Ansible docs](https://docs.ansible.com/projects/ansible/latest/installation_guide/intro_installation.html).

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

## Issues

[Due to `sudo` changes in Ubuntu 26.04](https://www.reddit.com/r/ansible/comments/1t6ie61/become_true_not_working_with_ubuntu_2604_lts), you may need to set

`ansible_become_exe: "sudo.ws"` in your variables.
