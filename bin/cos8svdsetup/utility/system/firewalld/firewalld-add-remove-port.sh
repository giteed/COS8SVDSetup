#!/bin/bash

# Source global definitions
# --> Прочитать настройки из /root/.bashrc
source /root/.bashrc

# --> Этот ссылка на функцию проверяет, запущен-ли скрипт с правами суперпользователя (root) в Linux.
. /root/vdsetup.2/bin/functions/run_as_root.sh

function help_fwd() {

  ttb=$(echo -e "
   Памятка:
   --------
   # firewall-cmd --add-port="$port"/"$protocol" --permanent --zone=public
   # firewall-cmd --remove-port="$port"/"$protocol" --permanent --zone=public
   # firewall-cmd --permanent --zone=public --add-service=http
   # firewall-cmd --permanent --zone=public --add-service=https
   # firewall-cmd --permanent --zone=public --add-service vnc-server
   # firewall-cmd --permanent --zone=public --remove-service vnc-server
   # firewall-cmd --permanent --zone=public --remove-service=vnc-server
   # firewall-cmd --list-all 
   # firewall-cmd --reload
   # firewall-cmd --complete-reload
   # firewall-cmd --list-all
   # systemctl restart firewalld
	  
 ⎧ Если вы вносите изменения в конфигурацию firewalld, то 
 | рекомендуется использовать команду: 
 | # firewall-cmd --reload
 | которая перечитывает конфигурационные файлы и применяет 
 ⎩ изменения, не прерывая работу службы firewalld.
   
 ⎧ Если вы делаете изменения в других параметрах, таких как 
 | уровни доступа или зоны, то можно использовать команду:
 | # firewall-cmd --complete-reload
 | которая полностью перезапускает firewalld, удаляет 
 ⎩ текущую конфигурацию из памяти и загружает ее снова.
   
 ⎧ Команда systemctl restart firewalld перезапускает службу 
 | firewalld, что приводит к ее полной остановке и запуску снова.
 | Это может привести к прерыванию соединений и задержке в 
 | обработке трафика, поэтому лучше использовать команду:
 ⎩ # firewall-cmd --reload
   
") && lang="cr" && bpn_p_lang ;
 }


ttb=$(echo -e "
 Firewalld
 ---------") && lang="nix" && bpn_p_lang ;
	fw_i
ttb=$(echo -e "
 ⎧ В этом скрипте используются переменные:
 | port, protocol и action, которые
 ⎩ можно настроить на нужные значения. 
 
") && lang="nix" && bpn_p_lang ;

# Запросить номер порта
read -p " Введите номер порта: " port

# Запросить протокол
read -p " Введите протокол (tcp или udp): " -e -i tcp protocol

# Запросить действие (открыть или закрыть порт)
read -p " Введите действие (open или close): " action

# Определить, какой сервис используется для указанного протокола
if [ "$protocol" == "tcp" ]; then
	service_name="http"
elif [ "$protocol" == "udp" ]; then
	service_name="dhcpv6-client"
else
	echo -e "\n ${RED}Неподдерживаемый протокол${NC}: $protocol"
	help_fwd ;
	exit 1
fi

# Определить команду, которая будет использоваться для открытия или закрытия порта
if [ "$action" == "open" ]; then
	command="add-port"
elif [ "$action" == "close" ]; then
	command="remove-port"
else
	echo -e "\n ${RED}Неподдерживаемое действие${NC}: $action"
	help_fwd ;
	exit 1
fi

ttb=$(echo -e "
 ⎧ Будет Выполнена команда: "$command"
 | Port: "$port" ("$service_name")
 | Protocol: "$protocol" 
 | Zone: zone=public
 ⎩ Выполняются команды:
   
   # firewall-cmd --"$command"="$port"/"$protocol" --permanent --zone=public
   # firewall-cmd --reload
   ") && lang="cr" && bpn_p_lang ;
   
   echo -en " ${GREEN}"
   # Открыть или закрыть порт для указанного сервиса и протокола
   firewall-cmd --$command=$port/$protocol --permanent --zone=public ;
   echo -e " ${nc}"
   
   echo -en " ${GREEN}"
   # reload Firewalld
   firewall-cmd --reload
   echo -e " ${nc}"
   
   fw_i ;
   
   ttb=$(echo -e "
	⎧ Посмотреть памятку по командам:
	⎩ Нажмите Enter или ESC... ") && lang="cr" && bpn_p_lang ;
   
   press_enter_to_continue_or_ESC_or_any_key_to_cancel ;

   help_fwd ;
   
   exit 0;
   
