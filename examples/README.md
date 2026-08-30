# Secrets

## Recommended layout

```txt
inventories/prod/
  hosts.yml
  group_vars/
    all.yml              # non-secret shared vars
  host_vars/
    myvps.yml            # host-specific vault-encrupted or not
```

## Using vault

Password for vault stored in: `~/.ansible_vault_pass` (see `ansible.cfg`)

Creating vault file with secrets example:

```sh
ansible-vault encrypt inventories/prod/host_vars/myvps.yml
ansible-vault decrypt inventories/prod/host_vars/myvps.yml
```

Editing encrypted file example:

```sh
ansible-vault edit inventories/prod/host_vars/myvps.yml
```

for comfort editing use VSCode:

```sh
# Example for fish shell, ~/.config/fish/config.fish file
set -gx EDITOR 'code --wait'
set -gx VISUAL 'code --wait'
```

## Run playbooks

```sh
# gets vault pass file from ansible.cfg
# or if not encrypted just reads inventory
ansible-playbook -i inventories/prod playbooks/system/setup.yml --limit myvps
```

## With vault pass or file

```bash
ansible-playbook -i inventories/prod playbooks/system/setup.yml --limit myvps --ask-vault-pass
# or
ansible-playbook ... --vault-password-file ~/.vault_pass
```
