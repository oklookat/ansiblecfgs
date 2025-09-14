# sing-box-deploy

Run Ansible:

```sh
# Full deployment
ansible-playbook -i hosts.yml deploy.yml

# Only VPS
ansible-playbook -i hosts.yml deploy.yml --tags vps

# Only Public Config
ansible-playbook -i hosts.yml deploy.yml --tags public_config

# Only Router
ansible-playbook -i hosts.yml deploy.yml --tags router

# Public Config on specific hosts
ansible-playbook -i hosts.yml deploy.yml --tags public_config --limit myvps2,myvps3
```

## Setting Directory Permissions for a Group (No sudo needed)

If you want multiple users to manage files in a directory **without using sudo**, you can create a dedicated group and configure the directory with proper permissions.

### Create a group

```sh
sudo groupadd groupname
```

Example: `sudo groupadd www-deploy`.

### Add users to the group

```sh
sudo usermod -aG groupname youruser
```

* Example:

```sh
sudo usermod -aG www-deploy youruser
sudo usermod -aG www-deploy root
sudo usermod -aG www-deploy sing-box
```

* After adding users, log out and back in, or run:

```sh
newgrp groupname
```

### Set the group ownership for the directory

```sh
sudo chgrp -R groupname /path/to/directory
```

* Recursively changes the group ownership for all files and subdirectories.

### Give the group write permissions

```sh
sudo chmod -R g+rwX /path/to/directory
```

* `g+rwX` → group can read/write, and `X` allows entering directories.

### Set the setgid bit (recommended)

```sh
sudo chmod g+s /path/to/directory
```

* New files and directories inherit the group automatically.
* Ideal for collaborative workflows.

### Verify

```sh
cd /path/to/directory
mkdir testdir
cd testdir
touch testfile.txt
ls -l
```

* New files should have the correct group and be writable without sudo.

### Typical Use Cases

* `/etc/sing-box` - configuration directory for sing-box.
* `/usr/share/nginx/static/` - shared web assets.
* Any collaborative directory where multiple users need write access.

### Notes / Best Practices

* Only trusted users should be added to the group.
* Always verify permissions after creation.
* Use `setgid` to avoid permission inconsistencies in collaborative directories.

## Granting Systemd Permissions via Polkit (No sudo needed)

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

* `action.id` → the Polkit action you want to allow (e.g., managing systemd units).
* `action.lookup("unit")` → restrict to a specific service.
* `subject.isInGroup("mygroup")` → restrict to users in a specific group.
* `polkit.Result.YES` → grants permission.

### Notes / Best Practices

* Only trusted users should be granted these permissions.
* Prefer groups over individual users for easier management.
* Polkit rules are evaluated in lexicographical order — lower-numbered files take precedence.
* After editing rules, changes take effect immediately; no service restart needed.
