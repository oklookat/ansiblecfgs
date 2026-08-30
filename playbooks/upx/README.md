# upx

<https://github.com/upx/upx>

Local `upx` operations.

Requirements: `Docker` **on localhost**.

## compress.yml

Default: compress `test` binary. Expected: `test.upx` in this dir.

```sh
ansible-playbook -i inventories/prod playbooks/upx/compress.yml
```
