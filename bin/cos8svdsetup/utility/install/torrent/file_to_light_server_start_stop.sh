#!/bin/bash

# Source global definitions
# --> Прочитать настройки из /root/.bashrc
source /root/.bashrc
echo ;

function msg_stop_npx_light_server() {
	ttb=$(echo -e "
 ⎧ 
 | npx_light_server остановлен.
 | 
 | Запустить снова npx_light_server для Transmission:
 | # start_light_server 
 |
 | Сможете забирать любым браузером скаченные 
 | файлы, с помощью вашего Transmission из папки:
 | /var/lib/transmission/Downloads
 ⎩
 ") && bpn_p_lang ; exit 0 ;
}

function msg_start_npx_light_server() {
 ttb=$(echo -e "
 ⎧ 
 | Файловый сервер для Transmission
 | запущен и работает в настоящий момент!
 |
 | Войти в screen с запущенным файловым
 | сервером npx_light_server:
 | # screen -r \"npx_light_server\"
 |
 | Выйти из screen с запущенным файловым
 | сервером npx_light_server:
 | Ctrl A+D
 |
 | Посмотреть все запущенные screen:
 | # screen -ls
 ⎩" ) && bpn_p_lang ; 
 
 ttb=$(echo -e " 
 ⎧ 
 | Принудительное убить процессы npx_light_server:
 | # pkill -f "npx_light_server"
 |
 | Помощь по screen:
 | # tldr screen 
 |
 | Остановить файловый сервер npx_light_server: 
 | # stop_light_server
 ⎩" ) && bpn_p_lang ; 
   
 ttb=$(echo -e "
 ⎧ 
 | Адрес вашего файлового сервера npx_light_server:
 | # http://$(ifconfig_real_ip):8081/
 ⎩" ) && bpn_p_lang ; echo ;
}

function msg_stop_or() {
  ttb=$(echo -e " 
 ⎧ Сервер работает в настоящий момент!
 | Хотите остановить файловый сервер npx_light_server?
 ⎩ Нажмите Enter иил 'Ctrl C' для выхода.") && bpn_p_lang ;
  echo -e " " && press_anykey ; kill_wipe_all_npx_light_server_screen ; msg_stop_npx_light_server ; exit 0 ;
}
 
function msg_start_or() {
  ttb=$(echo -e " 
 ⎧ Файловый сервер npx_light_server остановлен!
 | Хотите запустить файловый сервер npx_light_server?
 ⎩ Нажмите Enter иил 'Ctrl C' для выхода.") && bpn_p_lang ;
  echo -e " " && press_anykey ; Node_js_npx_light_server_start ; msg_start_npx_light_server ; exit 0 
}


 
function kill_wipe_all_npx_light_server_screen() {
	sudo ps ax | awk '/[n]px_light_server/ { print $1 }' | xargs kill &>/dev/null ;
	sudo pkill -f "npx_light_server" &>/dev/null ;
	sudo screen -wipe &>/dev/null ;
}
	


   # Функция Node_js_npx_light_server_start запускает http сервер в папке /var/lib/transmission/Downloads на 8081 порту
function Node_js_npx_light_server_start() {
   
   kill_wipe_all_npx_light_server_screen ;
   mkdir -p /var/lib/transmission/Downloads ;
   chown -R transmission:transmission /var/lib/transmission/Downloads ;
   sudo cd /var/lib/transmission/Downloads ;
   sudo /usr/bin/screen -dmS npx_light_server /usr/bin/npx light-server -s /var/lib/transmission/Downloads -p 8081 ; 
   sudo firewall-cmd --permanent --add-port=8081/tcp &>/dev/null ; 
   sudo firewall-cmd --reload &>/dev/null ; 
   
   return ;	
   # https://github.com/http-party/http-server
}
	
	# Функция Node_js_npx_light_server_start убивает http сервер в папке /var/lib/transmission/Downloads на 8081 порту
function Node_js_npx_light_server_stop() {
	
	kill_wipe_all_npx_light_server_screen ;
	sudo firewall-cmd --permanent --remove-port=8081/tcp &>/dev/null ;
	sudo firewall-cmd --reload &>/dev/null ;
	
	msg_stop_npx_light_server ;
	return ;
}
	
	
function status_light_server() {
	(screen -ls | grep npx_light_server) &>/dev/null && msg_start_npx_light_server && msg_stop_or || msg_start_or ;
	exit 0 ;
}

	
function Node_js_npx_light_server_help() {
	
	echo Node_js_npx_light_server_help ok ;
	return ;
}

	
	if  [[ "$1" == "start" ]] ; then Node_js_npx_light_server_start && msg_start_npx_light_server ; exit 0 ; fi ;
	if  [[ "$1" == "stop" ]] ; then Node_js_npx_light_server_stop && msg_stop_npx_light_server ; exit 0  ; fi ;
  if  [[ "$1" == "status" ]] ; then status_light_server ; exit 0 ; fi ;
	if  [[ "$1" == "" ]] ; then Node_js_npx_light_server_help ; fi ;
	
	exit  0;



