# wireguard-sing-box

- Assumed that you executed Basic before.

- WireGuard + sing-box server.

- [Example sing-box client config](./sing-box-client.json).

## Thanks

Very big thanks to author of this guides:

<https://www.youtube.com/watch?v=Dv5jrp8shRg>

<https://github.com/wynemo/tech-notes/blob/master/science/sing-box/sing-box-wiregurad.md>

## Adding new client

- Add peer to server config (see /etc/sing-box/config.json on your server), and assign IP to it.

- Generate keys: `sing-box generate wg-keypair`.

- In server config: paste PUBLIC key to new peer.

- In client config: add endpoint, paste PRIVATE key.

- see [sing-box-client](./sing-box-client.json), [sing-box-server](./sing-box-server.json.j2).

## Note: router example

Example: OpenWrt with sing-box <-> VPS <-> Smartphone with sing-box app

- Must-have setting (check example client config):

```json
      {
        "action": "route",
        "outbound": "wg-out",
        "ip_cidr": "10.18.0.0/24"
      }
```

- OpenWrt firewall must be allow input, and forward (if needed).
