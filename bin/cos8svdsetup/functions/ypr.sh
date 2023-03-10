#!/bin/bash

# --> Поиск программы/файла локально и в репо по 7 командам
   function ypr-f() 
  {
	 case $1 in
	 
	 '*' | '.'| h | -h | --h | -help | --help | help | hel | he | -hel | --hel | -he | --he | '')
	 
	 echo -e " # ypr - Совмещающает в себе для удобства\n набор следующих программ и утилит: \n "
	 
	 echo -e " yum provides - Ищет программные пакеты\n совпадающие с запросом, в установленных на этом\n сервере репозитариях пакетного менеджера yum/dnf "
	 echo -e " Использование: # ypr с ключом -p или --provides \n "
	 
	 echo -e " which - Находит исполняемые файлы(x), алиасы,\n функции, в переменой окружения \$PATH "
	 echo -e " Использование: # ypr с ключом -w или --which \n "
	 
	 echo -e " type - В отличие от which, type НЕ осуществляет\n сразу поиск в переменой окружения \$PATH\n type показывает  значение искомой команды или алиаса.  "
	 echo -e " Использование: # ypr с ключом -t или --type \n "
	 
	 echo -e " whereis - Ведет поиск в системных каталогах. "
	 echo -e " Использование: # ypr с ключом -e или --whereis \n "
	 
	 echo -e " locate - Ведет поиск файлов и папок, по базе данных,\n от / совпадающих с ключевым словом."
	 echo -e " Использование: # ypr с ключом -l или --locate \n "
	 
	 echo -e " # ypr с ключом -a или --all или запрос без -ключа\n Будет искать используя все эти программы.\n "
	 
	 echo -e " # ypr с ключом -h или --help\n Выводит эту справку. "
	 
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
