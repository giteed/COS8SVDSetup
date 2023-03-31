#!/bin/bash

# Source global definitions
# --> Прочитать настройки из /root/.bashrc
. /root/.bashrc


# Этот скрипт первым делом проверяет, был ли передан PID в качестве аргумента при запуске. Если не было, то пользователю будет предложено ввести PID вручную. Если PID был передан в аргументах, то он будет использован для поиска процесса.

# После того, как PID был определен, скрипт проверяет существование процесса с указанным PID, используя команду ps. Если процесс существует, скрипт отправляет сигнал SIGTERM процессу с помощью команды kill. Если процесс не существует, скрипт выведет сообщение об ошибке.






# Это скрипт для убийства процесса по PID
# Если PID не указан в аргументах, пользователь будет спрошен о его вводе
if [[ $1 == "-h" ]] ; then kill_help && exit ; fi ; 
if [ "$#" -ne 1 ]; then
	function msg() {
		(echo -en "\n ⎧ Введите ${ELLOW}PID${nc} процесса,\n ⎩ который ${red}хотите убить${nc}: ${ellow}" )  ;
	}
	
	echo -en "$(msg)" ; read pid

else
	pid="$1"
fi

# Проверяем существование процесса с указанным PID
if (ps -p "$pid" > /dev/null) &>/dev/null ; then
	ttb=$(echo -e "\n ⎧ Убиваем процесс с PID $pid:") && lang="nix" && bpn_p_lang 
	# Отправляем сигнал SIGTERM процессу с указанным PID
	(kill "$pid") &>/dev/null && ( ttb=$( echo -e " ⎩ Процесс с PID $pid Убит!" ) && lang="nix" && bpn_p_lang ) 
else
	( ttb=$( echo -e "\n ⎧ Процесс с PID $pid не сушествует!\n ⎩ Справка  # killl -h" ) && lang="nix" && bpn_p_lang) ;
fi



 









exit 0








