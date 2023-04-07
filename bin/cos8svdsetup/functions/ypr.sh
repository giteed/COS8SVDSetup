#!/bin/bash


function _s2() {
	if [[ $2 == "" ]] ; then arg2=test echo укажите что требуется найти ; fi ;
	arg1=$1
	arg2=$2

}

function ypr() {
	ypr-f $arg1 $arg2 ;
}	




function _more() {

   ttb=$(echo -e "   
 ⎧ Получить больше информации о репозитории с: \$pkg_name
 ⎩ https://pkgs.org/download/\$pkg_name") && lang=cr && bpn_p_lang ;
 
}

function _help() {
	 ttb=$(echo -e "\n | ypr - Совмещает в себе для удобства\n | набор следующих программ и утилит: ") && lang=cr && bpn_p_lang ;
	 
	 ttb=$(echo -e "   
 ⎧ yum provides - Ищет программные пакеты
 | совпадающие с запросом, в установленных на этом
 | сервере репозитариях пакетного менеджера yum/dnf
 ⎩ Использование: # ypr с ключом -p или --provides ") && lang=cr && bpn_p_lang ;

	 ttb=$(echo -e "   
 ⎧ which - Находит исполняемые файлы(x), алиасы,
 | функции, в переменой окружения \$PATH
 | сервере репозитариях пакетного менеджера yum/dnf
 ⎩ Использование: # ypr с ключом -w или --which ") && lang=cr && bpn_p_lang ;

	 ttb=$(echo -e "   
 ⎧ type - В отличие от which, type НЕ осуществляет
 | сразу поиск в переменой окружения \$PATH
 | type показывает  значение искомой команды или алиаса.
 ⎩ Использование: # ypr с ключом -t или --type") && lang=cr && bpn_p_lang ;

	 ttb=$(echo -e "   
 ⎧ whereis - Ведет поиск в системных каталогах.
 ⎩ Использование: # ypr с ключом -e или --whereis") && lang=cr && bpn_p_lang ;

	 ttb=$(echo -e "   
 ⎧ locate - Ведет поиск файлов и папок, по базе данных,
 | от / совпадающих с ключевым словом.
 ⎩ Использование: # ypr с ключом -l или --locate ") && lang=cr && bpn_p_lang ;	 

	 ttb=$(echo -e "   
 ⎧ ypr с ключом -a или --all или запрос без -ключа
 | Будет искать используя все эти программы.
 ⎩ ypr с ключом -h или --help Выводит эту справку. ") && lang=cr && bpn_p_lang ;	 

_more ;
	
}




function _provides() {
	
	
	 ttb=$(echo -e "    
 ⎧ *** Репозитории предоставляющие программу: "$arg2" ***
 | yum provides - Ищет программные пакеты
 | овпадающие с запросом, в установленных на этом
 | сервере репозитариях пакетного менеджера yum/dnf
 ⎩ $(whatis $arg2 2>/dev/null) \n ") && lang=cr && bpn_p_lang ;
	  
 ttb=$(echo -e "  
  $(yum provides $arg2 ;)
  $(yum search $arg2 ;)
  $(yum info $arg2 ;)
 ") && lang=nix && bpn_p_lang ;	

 _more ;

	 }



function _which() {
	 ttb=$(echo -e "   
 ⎧ *** Локальное расположение: "$arg2" ***
 | which - Находит исполняемые файлы(x), алиасы,
 | функции, в переменой окружения \$PATH 
 ⎩ # which $arg2") && lang=cr && bpn_p_lang ;

ttb=$(echo -en "
 $(which -a $arg2 )\n
 $(type -all $arg2 )\n ") && lang=cr && bpn_p_lang ;


	 }


function _type() {

	 ttb=$(echo -e "   
 ⎧ type - В отличие от which, НЕ осуществляет сразу поиск
 | в переменой окружения \$PATH
 | type - Показывает значение искомой команды или алиаса. 
 ⎩ # type $arg2") && lang=cr && bpn_p_lang ;	
 
 ttb=$(echo -e "  
	 $(type $arg2 ;)
	") && lang=nix && bpn_p_lang ;	
	
	 }

function _whereis() {

	 ttb=$(echo -e "    
 ⎧ whereis - Ведет поиск в системных каталогах.
 ⎩ # whereis $arg2") && lang=cr && bpn_p_lang ;	 

ttb=$(echo -e " 
 $(whereis $arg2)\n") && lang=cr && bpn_p_lang ; 
 
	 }


function _locate() {

	 ttb=$(echo -e "   
 ⎧ locate - Ведет поиск файлов/папок, по базе данных на
 | этом сервере, совпадающих с: "$arg2"
 ⎩ # locate "$arg2": ") && lang=cr && bpn_p_lang ;	 echo ;

 ttb=$(echo -e "$(stat -c '%a:%A %U %G %n' $( (locate "/$arg2") | (rg "/$arg2" | rg "/$arg2") ) 2>/dev/null | column -t ;)
	") && lang=cr && bpn_p_lang ;	

	 }


function _all() {

_provides ;
_which ;
_type ;	
_whereis ;
_locate ;

	 ttb=$(echo -e "   
 ⎧ ypr с ключом -a или --all - Выводит только 25 первых
 | результатов поиска файлов/папок совпадающих с: "$arg2"
 | Для вывода всего списка совпадений в locate:
 ⎩ Используйте: # ypr с ключом -l" "$arg2 или ypr с ключом --locate" "$arg2 ") && lang=cr && bpn_p_lang ;	 echo ;

 ttb=$(echo -e "$(stat -c '%a:%A %U %G %n' $( (locate "/$arg2") | (rg "/$arg2" | head -n 25 | rg "/$arg2") ) 2>/dev/null | column -t ;)
 ") && lang=cr && bpn_p_lang ;

 _more ;

}



# --> Поиск программы/файла локально и в repository по 7 командам
   function ypr-f() 
  {
	 case $arg1 in
	 
	 '*' | '.'| h | -h  | --help | help | '')
	 
	 _help ;
	 ;;
	 
	 a | -a | --all)
	 
	 _all ;
	 ;;
	 
	 p | -p | --provides )
	 _s2 ;
	 _provides ;
	 ;;
	 
	 w | -w | --which)
	 _which ;
	 ;;
	 
	 t | -t | --type)
	 _type ;	
	 
	 ;;
	 
	 e | -e | --whereis)
	 _whereis ;
	 ;;
	 
	 l | -l | --locate)

	 ttb=$(echo -e "   
 ⎧ locate - Ведет поиск файлов/папок, по базе данных на
 | этом сервере, совпадающих с: "$arg2"
 ⎩ # locate "$arg2": ") && lang=cr && bpn_p_lang ;
	 ttb=$(echo -e "  
 $(echo -e $(whatis $arg2 2>/dev/null ;))\n") && lang=cr && bpn_p_lang ; echo ;

 ttb=$(echo -e "$(stat -c '%a:%A %U %G %n' $( (locate "/$arg2") | (rg "/$arg2" | rg "/$arg2") ) 2>/dev/null | column -t ;)
	 ") && lang=cr && bpn_p_lang ;	
	 
	 
	 ;;
	 
	 
	 -rl | --list | -list | --rl)

	 echo -e "\n *** REPO List:  ***\n"
	 echo -e " yum repolist\n по базе данных на этом сервере\n "
	 echo -en " "
	 yum repolist 2>/dev/null ;
	 echo
	 GLIG_ASTRX_OF ;
	 echo -e "Содержимое папки /etc/yum.repos.d/\n"
	 stat -c '%a:%A %U %G %n' /etc/yum.repos.d/* | column -t ;
	 
	 ;;
	 
	 
	 *)
	 
	 ;;
	 esac 
	 
  }
