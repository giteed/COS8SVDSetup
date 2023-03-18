#!/bin/bash

# Source global definitions
# --> Прочитать настройки из /root/.bashrc
#. /root/.bashrc

# --> Этот функция проверяет, запущен ли скрипт с правами суперпользователя (root) в Linux.
#. /root/vdsetup.2/bin/functions/run_as_root.sh

rm -rf /root/COS8SVDSetup
rm -rf /root/vdsetup.2
rm /root/.bashrc
rm /root/.bash_aliases
rm /root/.bash_profile

exit 0 ; 
