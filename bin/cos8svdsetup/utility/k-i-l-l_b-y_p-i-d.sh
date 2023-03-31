#!/bin/bash

# Source global definitions
# --> Прочитать настройки из /root/.bashrc
. /root/.bashrc


# Это скрипт для убийства процесса по PID
# Если PID не указан в аргументах, пользователь будет спрошен о его вводе

if [ "$#" -ne 1 ]; then
	function msg() {
		(echo -en " Введите PID процесса, который вы хотите убить: " && echo -en "" )  ;
	}
	
	echo -en "$(msg)" ; read pid
	read pid
else
	pid="$1"
fi

# Проверяем существование процесса с указанным PID
if ps -p "$pid" > /dev/null; then
	ttb=$(echo -e "\n Убиваем процесс с PID $pid") && lang="nix" && bpn_p_lang 
	# Отправляем сигнал SIGTERM процессу с указанным PID
	(kill "$pid" &>/dev/null) && echo -e "\n Process with PID $pid Killed" || echo -e "\n Process with PID $pid is not running"
else
	ttb=$(echo -e "\n Процесс с PID $pid не запущен") && lang="nix" && bpn_p_lang ;
fi



 







ttb=$(echo -e " 
 ⎧ Для завершения процесса с определенным 
 | именем можно использовать следующую 
 | команду: # pkill имя_процесса
 ⎩ Например: # pkill firefox

 ⎧ Если нужно завершить несколько процессов с одним 
 | именем, можно использовать опцию -f для указания 
 | полного имени процесса: pkill -f имя_процесса
 ⎩ Например: # pkill -f firefox

 ⎧ Можно использовать опцию -u для завершения 
 | процессов, запущенных от указанного 
 | пользователя: # pkill -u имя_пользователя имя_процесса
 ⎩ Например: # pkill -u john firefox 
 " ) && lang="cr" && bpn_p_lang ;




exit 0

Этот скрипт первым делом проверяет, был ли передан PID в качестве аргумента при запуске. Если не было, то пользователю будет предложено ввести PID вручную. Если PID был передан в аргументах, то он будет использован для поиска процесса.

После того, как PID был определен, скрипт проверяет существование процесса с указанным PID, используя команду ps. Если процесс существует, скрипт отправляет сигнал SIGTERM процессу с помощью команды kill. Если процесс не существует, скрипт выведет сообщение об ошибке.







Вы можете сохранить этот скрипт в файл с расширением .sh, например kill_pid.sh, сделать его исполняемым (chmod +x kill_pid.sh) и запускать, передавая в качестве аргумента PID процесса, который вы хотите убить.

Пример запуска скрипта, чтобы убить процесс с PID 1234:


./kill_pid.sh 1234
Этот скрипт сначала проверяет, передан ли аргумент PID, а затем проверяет, существует ли процесс с указанным PID. Если процесс существует, скрипт отправляет сигнал SIGTERM процессу с помощью команды kill. Если процесс не существует, скрипт выведет сообщение об ошибке.









