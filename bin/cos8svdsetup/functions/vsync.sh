#!/bin/bash

# --> Этот функция проверяет, запущен ли скрипт с правами суперпользователя (root) в Linux.
#. /root/vdsetup.2/bin/functions/run_as_root.sh


 function rm_clone() {
    cd /root/ ; rm -rf /root/COS8SVDSetup ; (git clone https://github.com/giteed/COS8SVDSetup.git /root/COS8SVDSetup) ; (/root/COS8SVDSetup/bin/cos8svdsetup/preloader.sh) ; return ;
    
}


# --> клонирование из gh repo запуск /preloader.sh (в планах частичная синхронизация)
 function vsync()
 {
    function _vsync() {
        
        
        cd /root/COS8SVDSetup ;
        # сохранение изменений в стэш
        git status ;
        git stash ;
        gh repo sync --branch=main ;
        sudo cp -a /root/COS8SVDSetup/bin/cos8svdsetup/. /root/vdsetup.2/bin #2>/dev/null
        # --> скопировать файлы конфигурации в корневой каталог
        
        sudo cp -a /root/COS8SVDSetup/.bashrc /root/ ;
        sudo cp -a /root/COS8SVDSetup/.bash_profile /root/ ;
        sudo cp -a /root/COS8SVDSetup/.bash_aliases /root/ ;
        cd ~
        source /root/.bashrc
    }
    

    
    gh config set -h github.com git_protocol ssh ;
    
    [[ -n $(ls /root/COS8SVDSetup) ]] 2>/dev/null && _vsync || rm_clone ;

 }
 
