#!/bin/bash

# Source global definitions
# --> Прочитать настройки из /etc/bashrc
. /root/.bashrc

# --> Прочитать настройки:
. /root/bin/utility/.varfunc.sh &>/dev/null ;
. /root/bin/utility/.css.sh &>/dev/null 


debug_message ;
lang=nix ;

#echo -en "\n${CYAN} " ; ( systemctl status cash_var.service | grep " active " | awk '/active/  { print $2, $3 }' ) ; echo -e "${NC}" 
#) && bpn_p_lang ; ttb="" ;

function check_var_for_update() {
	

	# Функция vsync_15 в screen обновляет VDSetup.
	   function vsync15() {
			echo ; auto_update_status ;
			
			source /root/.bashrc &>/dev/null ;
			source /root/.bash_profile &>/dev/null ;
			sudo /root/bin/utility/gh-ss.sh ;
		   
		   exit 0 ;
		   # killall -s KILL .sleep_kill.sh &>/dev/null & 
		   # tldr screen ; echo ;
		   # echo screen -r ;
		   # echo screen -ls ;
		}
	
	vsync15
	
	#[[ $( cat /tmp/autoupdate_vdsetup.txt ) == "on" ]] && vsync15 || (auto_update_status) ;
	
	exit 0 ;
	
}




function update_cash() {

	ttb=$(echo -e " Эта функция обновляет информацию о версии VDSetup\n и ip адрес текущего Socks5 соединения настроенного на Tor.\n Установить или посмотреть помощь по \"Tor\": # vdsetup tor\n\n Если вы настроили автоматическое обновление версии VDSetup до последней беты,\n то это будет так же добавленно в эту функцию:\n Включить  автоматические обновления: # auto_update_on \n Отключить автоматические обновления: # auto_update_off\n") && bpn_p_lang ; ttb="" ; echo ;
	
	ttb=$(echo -e " Old version : $( cat /root/.ver.txt)") && bpn_p_lang ; ttb="" ;
	cd /tmp/ ; wget -q  -O .ver.txt https://raw.githubusercontent.com/giteed/VDSInstaller/main/.ver.txt 2>/dev/null ;
	ttb=$(echo -e " New version : $(cat /tmp/.ver.txt)") && bpn_p_lang ; ttb="" ;
	
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

#echo -en "${GREEN} " ; ( systemctl status cash_var.service | grep " active " | awk '/active/ { print $2 }' ) ; echo -e "${NC}\n" 


exit 0 ; 

