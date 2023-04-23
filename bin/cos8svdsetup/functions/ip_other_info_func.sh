#!/bin/bash




# Функция: Мой ip
function mi() { wget -qO- icanhazip.com ; } ;
  

# Функция: myip() ссылается на другую функцию mi() и показывает ip в цвете с помощью bat
function myip() { 
  	
  	ttb=$( echo -e "$(echo -e $(mi) 2>/dev/null)") && lang_cr && bpn_p_lang ; 
  }


# Функции для работы с процессами/системой:
function my_ip() {
	   
	  MY_L_IP=$(/sbin/ifconfig enp0s3 | awk '/inet/ { print $2 } ' | sed -e s/addr://)
	  MY_L_VPN_IP=$(/sbin/ifconfig tun0 | awk '/inet/ { print $2 } ' | sed -e s/addr://)
	  MY_I_VPN_IP=$(/sbin/ifconfig tun1 | awk '/inet/ { print $2 } ' | sed -e s/addr://)
	  MY_P_IP=$(/sbin/ifconfig ppp0 | awk '/inet/ { print $2 } ' | sed -e s/addr://)
	  MY_P_ISP=$(/sbin/ifconfig ppp0 | awk '/P-t-P/ { print $3 } ' | sed -e s/P-t-P://)
   }

function allip() { hostname --all-ip-addresses ; }
   #-----------------------------------
   
   # --> Функция ifconfig_real_ip() используется для получения реального IP-адреса сетевого интерфейса на машине. Вот как она работает:
   
   # --> ifconfig выводит список всех сетевых интерфейсов на машине вместе с их конфигурациями и статусом.
   # --> grep -Eo 'inet ([0-9]*\.){3}[0-9]*' ищет в выводе строки, начинающиеся с "inet " и за которыми следует четыре числа, разделенные точками, что соответствует IP-адресу.
   # --> grep -Eo '([0-9]*\.){3}[0-9]*' ищет в найденных строках только IP-адрес, извлекая его из найденного текста.
   # --> head -n 1 берет только первый найденный IP-адрес из списка, чтобы получить IP-адрес первого сетевого интерфейса.
   # --> В итоге функция возвращает реальный IP-адрес первого сетевого интерфейса на машине или ничего не возвращает, если что-то идет не так. Обратите внимание, что 2>/dev/null используется для перенаправления любых ошибок в /dev/null, что позволяет избежать вывода сообщений об ошибках.
   function ifconfig_real_ip() {
	   
	   (ifconfig | grep -Eo 'inet ([0-9]*\.){3}[0-9]*' | grep -Eo '([0-9]*\.){3}[0-9]*' | head -n 1) 2>/dev/null ;
   }
   
# Функция: local address
function lip-f() {
	  
	  echo -e "\n"$green""internal"$NC":" " ;
	  ifconfig | grep -Eo 'inet (addr:)?([0-9]*\.){3}[0-9]*' | grep -Eo '([0-9]*\.){3}[0-9]*' | grep -v '127.0.0.1'
	  echo -e "$cyan""\nexternal"$NC":" ;
	  myip ;
	  
	  echo -e "\n"$green""Privoxy TOR Socks5 127.0.0.1:9050"$NC":" " ;
	  curl --socks5 127.0.0.1:9050 http://2ip.ua
	  
   }
   
# Функция: Вывод от команды netstat -tupln | grep ssh
function netstat_i () {
	   
	  function netstat-tupln() {
		  echo ;
		  ( netstat -tupln | grep ssh ) | bat -l nix -p 2>/dev/null || ( netstat -tupln | grep ssh ) ;
		  echo -e "\n # netstat -tupln | grep ssh" ;
	   }
	  ttb=$(netstat-tupln) && lang="cr" && bpn_p_lang ;
   }
   
   
# Функция: ifconfig
function ifc() { ( echo -e "" && ifconfig | bat -p --paging=never -l conf ) || ( echo -e "" && ifconfig ) }