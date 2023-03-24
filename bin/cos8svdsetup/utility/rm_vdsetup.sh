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

ttb=$(echo -e " 
 ⎧ 
 | Будет выполнено полное удаление VDSetup:
 | Установленное с помощью VDSetup
 | удалено не будет!
 ⎩" ) && bpn_p_lang ; 
 
 press_enter_to_continue_or_ESC_or_any_key_to_cancel ;
 
ttb=$(echo -e " 
 ⎧  
 | # sudo rm -rf /root/COS8SVDSetup
 | # sudo rm -rf /root/vdsetup.2
 | # sudo rm /root/.bashrc
 | # sudo rm /root/.bash_aliases
 | # udo rm /root/.bash_profile
 | VDSetup удален! Для повторной установки введите:
 | # cd /root/ ; (dnf -y install rsync rsync-daemon git mc); (echo); (git clone https://github.com/giteed/COS8SVDSetup.git /root/COS8SVDSetup) ; (/root/COS8SVDSetup/bin/cos8svdsetup/preloader.sh) ;
 ⎩" ) && bpn_p_lang ; 



exit 0 ; 
