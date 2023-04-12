#!/bin/bash

# Source global definitions
# --> Прочитать настройки из /root/.bashrc
. /root/.bashrc


			
	function wget_ch_OK_MSG() {
		echo -e " $(green_1     ) ${GREEN}WGET${green} уже ${NC}настроен по умолчанию для работы через socks5."
		echo -e " $(green_1     ) ${GREEN}WGET${green} теперь может ${NC}скачивать файлы с ${green}.onion${NC} доменов."
		echo -e " $(ellow_1     ) ${red}Выключить${NC} для wget эти настройки: "
		echo -e " $(white_1     ) $(red_U0023) vdsetup ${red}wget-proxy-off${NC}"
		#echo -e " $(white_1     )  "
		TOR_or_REAL_IP="${GREEN}TOR${NC}"
		TOR_or_REAL_IP_MSG="$( echo -e " $(white_1     ) "  )"
	}
	
	function wget_ch_NO_MSG() {
		echo -e " $(red_1     ) ${GREEN}WGET${red} НЕ ${NC}настроен для работы через socks5."
		echo -e " $(white_1     ) "
		echo -e " $(ellow_1     ) ${green}Включить${NC} для wget эти настройки: "
		echo -e " $(white_1     ) $(red_U0023) vdsetup ${green}wget-proxy-on${NC}"
		echo -e " $(white_1     ) "
		TOR_or_REAL_IP="${red}Вашего провайдера${NC}"
		TOR_or_REAL_IP_MSG="$( echo -e " $(red_1     ) ${red}Сейчас вы ${RED}НЕ можете скачивать " ; echo -e " $(red_1     ) ${green}.onion${NC} ссылки wget-ом" ;   )"
		
	}
	
	function wget_CH_OK_NO_MSG() {
		if [[ -n $( cat /etc/wgetrc | grep "http_proxy = http://localhost:8118" ) ]] ; then wget_ch_OK_MSG 2>/dev/null ; else wget_ch_NO_MSG ; fi ;
	}
	
	# Функция создает бекап файла /etc/wgetrc_old и добавляет в конец файла "http_proxy = http://localhost:8118"
	function wgetrc_config_edit_now() {
		
		echo -e "\n $(black_U23A7 ) " ;
		echo -e " $(green_1     ) Внести изменения в /etc/wgetrc ? " ;
		echo -e " $(white_1     ) wget будет настроен на использование локального proxy" ;
		echo -e " $(white_1     ) http_proxy = http://localhost:8118" ;
		echo -e " $(white_1     ) который в свою очеедь будет работать через: " ;
		echo -e " $(white_1     ) TOR Socks5 127.0.0.1:9050 " ;
		echo -e " $(white_1     ) Оригинал /etc/wgetrc будет сохранен в /etc/wgetrc_old" ;
		echo -e " $(ellow_1     ) wget будет настроен по умолчанию для работы через Socks5."
		echo -e " $(white_1     )  " ;
	    echo -e " $(ellow_1     ) Вы можете в любой момент вернуть это обратно." ;
		echo -e " $(white_1     )  "
		echo -e " $(ellow_1     ) Включить или выключить для wget эти настройки: "
		echo -e " $(white_1     ) ${green}Включить${NC} : $(red_U0023) vdsetup ${green}wget-proxy-on${NC}"
		echo -e " $(white_1     ) ${red}Выключить${NC}: $(red_U0023) vdsetup ${red}wget-proxy-off${NC}"
		
		echo -e " $(black_U23A9 ) \n" ;
		
		press_enter_to_continue_or_ESC_or_any_key_to_cancel ;
		
		cp /etc/wgetrc /etc/wgetrc_old ;
		echo "http_proxy = http://localhost:8118" >> /etc/wgetrc ;
		
		
		
		wgetrc_CH ;
		
	}
	
	
	
	# Функция создает бекап файла /etc/privoxy/config.OLD и снимает коммент "#" со строки с паттерном "127.0.0.1:9050 ."
	function privoxy_config_edit_now() {
		
		
		
		
		
		function OK_privoxy_config_edit_now_MSG() {
		 echo -e " $(black_U23A7 ) " ;
		 echo -e " $(ellow_1     ) $(green_tick) privoxy будет настроен на Socks5 127.0.0.1:9050  " ;
		 echo -e " $(ellow_1     ) Сохранен бекап: /etc/privoxy/config.OLD" ;
		 echo -e " $(white_1     ) " ;
		 echo -e " $(ellow_1     ) теперь все обращения на http_proxy = http://localhost:8118 :"
		 echo -e " $(ellow_1     ) будут перенаправлены на Socks5 127.0.0.1:9050 " ;
		 echo -e " $(ellow_1     ) то есть любое приложение использующее http_proxy на этом VDS ${hostname} " ;
		 echo -e " $(ellow_1     ) http://localhost:8118 будет пропускать трафик через TOR Socks5 127.0.0.1:9050 " ;
		 echo -e " $(black_U23A9 ) \n" ;
		}
		
		#echo -e "\n $(black_U23A7 ) " ;
		#echo -e " $(green_1     ) Внести изменения в /etc/privoxy/config ${red}?${NC} " ;
		#echo -e " $(white_1     ) privoxy будет настроен на Socks5 127.0.0.1:9050" ;
		#echo -e " $(black_U23A9 ) \n" ;
		
		
		
		#press_enter_to_continue_or_ESC_or_any_key_to_cancel ;
		
		
		OK_privoxy_config_edit_now_MSG ;
		
		
		sed '/127.0.0.1:9050 ./s/^#//' -i.OLD /etc/privoxy/config ; 
		# sed https://itisgood.ru/2021/05/18/kak-raskommentirovat-stroki-v-fajle-s-pomoshhju-sed-na-linux/?ysclid=lahyuqle4d691153980
		
		
	}
	
	
	function wgetrc_already_edited_MSG() {
		echo -e "\n $(black_U23A7 ) " ;
		echo -e " $(green_1     ) Необходимые изменения в файл /etc/wgetrc внесены. " ;
		echo -e " $(green_1     ) Теперь wget по умолчанию работает через http_proxy " ;
		echo -e " $(green_1     ) http://localhost:8118 " ;
		echo -e " $(green_1     ) который подключен к TOR Socks5 127.0.0.1:9050 " ;
		echo -e " $(black_U23A9 ) \n" ;
	}
	
	function wgetrc_CH() {
		if [[ -n $( cat /etc/wgetrc | grep "http_proxy = http://localhost:8118" ) ]] ; then wgetrc_already_edited_MSG 2>/dev/null ; sleep 2 ; else wgetrc_config_edit_now ; fi ;
	}
	
	function privoxy_config_CH() {
		if [[ -n $( cat /etc/privoxy/config | grep " 127.0.0.1:9050 ." ) ]] ; then echo "строка найдена" &>/dev/null &&  privoxy_config_edit_now ; else echo -e " Ошибка редактирования" ; fi ;
	}
	
	
	
	function tor_install_now() {
		
		echo -e "\n $(black_U23A7 ) " ;
		echo -e " $(green_1     )${GREEN} TOR Socks5 ${NC}и${GREEN} Privoxy ${NC}INSTALLER " ;
		echo -e " $(white_1     )  https://wiki.parabola.nu/Tor_(Русский)" ;
		echo -e " $(white_1     )  " ;
		echo -e " $(green_1     )  1. установка РЕПО: ${GREEN}epel-release${NC}" ;
		
		yum install -y epel-release &>/dev/null ;
		echo -e " $(green_1     )  2. Установка: ${GREEN}TOR${NC}, privoxy, proxychains-ng" ;
		
		press_enter_to_continue_or_ESC_or_any_key_to_cancel ; 
		
		yum install -y tor privoxy proxychains-ng ;#&>/dev/null ;
		
		wgetrc_CH ;
		privoxy_config_CH ;
		
		tor_add_to_auto_load_and_firewall_MSG ;
		tor_add_to_auto_load_and_firewall ;
		
		# проверить TOR соединение и ip  
		# curl --socks5 127.0.0.1:9050 https://check.torproject.org/ | grep -i 'congratulations\|sorry'
		# wget -qO- --proxy=on http://ipinfo.io/ip
		# wget -qO- --proxy=off http://ipinfo.io/ip
		
		echo -e "\n $(black_U23A9 ) \n" ;
		
		press_enter_to_continue_or_ESC_or_any_key_to_cancel ; 
		
		sleep 1 ; 
		$0 $1 ;
	}
	
	
	function tor_add_to_auto_load_and_firewall_MSG() {
		echo -e " $(green_1    )  3. Добавляю TOR и Privoxy в автозагрузку открываю порт 9050/tcp для "${GREEN}"TOR" ;
		echo -e " $(green_1    )  4. ${red_U0023}chkconfig tor on" ;
		echo -e " $(green_1    )  5. Обновляю настройки и делаю рестарт firewall и network.service " ;
		echo -e " $(green_1    )  6. ${red_U0023}firewall-cmd --permanent --zone=public --add-port=9050/tcp " ;
		echo -e " $(green_1    )  7. ${red_U0023}firewall-cmd --complete-reload " ;
		echo -e " $(green_1    )  8. Отображаю настройки firewall, стартую tor.service " ;
		echo -e " $(green_1    )  9. ${red_U0023}firewall-cmd --permanent --list-all " ;
		echo -e " $(green_1    ) 10. Запускаю и проверяю статус TOR\n"  ;
		
	}
	
	
	function restart_tor_privoxy_firewall_network() {
		
		echo ;
		echo -e ${RED}systemctl enable tor.service${NC};
		systemctl enable tor.service ;
		echo -e ${RED}systemctl enable privoxy${NC};
		systemctl enable privoxy ;
		echo -e ${RED}firewall-cmd --complete-reload${NC};
		firewall-cmd --complete-reload ; echo ;
		echo -e ${RED}systemctl restart firewalld.service${NC};
		systemctl restart firewalld.service ; 
		#echo -e ${RED}systemctl restart network.service${NC};
		#systemctl restart network.service ;
		echo -e ${RED}systemctl restart wg-quick@wg0*${NC};
		systemctl restart wg-quick@wg0*
		echo -e ${RED}systemctl status --no-pager wg-quick@wg0*${NC};
		systemctl status --no-pager wg-quick@wg0*
		echo -e ${RED}firewall-cmd --permanent --list-all${NC};
		ttb=$(firewall-cmd --permanent --list-all ) && lang=nix && bpn_p_lang  ; echo ;
		echo -e ${RED}systemctl stop tor.service${NC};
		systemctl stop tor.service ; 
		echo -e ${RED}systemctl start tor.service${NC};
		systemctl start tor.service ; 
		#systemctl restart tor.service ;
		#systemctl enable tor.service ;
		#systemctl enable privoxy ;
		echo -e ${RED}systemctl stop privoxy${NC};
		systemctl stop privoxy ; 
		echo -e ${RED}systemctl start privoxy ${NC};
		systemctl start privoxy ;
		#systemctl restart privoxy ;
		echo -e ${RED}systemctl status --no-pager privoxy${NC}; echo ;
		systemctl status --no-pager privoxy ; 
		echo -e ${RED}systemctl status --no-pager tor.service${NC};
		systemctl status --no-pager tor.service ; echo ;
		#tor -f /etc/tor/torrc ; 
		echo -e ${RED}privoxy${NC};
		ttb=$(journalctl -u privoxy | tail -n 50) && lang=log && bpn_p_lang  ; echo ; 
		echo -e ${RED}network${NC}
		ttb=$(journalctl -u network | tail -n 50) && lang=log && bpn_p_lang  ; echo ; 
		echo -e ${RED}tor.service${NC}
		ttb=$(journalctl -u tor.service | tail -n 50) && lang=log && bpn_p_lang  ;
		echo ; 
		exit 1 ;
	}
	
	
	function tor_add_to_auto_load_and_firewall() {
		
		#journalctl -u tor
		firewall-cmd --permanent --zone=public --add-port=9050/tcp ;
		firewall-cmd --complete-reload ;
		systemctl restart firewalld.service ;
		systemctl restart network.service ; echo ;
		systemctl restart NetworkManager.service ; echo ;
		ttb=$(firewall-cmd --permanent --list-all) && bpn_p_lang  ; echo ;
		(systemctl enable tor.service) ;
		(systemctl enable privoxy);
		systemctl start tor.service ;
		systemctl start privoxy ;
		#systemctl restart tor.service ;
		#systemctl restart privoxy ;
		#systemctl status -n0 privoxy ;
		#return | systemctl status -n0 tor.service ;
		#(tor -f /etc/tor/torrc | grep 127.0.0.1 ); 
		
		
	}
	
	
	function tor_already_installed_MSG() {
		
		# Функция cash_var_sh_150_start_and_stop включает и отключает кеширование ip адреса тора и версии vdsetup на 150 секунд.
		cash_var_sh_150_start_and_stop ;
		
		echo -e "\n $(black_U23A7 ) " ;
		echo -e " $(green_1     )${GREEN} TOR Socks5 ${NC}и${GREEN} Privoxy ${NC}INSTALLER "
		echo -e " $(white_1     ) "
		echo -e " $(ellow_1     ) ${GREEN}TOR${NC} Socks5 уже установлен и работает! По умолчанию порт: ${tor_port} "
		echo -e " $(ellow_1     ) для localhost:${tor_port} или 127.0.0.1:${tor_port}"
		echo -e " $(white_1     ) "
		echo -e " $(ellow_1     ) Теперь, вы можете более гибко настроить ${GREEN}TOR${NC}."
		echo -e " $(white_1     ) $(red_U0023) nano /etc/tor/torrc"
		echo -e " $(white_1     ) $(red_U0023) nano /etc/privoxy/config"
		echo -e " $(white_1     ) "
		
		wget_CH_OK_NO_MSG ;
		
		echo -e " $(white_1     ) "
		echo -e " $(ellow_1     ) Проверить работу ${GREEN}TOR${NC} и присвоенный адрес можно командой:"
		echo -e " $(white_1     ) $(red_U0023) curl ${green}--socks5 127.0.0.1:9050${NC} http://2ip.ru\n " ;
		echo -en " Теперь ваш ip определяется как: ${green}" ; ( curl --socks5 127.0.0.1:${tor_port} http://2ip.ru; )
		
		echo -e "\n $(white_1       ) $(red_U0023) curl ${green}--socks5 127.0.0.1:9050${NC} http://2ip.ua \n${green}" ;
		curl --socks5 127.0.0.1:${tor_port} 2ip.ua ;
		
		echo -e "\n $(ellow_1     ) Ваш реальный ip адрес провайдера: "
		echo -e " $(white_1     ) $(red_U0023) curl ${red}2ip.ua\n ${red}" ;
		curl 2ip.ua ;
		echo -e " $(black_U23A9 ) \n" ;
		press_enter_to_continue_or_ESC_or_any_key_to_cancel ; 
		echo -e " $(black_U23A7 ) " ;
		echo -e " $(ellow_1     ) Несколько примеров использования " ;
		echo -e " $(ellow_1     ) wget, cyrl, через TOR Socks5: " ;
		echo -e " $(white_1     ) "
		wget_CH_OK_NO_MSG ;
		
		echo -e "${TOR_or_REAL_IP_MSG}" ;
		echo -e " $(black_U23A9 )" ;
		echo -e "\n $(black_U23A7 ) " ;
		echo -e " $(ellow_1     ) Скачиваем ${green}.onion${NC} ссылки wget'ом " ;
		echo -e " $(white_1     ) $(red_U0023) wget ${green}--proxy=on${NC} http://site${green}.onion${NC}/file.zip" ;
		echo -en " $(ellow_1     ) (будет виден ip ${TOR_or_REAL_IP}): ${green}" ;
		wget --proxy=on -qO- ipecho.net/plain ; echo ;
		
		echo -e " $(white_1     ) "
		echo -e " $(ellow_1     ) Скачиваем wget'ом с выключенным TOR " ;
		echo -e " $(white_1     ) $(red_U0023) wget ${red}--proxy=off${NC} -qO- ipecho.net/plain " ;
		echo -en " $(ellow_1     ) (будет виден Ваш ip): ${red}"
		wget --proxy=off -qO- ipecho.net/plain ; echo ;
		echo -e " $(white_1     ) "
		echo -e " $(ellow_1     ) Скачиваем ссылки curl'ом через socks5 TOR" ;
		echo -e " $(white_1     ) $(red_U0023) curl ${green}--socks5 127.0.0.1:${tor_port}${NC} http://site.com/ " ;
		echo -en " $(ellow_1     ) (будет виден ip TOR): ${green}"
		curl --socks5 127.0.0.1:${tor_port} http://2ip.ru ;
		press_enter_to_continue_or_ESC_or_any_key_to_cancel ; 
		echo -e " $(white_1     ) "
		echo -e " $(ellow_1     ) Скачиваем ссылки curl'ом без TOR подключения" ;
		echo -e " $(white_1     ) $(red_U0023) curl ${red} http://site.com/ " ;
		echo -en " $(ellow_1     ) (будет виден Ваш ip): ${red}"
		curl http://2ip.ru ;
		echo -e " $(white_1     ) "
		echo -e " $(ellow_1     ) Перезапустить WG, TOR, Privoxy, Firewalld." ;
		echo -e " $(white_1     ) $(red_U0023) tor-restart " ;
		echo -e " $(white_1     )  " ;
		echo -e " $(white_1     ) Полезное чтиво:" ;
		echo -e " $(green_1     ) ${green}https://wiki.parabola.nu/Tor_(Русский)"
		echo -e " $(green_1     ) ${green}https://hackware.ru/?p=10492"
		echo -e " $(white_1     )  " ;
		echo -e " $(white_1     ) Посмотреть журнал tor, последние 100 строк" ;
		echo -e " $(white_1     ) $(red_U0023) journalctl -u tor.service | tail -n 100" ;
		echo -e " $(white_1     )  " ;
		echo -e " $(white_1     ) Утилита поставляемая с пакетом TOR для перенаправления" ;
		echo -e " $(white_1     ) $(red_U0023) torify <сетевая_программа> [url/file]" ;
		echo -e " $(white_1     )  " ;
		
		echo -e " $(black_U23A9 ) \n" ;
		
	}
	
	function tor_CH() { if [[ -e /usr/bin/tor ]] ; then tor_already_installed_MSG ; else tor_install_now ; fi ; } ; 
	
	
	if [[ $1 == "wgetrc_config_edit_now" ]] ; then wgetrc_CH ; fi ;
	if [[ $1 == "privoxy_config_edit_now" ]] ; then privoxy_config_edit_now ; fi ;
	
	# restart_tor_privoxy_firewall_network
	if [[ $1 == "tor-restart" ]] ; then restart_tor_privoxy_firewall_network ; fi ;
	
	
	
	tor_CH ;
	
	
		exit 0 ;

		# https://wiki.parabola.nu/Tor_(Русский)#TorDNS
		# https://wiki.archlinux.org/title/Tor_(Русский)#Privoxy
		# https://habr.com/ru/company/southbridge/blog/255845/




Чтобы проверить, работает ли Tor на вашем сервере по протоколу SOCKS5, вы можете запустить команду curl --socks5 127.0.0.1:9050 https://check.torproject.org/ и посмотреть на вывод. Если вы получите ответ с "Congratulations" и увидите сообщение о том, что вы используете Tor, значит Tor работает по протоколу SOCKS5 на 127.0.0.1:9050.












	
	for test in 9150 9050 ''; do
		{ >/dev/tcp/127.0.0.1/$test1; } 2>/dev/null && { tsport="$test1"; break; }
		[ -z "$test1" ] && echo >&2 -e "\n Нет открытого Tor порта ... EXITING\n Похоже ТОР еще не установлен или не работает."
	done
	
	
	for test in 9150 9050 ''; do
		{ >/dev/tcp/127.0.0.1/$test; } 2>/dev/null && { tsport="$test"; break; }
		[ -z "$test" ] && echo >&2 -e "\nН ет открытого Tor порта ... EXITING\n" && exit 1
	done

