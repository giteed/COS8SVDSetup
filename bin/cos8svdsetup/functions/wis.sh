#!/bin/bash

function _more() {
   pkg_name=("$1")
   ttb=$(echo -e "   
 ⎧ Получить больше информации о пакете: $pkg_name
 ⎩ https://pkgs.org/download/$pkg_name") && lang=d && bpn_p_lang ; echo ;
 
}


# '*' | '.'| h | -h | --help | help | '')
function _help() {
	 ttb=$(echo -e "\n ⎧ wis -a [имя_программы] или:\n | wis -a [имя_файла] или:\n | wis -a [имя_функции]\n :\n | Поиск программы/файла_скрипта \n ⎩ локально и в repo, по 6 утилитам:\n ") && lang=nix && bpn_p_lang ;
	 
	 ttb=$(echo -e "   
 ⎧ yum provides - Ищет программные пакеты
 | совпадающие с запросом, в установленных 
 | на этом сервере репозитариях пакетного 
 | менеджера yum/dnf.
 :
 ⎩ Использование: wis -p [имя] или --provides") && lang=cr && bpn_p_lang ;

	 ttb=$(echo -e "   
 ⎧ which - Находит исполняемые файлы(x), 
 | алиасы, функции, в переменой окружения 
 | \$PATH на сервере репозиториях пакетного 
 | менеджера yum/dnf
 :
 ⎩ Использование: wis -wh [имя] или --which") && lang=cr && bpn_p_lang ;

	 ttb=$(echo -e "   
 ⎧ type - В отличие от which, type НЕ 
 | осуществляет сразу поиск в переменой 
 | окружения \$PATH. type показывает
 | значение искомой команды или алиаса.
 :
 ⎩ Использование: wis -t [имя] или --type") && lang=cr && bpn_p_lang ;

	 ttb=$(echo -e "   
 ⎧ whereis - Ведет поиск в системных 
 | каталогах исполняемых файлов, 
 | исходных кодов и страниц руководства
 | (man-страниц) заданной команды 
 | в заданных директориях.
 :
 ⎩ Использование: wis -ws [имя] или --whereis") && lang=cr && bpn_p_lang ;

	 ttb=$(echo -e "   
 ⎧ locate - Ведет поиск файлов и папок, 
 | по базе данных, от / совпадающих 
 | с ключевым словом.
 :
 ⎩ Использование: wis -l [имя] или --locate ") && lang=cr && bpn_p_lang ;	 

	 ttb=$(echo -e "   
 ⎧ yum search позволяет искать пакеты по 
 | ключевым словам в именах пакетов, 
 | описаниях и дополнительных метаданных.
 :
 ⎩ Использование: wis -s [имя] или --search") && lang=cr && bpn_p_lang ;	

	 ttb=$(echo -e "   
 ⎧ wis -a или --all или запрос без -ключа
 | Будет искать используя все эти программы.
 | wis -h или --help Выводит эту справку. 
 :
 ⎩ Попробуйте утилиту: # ww [имя]") && lang=cr && bpn_p_lang ;	 

 	_more $arg_2 ;
	
}


# wis p | -p | --provides)
function _provides() {
		
     arg_2=("$1")
		
     if [[ $arg_2 == "" ]] ; then ttb=$(echo -e "\n ⎧ Укажите вторым аргументом, что требуется найти!\n ⎩ Например: wis -p nginx \n") && lang=cr && bpn_p_lang && return ; fi ;
		
	 ttb=$(echo -e "    
 ⎧ Репозитории предоставляющие  
 | программу: "$arg_2". 
 | yum provides - Ищет 
 | программные пакеты cовпадающие 
 | с запросом, в установленных  
 | на этом сервере репозитариях 
 | пакетного менеджера yum/dnf
 :
 ⎩ # yum provides $arg_2 ")  && lang=cr && bpn_p_lang ;

  (ttb=$(echo -e "\n  $(whatis $arg_2 | column -t | tr -s ' ' )"  ) 2>/dev/null && lang=cr && bpn_p_lang) 2>/dev/null ;

  ttb=$(echo -e "  
  $(yum provides $arg_2 2>/dev/null ) 
  $(yum info $arg_2 2>/dev/null )") && lang=nix && bpn_p_lang ;
 
	 _more $arg_2 ;
   ttb=$(echo -e " : Удалить repo: dnf config-manager --disable <reponame*>\n") 2>/dev/null && lang=cr && bpn_p_lang
   _repo_list ;
   
	 
}


# wis wh | -wh | --which)
function _which() {
	arg_2=("$1")
	
	 if [[ $arg_2 == "" ]] ; then ttb=$(echo -e "\n ⎧ Укажите вторым аргументом, что требуется найти!\n ⎩ Например: wis -wh nginx \n") && lang=cr && bpn_p_lang && return ; fi ;
	 	
	 ttb=$(echo -e "   
 ⎧ Локальное расположение: "$arg_2"
 | which - Находит исполняемые
 | файлы(x), алиасы, функции, в
 | переменой окружения \$PATH 
 :
 ⎩ # which $1") && lang=cr && bpn_p_lang ;
 echo ;
 ttb=$(echo -en "$(which -a $1 )\n") && lang=cr && bpn_p_lang ;

}


# t | -t | --type)
function _type() {
	arg_2=("$1")
	 ttb=$(echo -e "   
 ⎧ type - В отличие от which,  
 | НЕ осуществляет сразу поиск 
 | в переменой окружения \$PATH.  
 | type - Показывает значение 
 | искомой команды или алиаса. 
 :
 ⎩ # type -all $arg_2") && lang=cr && bpn_p_lang ;	
 echo ;
 ttb=$(echo -e "$(type -all $arg_2 ;)") && lang=nix && bpn_p_lang ;	
	
}


# wh | -wh | --which)
function _whereis() {
	arg_2=("$1")
	 ttb=$(echo -e "   
 ⎧ whereis - Ведет поиск в системных 
 | каталогах исполняемых файлов, 
 | исходных кодов и страниц 
 | руководства (man-страниц) заданной 
 | команды в заданных директориях.
 :
 ⎩ # whereis "$arg_2" ") && lang=cr && bpn_p_lang ;	 
 echo ;
 ttb=$(echo -e "$(whereis $arg_2)\n") && lang=cr && bpn_p_lang ; 
 
}


# l | -l | --locate)
function _locate() {
	arg_2=("$1")
	
	if [[ $arg_2 == "" ]] ; then ttb=$(echo -e "\n ⎧ Укажите вторым аргументом, что требуется найти!\n ⎩ Например: wis -l nginx \n") && lang=cr && bpn_p_lang && return ; fi ;
	
	 ttb=$(echo -e "   
 ⎧ locate - Ведет поиск файлов/папок, 
 | по базе данных на этом сервере,
 | совпадающих с: "$arg_2"
 :
 ⎩ # locate "$arg_2" ") && lang=cr && bpn_p_lang ;	
  echo ;
  (ttb=$(echo -e "$(whatis $arg_2 | column -t | tr -s ' ' )"  ) 2>/dev/null && lang=cr && bpn_p_lang) 2>/dev/null ;
	 
  ttb=$(echo -e "$(stat -c '%a:%A %U %G %n' $( (locate "/$arg_2") | (rg "/$arg_2" | rg "/$arg_2") ) | column -t ;)\n") && lang=cr && bpal_p_lang;	

}


# s | -s | --search)
function _search() {
	arg_2=("$1")
	
	if [[ $arg_2 == "" ]] ; then ttb=$(echo -e "\n ⎧ Укажите вторым аргументом, что требуется найти!\n ⎩ Например: wis -s nginx \n") && lang=cr && bpn_p_lang && return ; fi ;
	
	 ttb=$(echo -e "   
 ⎧ yum search - позволяет искать 
 | пакеты по ключевым словам в 
 | именах, пакетов описаниях и 
 | дополнительных метаданных.
 :
 ⎩ # yum search "$arg_2" ") && lang=cr && bpn_p_lang ;	
  echo ;
  ttb=$(echo -e "$( yum search "$arg_2")\n ") && lang=d && bpal_p_lang ;

}

 
   


# -rl | --repo)
function _repo_list() {	
	GLIG_ASTRX_OF
	ttb=$(echo -e "   
 ⎧ *** REPO List: ***
 | репозитории установленные
 | на этом сервере.
 :
 ⎩ # dnf repolist
	 
	 $(dnf repolist) 
 
 | Содержимое папки:
 | /etc/yum.repos.d/
	 
$(stat -c '%a:%A %U %G %n' /etc/yum.repos.d/* | column -t ;)") && lang=cr && bpn_p_lang ;
	 
	 GLIG_ASTRX_ON ;
}


# a | -a | --all)
function _all() {
	arg_2=("$1")
	_provides $arg_2 ;
	_which $arg_2;
	_type $arg_2;	
	_whereis $arg_2;

	 ttb=$(echo -e "   
 ⎧ wis -a или --all - Выводит только  
 | 25 первых результатов поиска  
 | --locate файлов/папок совпадающих 
 | с: "$arg_2". Для вывода всего 
 | списка совпадений в locate: 
 :
 | Использование: wis -l" "$arg_2 
 ⎩ или: wis --locate" "$arg_2 ") && lang=bash && bpn_p_lang ;	 echo ;
  echo ;
  ttb=$(echo -e "$(stat -c '%a:%A %U %G %n' $( (locate "/$arg_2") | (rg "/$arg_2" | head -n 25 | rg "/$arg_2") ) 2>/dev/null | column -t ;)") && lang=cr && bpn_p_lang ;

  echo ;

	 ttb=$(echo -e "   
  ⎧ wis -a или --all - Выводит только 
  | 25 первых результатов поиска  
  | yum search совпадающих с: "$arg_2" 
  | Для вывода всего списка совпадений 
  | в yum search:
  :
  | Использование: wis -s" "$arg_2 
  ⎩ или: wis --search" "$arg_2 ") && lang=bash && bpn_p_lang ;	 echo ;
	echo ;
	ttb=$(echo -e "$(yum search "$arg_2" | head -n 25) ") && lang=d && bpn_p_lang ;


 	_more $arg_2 ;
	_repo_list ;

}


# Поиск программы/файла локально и в репо 
function wis-f() {
	   
	 case $1 in
	 
	 '*' | '.'| h | -h | --help | help | '')
	 _help
	 ;;
	 
	 
	 a | -a | --all)
	 arg_2=("$2")
	 _all $arg_2;
	 ;;
	 
	 
	 p | -p | --provides)
	 arg_2=("$2")
	 _provides $arg_2;
	 ;;
	 
	 
	 s | -s | --search)
	 arg_2=("$2")
	 _search $arg_2;
	 ;;
	 
	 
	 wh | -wh | --which)
	 arg_2=("$2")
	 _which $arg_2;
	 ;;
	 
	 
	 t | -t | --type)
	 arg_2=("$2")
	 _type $arg_2;
	 ;;
	 
	 
	 ws | -ws | --whereis)
	 arg_2=("$2")
	 _whereis $arg_2;
	 ;;
	 
	 
	 l | -l | --locate)
	 arg_2=("$2")
	 _locate $arg_2;
	 ;;
	 
	 
	 -rl | --repo)
	 arg_2=("$2")
	 _repo_list
	 ;;
	 
	 
	 *)
	 
	 ;;
	 
	 
	 esac 
	 
	 unset arg_2
  }
