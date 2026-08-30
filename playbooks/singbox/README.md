# sing-box

<https://github.com/SagerNet/sing-box>

`ansible-playbook -i inventories/prod playbooks/singbox/one_of_playbooks_below.yml`

## install_openwrt.yml

Installs or updates `sing-box`, compressed with `upx`.

Requiremenets: `Docker` on `host`.

## deploy_config.yml

Deploys config.

Supports: remote hosts and `OpenWrt`.

## update.yml

Updates sing-box Dockerfile and compose file.

## deploy_config_mixed.yml

Deploys simple mixed config.

## deploy_config_wgcf.yml

Deploys config with `wgcf` + WireGuard endpoint (system).
