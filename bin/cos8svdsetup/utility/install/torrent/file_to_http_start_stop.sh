#!/bin/bash

# Source global definitions
# --> Прочитать настройки из /root/.bashrc
source /root/.bashrc
echo ;

function msg_stop_npx_http_server() {
	ttb=$(echo -e "
 ⎧ 
 | npx_http_server остановлен.
 | 
 | Запустить снова npx_http_server для Transmission:
 | # start_http_server 
 |
 | Сможете забирать любым браузером скаченные 
 | файлы, с помощью вашего Transmission из папки:
 | /var/lib/transmission/Downloads
 ⎩
 ") && bpn_p_lang ; exit 0 ;
}

function msg_start_npx_http_server() {
 ttb=$(echo -e "
 ⎧ 
 | Файловый сервер для Transmission
 | запущен и работает в настоящий момент!
 |
 | Войти в screen с запущенным файловым
 | сервером npx_http_server:
 | # screen -r \"npx_http_server\"
 |
 | Выйти из screen с запущенным файловым
 | сервером npx_http_server:
 | Ctrl A+D
 |
 | Посмотреть все запущенные screen:
 | # screen -ls
 ⎩" ) && bpn_p_lang ; 
 
 ttb=$(echo -e " 
 ⎧ 
 | Принудительное убить процессы npx_http_server:
 | # pkill -f "npx_http_server"
 |
 | Помощь по screen:
 | # tldr screen 
 |
 | Остановить файловый сервер npx_http_server: 
 | # stop_http_server
 ⎩" ) && bpn_p_lang ; 
   
 ttb=$(echo -e "
 ⎧ 
 | Адрес вашего файлового сервера npx_http_server:
 | # http://$(ifconfig_real_ip):8080/
 ⎩" ) && bpn_p_lang ; echo ;
}

function msg_stop_or() {
  ttb=$(echo -e " 
 ⎧ Сервер работает в настоящий момент!
 | Хотите остановить файловый сервер npx_http_server?
 ⎩ Нажмите Enter иил 'Ctrl C' для выхода.") && bpn_p_lang ;
  echo -e " " && press_anykey ; kill_wipe_all_npx_http_server_screen ; msg_stop_npx_http_server ; exit 0 ;
}
 
function msg_start_or() {
  ttb=$(echo -e " 
 ⎧ Файловый сервер npx_http_server остановлен!
 | Хотите запустить файловый сервер npx_http_server?
 ⎩ Нажмите Enter иил 'Ctrl C' для выхода.") && bpn_p_lang ;
  echo -e " " && press_anykey ; Node_js_npx_http_server_start ; msg_start_npx_http_server ; exit 0 
}


 
function kill_wipe_all_npx_http_server_screen() {
	sudo ps ax | awk '/[n]px_http/ { print $1 }' | xargs kill &>/dev/null ;
	sudo pkill -f "npx_http" &>/dev/null ;
	sudo screen -wipe &>/dev/null ;
}
	


   # Функция Node_js_npx_http_server_start запускает http сервер в папке /var/lib/transmission/Downloads на 8080 порту
function Node_js_npx_http_server_start() {
   
   kill_wipe_all_npx_http_server_screen ;
   mkdir -p /var/lib/transmission/Downloads ;
   chown -R transmission:transmission /var/lib/transmission/Downloads ;
   sudo cd /var/lib/transmission/Downloads ;
   sudo /usr/bin/screen -dmS npx_http npx http-server /var/lib/transmission/Downloads &>/dev/null ; 
   sudo firewall-cmd --permanent --add-port=8080/tcp &>/dev/null ; 
   sudo firewall-cmd --reload &>/dev/null ; 
   
   return ;	
   # https://github.com/http-party/http-server
}
	
	# Функция Node_js_npx_http_server_start убивает http сервер в папке /var/lib/transmission/Downloads на 8080 порту
function Node_js_npx_http_server_stop() {
	
	kill_wipe_all_npx_http_server_screen ;
	sudo firewall-cmd --permanent --remove-port=808o/tcp &>/dev/null ;
	sudo firewall-cmd --reload &>/dev/null ;
	
	msg_stop_npx_http_server ;
	return ;
}
	
	
function status_http_server() {
	(screen -ls | grep npx_http) &>/dev/null && msg_start_npx_http_server && msg_stop_or || msg_start_or ;
	exit 0 ;
}

	
function Node_js_npx_http_server_help() {
	
	echo Node_js_npx_http_server_help ok ;
	return ;
}

	
	if  [[ "$1" == "start" ]] ; then Node_js_npx_http_server_start && msg_start_npx_http_server ; exit 0 ; fi ;
	if  [[ "$1" == "stop" ]] ; then Node_js_npx_http_server_stop && msg_stop_npx_http_server ; exit 0  ; fi ;
	if  [[ "$1" == "status" ]] ; then status_http_server ; exit 0 ; fi ;
	if  [[ "$1" == "" ]] ; then Node_js_npx_http_server_help ; fi ;
	
	exit  0;

# https://github.com/http-party/http-server

