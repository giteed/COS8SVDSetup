#! /bin/bash
# This script changes the ssh port for logins on CentOS 5 and 6

# Source global definitions
# --> Прочитать настройки из /root/.bashrc
. ~/.bashrc

sshPort=$((grep "Port" /etc/ssh/sshd_config) | head -n 1 );
echo -e "${NC}	----------------------------------------"
echo -e "${CYAN}	Записи о портах в файле конфигурации${NC}:\n	$(find /etc/ -name "sshd_config")"
echo -e "${CYAN}	${GREEN}$(grep "Port " /etc/ssh/sshd_config)${NC}"
echo -e "${NC}	----------------------------------------"
echo -e "${GRAY}	SSH-сервер по умолчанию работает с использованием 22-го TCP-порта. 
	Иногда бывают ситуации когда необходимо изменить этот порт. 
	Например, для превентивной защиты от bruteforce-атак, 
	направленных именно на 22-й порт, или для освобождения 
	этого порта, занятого другим приложением. \n
	В этом случае можно изменить порт SSH 
	на любой другой свободный TCP-порт.${NC} ${GREEN}\n"
echo -en "	Хотите изменить ssh порт?${NC} [Y/N]"
read -r -p "	 " response
if [[ $response =~ ^([yY][eE][sS]|[yY])$ ]]
then    
   echo -e "${GRAY}\n	Выберите порт между: ${GREEN}1024${NC}-${GREEN}65535${NC}"
   echo -en "${GREEN}\n	Какой новый порт вы хотите назначить${NC}?"
   read -p " " sshportconfig
   if (( ("$sshportconfig" > 1024) && ("$sshportconfig" < 65535) )) 2>/dev/null; 
then
   	cp /etc/ssh/sshd_config /etc/ssh/sshd_config_old_"$D$T" ;
	echo -e "Port $sshportconfig" >> /etc/ssh/sshd_config ;

	
	echo -e "${CYAN}	SSH изменен на ${NC}: $sshportconfig\n" ;
	sshPort=$(grep "Port" /etc/ssh/sshd_config | head -n 1 ) ;
	
	netstat_i ;
	
	echo -e "${GREEN}\n	$(green_tick) Добавляем новый порт sshd${NC}: $sshportconfig${NC}" ;
	echo -e "	$(red_U0023) firewall-cmd --permanent --add-port=$sshportconfig/tcp\n" ;
	
	
	firewall-cmd --permanent --add-port=$sshportconfig/tcp ;
	echo -e "	$(green_tick) $(red_U0023) firewall-cmd --reload" ;
	firewall-cmd --reload ;
	
	echo -e "${GREEN}\n	$(green_tick) Перезапускаем sshd${NC}:" ;
	echo -e "	$(red_U0023) systemctl restart sshd" ;
	systemctl restart sshd ;
	
	netstat_i ;
	
	echo -e "${CYAN}\n	$(green_tick) Открыт новый порт на firewallD ${NC}: $sshportconfig" ;
	echo -e "${CYAN}	 firewallD перезапущен для использования нового порта${NC}: $sshportconfig" ;
	
	
	fw_i ;
	
	echo -e "${ELLOW}\n	---= !!!   .......    ВНИМИНИЕ    .......   !!! =---${NC}"
	echo -e "${RED}\n	Не закрывайте эту сессию SSH прежде чем не убедитесь"
	echo -e "${RED}	в работоспособности соединения с новым портом${NC}: $sshportconfig"
	
	echo -e "${CYAN}\n	- Подключитесь к ssh с рабочей NIX машины и (${RED}не с этого сервера${NC})${NC}:" ;
	echo -e "${CYAN}	откройте новую сессию SSH в новом окне/вкладке терминала${NC}:" ;
	echo -e "	$(red_U0023) ssh $(whoami)@$(myip) -p $sshportconfig" ;
	echo -e "${ELLOW}\n	---= !!!   Закройте эту сессию SSH, если $(green_OK)${ELLOW}   !!! =---${NC}"
	
	echo -e "${CYAN}\n	- Посмотрите файл SSH настроек${NC}:\n 	${RED}#${NC} cat /etc/ssh/sshd_config ${NC}\n" ;
	   ( bat /etc/ssh/sshd_config ) 2>/dev/null || cat /etc/ssh/sshd_config ;
	echo -e "${CYAN}\n	- Чтобы добавить свой публичный ключ на этот сервер ${GREEN}$(hostname)${NC},"
	echo -e "${CYAN}	выполните с рабочей Linux машины (${RED}не с этого сервера${NC}):"
	echo -e "	$(red_U0023) ssh-copy-id $(whoami)@$(myip) -p $sshportconfig\n"
	
   else
	echo -e "\n${RED}	Вы выбрали не правильный порт. ${NC}" ;
	echo -e "${GRAY}	Выберите порт между: ${GREEN}1024${NC}-${GREEN}65535${NC}\n" ;
	echo -e "${CYAN}	Запустите скрипт снова и сделайте правильный выбор порта${NC}" ;
	echo -e "	$(red_U0023) $0${NC}" ;
	sshPort=$((grep "Port" /etc/ssh/sshd_config) | head -n 1 ) ;
	
	exit 1
   fi
else 
   sshPort=$((grep "Port" /etc/ssh/sshd_config) | head -n 1 ) ;
   
   echo -e "${CYAN}	SSH порт ${RED}не был${NC}${CYAN} изменен${NC}:" ;
   echo -e "${CYAN}	${GREEN}$(grep "Port " /etc/ssh/sshd_config)${NC}"
   echo -e "${CYAN}\n	Посмотреть файл${NC}:\n 	${RED}#${NC} cat /etc/ssh/sshd_config ${NC}" ;
   ( bat -l cr -p /etc/ssh/sshd_config ) 2>/dev/null || cat /etc/ssh/sshd_config ;
   fw_i ;
   echo 
   netstat_i ;
   echo -e "${NC}" ;
   exit 1 
fi

exit 0 ;