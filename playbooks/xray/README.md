# xray

<https://github.com/xtls/xray-core>

`ansible-playbook -i inventories/prod playbooks/xray/one_of_playbooks_below.yml`

## install_openwrt.yml

Installs or updates `xray`, compressed with `upx`.

Requiremenets: `Docker` on `host`.

## deploy_config.yml

Deploys config.

Supports: remote hosts and `OpenWrt`.

## update.yml

Updates xray Dockerfile and compose file.
