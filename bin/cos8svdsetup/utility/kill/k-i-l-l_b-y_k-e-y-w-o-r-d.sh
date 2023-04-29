#!/bin/bash

# Source global definitions
# --> Прочитать настройки из /root/.bashrc
source /root/.bashrc


# https://losst.pro/kak-ubit-protsess-linux?ysclid=lay4xo7gzk993626029


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
			( pidof ${snippet} | awk '{ print $1 }' | xargs kill ) && bl_pidof=$blink && msgok 
		}
		
		( test $(pidof ${snippet} | awk '{ print $1 }' ) && msg_end_pidof && pidof_snippet_kill && exit 0 )
		
	}
	
	
	function ps_ax_grep_ch() {
		
		function ps_ax_grep_kill() {
			
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
	
	echo -e "${red}\n exit 0${nc};\n" 
	


	exit 0
