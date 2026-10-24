# xray files

## geoip.dat.openwrt, geosite.dat.openwrt

Minified geofiles for openwrt with small free space.

geoip: "private".

geosite: "private", "category-ru".

## xray-collector config

### geosite

```json
{
    "cachePath": "./build/geosite-cache",
    "maxCacheSize": 100000000,
    "input": [
        {
            "type": "v2ray-data",
            "args": {
                "uri": "https://raw.githubusercontent.com/v2fly/domain-list-community/refs/heads/master/data",
                "lists": [
                    "category-ru",
                    "private"
                ]
            }
        }
    ],
    "output": [
        {
            "type": "v2ray-dat",
            "action": "output",
            "args": {
                "path": "./build/output/geosite.dat",
                "lists": [
                    "category-ru",
                    "private"
                ]
            }
        }
    ]
}
```
