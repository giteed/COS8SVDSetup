#!/bin/bash

# Source global definitions
# --> Прочитать настройки из /root/.bashrc
. /root/.bashrc 

# --> Эта ссылка на функцию проверяет, запущен-ли скрипт с правами суперпользователя (root) в Linux.
. /root/vdsetup.2/bin/functions/run_as_root.sh

  
# Назначение/изменение имени хоста
function _set_hostname() {
  	
  	echo ;
  	echo -e " $(black_U23A7 ) " ;
  	echo -en " $(ellow_1     ) Текущее имя хоста: " ; hostname > hostname.txt && cat hostname.txt ;
  	echo -e " $(white_1     ) Введите новое имя хоста или нажмите "$GREEN"Enter${NC} .." ;
  	echo -e " $(black_1      ) ${BLACK}Если оставить поле пуcтым имя хоста останется без изменений${NC}." ;
  	echo -en " $(blue_1      ) ${NC}: " ; read hostname ;
  	
  	if [[ -z "$hostname" ]]; then
  		echo -e " $(ellow_1     ) Имя хоста НЕ будет изменено."; 
  		hostname=$(cat hostname.txt);
  	else
  		echo -e " $(blue_1      ) Имя хоста будет изменено на:$GREEN $hostname${NC}";
  		hostnamectl set-hostname "$hostname";
  	fi
  	
  	echo -e " $(ellow_1     ) " ;
  	echo -e " $(white_1     ) Имя хоста:"$GREEN" "$hostname"${NC} " ;
  	echo -e " $(blue_1      ) $(wget -qO- https://icanhazip.com) ${NC}" ;
  	echo -e " $(blue_1      ) ${NC}" ;
  	echo -e " $(black_U23A9 ) " ;
  	echo ;
  	
  	echo -e " $(black_U23A7    ) " ;
  	echo -e " $(ellow_1       ) $(red_U0023) hostnamectl set-hostname "$hostname" " ;
  	echo -e " $(black_U23A9 ) \n" ;
  	
  	( hostnamectl | bat -l nix -p )2>/dev/null || hostnamectl ; 
  	
  }
	_set_hostname ;
	exit 0 ;

