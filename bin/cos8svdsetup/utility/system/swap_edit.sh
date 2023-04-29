
#!/bin/bash

# --> Прочитать настройки из /root/.bashrc
. /root/.bashrc

# --> Этот ссылка на функцию проверяет, запущен-ли скрипт с правами суперпользователя (root) в Linux.
	. /root/vdsetup.2/bin/functions/run_as_root.sh

# --> Этот код является сценарием в bash, который создает файл подкачки и активирует его без перезапуска системы. Сначала скрипт отображает информацию о текущем использовании подкачки в системе. Затем он запрашивает у пользователя размер нового файла подкачки в мегабайтах. Он создает файл подкачки, форматирует его для использования в качестве подкачки, активирует его, а затем обновляет конфигурационные файлы системы, чтобы новый файл подкачки мог быть активирован при загрузке системы. Наконец, он отображает информацию о новом использовании подкачки и использовании памяти системы.
# --> Сценарий также предоставляет сообщения об ошибках, если какие-либо из команд не могут быть выполнены, и создает резервную копию файла rc.local системы перед его изменением.
# --> Следует отметить, что для выполнения сценария требуются привилегии root.
  
  echo ;
  
function swap_edit() {
	
	# Получить размер текущего SWAP-файла
	CURRENT_SWAP_SIZE=$(test -f /swap* && free -h -t | awk '/^Swap:/ { print $2 }' ) || echo "0 GB"
	
  echo -e " $(black_U23A7   )	Информация о swap: $CURRENT_SWAP_SIZE" ;
  echo -en " $(ellow_1       )\n" ;
  ( free -h -t | bat  --paging=never -l meminfo -p ) 2>/dev/null || free -h -t  ; echo -en ""
  echo -e "\n $(black_U23A9 )" ;
  
  
  press_enter_to_continue_or_ESC_or_any_key_to_cancel ;
 
  if swapoff -a ; 
	then 
	echo -e " $(black_U23A7 ) " ;
	echo -e " $(ellow_1     ) Укажите в мегабайтах размер "${RED}"SWAP"${NC}" файла, " ;
	echo -en " $(ellow_1    ) $(green_arrow) который хотите создать${RED}:${NC} " ; read swp ;
	echo -e " $(black_1     ) "
	echo -e " $(black_1     ) Пожалуйста подождите..."
	echo -e " $(black_1     ) "
	echo -en " $(white_1    ) $(green_n1). Создаю файл подкачки /swap "${GREEN}""${swp}""${NC}" MB: " ;
	(( dd if=/dev/zero of=/swap bs=1M count="${swp}" ) &>/dev/null ; ) && green_tick || error_MSG ;
	
	echo -en " $(white_1    ) $(green_n2). Форматирую файл под swap: " ;
	(( mkswap /swap) &>/dev/null ; ) && green_tick || error_MSG  ;
	
	
	echo -en " $(white_1    ) $(green_n3). Включаю swap без перезагрузки: " ;
	(( swapon /swap ) &>/dev/null ) && green_tick || error_MSG ;
	( chmod a+x /etc/rc.local ) ;
	
	
	echo -e " $(white_1     ) $(green_n4). Устанавливаю:" ;
	echo -en " $(white_1    )    chown root:root /swap , chmod 0600 /swap: " ; (( chown root:root /swap ) && ( chmod 0600 /swap )) && green_tick || error_MSG ;
	echo -en " $(white_1    ) $(green_n5). Создаю backup файла rc.local в /tmp/: " ; date_backup="${D}"_"${T}" ;
	(( cp /etc/rc.local /tmp/rc.local.backup.${date_backup} ) &>/dev/null ; ) && green_tick || error_MSG ;
	
   function echo_create_rc.local() {
	 echo \#!/bin/bash > /etc/rc.local ;
	 echo \# THIS FILE IS ADDED FOR COMPATIBILITY PURPOSES >> /etc/rc.local ;
	 echo \# >> /etc/rc.local ;
	 echo \# It is highly advisable to create own systemd services or udev rules >> /etc/rc.local ;
	 echo \# to run scripts during boot instead of using this file. >> /etc/rc.local ;
	 echo \# >> /etc/rc.local ;
	 echo \# In contrast to previous versions due to parallel execution during boot >> /etc/rc.local ;
	 echo \# this script will NOT be run after all other services. >> /etc/rc.local ;
	 echo \# >> /etc/rc.local ;
	 echo \# Please note that you must run 'chmod +x /etc/rc.d/rc.local' to ensure >> /etc/rc.local ;
	 echo \# that this script will be executed during boot. >> /etc/rc.local ;
	 echo touch /var/lock/subsys/local >> /etc/rc.local;
	 echo "swapon /swap" >> /etc/rc.local ;
   }

	# Получить размер текущего SWAP-файла
    CURRENT_SWAP_SIZE=$(test -f /swap* && free -h -t | awk '/^Swap:/ { print $2 }' ) || echo "0 GB"
	echo -en " $(white_1    ) $(green_n6). Создаю новый файл /etc/rc.local: " ;
	( echo_create_rc.local ; ) && green_tick || error_MSG ;
	echo -e " $(black_1     )"
	echo -e " $(ellow_1     )    Информация о swap: ${green}$CURRENT_SWAP_SIZE${nc} \n" ;
	( swapon | bat --paging=never -l nix -p ; ) 2>/dev/null || swapon ;
	
	
	echo -e "\n $(white_1   )  Информация о всей памяти системы:\n " ; ( free -h -t | bat  --paging=never -l meminfo -p ) 2>/dev/null || free -h -t | grep -E '(Mem|Swap|Total)' ;
	
   
	echo -en "\n $(white_1  )  Версия swapon: " ; ( swapon -V | bat --paging=never -l nix -p ; ) 2>/dev/null || swapon -V ;
	
	
	echo -e " $(white_1     ) ${GREEN} Создание раздела виртуальной памяти  " ;
	echo -en " $(white_1    ) ${RED} swap ${NC}размером: ${RED}${swp}${GREEN} MB: " ; green_tick ; 
	echo -e " $(black_U23A9 ) \n"
	
	else 
	
	echo -e "\n $(black_U23A7 ) " ;
	echo -e " $(red_1     ) SWAP файл не может быть создан" ;
	echo -e " $(red_1       ) сначала отключите vncserver" ;
	echo -e " $(red_1       ) $(red_U0023) vncserver -list " ;
	echo -e " $(red_1       ) $(red_U0023) vncserver -kill :1 (или :2 и т.д.) " ;
	echo -e " $(black_U23A9 ) \n" ;
	vncserver -list ; echo ;
	
	fi
}

function swap_CH_and_warn_msg() {
  echo -e "\n $(black_U23A7 ) " ;
  echo -e " $(ellow_1      )    Информация о swap: \n" ;
  ( swapon | bat --paging=never -l nix -p ; ) 2>/dev/null || swapon ;
  
  echo -e "\n $(white_1     ) Для нормальной работы графического окружения "
  echo -e " $(white_1     ) рабочего стола Linux, имеет смысл назначить "
  echo -e " $(white_1     ) swap размером не менее 2 Гигабайт. "
  echo -e " $(white_1     ) Создание/редактирование swap раздела. "
  echo -e " $(white_1     ) $( red_U0023 ) "${0}" -sw "
  echo -e " $(black_U23A9 ) \n" ;
}

function vnc-swap-CH() {
  
  vnc_not_found() {
	echo -e "\n $(black_U23A7 ) " ; 
	echo -e " $(red_1       ) VNC : $(not_found_MSG)" ; 
	echo -e " $(black_U23A9 )\n" 
  }
  
  . /root/.bashrc ;
  ( ls /usr/bin/vncserver ; lk /usr/bin/vncserver ) #&>/dev/null ;  ;
  ( [[ -z $( vncserver -list ) ]] 2>/dev/null ) && vnc_not_found || swap_CH_and_warn_msg
  
}

# --> запускаем функцию редактирования swap 
swap_edit ;

exit 0 ;
