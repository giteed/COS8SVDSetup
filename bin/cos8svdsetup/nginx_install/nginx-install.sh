#!/bin/bash

## Source global definitions
# --> Прочитать настройки из /root/.bashrc
. /root/.bashrc


	# ФУНКЦИЯ: Проверка установки nginx (/usr/sbin/nginx) и если не найден - пишет "не найден"
	function nginxCH()
	{
		echo -e -n "\n	${ELLOW}|${nc} Проверяем наличие устанвки nginx " ; echo -e -n "." ; echo -e ".."
		([[ -z $( ls /usr/sbin/nginx  ) ]] 2>/dev/null && echo -e "	${ELLOW}|${red} /usr/sbin/nginx    : $( not_found_MSG ) ") || echo -e "	${ELLOW}|${green} /usr/sbin/nginx    : $( found_MSG ) " ;
		#sleep 1 ;
	}
	
	# ФУНКЦИЯ: Выводит http ip nginx web сервера
	function nginx_http_ip() 
	{
		function httpCH()
		{
			(echo -e "	http://$(ifconfig_real_ip)/" > /tmp/nginx_http_ip) 2>/dev/null ;
			( cat /tmp/nginx_http_ip | bat --paging=never -l nix -p ; ) 2>/dev/null || ( cat /tmp/nginx_http_ip ) ;
		}
		
		function curlCH()
		{
			( curl http://$(ifconfig_real_ip)/ ) &>/dev/null && echo -e "$( green_tick ) ${GREEN}Online${NC}" || echo -e "$( red_cross ) ${RED}Failed to connect${NC}" ;
		}
		
		echo -e "${GREEN} .........................................................................." ;
		fw_i ;
		echo -en "\n	${CYAN}Адрес Web сервера nginx:${NC} " ; curlCH
		
		httpCH ; 
		echo -e "${GREEN} .........................................................................." ;
		echo ;
	}
	
	# ФУНКЦИЯ: Просмотр лога установки nginx_install.log
	function nginx_install.log() 
	{
		( cat /tmp/nginx_install.log | bat --paging=never -l nix -p ; ) 2>/dev/null || ( cat /tmp/nginx_install.log ) ;
	}
	
	# ФУНКЦИЯ: Просмотр статуса status_nginx.service
	function status_nginx.service() 
	{
		# systemctl status -n0 --no-pager nginx.service
		function nginxs() { systemctl status --no-pager nginx.service &>/tmp/status_nginx.service ; } ; nginxs ; 
		( systemctl status --no-pager nginx.service &>/dev/null && systemctl status --no-pager nginx.service || cat /tmp/status_nginx.service | bat -l conf -p ) &>/dev/null  || systemctl status --no-pager nginx.service ;

	}
	
	
	# ФУНКЦИЯ: Help
	function help()
	{
		
		nginx_http_ip ;
		status_nginx.service ;
		echo ;
		echo -en "	- ${nc}Посмотреть лог установки nginx: ${NC}........ " ;
		echo -e "$( red_U0023 ) $0 -ngi.log ${ELLOW}" ;
		echo -en "	- ${nc}Проверить открытые порты: ${NC}.............. " ;
		echo -e "$( red_U0023 ) firewall-cmd --list-all ${ELLOW}" ;
		echo -en "	- ${nc}Проверить, статус nginx:${NC} ............... " ;
		echo -e "$( red_U0023 ) systemctl status --no-pager nginx.service ${GREEN}" ;
		echo -en "	- ${nc}Добавить nginx в автозагрузку:${NC} ......... " ;
		echo -e "$( red_U0023 ) systemctl enable nginx.service ${RED}" ;
		echo -en "	- ${nc}Удалить nginx из автозагрузки:${NC} ......... " ;
		echo -e "$( red_U0023 ) systemctl disable nginx.service ${GREEN}" ;
		echo -en "	- ${nc}Заменить nginx.conf преднастроенным: ${NC}... " ;
		echo -e "$( red_U0023 ) $0 -ngconf ${ELLOW}" ;
		echo -en "	- ${nc}Посмотреть /etc/nginx/nginx.conf : ${NC} .... " ;
		echo -e "$( red_U0023 ) $0 -ngc.l ${ELLOW}" ;
		echo -en "	- ${nc}Проверить nginx.conf : ${NC} ................ " ;
		echo -e "$( red_U0023 ) $0 -ngc.c ${ELLOW}" ;
		echo -en "	- ${nc}Перезагрузить конфигурацию nginx: ${ELLOW}...... " ;
		echo -e "$( red_U0023 ) nginx -s reload ${ELLOW}" ;
		echo -en "	- ${nc}Переустановить nginx:${NC} .................. " ;
		echo -e "$( red_U0023 ) $0 -ng ${RED}" ;
		echo -en "	- ${nc}Удалить nginx: ${NC}......................... " ;
		echo -e "$( red_U0023 ) dnf remove nginx ${NC}" ;
		
	}
	
	# ФУНКЦИЯ: Установка nginx
	function nginx_install_reinstall() 
		{
	echo -e -n "	${ELLOW}|${nc} Установить/переустановить "${GREEN}"nginx"${NC}"?\n
	${RED}|${nc} Если нет, "${RED}"Enter"${NC}" 
	${GREEN}|${nc} Eсли да, введите: "${GREEN}"yes"$NC"
			
	["$RED" "$(im)""$NC"@"$GRAY"""$(hostname)" ""$NC"] "$NC"<<< "$RED"# "$NC""$GREEN""
			read nginxyes
			
		if [[ "$nginxyes" == "yes" ]]
			then 
			echo -e "\n Приступаем к установке и настройке nginx, FirewallD\n ${NC}" ;
			echo -e " 1. Выберите что вам нужно сделать ... " ;
			
			function case_1_2()
			{
			
	ttb=$(echo -e "	
 ⎧ Какой из repository nginx добавить для установки, 
 ⎩ [nginx-stable] или [nginx-mainline]? 
 
 ⎧ - Добавить [nginx-stable] .... введите: 1 (долгоср. поддержка)
 | (Если вы хотите стабильную версию, то используйте репозиторий 
 | [nginx-stable], тогда конфигурация дефолтного хоста будет 
 ⎩ в основном конфиге: /etc/nginx/nginx.conf)
 
 ⎧ - Добавить [nginx-mainline] .. введите: 2 (более новые версии)
 | (Если установить nginx из официального репозитория  
 | [nginx-mainline], то конфигурация дефолтного хоста будет 
 ⎩ в отдельном конфиге: /etc/nginx/conf.d/default.conf)
	
 | Оба репозитория [nginx-stable] и [nginx-mainline] для CentOS 8 Stream 
 | содержат файл конфигурации /etc/nginx/nginx.conf с настройками 
 | по умолчанию для всех серверов и локаций. Репозиторий [nginx-mainline] 
 | также предлагает директорию /etc/nginx/conf.d/ для дополнительных 
 | конфигурационных файлов серверов и локаций, которые будут автоматически
 | включены в основной файл конфигурации /etc/nginx/nginx.conf через 
 | директиву \"include /etc/nginx/conf.d/*.conf;\". 
 |
 | Если вы установите Nginx из репозитория [nginx-mainline] и создадите 
 | файл конфигурации /etc/nginx/conf.d/default.conf, он автоматически 
 | будет включен в основной файл конфигурации /etc/nginx/nginx.conf.
 
	 
	⎧ - Чтобы добавить [nginx-stable] .... введите: 1 (стабильные версии)
	⎩ - Чтобы добавить [nginx-mainline] .. введите: 2 (новые версии)
	
	⎧ - Отмена установки nginx ...........  введите: Q(q) 
	⎩ (Процесс будет завершен без каких-либо изменений)
	 
	⎧ - Удалить и переустановить nginx ...  введите: R(r)
	⎩ (Полное удаление nginx с конфигами и repository а затем переустановка)\n")&& lang=cr && bpn_p_lang ; echo ;
	
	echo -en "	Сделайте выбор: "
					read -p -e -i yes ng_1_2
					
					echo -n ""
					case $ng_1_2 in
					
				  1)
					echo -e "\n | Добавляем: ${BLUE}[nginx-stable]${NC} \n\n"
					rm -rf /etc/yum.repos.d/nginx.repo ;
					( cat /root/vdsetup.2/bin/nginx_install/nginx-stable ) > /etc/yum.repos.d/nginx.repo ;
					;;
				  2)
					echo -e "\n 	| Добавляем: ${GREEN}[nginx-mainline]${NC} \n\n"
					rm -rf /etc/yum.repos.d/nginx.repo ;
					( cat /root/vdsetup.2/bin/nginx_install/nginx-mainline ) > /etc/yum.repos.d/nginx.repo ;
					;;
				  r|R)
					echo -e "\n	| ${RED}Удаляем${NC} nginx вместе с конфигурационными файлами и репозиторием ...\n"
					echo ;
					dnf remove nginx -y;
					echo -e "\n 	| ${RED}Nginx удален вместе с конфигурационными файлами и репозиторием!${NC}\n" ;
					case_1_2 ;
					;;
				  q|Q)
					echo -e "\n 	| ${ELLOW}Отмена установки${NC} nginx\n"
					exit ;
					;;
				  *)
					echo -e "\n 	| Такого варианта нет... \n" 
					case_1_2 ;
					;;
				esac
			}
			
			case_1_2 ;
			
				
				
				
			echo -e " 2. Устанавливаем nginx" ;
			
			echo -e "\n${CYAN}	| После установки nginx запустится автоматически${NC}" ; 
			echo -e "\n${GREEN}	| Пожалуйста подождите...${NC}" ;
			echo > /tmp/nginx_install.log ;
				( (yum reinstall -y nginx --disablerepo=* --enablerepo=nginx-mainline &>/tmp/nginx_install.log && echo -e "	| Переустановка nginx завершена $(ellow_tick)\n") || (yum install -y nginx --disablerepo=* --enablerepo=nginx-mainline &>/tmp/nginx_install.log && echo -e "	| Установка nginx завершена $(green_tick)\n") ) || echo -e "\n    $(error_MSG) | function nginx_install, try dnf clean packages" ;
				
			
			echo -e " 3. Добавляем nginx в автозагрузку\n" ; 
			
			systemctl start nginx.service &>>/tmp/nginx_install.log ;
			systemctl enable nginx.service &>>/tmp/nginx_install.log ;
			firewall-cmd --permanent --zone=public --add-service=http &>>/tmp/nginx_install.log ;
			firewall-cmd --permanent --zone=public --add-service=https &>>/tmp/nginx_install.log ;
			firewall-cmd --reload &>>/tmp/nginx_install.log ;
			firewall-cmd --list-all &>>/tmp/nginx_install.log ;
			echo -en "	" ; ww nginx ;
			echo ; systemctl status --no-pager nginx.service ;
			help ;
			echo -en "\n	- ${cyan}Вы можете заменить ${NC}nginx.conf ${cyan}преднастроенным конфигурационным файлом:${NC}\n " ;
			echo -e "	$( red_U0023 ) $0 -ngconf ${NC}\n" ;
			
		else 
		echo -e "\n"
		$0 -h ;
		
		fi ;
		
		}
		
		
		# ФУНКЦИЯ: Проверка файла конфигурации /etc/nginx/nginx.conf
		function ngc.CH() 
		{
			echo -e "\n	| Выполняется проверка файла конфигурации /etc/nginx/nginx.conf :" ;
			echo -e "	| $( red_U0023 ) nginx -t ${NC} (Смотрите вывод с результатами проверки ниже)\n " ;
			function nginxt() { nginx -t &>/tmp/nginx_nginxt.log ; } ; nginxt ; 
			cat /tmp/nginx_nginxt.log | bat --paging=never -l v || nginx -t ;
			echo ;
			echo -e "	| $( red_U0023 ) nginx -s reload ${NC} (Перезагрузить конфигурацию nginx)\n " ;
			
		}
		
		# ФУНКЦИЯ: Просмотр файла конфигурации /etc/nginx/nginx.conf
		function ngc.list() 
		{
			echo -e "\n	| Выполняется просмотр файла конфигурации /etc/nginx/nginx.conf :" ;
			echo -e "	| $( red_U0023 ) cat /etc/nginx/nginx.conf ${NC} " ;
			echo ;
			(( cat /etc/nginx/nginx.conf | bat --paging=never -l conf ; ) 2>/dev/null || ( cat /etc/nginx/nginx.conf ) ) ;
			echo -e "	| $( red_U0023 ) nano /etc/nginx/nginx.conf ${NC} (редактировать файл)\n " ;
			ngc.CH ;
		}
		
		# ФУНКЦИЯ: Добавления конфига nginx /etc/nginx/nginx.conf
		function nginx_addConfig_nginx.conf() 
			{
				
				echo -e -n "	
 ${ELLOW}|${nc} Заменить текущий конфиг файл /etc/nginx/nginx.conf "${GREEN}"на преднастроенный"${NC}"?\n
 ${RED}|${nc} Если нет, "${RED}"Enter"${NC}" 
 ${GREEN}|${nc} Eсли да, введите: "${GREEN}"yes"$NC"
				
 ["$RED"$(im)"$NC"@"$GRAY""$(hostname)""$NC"] "$NC"<<< "$RED"# "$NC""$GREEN""
				read nginxconfyes
				
			if [[ "$nginxconfyes" == "yes" ]]
				then 
				
				echo -e "\n ${NC}1. Создаю backup старого nginx.conf : " ;
				( cp /etc/nginx/nginx.conf /etc/nginx/nginx.conf_old_$D_$T ) 2>/dev/null || echo -e " | /etc/nginx/nginx.conf    : $( not_found_MSG ) (Невозможно создать backup - файл не существует)" ;
				echo -e " | $( red_U0023 ) cat /etc/nginx/nginx.conf_old_$D_$T ${NC}" ;
				echo -e "\n	${NC}2. Создаю новый файл конфигурации /etc/nginx/nginx.conf : $( green_tick ) " ;
				cat . /root/vdsetup.2/bin/nginx_install/nginx_conf > /etc/nginx/nginx.conf ;
				mkdir -p /var/cache/nginx/client_temp ;
				
				ngc.CH ;
				
				help ;
				echo -e "\n	| $( red_U0023 ) nginx -s reload  (${RED}Перезагрузите конфигурацию nginx!${NC})\n "
				else ngc.list ; $0 -h ;
			fi	
		}

		
		case $1 in
				# Просмотр лога установки nginx
				ngi.log | -ngi.log | --nginx_install.log )
				nginx_install.log ;
				;; 
				
				# Проверка: установлен-ли nginx и установка/переустановка
				ng | -ng | --nginx )
				nginxCH ; 
				nginx_install_reinstall ;
				;;
				
				# Добавление нового конфига nginx /etc/nginx/nginx.conf
				ngconf | -ngconf | --nginx_conf )
				nginx_addConfig_nginx.conf ;
				;;
				
				# Справка по ключам этой программы
				h | -h | --help )
				help ;
				;;
				
				# Просмотр файла конфигурации nginx /etc/nginx/nginx.conf
				ngc.l | -ngc.l | --ngc.list )
				ngc.list ;
				;;
				
				# Проверка файла конфигурации nginx /etc/nginx/nginx.conf
				ngc.c | -ngc.c | --ngc.check )
				ngc.CH ;
				;;
				# Запуск программы без параметров запустит программу повторно с ключем -ng 
				*)
				
				$0 -ng || $0 -h ;	
				;;
				
				
		esac
		
		
exit 0 ;











# https://serveradmin.ru/nastrojka-web-servera-nginx-php-fpm-php7-na-centos-8/?ysclid=l7nou55afx191688767

