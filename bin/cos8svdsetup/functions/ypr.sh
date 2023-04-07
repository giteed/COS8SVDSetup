#!/bin/bash

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
 ⎩ Использование: ypr с ключом -p или --provides ") && lang=cr && bpn_p_lang ;

	 ttb=$(echo -e "   
 ⎧ which - Находит исполняемые файлы(x), алиасы,
 | функции, в переменой окружения \$PATH
 | сервере репозитариях пакетного менеджера yum/dnf
 ⎩ Использование: ypr с ключом -w или --which ") && lang=cr && bpn_p_lang ;

	 ttb=$(echo -e "   
 ⎧ type - В отличие от which, type НЕ осуществляет
 | сразу поиск в переменой окружения \$PATH
 | type показывает  значение искомой команды или алиаса.
 ⎩ Использование: ypr с ключом -t или --type") && lang=cr && bpn_p_lang ;

	 ttb=$(echo -e "   
 ⎧ whereis - Ведет поиск в системных каталогах.
 ⎩ Использование: ypr с ключом -e или --whereis") && lang=cr && bpn_p_lang ;

	 ttb=$(echo -e "   
 ⎧ locate - Ведет поиск файлов и папок, по базе данных,
 | от / совпадающих с ключевым словом.
 ⎩ Использование: ypr с ключом -l или --locate ") && lang=cr && bpn_p_lang ;	 

	 ttb=$(echo -e "   
 ⎧ ypr с ключом -a или --all или запрос без -ключа
 | Будет искать используя все эти программы.
 ⎩ ypr с ключом -h или --help Выводит эту справку. ") && lang=cr && bpn_p_lang ;	 

_more ;
	
}




function _provides() {
		
     arg_2=("$1")
		
     if [[ $arg_2 == "" ]] ; then ttb=$(echo -e "\n ⎧ Укажите вторым аргументом, что требуется найти!\n ⎩ Например: ypr -p nginx \n") && lang=cr && bpn_p_lang && return ; fi ;
		
	 ttb=$(echo -e "    
 ⎧ *** Репозитории предоставляющие программу: "$arg_2" ***
 | yum provides - Ищет программные пакеты
 | овпадающие с запросом, в установленных на этом
 | сервере репозитариях пакетного менеджера yum/dnf
 ⎩ $(whatis $arg_2 2>/dev/null) \n ") && lang=cr && bpn_p_lang ;
	  
 ttb=$(echo -e "  
  $(yum provides $arg_2 ;)
  $(yum info $arg_2 ;)
  
  | Попробуйте искать командой: 
  | # yum search $arg_2
 ") && lang=cr && bpn_p_lang ;	
 
	 _more ;
	 
	 }



function _which() {
	arg_2=("$1")
	 ttb=$(echo -e "   
 ⎧ *** Локальное расположение: "$arg_2" ***
 | which - Находит исполняемые файлы(x), алиасы,
 | функции, в переменой окружения \$PATH 
 ⎩ # which $1") && lang=cr && bpn_p_lang ;

ttb=$(echo -en "
 $(which -a $1 )\n
 $(type -all $1 )\n ") && lang=cr && bpn_p_lang ;


	 }


function _type() {
	arg_2=("$1")
	 ttb=$(echo -e "   
 ⎧ type - В отличие от which, НЕ осуществляет сразу поиск
 | в переменой окружения \$PATH
 | type - Показывает значение искомой команды или алиаса. 
 ⎩ # type $arg_2") && lang=cr && bpn_p_lang ;	
 
 ttb=$(echo -e "  
 	
	 $(type $arg_2 ;)
	") && lang=nix && bpn_p_lang ;	
	
	 }

function _whereis() {
	arg_2=("$1")
	 ttb=$(echo -e "    
 ⎧ whereis - Ведет поиск в системных каталогах.
 ⎩ # whereis $arg_2") && lang=cr && bpn_p_lang ;	 

ttb=$(echo -e " 
 $(whereis $arg_2)\n") && lang=cr && bpn_p_lang ; 
 
	 }


function _locate() {
	arg_2=("$1")
	
	if [[ $arg_2 == "" ]] ; then ttb=$(echo -e "\n ⎧ Укажите вторым аргументом, что требуется найти!\n ⎩ Например: ypr -l nginx \n") && lang=cr && bpn_p_lang && return ; fi ;
	
	 ttb=$(echo -e "   
 ⎧ locate - Ведет поиск файлов/папок, по базе данных на
 | этом сервере, совпадающих с: "$arg_2"
 ⎩ # locate "$arg_2": ") && lang=cr && bpn_p_lang ;	 echo ;
 
 ttb=$(echo -e "$(whatis $arg_2)\n" 2>/dev/null ) && lang=cr && bpn_p_lang ;
	 
 ttb=$(echo -e "$(stat -c '%a:%A %U %G %n' $( (locate "/$arg_2") | (rg "/$arg_2" | rg "/$arg_2") ) 2>/dev/null | column -t ;)
	") && lang=cr && bpn_p_lang ;	

	 }


function _all() {
arg_2=("$1")
_provides $arg_2 ;
_which $arg_2;
_type $arg_2;	
_whereis $arg_2;
_locate $arg_2;

	 ttb=$(echo -e "   
 ⎧ ypr с ключом -a или --all - Выводит только 25 первых
 | результатов поиска файлов/папок совпадающих с: "$arg_2"
 | Для вывода всего списка совпадений в locate:
 ⎩ Используйте: # ypr с ключом -l" "$arg_2 или ypr с ключом --locate" "$arg_2 ") && lang=cr && bpn_p_lang ;	 echo ;

 ttb=$(echo -e "$(stat -c '%a:%A %U %G %n' $( (locate "/$arg_2") | (rg "/$arg_2" | head -n 25 | rg "/$arg_2") ) 2>/dev/null | column -t ;)
 ") && lang=cr && bpn_p_lang ;

 _more ;

}



function _repo_list() {
	
	arg_2=("$2")
	GLIG_ASTRX_OF
	ttb=$(echo -e "   
 ⎧ *** REPO List:  ***
 | # yum repolist
 ⎩ по базе данных на этом сервере
	 
	 $(yum repolist) 
 
 | Содержимое папки /etc/yum.repos.d/
	 
$(stat -c '%a:%A %U %G %n' /etc/yum.repos.d/* | column -t ;)
	 ") && lang=cr && bpn_p_lang ;
	 
	 GLIG_ASTRX_ON ;
}











   function ypr-f() # Поиск программы/файла локально и в репо
  {
	 case $1 in
	 
	 '*' | '.'| h | -h | --h | -help | --help | help | hel | he | -hel | --hel | -he | --he | '')
	 
	 _help
	 
	 ;;
	 
	 
	 -a | -al | -all | --a | --al | --all)
	 
	 arg_2=("$2")
	 _all $arg_2;
	 unset arg_2
	 
	 ;;
	 
	 
	 -p | --p | --provides | -s | --s | --search | -i | --i | --info )
	 
	 arg_2=("$2")
	  _provides $arg_2;
	 unset arg_2 
	 
	 ;;
	 
	 
	 -w | --w | --which)
	 
	 arg_2=("$2")
	   _which $arg_2;
	  unset arg_2 
	 
	 ;;
	 
	 
	 -t | --t | --type)
	 
	 arg_2=("$2")
	  _type $arg_2;
	  unset arg_2 
	 
	 ;;
	 
	 
	 -e | --e | --whereis)
	 
	 arg_2=("$2")
	  _whereis $arg_2;
	  unset arg_2 
	 
	 ;;
	 
	 
	 -l | --l | --locate)
	 
	 arg_2=("$2")
	  _locate $arg_2;
	  unset arg_2 
	  
	 ;;
	 
	 
	 -rl | --list | -list | --rl)
	 
	 arg_2=("$2")
	 _repo_list
	 unset arg_2
	 
	 ;;
	 
	 
	 *)
	 
	 ;;
	 esac 
	 unset arg_2
  }
