#!/bin/bash

function _more() {

   ttb=$(echo -e "   
 ⎧ Получить больше информации о репозитории с: \$pkg_name
 ⎩ https://pkgs.org/download/\$pkg_name") && lang=cr && bpn_p_lang ; echo ;
 
}


# '*' | '.'| h | -h | --help | help | '')
function _help() {
	 ttb=$(echo -e "\n | ypr - Совмещает в себе для удобства\n | набор следующих программ и утилит: ") && lang=cr && bpn_p_lang ;
	 
	 ttb=$(echo -e "   
 ⎧ yum provides - Ищет программные пакеты
 | совпадающие с запросом, в установленных на этом
 | сервере репозитариях пакетного менеджера yum/dnf
 ⎩ Использование: ypr -p или --provides ") && lang=cr && bpn_p_lang ;

	 ttb=$(echo -e "   
 ⎧ which - Находит исполняемые файлы(x), алиасы,
 | функции, в переменой окружения \$PATH
 | сервере репозитариях пакетного менеджера yum/dnf
 ⎩ Использование: ypr -wh или --which ") && lang=cr && bpn_p_lang ;

	 ttb=$(echo -e "   
 ⎧ type - В отличие от which, type НЕ осуществляет
 | сразу поиск в переменой окружения \$PATH
 | type показывает  значение искомой команды или алиаса.
 ⎩ Использование: ypr -t или --type") && lang=cr && bpn_p_lang ;

	 ttb=$(echo -e "   
 ⎧ whereis - Ведет поиск в системных каталогах.
 ⎩ Использование: ypr -ws или --whereis") && lang=cr && bpn_p_lang ;

	 ttb=$(echo -e "   
 ⎧ locate - Ведет поиск файлов и папок, по базе данных,
 | от / совпадающих с ключевым словом.
 ⎩ Использование: ypr -l или --locate ") && lang=cr && bpn_p_lang ;	 

	 ttb=$(echo -e "   
 ⎧ ypr -a или --all или запрос без -ключа
 | Будет искать используя все эти программы.
 ⎩ ypr -h или --help Выводит эту справку. ") && lang=cr && bpn_p_lang ;	 

 	_more ;
	
}


# ypr p | -p | --provides)
function _provides() {
		
     arg_2=("$1")
		
     if [[ $arg_2 == "" ]] ; then ttb=$(echo -e "\n ⎧ Укажите вторым аргументом, что требуется найти!\n ⎩ Например: ypr -p nginx \n") && lang=cr && bpn_p_lang && return ; fi ;
		
	 ttb=$(echo -e "    
 ⎧ *** Репозитории предоставляющие программу: "$arg_2" ***
 | yum provides - Ищет программные пакеты
 | овпадающие с запросом, в установленных на этом
 | сервере репозитариях пакетного менеджера yum/dnf
 ⎩ $(whatis $arg_2 2>/dev/null)") && lang=cr && bpn_p_lang ;
	  
  ttb=$(echo -e "  
  $(yum provides $arg_2 ;)
  $(yum info $arg_2 ;)
  
  | Попробуйте искать командой: 
  | # yum search $arg_2") && lang=cr && bpn_p_lang ;	
 
	 _more ;
	 
}


# ypr wh | -wh | --which)
function _which() {
	arg_2=("$1")
	
	 if [[ $arg_2 == "" ]] ; then ttb=$(echo -e "\n ⎧ Укажите вторым аргументом, что требуется найти!\n ⎩ Например: ypr -wh nginx \n") && lang=cr && bpn_p_lang && return ; fi ;
	 	
	 ttb=$(echo -e "   
 ⎧ *** Локальное расположение: "$arg_2" ***
 | which - Находит исполняемые файлы(x), алиасы,
 | функции, в переменой окружения \$PATH 
 ⎩ # which $1") && lang=cr && bpn_p_lang ;
 echo ;
 ttb=$(echo -en "$(which -a $1 )\n") && lang=cr && bpn_p_lang ;

}


# t | -t | --type)
function _type() {
	arg_2=("$1")
	 ttb=$(echo -e "   
 ⎧ type - В отличие от which, НЕ осуществляет сразу поиск
 | в переменой окружения \$PATH
 | type - Показывает значение искомой команды или алиаса. 
 ⎩ # type -all $arg_2") && lang=cr && bpn_p_lang ;	
 echo ;
 ttb=$(echo -e "$(type -all $arg_2 ;)") && lang=nix && bpn_p_lang ;	
	
}


# wh | -wh | --which)
function _whereis() {
	arg_2=("$1")
	 ttb=$(echo -e "    
 ⎧ whereis - Ведет поиск в системных каталогах.
 ⎩ # whereis $arg_2") && lang=cr && bpn_p_lang ;	 
 echo ;
 ttb=$(echo -e "$(whereis $arg_2)\n") && lang=cr && bpn_p_lang ; 
 
}


# l | -l | --locate)
function _locate() {
	arg_2=("$1")
	
	if [[ $arg_2 == "" ]] ; then ttb=$(echo -e "\n ⎧ Укажите вторым аргументом, что требуется найти!\n ⎩ Например: ypr -l nginx \n") && lang=cr && bpn_p_lang && return ; fi ;
	
	 ttb=$(echo -e "   
 ⎧ locate - Ведет поиск файлов/папок, по базе данных на
 | этом сервере, совпадающих с: "$arg_2"
 ⎩ # locate "$arg_2" ") && lang=cr && bpn_p_lang ;	
  echo ;
  ttb=$(echo -e "$(whatis $arg_2)" 2>/dev/null ) && lang=cr && bpn_p_lang ;
	 
  ttb=$(echo -e "$(stat -c '%a:%A %U %G %n' $( (locate "/$arg_2") | (rg "/$arg_2" | rg "/$arg_2") ) 2>/dev/null | column -t ;)\n") && lang=cr && bpal_p_lang;	

}


# a | -a | --all)
function _all() {
	arg_2=("$1")
	_provides $arg_2 ;
	_which $arg_2;
	_type $arg_2;	
	_whereis $arg_2;
	_locate $arg_2;

	 ttb=$(echo -e "   
 ⎧ ypr -a или --all - Выводит только 25 первых
 | результатов поиска файлов/папок совпадающих с: "$arg_2"
 | Для вывода всего списка совпадений в locate:
 | Использование: ypr -l" "$arg_2 
 ⎩ или: ypr --locate" "$arg_2 ") && lang=bash && bpn_p_lang ;	 echo ;
  echo ;
  ttb=$(echo -e "$(stat -c '%a:%A %U %G %n' $( (locate "/$arg_2") | (rg "/$arg_2" | head -n 25 | rg "/$arg_2") ) 2>/dev/null | column -t ;)") && lang=cr && bpn_p_lang ;

 	_more ;

}


# -rl | --repo)
function _repo_list() {	
	arg_2=("$2")
	GLIG_ASTRX_OF
	ttb=$(echo -e "   
 ⎧ *** REPO List:  ***
 | # yum repolist
 ⎩ по базе данных на этом сервере
	 
	 $(yum repolist) 
 
 | Содержимое папки /etc/yum.repos.d/
	 
$(stat -c '%a:%A %U %G %n' /etc/yum.repos.d/* | column -t ;)") && lang=cr && bpn_p_lang ;
	 
	 GLIG_ASTRX_ON ;
}


# Поиск программы/файла локально и в репо 
function ypr-f() {
	   
	 case $1 in
	 
	 '*' | '.'| h | -h | --help | help | '')
	 
	 _help
	 
	 ;;
	 
	 
	 a | -a | --all)
	 
	 arg_2=("$2")
	 _all $arg_2;
	 unset arg_2
	 
	 ;;
	 
	 
	 p | -p | --provides)
	 
	 arg_2=("$2")
	 _provides $arg_2;
	 unset arg_2 
	 
	 ;;
	 
	 
	 wh | -wh | --which)
	 
	 arg_2=("$2")
	 _which $arg_2;
	 unset arg_2 
	 
	 ;;
	 
	 
	 t | -t | --type)
	 
	 arg_2=("$2")
	 _type $arg_2;
	 unset arg_2 
	 
	 ;;
	 
	 
	 ws | -ws | --whereis)
	 
	 arg_2=("$2")
	 _whereis $arg_2;
	 unset arg_2 
	 
	 ;;
	 
	 
	 l | -l | --locate)
	 
	 arg_2=("$2")
	 _locate $arg_2;
	 unset arg_2 
	  
	 ;;
	 
	 
	 -rl | --repo)
	 
	 arg_2=("$2")
	 _repo_list
	 unset arg_2
	 
	 ;;
	 
	 
	 *)
	 
	 ;;
	 
	 
	 esac 
	 
	 unset arg_2
  }
