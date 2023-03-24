#!/bin/bash 

# Source global definitions
# --> Прочитать настройки из /etc/bashrc
. ~/.bashrc


#-----------------------------------

# dnf install git tar curl wget -y ;

 (( [[ ! -z $(git --version )  ]] ) &>/dev/null && echo -e "Now install dnf install git curl wget, please wait..." && ( ( dnf install tar git curl wget -y ) 2>/dev/null ) && source ~/.bashrc ) || ( echo -e "git version $(git --version)" ) &>/dev/null ;

	# ФУНКЦИЯ: Установка fzf
 function fzfIN() 
 { 
		 echo -e " Установка fzf." 
		 
		 ( ( git clone --depth 1 https://github.com/junegunn/fzf.git ~/.fzf && ~/.fzf/install --all ) ) && ( echo -e " ${GREEN}Установка fzf завершена${NC}" && echo -e " ($( green_tick )) - fzf version ${RED}    |${NC} $($HOME/.fzf/bin/fzf --version)" && ( echo -e "\n Для обновления настроек введите:\n ${RED}#${NC} source ${CYAN}~/.bashrc\n${NC}" ) ; ) || ( echo -en " Функция fzfIN завешилась с ошибкой: " && error_MSG ; ) ;
		 # &>/dev/null 
 }  


# Проверка на наличие fzf или установка fzf
 ( [[ -z $(fzf --version) ]] ) &>/dev/null  && fzfIN # || ( ( echo -e "fzf version $(fzf --version)" ) &>/dev/null );



case $1 in
-h | --help )
# Справка
	echo -e ""${cyan}"\n"${cyan}"***"${NC}" Справка /root/vdsetup.2/bin/utility/lastf.sh "${cyan}"***"${NC}" "
	echo -e ""${cyan}"\n Использование:"${NC}" /root/vdsetup.2/bin/utility/lastf.sh [username][ip][Day][Month][etc] " ;
	echo -e ""${cyan}"  пример:"${NC}" /root/vdsetup.2/bin/utility/lastf.sh "$mi" "${cyan}" (поиск по ip адресу или по "${NC}"ip.маске.*"${cyan}")"${NC}"" ;
	echo -e ""${cyan}"     или:"${NC}" /root/vdsetup.2/bin/utility/lastf.sh "$Month" "$(whoami)" "${cyan}"(поиск по Месяцу и UserName)"${NC}"" ;
	echo -e ""${cyan}"     или:"${NC}" /root/vdsetup.2/bin/utility/lastf.sh "$Day" "$Month" "${cyan}"(поиск по Дню и Месяцу)"${NC}"" ;
	echo -e ""${cyan}"     или:"${NC}" /root/vdsetup.2/bin/utility/lastf.sh "$Month" \"("$im"|boot|pts)\" $Day "${cyan}"(использование сдвоенной переменной)"${NC}"" ;
	echo -e ""${cyan}"     или:"${NC}"     [с ключем -a] "${cyan}"(поиск по всем записям и выбор только одной)"${NC}"" ;
	echo -e ""${cyan}"     или:"${NC}"     [с ключем --all или -all или --a ]"${cyan}" (листинг всех записей)"${NC}"" ;
	echo -e ""${cyan}"     или:"${NC}"     [используйте до 7 ключевых слов в запросе для сортировок]"${NC}"" ;
;;

-a )
# Вывести все и выбрать 1 запись интерактивным поиском fzf!
	echo -e "\n"${cyan}"***"${NC}" Поиск из всех записей и выбор одной этой: "${cyan}"***"${NC}"" ;
	( last -i | fzf | bat -p --paging=never -l nix ) 2>/dev/null || last -i   ;
;;

--all | -all | --a | -al | --al)
# Листинг всех записей
	echo -e "\n"${cyan}"***"${NC}" Листинг всех записей: "${cyan}"***"${NC}"\n " ;
	( last -i | bat -p --paging=never -l nix ) 2>/dev/null || last -i  ;
;;

'' )
# Если небыло запроса
	echo -e ""${cyan}"\n***"${NC}" Выборка /root/vdsetup.2/bin/utility/lastf.sh из всех записей за сегодня: "${cyan}""$Data""${NC}" "$DMY" "${cyan}"***"${NC}"\n"
	( last -i | rg "$Month" | rg "$Day" | rg "$Data" | bat -p --paging=never -l nix ) 2>/dev/null || last -i | grep "$Month" | grep "$Day" | grep "$Data" ;
;;


*)
# Или все остальное (ипользование с ключевыми словами)
echo -e ""${cyan}"\n***"${NC}" Выборка из всех записей: "${ELLOW}""$@" "${cyan}"***"${NC}" \n " ;
(last -i | rg "$1" | rg "$2" | rg "$3"| rg "$4" | rg "$5" | rg "$6" | rg "$7" | bat -p --paging=never -l nix) 2>/dev/null || last -i | grep "$1" | grep "$2" | grep "$3"| grep "$4" | grep "$5" | rggrep "$6" | grep "$7" ;

;;

esac


