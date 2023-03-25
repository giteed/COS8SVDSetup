#!/bin/bash

# --> Этот ссылка на функцию проверяет, запущен-ли скрипт с правами суперпользователя (root) в Linux.
. /root/vdsetup.2/bin/functions/run_as_root.sh

# --> Функция для удаления старой версии репозитория и клонирования свежей версии из GitHub После клонирования запускается скрипт /preloader.sh
function rm_clone() {
# --> переходим в корневую директорию
        cd /root/ ;
# --> удаляем старую версию репозитория, если есть
        rm -rf /root/COS8SVDSetup ; 
# --> клонируем репозиторий из GitHub
        (git clone https://github.com/giteed/COS8SVDSetup.git /root/COS8SVDSetup) ;
# --> запускаем скрипт /preloader.sh
        (/root/COS8SVDSetup/bin/cos8svdsetup/preloader.sh) ; 
        return ; # --> завершаем функцию
}

# --> Функция для синхронизации репозитория и обновления локальной версии.
# --> Если локальная версия отсутствует, то вызывается функция rm_clone для ее создания
# --> После синхронизации копируются файлы из репозитория в /root/vdsetup.2/bin/
# --> и переносится .bashrc, .bash_profile, и .bash_aliases в домашнюю директорию /root/

function vsync() {
    echo ========================================================================== ;
    echo .......................................................................... ;
# --> Внутренняя функция для синхронизации репозитория и обновления локальной версии   
    function _vsync() {
# --> переходим в директорию репозитория
        cd /root/COS8SVDSetup ;
# --> сохраняем изменения в stash
        #git status ;
        #git stash ;
# --> синхронизируем репозиторий с GitHub
        gh repo sync --branch=main ;
# --> Копирование файлов из репозитория в /root/vdsetup.2/bin
        sudo cp -a /root/COS8SVDSetup/bin/cos8svdsetup/. /root/vdsetup.2/bin ;
# --> копируем .bashrc, .bash_profile и .bash_aliases в домашнюю директорию /root/
        sudo cp -a /root/COS8SVDSetup/.bashrc /root/ ;
        sudo cp -a /root/COS8SVDSetup/.bash_profile /root/ ;
        sudo cp -a /root/COS8SVDSetup/.bash_aliases /root/ ;
# --> копируем VERSION в /root/vdsetup.2/bin/
        sudo cp -a /root/COS8SVDSetup/VERSION /root/vdsetup.2/bin/ ;
        cd ~
# --> Наконец, запускается алиас чтения .bashrc для применения изменений alias urc='source /root/.bashrc'
        source /root/.bashrc
        urc ;
        
        ttb=$(echo -e "  VDSetup $(cat /root/vdsetup.2/bin/VERSION)\n\n  If you need to completely remove,\n  and reinstall vdsetup from GitHub,  type: # rm_clone \n  If you only need to remove vdsetup, type: # rm_vdsetup \n  ( Alias 'urc' ) For update .bashrc, type: # source /root/.bashrc") && lang_cr ; bpn_p_lang ; 
        echo ========================================================================== ;
    }
# --> Включение SSH протокола для работы с репозиторием
    gh config set -h github.com git_protocol ssh ;
# --> Проверка наличия директории /root/COS8SVDSetup, если директории нет - клонируем репозиторий rm_clone, иначе запускаем _vsync
    [[ -n $(ls /root/COS8SVDSetup) ]] 2>/dev/null && _vsync || rm_clone ;
}

