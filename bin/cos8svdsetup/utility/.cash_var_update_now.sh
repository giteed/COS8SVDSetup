#!/bin/bash

# Source global definitions
# --> Прочитать настройки из /root/.bashrc
. /root/.bashrc ;

lang_cr ;

#echo -en "\n${CYAN} " ; ( systemctl status cash_var.service | grep " active " | awk '/active/  { print $2, $3 }' ) ; echo -e "${NC}" 
#) && bpn_p_lang ; ttb="" ;

function check_var_for_update() {
# Функция vsync_15 в screen обновляет VDSetup.
	   function vsync15() {
			echo ; auto_update_status ;
			
			source /root/.bashrc &>/dev/null ;
			source /root/.bash_profile &>/dev/null ;
			sudo /root/vdsetup.2/bin/utility/gh-ss.sh ;
		   
		   exit 0 ;
		}
	
	vsync15

	exit 0 ;
}


function update_cash() {

	ttb=$(echo -e " Эта функция обновляет ip адрес текущего Socks5 соединения настроенного на Tor.\n Установить или посмотреть помощь по \"Tor\": # vdsetup tor\n\n") && bpn_p_lang ; ttb="" ; echo ;
	
	ttb=$(echo -e " Old tor ip  : $(cat /tmp/tor_ip) ") && bpn_p_lang ; ttb="" ;
	(curl -s --socks5 127.0.0.1:${tor_port} icanhazip.com) >/tmp/tor_ip ;
	sleep 1 ;
	ttb=$(echo -e " New tor ip  : $(cat /tmp/tor_ip) ") && bpn_p_lang ; ttb="" ;
	
	check_var_for_update ;

	sleep 1 ;
	return 
}

update_cash ;

# https://habr.com/ru/company/southbridge/blog/255845/

echo -en "${GREEN} " ; ( systemctl status cash_var.service | grep " active " | awk '/active/ { print $2 }' ) ; echo -e "${NC}\n" 


exit 0 ; 

