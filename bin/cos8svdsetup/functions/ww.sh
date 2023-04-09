#!/bin/bash

   # --> Поиск информации о программе сразу по 11 командам. пример: ww hh
   function ww() {
	   
	   function msg_ww() {
		 
	 ttb=$(echo -e "
 ⎧ Чтобы получить информацию сразу по 4 командам: 
 | type -all [имя],  rpm -qa [имя]
 |  which -a [имя],  whereis [имя]
 | используйте: # ww [имя_программы] 
 | или:         # ww [имя_скрипта] 
 | или:         # ww [имя_функции]
 | Пример:      # ww htop
 | или:         # ww mc
 :
 ⎩ Попробуйте:  # wis [имя]
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
 ⎧ Просмотр информации по which -a: 
 ⎩ # which -a $1") && lang=cr && bpn_p_lang ;
      echo ; ttb=$(which -a $*) && lang=cr  && bpn_p_lang 2>/dev/null ; echo ;

   ttb=$(echo -e "
 ⎧ Просмотр информации по which -a: 
 ⎩ # whereis $1") && lang=cr && bpn_p_lang ;
      echo ; ttb=$(whereis $*) && lang=cr  && bpn_p_lang 2>/dev/null ; echo ;	
   
   tldr $1 2>/dev/null; echo ;
   ttb=$(echo -e "   
 ⎧ Получить больше информации о пакете: $1
 ⎩ https://pkgs.org/download/$1") && lang=cr && bpn_p_lang ; echo ;

      
   }
   