#!/bin/bash

# Source global definitions
# --> Прочитать настройки из /root/.bashrc
. /root/.bashrc


# Этот скрипт первым делом проверяет, был ли передан PID в качестве аргумента при запуске. Если не было, то пользователю будет предложено ввести PID вручную. Если PID был передан в аргументах, то он будет использован для поиска процесса.

# После того, как PID был определен, скрипт проверяет существование процесса с указанным PID, используя команду ps. Если процесс существует, скрипт отправляет сигнал SIGTERM процессу с помощью команды kill. Если процесс не существует, скрипт выведет сообщение об ошибке.

function kill_help() {

ttb=$(echo -e " 
    Используйте этот скрипт так:
    # killl PID_процесса
   
    Другая программа для kill: (pkill):
    -----------------------------------------
 ⎧ 1) Для завершения процесса с определенным 
 | именем можно использовать следующую 
 | команду: # pkill имя_процесса
 ⎩ Например: # pkill firefox

 ⎧ 2) Если нужно завершить несколько процессов с одним 
 | именем, можно использовать опцию -f для указания 
 | полного имени процесса: # pkill -f имя_процесса
 ⎩ Например: # pkill -f firefox

 ⎧ 3) Можно использовать опцию -u для завершения 
 | процессов, запущенных от указанного 
 | пользователя: # pkill -u имя_пользователя имя_процесса
 ⎩ Например: # pkill -u john firefox 
 
    Другие скрипты для kill: (kkill и fkill):
    -----------------------------------------
 ⎧ 1) Убить процесс по неточному совадению:
 ⎩ # kkill
 
 ⎧ 2) Убить процесс по неточному совадению (fzf):
 ⎩ # fkill
 
 " ) && lang="cr" && bpn_p_lang ;
}




# Это скрипт для убийства процесса по PID
# Если PID не указан в аргументах, пользователь будет спрошен о его вводе
if [[ $1 == "-h" ]] ; then kill_help && exit ; fi ; 
if [ "$#" -ne 1 ]; then
	function msg() {
		(echo -en "\n ⎧ Введите ${ELLOW}PID${nc} процесса,\n ⎩ который ${red}хотите убить${nc}: ${green}" )  ;
	}
	
	echo -en "$(msg)" ; read pid

else
	pid="$1"
fi

# Проверяем существование процесса с указанным PID
if (ps -p "$pid" > /dev/null) &>/dev/null ; then
	ttb=$(echo -e "\n Убиваем процесс с PID $pid") && lang="nix" && bpn_p_lang 
	# Отправляем сигнал SIGTERM процессу с указанным PID
	(kill "$pid") &>/dev/null && ( ttb=$( echo -e "\n Процесс с PID $pid Убит!" ) && lang="nix" && bpn_p_lang ) 
else
	( ttb=$( echo -e "\n Процесс с PID $pid не сушествует!" ) && lang="nix" && bpn_p_lang) ;
fi



 









exit 0








