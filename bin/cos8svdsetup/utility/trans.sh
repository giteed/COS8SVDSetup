#!/bin/bash

# Source global definitions
# --> Прочитать настройки из /etc/bashrc
. /root/.bashrc

# --> Прочитать настройки:
. /root/bin/utility/.varfunc.sh &>/dev/null ;
. /root/bin/utility/.css.sh &>/dev/null 

debug_message ;

 function check_old_if_0() {
	 # Если значения пустые назначить из файла если он есть предыдущие логин и пароль.
		 
	 function cat_login_password() {
		 login=$(cat /root/.login_password_Transmission.txt | grep login | awk ' /login/ { print $2 }') 2>/dev/null
		 password=$(cat /root/.login_password_Transmission.txt | grep password | awk ' /password/ { print $2 }') 2>/dev/null
	 }
	 
	 if_0(){
		 
		 if [[ "$login" == "" ]] ; then cat_login_password 2>/dev/null ; fi ; 
		 if [[ "$password" == "" ]] ; then cat_login_password 2>/dev/null ; fi ;
	 }
	 
	 [[ -n /root/.login_password_Transmission.txt ]] 2>/dev/null && if_0 || return ;
	 
	 echo -e " login: $login\n password: $password\n URL: http://$(ifconfig_real_ip):9091/ " > /root/.login_password_Transmission.txt
	 
	 
 }

# Если файл с логином и паролем есть то устанавливать не нужно....
 function check_Transmission_already_installed() {
	 
	 function msg_check_Transmission_already_installed() {
		 
		[[ -n /root/.login_password_Transmission.txt ]] 2>/dev/null && check_old_if_0 ;
		
		# https://russianblogs.com/article/52711929200/
		# https://github.com/http-party/http-server
		
ttb=$(echo -e " ⎧ Похоже, Transmission уже был
 ⎩ установлен и доступен сейчас!") && lang="nix" && bpn_p_lang ;

 echo -e "\n $(black_U23A7 ) " ;
 echo -en " $(green_U23A6) " ; echo -en " Transm. IP : " ; ttb="$( echo -e "http://$( ifconfig_real_ip ):9091/" )" && lang="passwd" && bpn_p_lang ;
 echo -en " $(green_U23A6) " ; echo -en " Transm. URL: " ; ttb="$( echo -e "http://$( hostname ):9091/" )" && lang="passwd" && bpn_p_lang ;
  
 echo -en " $(purple_U23A6) " ; echo -e " Login      : ${CYAN}$login ${NC}" ;
 echo -en " $(purple_U23A6) " ; echo -e " Password   : ${RED}$password${NC} " ;
 echo -e " $(black_U23A9 )  " ;
 open_port_and_services_firewall ;

 ttb=$(echo -e "
 ⎧ Забрать загруженные файлы 
 | торрентов через HTTP, 
 | с помощью \"light_server\" введите:
 | # start_light_server  
 |
 | - Затем забирайте по адресу:
 ⎩ http://$(ifconfig_real_ip):8081/ 
 
 ⎧ Остановить HTTP доступ к папке 
 | Downloads с файлами Transmission:
 ⎩ # stop_light_server
 
 ⎧ Удалить Transmission:
 ⎩ # vdsetup -tr_rm") && lang="nix" && bpn_p_lang ;

	 
ttb=$(echo -e "
 ⎧ Хотите сменить пароль, проверить
 | и обновить компоненты программы?
 ⎩ Нажмите Enter иил 'Ctrl C' для выхода. ") && lang="nix" && bpn_p_lang ;
		   sleep 1 ; echo ;
		   
		press_anykey ;
			   
			   return ;
	 }
	 
	 (type -a transmission-cli) &>/dev/null && msg_check_Transmission_already_installed || return ;
	 
	}



function msg_wait() {
	ttb=$(echo -e " | \n ⎩ Пожалуйста подождите...") && lang_nix && bpn_p_lang ; echo ; sleep 1 ;
}

function echo_e_json() {
echo -e "{
\"alt-speed-down\": 50,
\"alt-speed-enabled\": false,
\"alt-speed-time-begin\": 540,
\"alt-speed-time-day\": 127,
\"alt-speed-time-enabled\": false,
\"alt-speed-time-end\": 1020,
\"alt-speed-up\": 50,
\"bind-address-ipv4\": \"0.0.0.0\",
\"bind-address-ipv6\": \"::\",
\"blocklist-enabled\": false,
\"blocklist-url\": \"http://www.example.com/blocklist\",
\"cache-size-mb\": 4,
\"dht-enabled\": true,
\"download-dir\": \"/var/lib/transmission/Downloads\",
\"download-queue-enabled\": true,
\"download-queue-size\": 5,
\"encryption\": 1,
\"idle-seeding-limit\": 30,
\"idle-seeding-limit-enabled\": false,
\"incomplete-dir\": \"/var/lib/transmission/Downloads\",
\"incomplete-dir-enabled\": false,
\"lpd-enabled\": false,
\"message-level\": 1,
\"peer-congestion-algorithm\": \"\",
\"peer-id-ttl-hours\": 6,
\"peer-limit-global\": 200,
\"peer-limit-per-torrent\": 50,
\"peer-port\": 51413,
\"peer-port-random-high\": 65535,
\"peer-port-random-low\": 49152,
\"peer-port-random-on-start\": false,
\"peer-socket-tos\": \"default\",
\"pex-enabled\": true,
\"port-forwarding-enabled\": true,
\"preallocation\": 1,
\"prefetch-enabled\": true,
\"queue-stalled-enabled\": true,
\"queue-stalled-minutes\": 30,
\"ratio-limit\": 2,
\"ratio-limit-enabled\": false,
\"rename-partial-files\": true,
\"rpc-authentication-required\": true,
\"rpc-bind-address\": \"0.0.0.0\",
\"rpc-enabled\": true,
\"rpc-host-whitelist\": \"\",
\"rpc-host-whitelist-enabled\": true,
\"rpc-username\": \"$login\",
\"rpc-password\": \"$password\",
\"rpc-port\": 9091,
\"rpc-url\": \"/transmission/\",
\"rpc-whitelist\": \"0.0.0.0\",
\"rpc-whitelist-enabled\": false,
\"scrape-paused-torrents-enabled\": true,
\"script-torrent-done-enabled\": false,
\"script-torrent-done-filename\": \"\",
\"seed-queue-enabled\": false,
\"seed-queue-size\": 10,
\"speed-limit-down\": 100,
\"speed-limit-down-enabled\": false,
\"speed-limit-up\": 100,
\"speed-limit-up-enabled\": false,
\"start-added-torrents\": true,
\"trash-original-torrent-files\": false,
\"umask\": 18,
\"upload-slots-per-torrent\": 14,
\"utp-enabled\": true
}" > /var/lib/transmission/.config/transmission-daemon/settings.json
return ;
}



	 
	 
	 function transmission_Check_or_install() {
	 
	   function msg_in1() {
		ttb=$(echo -e " | $dnf_trans успешно установлен!") && lang="nix" && bpn_p_lang ;
	   }
	   
	   function msg_in2() {
		ttb=$(echo -e " | Ошибка установки $dnf_trans!") && lang="nix" && bpn_p_lang ;
	   }
	   
	   function msg_in3() {
		ttb=$(echo -e " | $dnf_trans уже был установлен.") && lang="nix" && bpn_p_lang ;
	   }
	   
	   function msg_inUP() {
		   ttb=$(echo -e " | $dnf_trans успешно обновлен!") && lang="nix" && bpn_p_lang ;
		  }
	   
	   dnf_trans=transmission
	   
	   (type -a transmission-cli) &>/dev/null && msg_in3 || ( dnf install transmission-cli -y &>/dev/null && msg_in1 || msg_in2 ) ;
	   
	   dnf_trans=transmission-daemon
	   
	   (type -a transmission-daemon) &>/dev/null && msg_in3 || ( dnf install transmission-daemon -y &>/dev/null && msg_in1 || msg_in2 ) ;
	   
	   dnf_trans=transmission-common
		
		(( dnf install -y transmission-common | grep "already installed" ) &>/dev/null && msg_in3 || msg_in1 ) || msg_in2 ;
		
	   
	   
	   function dnf_install_npm_http_server() {
	    	dnf_trans=npm_http_server
			(( dnf install -y npm | grep "already installed" ) &>/dev/null && msg_in3 || msg_in1 ) || msg_in2 ;
			echo ;
			ttb=$(npm install --global http-server 2>/dev/null) && lang="nix" && bpn_p_lang && echo && msg_inUP ;
		}
		
		dnf_install_npm_http_server ;
		
		function npm_install_light-server() {
			dnf_trans=npm_install_light-server
			(( dnf install -y npm | grep "already installed" ) &>/dev/null && msg_in3 || msg_in1 ) || msg_in2 ;
			echo ;
			npm install -g light-server && echo && msg_inUP
		}
		
		npm_install_light-server ;
	}
	
	
	
	function systemctl_start_enable_stop_transmission_daemon() {
		
		 systemctl start transmission-daemon
		 systemctl enable transmission-daemon &>/dev/null
		 msg_wait && systemctl stop transmission-daemon
	}
	
	function systemctl_restart_transmission_daemon() {
		systemctl restart transmission-daemon || systemctl start transmission-daemon  ;
		systemctl status transmission-daemon ;
	}
	
	function systemctl_restart_transmission_daemon_msg() {
		css ;
ttb=$(echo -e "\n ⎧ 
 | Перезагружаем Transmission:
 |
 | # systemctl restart transmission-daemon") && lang="nix" && bpn_p_lang ; echo ;

   systemctl_restart_transmission_daemon ;
echo -e "\n ⎩" ; sleep 1 ; css ;
	}
 
	
	function json_hand_edit() {
		ttb=$(echo -e "\n ⎧ 
 | Отредактируйте конфигурационный файл
 | settings.json вручную:
 | # nano /var/lib/transmission/.config/transmission-daemon/settings.json ;
 |
 | Теперь настройте settings.json как вам 
 | понравится, и не забываете сохраняться.
 | Строки для settings.json указанные ниже, 
 | обеспечат доступ к вашему VDS и 
 | transmission для любых ip адресов с 
 | указанными в settings.json login/password :
		 
	\"rpc-authentication-required\": true,
	\"rpc-enabled\": true,
	\"rpc-password\": \"mypassword\", // ваш пароль
	\"rpc-username\": \"mysuperlogin\", //ваш логин
	\"rpc-whitelist-enabled\": false,
	\"rpc-whitelist\": \"0.0.0.0\",
		 
 | Запишите свой пароль после редактирования  
 | settings.json, Перезагрузка transmission  
 | захеширует пароль и он станет нечитабельным!
 ⎩
 
 ⎧
 | Перезагрузить вручную Transmission:
 |
 | # systemctl restart transmission-daemon") && lang="nix" && bpn_p_lang ;
		  echo -e " ⎩"
		  
		  
		
	 }


 function add_port_9091_and_reload_firewalld() {
		  echo -e "\n ⎧ \n"
		  ttb=$(firewall-cmd --permanent --zone=public --add-port=9091/tcp) && lang="nix" && bpn_p_lang
		  ttb=$(firewall-cmd --complete-reload) && lang="nix" && bpn_p_lang
		  ttb=$(firewall-cmd --list-all) && lang="nix" && bpn_p_lang
		  echo -e "\n ⎩ \n"
	  }
	 

function remove_port_9091_and_reload_firewalld() {
		  echo -e "\n ⎧ \n"
		  ttb=$(firewall-cmd --permanent --zone=public --remove-port=9091/tcp) && lang="nix" && bpn_p_lang
		  ttb=$(firewall-cmd --complete-reload) && lang="nix" && bpn_p_lang
		  ttb=$(firewall-cmd --list-all) && lang="nix" && bpn_p_lang
		  echo -e "\n ⎩ \n"
		  return ;
	  }
	

function dnf_remove_transmission() {
		  dnf remove -y transmission-cli transmission-daemon transmission-common &>/dev/null ;
		  remove_port_9091_and_reload_firewalld 2>/dev/null ;
		  return ;
	  }


function remove_tr() {
		  dnf_remove_transmission && echo -e "
⎧ Transmission ${red}
⎩ Успешно удален!${nc}\n" ; exit 0 ;
		  # || echo -e "${red}\n  error remove transmission\n${nc}"
		  exit 0 ;
	  } 



   if [[ "$1" == "--transmission-remove" ]] ; then remove_tr ; exit 0 ; fi ;
   
   check_Transmission_already_installed ; css ;


ttb=$(echo -en "
 ⎧ Установка/обновление Transmission 
 | в CentOS 8 Stream
 | 
 | Transmission — простой BitTorrent-клиент
 | c открытым кодом. Позволяет скачивать
 | файлы из Интернета и предоставлять доступ
 | к своим собственным файлам или торрентам
 ⎩ другим пользователям в сети.
 
 ⎧ Включаем 'EPEL' репозиторий в системе: 
 | 
 | # dnf install epel-release ;
 | # dnf -y update (самостоятельно)
 ⎩$(epel_repo_Check_or_install)") && lang_nix && bpn_p_lang ;
 

ttb=$(echo -e " 
 ⎧  Устанавливаем или обновляем Transmission:
 |
 | # dnf install npm light-server http-server
 | # dnf install transmission-daemon transmission-cli
 | # dnf install transmission-common
 | Пожалуйста подождите ...
 | ") && lang="nix" && bpn_p_lang ;
 #echo -e " | ";
 transmission_Check_or_install ;
 echo -e " ⎩"

ttb=$(echo -e "  
 ⎧ Запускаем и добавляем transmission в автозагрузку:
 |
 | # systemctl start  transmission-daemon ;
 | # systemctl enable transmission-daemon ;
 | # systemctl stop   transmission-daemon ;") && lang="nix" && bpn_p_lang ;

 systemctl_start_enable_stop_transmission_daemon ;
 echo -e "" ; css ;
 


function press_enter_to_change_login_password() {
	
		function change_login_password() {	
			echo -en "\n	Web GUI    login: "
			read login ;
			echo -en "	Web GUI password: "
			read password ;
			
			ttb=$(echo -e "
 ⎧ Логин и пароль записаны дополнительно в файл:
 ⎩  # cat /root/.login_password_Transmission.txt" ) && lang="nix" && bpn_p_lang ;
			
			check_old_if_0 ;
			echo_e_json ;
			return ;
		}
		
		function change_or_no() {
			ttb=$(echo -en "\n	Хотите автоматически сконфигурировать settings.json\n	и назначить новые Login и Password для Web интерфейса?") && lang="nix" && echo -en "" ; bpn_p_lang ;
			read -rp "	[y/n]: " -e -i y change 
			if [[ "$change" == "y" ]] ; then css ; change_login_password ; else css ; json_hand_edit ; fi ;
			}
			
			change_or_no ;
			
			
			return ;
			
	}

function end_install_transmission() {
	

	check_old_if_0 ;
	sleep 1 ; css ;
	
 
 ttb=$(echo -e "
 ⎧ Папка со скаченными файлами (по умолчанию): 
 | /var/lib/transmission/Downloads
 |
 | Папка с файлами торрентов:
 | /var/lib/transmission/.config/transmission-daemon/torrents
 |
 | Конфигурация Transmission:
 ⎩ /var/lib/transmission/.config/transmission-daemon/settings.json 
 
 ⎧ Если сайт c вашим Transmission будет 
 | недоступен, проверьте настройки firewall.
 ⎩ # firewall-cmd --list-all") && lang="nix" && bpn_p_lang ;
 
 open_port_and_services_firewall ;
 
 echo ; press_anykey ; css ;
 ttb=$(echo -e "
    	Клиент Transmission доступен по HTTP. ") && lang="nix" && bpn_p_lang ;
   
	echo -e " $(black_U23A7 ) " ;
	echo -en " $(green_U23A6) " ; echo -en " Transm. IP : " ; ttb="$( echo -e "http://$( ifconfig_real_ip ):9091/" )" && lang="passwd" && bpn_p_lang ;
	echo -en " $(green_U23A6) " ; echo -en " Transm. URL: " ; ttb="$( echo -e "http://$( hostname ):9091/" )" && lang="passwd" && bpn_p_lang ;
	 
	echo -en " $(purple_U23A6) " ; echo -e " Login      : ${CYAN}$login ${NC}" ;
	echo -en " $(purple_U23A6) " ; echo -e " Password   : ${RED}$password${NC} " ;
	echo -e " $(black_U23A9 )  " ;
   

ttb=$(echo -e " 
 ⎧ Логин и пароль вы можете в любой момент
 | назначить новые, снова запустив:
 ⎩ # vdsetup [-tr] или [--transmission]") && lang="nix" && bpn_p_lang ;  
 
ttb=$(echo -e "
 ⎧ Поздравляем, вы только что успешно установили
 | /обновили Transmission. Есть два доступных
 ⎩ варианта забрать по HTTP то, что скачалось:") && lang="nix" && bpn_p_lang ;
 
 ttb=$(echo -e "
 ⎧ 1) Забрать загруженные файлы с торрентов
 | через HTTP с помощью \"light_server\" введите:
 | # start_light_server  
 |
 | - Затем забирайте по адресу http://$(ifconfig_real_ip):8081/ 
 |
 | Остановить HTTP доступ к папке Downloads
 | с файлами Transmission:
 ⎩ # stop_light_server\n") && lang="nix" && bpn_p_lang ;
 
 sleep 2 ;
 
 ttb=$(echo -e "  
 ⎧ 2) И (или) забрать загруженные файлы с торрентов 
 | через http_server (Node.js) введите:
 | # start_http_server  
 |
 | - Затем забирайте по адресу:
 | http://$(ifconfig_real_ip):8080/
 |
 | Остановить (Node.js) доступ к папке Downloads
 | с файлами Transmission:
 ⎩ # stop_http_server
 
 ⎧ Удалить Transmission:
 ⎩ # vdsetup -tr_rm") && lang="nix" && bpn_p_lang ;
 }
 


	press_enter_to_change_login_password ;
	
	echo ;
	
	press_anykey ;
	
	systemctl_restart_transmission_daemon_msg ;

	add_port_9091_and_reload_firewalld ;
    
	end_install_transmission ;


exit 0 ; 



























&& green_tick_en && ttb=$

&& lang="nix" && bpn_p_lang


echo -e "${TOR_or_REAL_IP_MSG}" ;

echo -e "\n $(black_U23A7 ) " ;
echo -e " $(white_1     ) "
echo -e " $(red_1       ) "
echo -e " $(blue_1      ) "
echo -e " $(cyan_1      ) "
echo -e " $(purple_1    ) "
echo -e " $(purple_U23A6) "
echo -e " $(black_1     ) "
echo -e " $(white_1     ) "
echo -e " $(ellow_1     ) " ;
echo -e " $(green_1     ) "
echo -e " $(green_U23A6 ) "
echo -e " $(white_1     ) $(red_U0023) " ;
echo -e " $(white_1     )  " ;
echo -e " $(black_U23A9 ) \n" ;
echo ;








echo -e " ⎧"
echo -e " ⎩"
