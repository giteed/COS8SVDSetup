#!/bin/bash

# --> Этот функция проверяет, запущен ли скрипт с правами суперпользователя (root) в Linux.
. /root/vdsetup.2/bin/functions/run_as_root.sh

# --> клонирование из gh repo запуск /preloader.sh (в планах частичная синхронизация)
 function vsync()
 {
    gh config set -h github.com git_protocol ssh
    
    function sync() {
        
        cd /root/COS8SVDSetup ;
        
        # сохранение изменений в стэш
        git status ;
        git stash ;
        gh repo sync --branch=main ;
        echo y | cp -a /root/COS8SVDSetup/bin/cos8svdsetup/. /root/vdsetup.2/bin #2>/dev/null
    }
    
    function rm_clone() {
        cd /root/ ; rm -rf /root/COS8SVDSetup ; (git clone https://github.com/giteed/COS8SVDSetup.git /root/COS8SVDSetup) ; (/root/COS8SVDSetup/bin/cos8svdsetup/preloader.sh) ;
    }
    sync #|| rm_clone
 }
 
 #vsync ;