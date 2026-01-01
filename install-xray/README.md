# install-xray

Installs `xray-core` via `Xray-install`.

## Autoupdate

Force: 

```
systemctl list-timers xray-update.timer
sudo systemctl start xray-update.service
sudo systemctl status xray-update.service
journalctl -u xray-update.service -n 50 --no-pager
```