# System

## setup

`ansible-playbook -i inventories/prod playbooks/system/setup.yml --limit myvps`

Variables:

```yaml
# before system/setup:
# (comment this block after system/setup and rebooting)
ansible_host: 192.168.1.1
ansible_user: "root"
ansible_password: "root"
###

system_new_root_password: "newroot"
system_new_user_name: "myuser"
system_new_user_password: "myuser"
system_new_ssh_port: "31101"

# after system/setup and rebooting, uncomment this:
# ansible_host: 192.168.1.1
# ansible_port: "{{ system_new_ssh_port }}"
# ansible_user: "{{ system_new_user_name }}"
# ansible_become_password: "{{ system_new_user_password }}"
```
