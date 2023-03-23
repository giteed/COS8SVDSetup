#!/bin/bash

# Source global definitions
# --> Прочитать настройки из /root/.bashrc
#. /root/.bashrc

# --> Этот ссылка на функцию проверяет, запущен-ли скрипт с правами суперпользователя (root) в Linux.
#. /root/vdsetup.2/bin/functions/run_as_root.sh


# --> Полное удаление VDSetup (не удаляет того, что было установлено скриптом)
sudo rm -rf /root/COS8SVDSetup
sudo rm -rf /root/vdsetup.2
sudo rm /root/.bashrc
sudo rm /root/.bash_aliases
sudo rm /root/.bash_profile

exit 0 ; 
