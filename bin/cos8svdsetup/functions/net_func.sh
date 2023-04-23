#!/bin/bash

# network restart  
function network_restart() { (/etc/init.d/network restart) }


# Функция: Кеширует ip адрес TOR
function reload_cash() {
    /root/vdsetup.2/bin/utility/.cash_var.sh $1
  }


# Функция: cash_var_sh_150_start_and_stop включает и отключает кеширование ip адреса тора и версии vdsetup на 150 секунд.
function cash_var_sh_150_start_and_stop() {
     ( cash_var_sh_150 ) &>/dev/null 
     
     ps ax | awk '/[s]leep_kill/ { print $1 }' | xargs kill &>/dev/null 
     pkill -f "sleep_kill" &>/dev/null
     screen -wipe &>/dev/null 
     # ps ax | awk '/[s]nippet/ { print $1 }' | xargs kill (тоже рабочий вариант вместо snippet имя скрипта или программы)
    ( /usr/bin/screen -dmS sleep_kill /bin/bash /root/vdsetup.2/bin/utility/install/tor/.sleep_kill.sh ) &>/dev/null ; 
    return ; 
  }


# Функция: удаляет юнит кеширования ip адреса Тора и версии vdsetup 
function remove_unit_stop_cashing() {
   ${msg9} ;
   
   systemctl disable cash_var.service &>/dev/null || ttb=$(echo -e "\n Error disable Unit /etc/systemd/system/cash_var.service could not be found. \n") && bpn_p_lang  ;
   systemctl stop cash_var.service &>/dev/null || ttb=$(echo -e "\n Error stop Unit /etc/systemd/system/cash_var.service could not be found. \n") && bpn_p_lang  ;
   rm /etc/systemd/system/cash_var.service &>/dev/null || ttb=$(echo -e "\n Error remove Unit /etc/systemd/system/cash_var.service could not be found. \n") && bpn_p_lang  ;
   systemctl daemon-reload &>/dev/null || ttb=$(echo -e "\n Error daemon-reload \n") && bpn_p_lang  ;
 
   ttb=$(echo -e "\n Unit /etc/systemd/system/cash_var.service removed \n") && bpn_p_lang  ;
   #systemctl status -n0 cash_var.service 2>/dev/null;
   return ;
  }


# Функция: Информация о вебсервере nginx
function http() { ttb=$( echo -e "\n $( cat /tmp/nginx_http_ip 2>/dev/null )") && lang=meminfo && bpn_p_lang ; }


# Функция: Запускает http Node_js сервер
function start_http_server() {
     /root/vdsetup.2/bin/utility/torrent/file_to_http_start_stop.sh start ;
  }

 
# Функция: Останавливает http Node_js сервер
function stop_http_server() {
     /root/vdsetup.2/bin/utility/torrent/file_to_http_start_stop.sh stop ;
  }

 
# Функция: показывает статус http Node_js сервера
function status_http_server() {
     /root/vdsetup.2/bin/utility/torrent/file_to_http_start_stop.sh status ;
  }

 
# Функция: Запускает http light Node_js сервер
  function start_light_server() {
     /root/vdsetup.2/bin/utility/torrent/file_to_light_server_start_stop.sh start ;
  }

 
# Функция: Останавливает http light Node_js сервер
  function stop_light_server() {
     /root/vdsetup.2/bin/utility/torrent/file_to_light_server_start_stop.sh stop ;
  }

 
# Функция: Показывает статус http light Node_js сервера
function status_light_server() {
     /root/vdsetup.2/bin/utility/torrent/file_to_light_server_start_stop.sh status ;
  }


# Функция: 
function lastf() {
     /root/vdsetup.2/bin/utility/lastf.sh $1 ;
  }


# Функция: Показывает открытые порты и сервисы на firewalld (окрашивает текст lang="passwd")
function open_port_and_services_firewall() {
   function services-ports() {
     echo -e "\n  firewalld services, ports: \n" ;
     echo -e "$( sudo firewall-cmd --list-all | grep -E "(services:|ports:)" | grep -v "(forward|source)" ;)"
     echo ;
     echo -e " # sudo firewall-cmd --list-all\n" ;
     
    }
    
    ttb=$(services-ports) && lang="passwd" && bpn_p_lang ;
  }


# Функция: Показывает открытые порты и сервисы на firewalld (окрашивает текст lang="cr")
function fw_i() {
   
   function services-ports() {
      echo -e "\n  firewalld services, ports: \n" ;
      echo -e "$( sudo firewall-cmd --list-all | grep -E "(services:|ports:)" | grep -v "(forward|source)" ;)"
      echo ;
      echo -e " # sudo firewall-cmd --list-all\n" ;
   }
   
    ttb=$(services-ports) && lang="cr" && bpn_p_lang ;
  }


# Функция: Показывает открытые порты и сервисы и правила на firewalld (окрашивает текст lang="cr") 
function fw_i_r() {
   
   function get-all-rules() {
      echo -e "\n  firewalld services, ports, rules: \n" ;
      echo -e "$( sudo firewall-cmd --list-all | grep -E "(services:|ports:)" | grep -v "(forward|source)" ;)"
      echo "\n  rules:\n";
      echo -e "$( sudo firewall-cmd --direct --get-all-rules ;)"
      echo ;
      echo -e " # sudo firewall-cmd --direct --get-all-rules && sudo firewall-cmd --list-all\n" ;
    }
   
   ttb=$(get-all-rules) && lang="cr" && bpn_p_lang ;
  }

