#!/bin/bash

# Source global definitions
# --> Прочитать настройки из /root/.bashrc
. /root/.bashrc

echo ;

# Функция cash_var_sh_150_start_and_stop включает и отключает кеширование ip адреса тора и версии vdsetup на 150 секунд.
cash_var_sh_150_start_and_stop ;

function flush_iptables_rules () {
	iptables -F && iptables -t nat -F ; 
	ttb=$(echo -e "\n ⎧ # iptables -F : OK\n ⎩ # iptables -t nat -F : OK \n") ; 
	bpn_p_lang ;
}

function msg_systemctl_start_tor() {
	systemctl start tor.service ; 
	ttb=$(echo -e "\n ⎧ # systemctl start tor\n ⎩ TOR Socks5 127.0.0.1:9050 Включен!\n") ; 
	bpn_p_lang ;
}

dev=$(ifconfig | grep 4163 | awk '{ print $1}')

function msg_local() {
	
	ttb=$(echo -e "\n ⎧ Но возможно, что \"$dev\" является сетевым\n | интерфейсом в вашей домашней локальной сети $(hostname)\n ⎩ и несоответствие ip адресов происходит из за этого.") && bpn_p_lang
}	


function msg_dev() { 
	echo $dev 
}


function check_self_ifconfig() {
		
	echo -en " $(black_U23A7 )" ; ttb=$(echo -e " Ваш ip полученный от ifconfig \"$(msg_dev)\" ") && bpn_p_lang ;
	echo -en " $(black_U23A9 ) " ; ttb=$(ifconfig_real_ip) && bpn_p_lang ; 
}

function check_tor_connect() {
	
		function msg_start_tor_if_need() {
			ttb=$(echo -e "\n\n ⎧ Похоже, TOR Socks5 не работает.\n ⎩ # systemctl start tor") && bpn_p_lang ;
		}
	 
		URL_TOR_CHECK="https://2ip.ua"
	 
		for i in {0..5}; do
		 
		 if [[ "$r" == "3" ]] ; then msg_start_tor_if_need ; echo ; fi ;
	     
			ip_address=$(curl --insecure -s --socks5 127.0.0.1:9050 "${URL_TOR_CHECK}")
			
			if [[ "$ip_address" != "" ]] ; then
				echo -en " $(black_U23A7 )" ; ttb=$(echo -e " Ваш ip через локальный TOR Socks5\n | проверялся через:") && bpn_p_lang ;
				echo -en " $(black_U23A9 )" ; ttb=$(echo -e " # curl --insecure -s --socks5 127.0.0.1:9050 ${URL_TOR_CHECK} ") && bpn_p_lang ; echo ;
				ttb=$(echo -e "${ip_address}\n") && lang=cr && bpn_p_lang ; echo ;
				return ;
				else echo -en "${red} ." && sleep 1 && r=$(( $r + 1 )) ; continue ;
			fi
			sleep 1
		done
		 echo ;
		ttb=$(echo -e "\n ⎧ Ошибка определения ip адреса через\n ⎩ TOR Socks5 127.0.0.1:9050\n") && bpn_p_lang ;

}


function check_self_connect() {
	
	function msg_no() {
		
		if [[ "$dev" == "enp0s3:" ]] ; then msg_local=msg_local ; fi ;
		
		ttb=$(echo -e " Ваш ip \"Напрямую\": $ip_tmp\n | не соответствует полученному\n | от \"ifconfig\" ip : $(ifconfig_real_ip)\n |\n | Скорее всего, анонимайзер или прокси включены\n ⎩ и роутинг соединений проходит сейчас через них. ") && bpn_p_lang && ${msg_local} ;
		
		ttb=$(echo -e "\n ⎧ Откл/Включить роутинг всех соединений через Tor:\n | # toriptables2.py -h\n ⎩ (кроме Socks5 \"127.0.0.1:${tor_port}\")\n\n ⎧ Ваш ip \"Напрямую\": $ip_tmp\n | проверялся через:") && bpn_p_lang ; 
	}
	
	function msg_yes() {
		ttb=$(echo -e " Ваш ip \"Напрямую\": $ip_tmp\n | соответствует полученному\n | от \"ifconfig\" ip : $(ifconfig_real_ip)\n |\n | Это значит что анонимайзер или прокси для \n | СИСТЕМЫ В ЦЕЛОМ выключены и роутинг соединений идет \n | без изменений через сеть вашего провайдера.\n |\n | Если хотите включить TOR для ВСЕГО ТРАФФИКА \n ⎩ введите: # toriptables2.py -l\n\n ⎧ Ваш ip \"Напрямую\" проверялся через:") && bpn_p_lang 
	}
	
	URL_NO_TOR_CHECK="https://2ip.ua"

	for i in {0..2}; do
		
		curl --insecure -s "${URL_NO_TOR_CHECK}" > /tmp/ip_tmp.txt ;
		
		ip_address=$( cat /tmp/ip_tmp.txt )
		
		if [[ "$ip_address" != "" ]] ; 
			then
			
			ip_tmp=$(cat /tmp/ip_tmp.txt | grep ip | awk ' { print $3 }')
			
			if [[ "$ip_tmp" == "$(ifconfig_real_ip)" ]] ; then msg_ip=msg_yes ; else msg_ip=msg_no ; fi ;
			
			echo -en "\n $(black_U23A7 )" ; ${msg_ip} ;
			echo -en " $(black_U23A9 )" ; ttb=$(echo -e " # curl --insecure -s ${URL_NO_TOR_CHECK} ") && bpn_p_lang ; echo ;
			
			ttb=$(echo -e "${ip_address}\n") && bpn_p_lang ; echo ;
			return ; 
			else echo -en "${red} ." && sleep 1 ; continue ;
		fi
		sleep 1
		
	done
	echo ;


function flush_rules_or_start_tor() {
	 
	 echo -en "";
	ttb=$(echo -en " 
 ⎧ Ошибка определения ip адреса \"напрямую\"
 | роутинг работает не правильно!
 | Выберите что нужно сделать: 
 | 1) Сбросить правила iptables: # iptables -F && iptables -t nat -F
 | 2) Включить TOR Socks5: # systemctl start tor
 | ") && bpn_p_lang ; 
 
 echo -en " ⎩ Введите '1' или '2' : " ; read w ;
 
 if [[ $w == 1 ]] ; then flush_iptables_rules && check_self_connect ; fi ;
 if [[ $w == 2 ]] ; then msg_systemctl_start_tor && check_self_connect ; fi ;
 
 if [[ $w != 1 ]] ; then return ; fi ;
 if [[ $w != 2 ]] ; then return ; fi ;
 
 }

 	flush_rules_or_start_tor

}

	check_self_ifconfig ;
	check_self_connect ;
	check_tor_connect ;
	tor_check_ip_wget ;
	

exit 0 ;

