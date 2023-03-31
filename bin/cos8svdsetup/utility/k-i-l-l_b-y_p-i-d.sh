#!/bin/bash

# Source global definitions
# --> Прочитать настройки из /root/.bashrc
. /root/.bashrc


# Это скрипт для убийства процесса по PID
# Если PID не указан в аргументах, пользователь будет спрошен о его вводе

if [ "$#" -ne 1 ]; then
	#ttb=$(echo -en "\n Введите PID процесса, который вы хотите убить: )" && lang="nix" && bpn_p_lang 
	echo Введите PID процесса:
	read pid
else
	pid="$1"
fi

# Проверяем существование процесса с указанным PID
if ps -p "$pid" > /dev/null; then
	ttb=$(echo -e "\n Убиваем процесс с PID $pid") && lang="nix" && bpn_p_lang 
	# Отправляем сигнал SIGTERM процессу с указанным PID
	kill "$pid"
else
	ttb=$(echo -e "\n Процесс с PID $pid не запущен") && lang="nix" && bpn_p_lang ;
fi

ttb=$(echo -e " 
Для завершения процесса с определенным 
именем можно использовать следующую 
команду: # pkill имя_процесса
Например: # pkill firefox

Если нужно завершить несколько процессов с одним 
именем, можно использовать опцию -f для указания 
полного имени процесса: pkill -f имя_процесса
Например: # pkill -f firefox

Можно использовать опцию -u для завершения 
процессов, запущенных от указанного 
пользователя: # pkill -u имя_пользователя имя_процесса
Например: # pkill -u john firefox " ) && lang="nix" && bpn_p_lang ;




exit 0

Этот скрипт первым делом проверяет, был ли передан PID в качестве аргумента при запуске. Если не было, то пользователю будет предложено ввести PID вручную. Если PID был передан в аргументах, то он будет использован для поиска процесса.

После того, как PID был определен, скрипт проверяет существование процесса с указанным PID, используя команду ps. Если процесс существует, скрипт отправляет сигнал SIGTERM процессу с помощью команды kill. Если процесс не существует, скрипт выведет сообщение об ошибке.







Вы можете сохранить этот скрипт в файл с расширением .sh, например kill_pid.sh, сделать его исполняемым (chmod +x kill_pid.sh) и запускать, передавая в качестве аргумента PID процесса, который вы хотите убить.

Пример запуска скрипта, чтобы убить процесс с PID 1234:


./kill_pid.sh 1234
Этот скрипт сначала проверяет, передан ли аргумент PID, а затем проверяет, существует ли процесс с указанным PID. Если процесс существует, скрипт отправляет сигнал SIGTERM процессу с помощью команды kill. Если процесс не существует, скрипт выведет сообщение об ошибке.









function msg1() {
	(echo -e "\n $(black_U23A7 ) " ;)
}

function msg2() {
	(echo -en " $(white_1     ) " ; ttb=$(echo -e " Быстро убить процесc(сы) по точному имени или ключевому слову.") && bpn_p_lang ; ttb=""  ;)
}

function msg2_1() {
	(echo -en " $(red_1     ) " ; ttb=$(echo -e " Будьте крайне осторожны с использованием!\n |  Если результаты не верны ' Ctrl + C ' для выхода из утилиты.\n |   ") && bpn_p_lang ; ttb=""  ;)
}


function msg3() {
	(  echo -en " $(green_1       ) " ; echo -en " Введите ключевое слово: ${green}" && echo -en "" )  ;
}

function msg4() {
	(echo -e " $(white_1      ) ") ; 
}

function msg5() {
	(echo -en " $(blue_1      ) " ; ttb=$(echo -e " Вы выбрали: ${snippet}") && lang="nix" && bpn_p_lang ;)
}

function msg6() {
	(echo -en " $(cyan_1     ) " ; ttb=$(echo -en " ${resp}" ) && bpn_p_lang ; ttb="" ;)
}

function msg7() {
	(echo -en " $(cyan_1      ) " ; ttb=$( echo -e " Убить процесс по ключевому слову можно командой:") && lang="nix" && bpn_p_lang ;)
}

function msg8() {
	(echo -en " $(white_1     ) " ; ttb=$(echo -e " # ps ax | awk '/[n]ame/ { print \$1 }' | xargs kill" ) && lang_bash && bpn_p_lang ; ttb="" ;)
}

function msg9() {
	(echo -en "${bl_pidof} $(white_1     ) " ; ttb=$(echo -e " # pidof name | awk '{ print \$1 }' | xargs kill" ) && lang_bash && bpn_p_lang ; ttb="" ;)
}

function msg10() {
	(echo -en "${bl_grep} $(white_1     ) ${nc}" ; ttb=$(echo -e " # ps ax | grep <name> | grep -v grep | awk '{print \$1}' | xargs kill" ) && lang_bash && bpn_p_lang ; ttb="" ;)
}

function msg11() {
	(echo -e " $(black_U23A9 ) \n";)
}





function kill_snippet() {
	
	msg1 ; msg2 ; msg2_1 ; echo -en "$(msg3)" ; read snippet 
	
	function msgno() {
		 st=return &&  resp=$( echo -e "Ничего не найдено по кл.сл. $snippet" ) && ( msg5 && msg6 && msg4 && msg7 && msg8 && msg9 && msg10 && msg11 )
	}
	
	function msgok() {
		resp=$( echo -e "Был(и) найден(ы) и успешно убит(ы) \n |  процесс(сы) в имени которого(ых) есть: $snippet !" ) && st=exit && (msg5 && msg6 && msg4 && msg7 && msg8 && msg9 && msg10 && msg11 ) 
	}
	
	function msg_end_pidof() {
		pid=$(pidof ${snippet} | awk '{ print $1 }')
		echo -e " |  ${nc}PID ${snippet}:${green} ${pid}${nc}" ;
		echo -e "\n${red} Внимание!${nc} Только этот, найденный процесс, с точным\n совпадением в имени: ${green}${snippet}, ${nc}PID: ${red}${pid}, ${RED}будет убит${red}!\n\n $( ps ax | grep ${snippet} | grep ${pid} | grep -v grep )${nc}\n \n (Чтобы убить ${green}все найденные процессы${nc} попробуйте искать по маске, например: '${green}${snippet}${red}*${nc}')\n (ниже ${green}процессы${nc} по маске: '${green}${snippet}${red}*${nc}' - сейчас они убиты не будут, кроме проц.: ${red}${pid}${nc})\n" && ttb=$(echo -e "$( ps ax | grep ${snippet} | grep -v grep ) \n") && bpn_p_lang && echo && ttb="" && press_anykey && echo -e "\n"
	}
	
	function msg_end_grep() {
		echo -e "\n${red} Внимание!${nc} Все найденные процессы, \n с ключевым словом: ${green}${snippet} ${nc}в имени${RED}\n будут убиты!\n${nc}\n" && press_anykey && echo -e "\n"
	}
	
	
	function pidof_snippet_ch() {
		
		function pidof_snippet_kill() {
			#echo pidof ;
			#echo ;
			( pidof ${snippet} | awk '{ print $1 }' | xargs kill ) && bl_pidof=$blink && msgok 
		}
		
		( test $(pidof ${snippet} | awk '{ print $1 }' ) && msg_end_pidof && pidof_snippet_kill && exit 0 )
		
	}
	
	
	function ps_ax_grep_ch() {
		
		function ps_ax_grep_kill() {
			#echo grep ;
			#echo ;
			(( ps ax | grep ${snippet} | grep -v grep | grep -v "xargs kill" | awk '{ print $1 }' | xargs kill ) && bl_grep=$blink && msgok );
		}
		echo ;
		ttb=$(( ps ax | grep ${snippet} | grep -v grep ) ) && bpn_p_lang && ttb="" && msg_end_grep && ps_ax_grep_kill && echo && exit 0 
		
	}
	
	
	
	if [[ "$snippet" == '' ]] ; then exit ; fi ;

	pidof_snippet_ch && exit 0;
	ps_ax_grep_ch && exit 0;
	
	msgno ;

	
}



kill_snippet

























if [[ "$1" != '' ]] ; 
then  snippet=$1 ; kill_snippet ;
fi 

kill_snippet



press_enter_to_continue_or_any_key_to_cancel


exit 0 ; 


&& green_tick_en && ttb=$

&& lang="nix" && bpn_p_lang


echo -e "${TOR_or_REAL_IP_MSG}" ;

echo -e "\n $(black_U23A7 ) " ;
echo -e " $(white_1     ) "
echo -e " $(red_1       ) "
echo -e " $(blue_1      ) "
echo -e " $(cyan_1      ) "
echo -e " $(purple_1    ) "
echo -e " $(purple_U23A6) "
echo -e " $(black_1     ) "
echo -e " $(white_1     ) "
echo -e " $(ellow_1     ) " ;
echo -e " $(green_1     ) "
echo -e " $(green_U23A6 ) "
echo -e " $(white_1     ) $(red_U0023) " ;
echo -e " $(white_1     )  " ;
echo -e " $(black_U23A9 ) \n" ;
echo ;