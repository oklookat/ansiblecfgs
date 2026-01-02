# openwrt-install-xray

Installation and update of **Xray-core** on OpenWRT devices. Local compression of the Xray binary with **UPX**, renders templates, and deploys everything to the router using SSH/SCP.

[TPROXY (port 3000), DNS interception (port 53), dnsmasq disabled](./templates/init.d/xray.j2).

## Usage

1. localhost: `ansible-playbook -i inventory.yml playbook.yml`
2. OpenWrt: fill `/etc/xray/config.json`.
3. OpenWrt: `service xray start`

## config.json example

```jsonc
{
    "log": {
        "loglevel": "info"
    },
    "dns": {
        "tag": "dns-proxy",
        "queryStrategy": "UseIP",
        "disableFallbackIfMatch": false,
        "servers": [
            {
                "address": "fakedns"
            },
            {
                "address": "tcp://1.1.1.1:53533"
            },
            {
                "tag": "dns-direct",
                "address": "https://77.88.8.8/dns-query",
                "domains": [
                    "geosite:category-ru"
                ],
                "skipFallback": true
            },
            {
                "tag": "dns-direct",
                "address": "62.76.76.62",
                "domains": [
                    "geosite:category-ru"
                ],
                "skipFallback": true,
                "finalQuery": true
            }
        ]
    },
    "fakedns": [
        {
            "ipPool": "198.19.0.0/16",
            "poolSize": 65535
        },
        {
            "ipPool": "fd88:1234:5678::/48",
            "poolSize": 65535
        }
    ],
    "routing": {
        "domainStrategy": "AsIs",
        "rules": [
            {
                "type": "field",
                "protocol": [
                    "quic"
                ],
                "outboundTag": "block-out"
            },
            {
                "type": "field",
                "inboundTag": [
                    "doko-in-dns"
                ],
                "outboundTag": "dns-out"
            },
            {
                "inboundTag": [
                    "dns-direct"
                ],
                "outboundTag": "direct-out"
            },
            {
                "type": "field",
                "ip": [
                    "geoip:private",
                    "77.88.8.8",
                    "62.76.76.62"
                ],
                "outboundTag": "direct-out"
            },
            {
                "type": "field",
                "domain": [
                    "geosite:category-ru"
                ],
                "outboundTag": "direct-out"
            },
            {
                "type": "field",
                "protocol": [
                    "bittorrent"
                ],
                "outboundTag": "direct-out"
            },
            {
                "type": "field",
                "inboundTag": [
                    "dns-proxy"
                ],
                "outboundTag": "vless-out"
            }
        ]
    },
    "inbounds": [
        {
            "tag": "doko-in",
            "listen": "0.0.0.0",
            "port": 3000,
            "protocol": "dokodemo-door",
            "settings": {
                "network": "tcp,udp",
                "followRedirect": true
            },
            "streamSettings": {
                "sockopt": {
                    "tproxy": "tproxy"
                }
            },
            "sniffing": {
                "enabled": true,
                "destOverride": [
                    "http",
                    "tls",
                    "quic",
                    "fakedns"
                ]
            }
        },
        {
            "tag": "doko-in-dns",
            "listen": "0.0.0.0",
            "port": 53,
            "protocol": "dokodemo-door",
            "settings": {
                "network": "tcp,udp",
                "followRedirect": false
            },
            "sniffing": {
                "enabled": false
            }
        }
    ],
    "outbounds": [
        {
            "tag": "vless-out",
            "protocol": "vless",
            "settings": {
                // etc...
            },
            "streamSettings": {
                "sockopt": {
                    "domainStrategy": "UseIP",
                    "mark": 2
                }
                // etc...
                }
            }
        },
        {
            "tag": "direct-out",
            "protocol": "freedom",
            "settings": {
                "targetStrategy": "UseIP"
            },
            "streamSettings": {
                "sockopt": {
                    "domainStrategy": "UseIP",
                    "mark": 2
                }
            }
        },
        {
            "protocol": "dns",
            "tag": "dns-out",
            "streamSettings": {
                "sockopt": {
                    "mark": 2
                }
            }
        },
        {
            "tag": "block-out",
            "protocol": "blackhole",
            "settings": {
                "response": {
                    "type": "http"
                }
            }
        }
    ]
}
```
