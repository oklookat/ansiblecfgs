# Конфиги для Ansible

## Установка Ansible

```sh
cd ~
sudo apt install -y python3
sudo apt install -y python3-pip
sudo apt install -y python3-venv
sudo apt install -y sshpass # для входа по паролю на сервер
mkdir ansible && cd ansible
python3 -m venv venv
source venv/bin/activate # для взаимодействия с Ansible используйте venv
pip install ansible
pip install passlib # для создания пользователя с паролем на сервере
```

В директории ansible создайте файл `inventory.ini`. Впишите такое:

```ini
[all]
IP_СЕРВЕРА ansible_user=root ansible_password=ПАРОЛЬ_ОТ_РУТА
```

## basic.yml

Базовая настройка VPS. Вероятно, подойдет не для всех VPS.

- Устанавливает DNS на CloudFlare.
- Изменяет пароль рута.
- Создает нового пользователя с паролем.
- Меняет порт SSH, запрещает вход под рутом, разрешает вход только по SSH ключу, и запрешает другие мелкие вещи (см. в конфиге).
- Запрещает вход по паролю в cloud-init (может быть не на всех серверах, поэтому тут скрипт может выдать вам ошибку).
- Копирует id_rsa из вашей домашней папки на сервер.
- Отключает UFW, и настраивает iptables (см. конфиг).
- Включает BBR, отключает ipv6, включает syncookies, и подобные твики. 

Скопируйте его в директорию `ansible`. Чтобы начать установку на сервер, введите:

```sh
ansible-playbook -i inventory.ini basic.yml --extra-vars "new_ssh_port=НОВЫЙ_ПОРТ_SSH new_user_name=НОВОЕ_ИМЯ_ПОЛЬЗОВАТЕЛЯ new_user_password=ПАРОЛЬ_НОВОГО_ПОЛЬЗОВАТЕЛЯ new_root_password=НОВЫЙ_ПАРОЛЬ_ДЛЯ_РУТА"
```

После успешной установки войдите на сервер (теперь всегда входите так):

`ssh НОВОЕ_ИМЯ_ПОЛЬЗОВАТЕЛЯ@IP_СЕРВЕРА -p НОВЫЙ_ПОРТ_SSH`

И перезагрузите систему - `sudo reboot`.

Готово.