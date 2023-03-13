#!/bin/bash

# --> Этот функция проверяет, запущен ли скрипт с правами суперпользователя (root) в Linux.
. /root/vdsetup.2/bin/functions/run_as_root.sh

# --> клонирование из gh repo запуск /preloader.sh (в планах частичная синхронизация)
 function vsync()
 {
    cd /root/ ; (git clone https://github.com/giteed/COS8SVDSetup.git /root/.COS8SVDSetup) ; (/root/.COS8SVDSetup/bin/cos8svdsetup/preloader.sh) ;
 }