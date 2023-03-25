#!/bin/bash

# Source global definitions
# --> Прочитать настройки из /root/.bashrc
. /root/.bashrc

echo ;


# Функция sleep_kill останавливает через 10 (600 сек) минут после последней активнисти пользователя скрипта VDSetup, юнит обновления кеша ip адреса Tor и версии VDSetup.
# /root/bin/utility/.cash_var.sh ;

# Юнит автоматически запускается снова на обновление раз в 150 секунд (2,5 мин) при запуске vdsetup, vdsetup tor, и др страницах на которые вставлена функция cash_var_sh_150_start_and_stop 


function sleep_kill() {
	   (sleep 600 )
	   (ls /tmp/up_sec.txt) || echo 147 > /tmp/up_sec.txt
	   (systemctl stop cash_var.service) &>/dev/null ;
   }
   
sleep_kill ;

exit 0 ; 

# юниты
# https://habr.com/ru/company/southbridge/blog/255845/