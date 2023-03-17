#!/bin/bash

# --> Этот функция проверяет, запущен ли скрипт с правами суперпользователя (root) в Linux.
. /root/vdsetup.2/bin/functions/run_as_root.sh

# --> клонирование из gh repo запуск /preloader.sh (в планах частичная синхронизация)
 function vsync()
 {
  
    
    function sync() {
        
        cd /root/COS8SVDSetup ;
        
        # сохранение изменений в стэш
        git status ;
        git stash ;
        gh repo sync --branch=main ;
        echo y | cp -a /root/COS8SVDSetup/bin/cos8svdsetup/. /root/vdsetup.2/bin #2>/dev/null
        # --> скопировать файлы конфигурации в корневой каталог
        echo y | cp -f /root/.COS8SVDSetup/.bashrc /root/ ;
        echo y | cp -f /root/.COS8SVDSetup/.bash_profile /root/ ;
        echo y | cp -f /root/.COS8SVDSetup/.bash_aliases /root/ ;
        source /root/.bashrc
    }
    
    function rm_clone() {
        cd /root/ ; rm -rf /root/COS8SVDSetup ; (git clone https://github.com/giteed/COS8SVDSetup.git /root/COS8SVDSetup) ; (/root/COS8SVDSetup/bin/cos8svdsetup/preloader.sh) ;
    }
    
    gh config set -h github.com git_protocol ssh ;
    (sync 2>/dev/null) && echo sync OK || echo sync_fail #&& rm_clone && echo rm_clone OK
 }
 
 #vsync ;