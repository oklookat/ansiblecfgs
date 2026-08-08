# Docker

## caddy_naive_singbox

Docker + Caddy naive fork (upstream to sing-box) + sing-box (socks5 inbound)

Full example setup:

```bash
ansible-playbook -i inventories/prod playbooks/system/setup.yml --limit myvps

ansible-playbook -i inventories/prod playbooks/docker/install.yml --limit myvps

ansible-playbook -i inventories/prod playbooks/docker/caddy_naive_singbox.yml --limit myvps
```

Required variables:

```yaml
# before system/setup:
ansible_host: 192.168.1.1
ansible_user: "root"
ansible_password: "root"

system_new_root_password: "newroot"
system_new_user_name: "myuser"
system_new_user_password: "myuser"
system_new_ssh_port: "31101"

# after system/setup and rebooting, uncomment this:
# ansible_host: 192.168.1.1
# ansible_port: "{{ system_new_ssh_port }}"
# ansible_user: "{{ system_new_user_name }}"
# ansible_become_password: "{{ system_new_user_password }}"

# docker
docker_caddy_domain: "example.com"
docker_template_caddy_caddyfile: "mysecrets/caddyfile.naive.j2" # for custom caddyfile
docker_template_singbox_config: "mysecrets/mixed.json.j2" # for custom mixed config, mixed only
```

sing-box client outbound example:

```json
        {
            "type": "naive",
            "tag": "proxy",
            "server": "192.168.1.1",
            "server_port": 443,
            "username": "username",
            "password": "password",
            "insecure_concurrency": 1,
            "udp_over_tcp": true,
            "quic": false,
            "tls": {
                "enabled": true,
                "server_name": "example.com"
            }
        },
```
