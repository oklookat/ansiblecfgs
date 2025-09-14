# sing-box-deploy

Run Ansible:

```bash
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

---

## Setting Directory Permissions for a Group (No sudo needed)

If you want multiple users to manage files in a directory **without using sudo**, you can create a dedicated group and configure the directory with proper permissions.

### Create a group

```sh
sudo groupadd groupname
```

* Example: `singboxctl` or `www-deploy`.

### Add users to the group

```sh
sudo usermod -aG groupname youruser

# Example:
sudo usermod -aG www-deploy youruser
sudo usermod -aG www-deploy root
sudo usermod -aG www-deploy sing-box
```

* After adding, log out and back in, or run:

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

* `g+rwX` -> group can read/write, and `X` allows entering directories.

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
