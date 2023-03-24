#!/bin/bash

# Source global definitions
# --> Прочитать настройки из /root/.bashrc
. /root/.bashrc

# --> Этот ссылка на функцию проверяет, запущен-ли скрипт с правами суперпользователя (root) в Linux.
. /root/vdsetup.2/bin/functions/run_as_root.sh

function remove_vdsetup() {
	# --> Полное удаление VDSetup (не удаляет того, что было установлено скриптом)
	sudo rm -rf /root/COS8SVDSetup
	sudo rm -rf /root/vdsetup.2
	sudo rm /root/.bashrc
	sudo rm /root/.bash_aliases
	sudo rm /root/.bash_profile
}


ttb=$(echo -e " 
 ⎧ 
 | A complete removal of VDSetup will be performed:
 | Installed using VDSetup will not be deleted!
 |
 | Commands will be executed:
 | # rm -rf /root/COS8SVDSetup
 | # rm -rf /root/vdsetup.2
 | # rm /root/.bashrc
 | # rm /root/.bash_aliases
 | # rm /root/.bash_profile
 ⎩" ) && lang_cr && bpn_p_lang ; 
 
 press_enter_to_continue_or_ESC_or_any_key_to_cancel ;
 
 remove_vdsetup ;
 
ttb=$(echo -e " 
 ⎧  
 | VDSetup removed! To reinstall, enter: # vsync
 | or:
 | # cd /root/ ; (dnf -y install rsync rsync-daemon git mc);
 | # git clone https://github.com/giteed/COS8SVDSetup.git /root/COS8SVDSetup ; 
 | # /root/COS8SVDSetup/bin/cos8svdsetup/preloader.sh ;
 ⎩" ) && lang_cr && bpn_p_lang ; 



exit 0 ; 
