# xray-deploy-geo

Deploys `geoip` and `geosite` files for Xray-core. Supports `systemd` and `OpenWrt`.

Usage: `ansible-playbook -i inventory.yml playbook.yml`

Write permissions can be achieved via [deploy-group](../deploy-group) and [polkit-manage-units](../polkit-manage-units) playbooks.
