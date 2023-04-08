#!/bin/bash

   # --> Поиск информации о программе сразу по 11 командам. пример: ww hh
   function ww() {
	   
	   function msg_ww() {
		 
	 ttb=$(echo -e "
 ⎧ Чтобы получить информацию сразу по 11 командам: 
 | type -all [имя], yum info [имя],
 | yum provides [имя], yum search [имя], 
 | yum repolist [имя] rpm -qa [имя],
 | which -a [имя], whatis [имя], whereis [имя],
 | locate [имя], tldr [имя].
 | используйте: 
 | # ww [имя_программы] или [имя_скрипта] или [имя_функции]
 |
 ⎩ Пример: # ww perl или [nginx], [ww], [ff], [htop].
   ") && lang=cr && bpn_p_lang ;
   
   }  
   
	if [[ $1 == "" ]] ; then msg_ww && return ; fi ;

	
   ( ttb=$(echo -e "
 ⎧ Просмотр информации о типе команды $1: 
 ⎩ # type -a $1") && lang=cr && lang=cr && bpn_p_lang ; )
	echo ; ttb=$(type -a $*) && lang=bash && bpn_p_lang 2>/dev/null ; echo ;
	
	ttb=$(echo -e "
 ⎧ Просмотр информации о пакете rpm: 
 ⎩ # rpm -qa $1") && lang=cr && bpn_p_lang ;
	echo ; ttb=$(rpm -qa $*) && lang=cr  && bpn_p_lang 2>/dev/null ; echo ;
	
	ttb=$(echo -e "
 ⎧ Просмотр информации по 9 командам: 
 ⎩ # ypr -a $1") && lang=cr && bpn_p_lang ;
	echo ; ttb=$(ypr -a $1) && lang=cr && bpn_p_lang ; echo ;

   ttb=$(echo -e "
 ⎧ Просмотр информации dnf search: 
 ⎩ # dnf search $1") && lang=cr && bpn_p_lang ;
   echo ; ttb=$(dnf search $1) && lang=cr && bpn_p_lang ; echo ;
   
   tldr $1 ; echo ;
   ttb=$(echo -e "   
 ⎧ Получить больше информации о репозитории с: $1
 ⎩ https://pkgs.org/download/$1") && lang=cr && bpn_p_lang ; echo ;

      
   }
   