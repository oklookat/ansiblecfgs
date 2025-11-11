# polkit-manage-units

`Ubuntu 24.04` required, due to new polkit syntax.

Allows specific group to manage specific `systemd` unit.

Useful with `deploy-group` playbook.

Example: i need to restart nginx by my user without password.
I creating group via `deploy-group` and add my user to it.
Then i run `polkit-manage-user`, that allows my deploy group to manage nginx unit without sudo password.

## Based on this guide

### Granting Systemd Permissions via Polkit (No sudo needed)

If you want certain users or groups to manage specific systemd services **without using sudo**, you can create a Polkit rule.

### Create a Polkit Rule

Create a file in `/etc/polkit-1/rules.d/`, e.g.:

```sh
sudo nano /etc/polkit-1/rules.d/10-singbox.rules
```

**Example — Allow `www-deploy` group to manage `sing-box.service`:**

```js
polkit.addRule(function(action, subject) {
    if (action.id == "org.freedesktop.systemd1.manage-units" &&
        action.lookup("unit") == "sing-box.service" &&
        subject.isInGroup("www-deploy")) {
        return polkit.Result.YES;
    }
});
```

*Explanation:*

- `action.id` → the Polkit action you want to allow (e.g., managing systemd units).
- `action.lookup("unit")` → restrict to a specific service.
- `subject.isInGroup("mygroup")` → restrict to users in a specific group.
- `polkit.Result.YES` → grants permission.

### Notes / Best Practices

- Only trusted users should be granted these permissions.
- Prefer groups over individual users for easier management.
- Polkit rules are evaluated in lexicographical order — lower-numbered files take precedence.
- After editing rules, changes take effect immediately; no service restart needed.
