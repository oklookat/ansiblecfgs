# WireGuard

Pure WireGuard VPN in Docker with full Jinja-generated configs.
Supports IPv4 + IPv6. Designed for nftables + Docker backend.

## install

```bash
ansible-playbook -i inventories/prod playbooks/wireguard/install.yml --limit myhost
```

## Required variables

```yaml
docker_dir: "/opt/ansiblecfgs/docker"
docker_group: "docker"

wireguard_endpoint: "vpn.example.com"   # or public IP
```

## Example

```yaml
wireguard_port: 51820
wireguard_address: "10.13.13.1/24"
wireguard_network_cidr: "10.13.13.0/24"

wireguard_enable_ipv6: true
wireguard_address_ipv6: "fd42:42:42::1/64"
wireguard_network_cidr_ipv6: "fd42:42:42::/64"

wireguard_peers:
  - name: phone
    address: "10.13.13.2/32"
    address_ipv6: "fd42:42:42::2/128"
    allowed_ips: "0.0.0.0/0, ::/0"
    persistent_keepalive: 25

  - name: laptop
    address: "10.13.13.3/32"
    address_ipv6: "fd42:42:42::3/128"
    allowed_ips: "0.0.0.0/0, ::/0"
    persistent_keepalive: 25
```

## Client configs

After install, client configs are available at:

```
{{ docker_dir }}/wireguard/clients/<name>/<name>.conf
```

## nftables

The role deploys rules to:

```
/etc/nftables.d/wireguard.nft
```

These rules are included by the main `nftables.conf` from the `firewall` role.

**Important:**  
Do not run `nft -f /etc/nftables.conf` while Docker is running — Docker rules will be flushed.  
Use the procedure from `playbooks/docker/README.md` (stop Docker → apply nft → start Docker).

## Notes

- Keys are generated once and persisted.
- Changing peers list will regenerate client configs (existing keys are kept).
- To force key regeneration for a peer — delete its folder under `clients/` and re-run the playbook.
