# sing-box-deploy

Convenient deployment of sing-box configurations.

- Copies `sing-box` configs, validates, and restart service. Supports `systemd` and `OpenWrt`.

- Deployment of public `sing-box` configs with validation(?).

- Assumed that no password needed for `systemctl restart sing-box` and access to `/etc/sing-box`.
  - It can be achieved with `deploy-group` and `polkit-manage-units` playbooks.

Run Ansible:

```sh
# Full deployment
ansible-playbook -i hosts.yml deploy.yml

# Only VPS
ansible-playbook -i hosts.yml deploy.yml --tags vps

# Only Public Config
ansible-playbook -i hosts.yml deploy.yml --tags public_config

# Only Router
ansible-playbook -i hosts.yml deploy.yml --tags router

# Public Config on specific hosts
ansible-playbook -i hosts.yml deploy.yml --tags public_config --limit myvps2,myvps3
```
