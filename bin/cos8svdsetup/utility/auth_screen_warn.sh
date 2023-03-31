#!/bin/bash

# Source global definitions
# --> Прочитать настройки из /root/.bashrc
#. /root/.bashrc

# --> Этот ссылка на функцию проверяет, запущен-ли скрипт с правами суперпользователя (root) в Linux.
#. /root/vdsetup.2/bin/functions/run_as_root.sh



#while true; do echo "test"; sleep 10; done

sudo socat unix-listen:/tmp/mysocket.sock,fork -& 
sudo -u root /root/vdsetup.2/bin/utility/auth_warn.sh | sudo socat - unix-connect:/tmp/mysocket.sock 



