#!/bin/bash

# Source global definitions
# --> Прочитать настройки из /root/.bashrc
. /root/.bashrc

# --> Этот ссылка на функцию проверяет, запущен-ли скрипт с правами суперпользователя (root) в Linux.
. /root/vdsetup.2/bin/functions/run_as_root.sh

function remove_vdsetup() {
	# --> Полное удаление VDSetup (не удаляет того, что было установлено скриптом)
	sudo rm -rf /root/COS8SVDSetup ;
	sudo rm -rf /root/vdsetup.2 ;
	sudo rm /root/.bashrc ;
	sudo rm /root/.bash_aliases ;
	sudo rm /root/.bash_profile ;
    remove_unit_stop_cashing ;
    rm /root/.login_password_Transmission.txt ;
    rm /tmp/up_sec.txt ;
    rm /tmp/ip_tmp.txt ;
    rm /tmp/tor_ip ;
}


ttb=$(echo -e " 
 ⎧ 
 | A complete removal of VDSetup will be performed:
 | Installed packages using VDSetup script, -
 | WILL NOT BE REMOVED!
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
 | VDSetup script removed successfully! 
 | To reinstall VDSetup script, type: 
 | # vsync
 | or:
 | # cd /root/ ; (dnf -y install rsync rsync-daemon git mc);
 | # git clone https://github.com/giteed/COS8SVDSetup.git /root/COS8SVDSetup ; 
 | # /root/COS8SVDSetup/bin/cos8svdsetup/preloader.sh ;
 ⎩" ) && lang_cr && bpn_p_lang ; 



exit 0 ; 
