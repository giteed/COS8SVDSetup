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
	red_prgrm=("$2")
	 ttb=$(echo -e "   
 ⎧ *** Локальное расположение: "$red_prgrm" ***
 | which - Находит исполняемые файлы(x), алиасы,
 | функции, в переменой окружения \$PATH 
 ⎩ # which $2") && lang=cr && bpn_p_lang ;

ttb=$(echo -en "
 $(which -a $2 )\n
 $(type -all $2 )\n ") && lang=cr && bpn_p_lang ;


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
















   function ypr-f() # Поиск программы/файла локально и в репо
  {
	 case $1 in
	 
	 '*' | '.'| h | -h | --h | -help | --help | help | hel | he | -hel | --hel | -he | --he | '')
	 
	 _help
	 
	 ;;
	 
	 -a | -al | -all | --a | --al | --all)
	 red_prgrm=("$2")
	 echo -e "\n *** Локальное расположение: "$red_prgrm" ***\n"
	 echo -e " which - Находит исполняемые файлы(x), алиасы,\n функции, в переменой окружения \$PATH"
	 echo -en " # which "
	 echo -en "$2" 
	 echo -e "\n "
	 which -a $2 
	 
	 echo -e "\n\n type - В отличие от which, НЕ осуществляет сразу поиск\n в переменой окружения \$PATH"
	 echo -e " type - Показывает значение искомой команды или алиаса." 
	 echo -e " # type $2\n"
	 type -all $2 
	 echo -e " \n\n whereis - Ведет поиск в системных каталогах."
	 echo -e " # whereis $2\n"
	 whereis $2 
	 echo -e "\n locate - Ведет поиск файлов/папок, по базе данных на\n этом сервере, совпадающих с: "$red_prgrm" "
	 echo -e " # locate "$2": \n"
	 stat -c '%a:%A %U %G %n' $( (locate "/$2") | (rg "/$2" | head -n 25 | rg "/$2") ) 2>/dev/null | column -t ;
	 echo -e "\n ypr с ключом -a или --all - Выводит только 25 первых\n результатов поиска файлов/папок совпадающих с: "$red_prgrm"\n  \n Используйте: # ypr с ключом -l" "$red_prgrm или ypr с ключом --locate" "$red_prgrm\n Для вывода всего списка совпадений в locate."
	 
	 echo -e "\n\n *** Репозитории предоставляющие программу: "$red_prgrm" ***\n"
	 echo -e $(whatis $2) 2>/dev/null ;
	 echo -e
	 yum provides $2 ;
	 echo
	 yum info $2 ;
	 unset red_prgrm
	 
	 ;;
	 
	 -p | --p | --provides | -s | --s | --search | -i | --i | --info )
	 echo -e "\n *** Репозитории предоставляющие программу: "$2" ***\n" ;
	 echo -e " yum provides - Ищет программные пакеты\n совпадающие с запросом, в установленных на этом\n сервере репозитариях пакетного менеджера yum/dnf\n "
	 echo -en " "
	 echo -e $(whatis $2) 2>/dev/null ;
	 echo
	 yum provides $2 ;
	 echo 
	 yum search $2 ;
	 echo
	 yum info $2 ;
	 ;;
	 
	 -w | --w | --which)
	 echo -e "\n *** Локальное расположение: "$2" ***\n"
	 echo -e " which - Находит исполняемые файлы(x), алиасы, функции, в переменой окружения \$PATH\n"
	 echo -en " "
	 echo -e $(whatis $2) 2>/dev/null ;
	 echo
	 echo -en  " # which "
	 echo -en "$2": 
	 which -a $2  ;
	 ;;
	 
	 -t | --t | --type)
	 echo -e "\n type - В отличие от which, НЕ осуществляет сразу поиск в переменой окружения \$PATH"
	 echo -e " type - Показывает значение искомой команды или алиаса.\n" 
	 echo -en " "
	 echo -e $(whatis $2) 2>/dev/null ;
	 echo
	 echo -en " # type "
	 type -all $2 
	 ;;
	 
	 -e | --e | --whereis)
	 echo -e " \n whereis - Выводит результаты поиска в системных каталогах.\n"
	 echo -en " "
	 echo -e $(whatis $2) 2>/dev/null ;
	 echo
	 echo -en " # whereis "
	 whereis $2 
	 ;;
	 
	 -l | --l | --locate)
	 red_prgrm=("$2")
	 echo -e "\n *** Локальное расположение: "$2" ***\n"
	 echo -e " locate - Выводит полный список результов поиска файлов/папок,\n по базе данных на этом сервере, совпадающих с: "$red_prgrm"\n "
	 echo -en " "
	 echo -e $(whatis $2) 2>/dev/null ;
	 echo
	 echo -e " # locate "$2": "
	 stat -c '%a:%A %U %G %n' $( (locate "/$2") | (rg "/$2" | rg "/$2") ) 2>/dev/null | column -t ;
	 unset red_prgrm
	 ;;
	 
	 
	 -rl | --list | -list | --rl)
	 red_prgrm=("$2")
	 echo -e "\n *** REPO List:  ***\n"
	 echo -e " yum repolist\n по базе данных на этом сервере\n "
	 echo -en " "
	 yum repolist 2>/dev/null ;
	 echo
	 GLIG_ASTRX_OF ;
	 echo -e "Содержимое папки /etc/yum.repos.d/\n"
	 stat -c '%a:%A %U %G %n' /etc/yum.repos.d/* | column -t ;
	 unset red_prgrm
	 ;;
	 
	 
	 *)
	 
	 ;;
	 esac 
	 unset red_prgrm
  }
