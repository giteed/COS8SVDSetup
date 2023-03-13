#!/bin/bash

# --> Прочитать настройки из файла с функциями:
. /root/vdsetup.2/bin/functions/bat_or_bat_not_installed.sh
. /root/vdsetup.2/bin/functions/press_enter.sh
. /root/vdsetup.2/bin/functions/ypr.sh
. /root/vdsetup.2/bin/functions/ww.sh
. /root/vdsetup.2/bin/functions/ip_other_info_func.sh


# --> Этот функция проверяет, запущен ли скрипт с правами суперпользователя (root) в Linux.
#. /root/vdsetup.2/bin/functions/run_as_root.sh