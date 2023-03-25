#!/bin/bash

# Source global definitions
# --> Прочитать настройки из /root/.bashrc
. /root/.bashrc

debug_stat=1

# НЕ_СТИРАТЬ # echo -en "\n Отладка:  НЕ показывать дебаг сообщения. " && debug_msg=0 ; 
if [[ $debug_stat == '0' ]] ; 
then test ; 



function msg13() {
	ttb=$(echo -e "\n Сервис существует и будет активирован.\n" ; echo ;) && lang_nix && bpn_p_lang  ; ttb="" ;
return ; } ; msg13=(msg13)

function msg14() {
	ttb=$(echo -e "\n Автоматический перезапуск сервиса активен (auto-restart)\n" ; echo ;) && lang_nix && bpn_p_lang  ; ttb="" ; 
return ; } ; msg14=(msg14)

function msg15() {
	
	ttb=$(echo -e "\n Сначала удалите старый сервис # remove_unit_stop_cashing\n" ; echo ;) && bpn_p_lang  ; ttb="" ;
	ttb=$(echo -e "\n Затем запустите # reload_cash\n" ; echo ;) && bpn_p_lang  ; ttb="" ;

return ; } ; msg15=(msg15)




function lang_def() {
	lang=nix ;
}

#else # НЕ_СТИРАТЬ # echo -en "\n Отладка: Показывать дебаг сообщения. " ;




function lang_def() {
	lang=bash ;
}


function msg1() {
	echo ;
	ttb=$(echo -e " up_sec=120 IN 1 !!! (Если значение \$up_sec содержит целое число, меньше или равное '120' то up_sec=120 ) \n") && lang_def && bpn_p_lang
return ; } ; msg1=(msg1)



function msg2() {
	ttb=$(echo -e "\n function start_msg IN 2 !!! function start_msg\n") && lang_def && bpn_p_lang ; echo ;
return ; } ; msg2=(msg2)



function msg3() {
	ttb=$(echo -e "\n function update_cash IN 3 !!!  \n ") && bpn_p_lang ;
	ttb=$(echo -e "	bash /root/vdsetup.2/bin/utility/.cash_var_update_now.sh ;\n") && lang_nix && bpn_p_lang ; 
	ttb=$(echo -e "\n Updating now! \n") && lang_nix && bpn_p_lang ;
return ; } ; msg3=(msg3)



function msg4() {
	lang_def ;
	ttb=$(echo -e "\n function unit_cash_var_create_and_start IN 4 !!! function unit_cash_var_create_and_start ; exit ; ") && lang=bash && bpn_p_lang ; echo ;
return ; } ; msg4=(msg4)



function msg5() {

	ttb=$(echo -e " function Up_OR_Remove \$1 IN 5 !!! (Если \$1 значение НЕ пустое) if [[ "$1" != '' ]] ; then Up_OR_Remove \"$1\" ; exit  \n") && lang_def && bpn_p_lang ; ttb="" ; echo ;
	
	#принудительно обновить удалить юнит и выключить кеширование	или проверить на правило функции if_then, что интервал обновления должен быть не меньше 120 секунд. затем запустить && unit_cash_var_create_and_start
return ; } ; msg5=(msg5)



function msg6() {
	ttb=$(echo -e " exit IN 6 !!! (Если значение пустое \$up_sec) if [[ "$up_sec" == '' ]]; \n exit ; ") && lang_def && bpn_p_lang  ;
return ; } ; msg6=(msg6)


function msg7() {
	ttb=$(echo -e " function Up_OR_Remove $up_sec IN 7 !!! (если значение \$up_sec НЕ пустое) if [[ "$up_sec" != '' ]] ; Up_OR_Remove $up_sec ; \n") && lang_def && bpn_p_lang  ; echo ;
return ; } ; msg7=(msg7)


function msg8() {
	ttb=$(echo -e " function remove_unit_stop_cashing IN 8 !!! (rm /etc/systemd/system/cash_var.service) .varfunc.sh . \n") && lang_def && bpn_p_lang  ; ttb="" ;
return ; } ; msg8=(msg8)


function msg9() {
	echo -e " Отладка: Введено - $up_sec" ;
return ; } ; msg9=(msg9)


function msg10() {
	ttb=$(echo -e " # Верный ввод, целое число.\n") && lang_nix && bpn_p_lang  ; ttb="" ;
return ; } ; msg10=(msg10)


function msg11() {
	ttb=$(echo -e " копирую переменную в файл echo $up_sec > /tmp/up_sec.txt \n") && lang_nix && bpn_p_lang  ; ttb="" ;
return ; } ; msg11=(msg11)


function msg12() {
	ttb=$(echo -e "\n Зписано в файл /tmp/up_sec.txt: $up_sec\n Читаем из файла: $( cat /tmp/up_sec.txt )" ; echo ;) && lang_nix && bpn_p_lang  ; ttb="" ;
return ; } ; msg12=(msg12)


function msg13() {
	ttb=$(echo -e " function check_inactive_cash_var_service Сервис существует и будет активирован." ; echo ;)  && bpn_p_lang  ; ttb="" ;
return ; } ; msg13=(msg13)

function msg14() {
	ttb=$(echo -e " function check_inactive_cash_var_service Автоматический перезапуск сервиса активен (auto-restart)\n" ; echo ;)  && bpn_p_lang  ; ttb="" ;
return ; } ; msg14=(msg14)


function msg15() {
	ttb=$(echo -e "\n Сначала удалите старый сервис # remove_unit_stop_cashing\n" ; echo ;) && bpn_p_lang  ; ttb="" ;
return ; } ; msg15=(msg15)

function msg16() {
	echo -e " grep activating ${green}НАЙДЕН${nc}\n" ;
return ; } ; msg16=(msg16)

function msg17() {
	echo -e "\n Выход из grep_activating" ;
return ; } ; msg17=(msg17)

function msg18() {
	echo -e " grep activating в файле ${red}НЕ НАЙДЕН ${nc}" ;
return ; } ; msg18=(msg18)


function msg19() {
	echo -e " grep active ${green}НАЙДЕН${nc}\n" ;
return ; } ; msg19=(msg19)


function msg20() {
	echo -e "\n Выход из grep_active" ;
return ; } ; msg20=(msg20)


function msg21() {
	echo -e " grep active     в файле ${red}НЕ НАЙДЕН${nc}"  ;
return ; } ; msg21=(msg21)


function msg22() {
	echo -e " grep inactive ${green}НАЙДЕН${nc}\n" ;
return ; } ; msg22=(msg22)


function msg23() {
	echo -e " Сервис cash_var.service запущен" ;
return ; } ; msg23=(msg23)


function msg24() {
	echo -e " grep inactive   в файле ${red}НЕ НАЙДЕН ${nc}" ;
return ; } ; msg24=(msg24)


function msg25() {
	echo -e "\n Файл: /etc/systemd/system/cash_var.service существует,\n действия не требуются, все и так хорошечно работает..." ;
return ; } ; msg25=(msg25)


function msg26() {
	echo -e " - отрицательный ответ от file_548 и продолжили делать новый юнит ..." ;
return ; } ; msg26=(msg26)



function msg27() {
	echo -e " Едем далше ...\n" ;
return ; } ; msg27=(msg27)



function msg28() {
	 echo -e " с grep_inactive все хорошо." ;
return ; } ; msg28=(msg28)



function msg29() {
	echo -e " Едем далше ...\n" ;
return ; } ; msg29=(msg29)


function msg30() {
	echo -e " с grep_active все хорошо." ;
return ; } ; msg30=(msg30)


function msg31() {
	echo -en " Выход function preload_check" ;
return ; } ; msg31=(msg31)


function msg32() {
	echo -e " с grep_active все хорошо." ;
return ; } ; msg32=(msg32)



 fi ; 

echo -e "$debug_msg \n"
 	

	  
	 function check_cash_var_service_grep_activating() {
			
			((systemctl status cash_var.service | grep activating ;) && ${msg16} && ${msg14} && ${msg17} &&  exit 0 ; ) || ${msg18} ;
	  }
	 
	 function check_cash_var_service_grep_active() {
			
			((systemctl status cash_var.service | grep active ;) && ${msg19} && ${msg14} && ${msg20} && exit 0 ; ) || ${msg21} ;
		}
	 function check_cash_var_service_grep_inactive() {
			
			((systemctl status cash_var.service | grep inactive ;) && ${msg22} && ${msg13} && echo && (systemctl start cash_var.service ;) && ${msg23} && exit 0 ) || ${msg24} ;
	 }
		 
	  function file_cash_var_service() {
		  
		  ls /etc/systemd/system/cash_var.service &>/dev/null && ${msg25} && ${msg15} && exit 0 || ${msg26} ;
	  }	 
		 
		 
	 function preload_check() {
			 check_cash_var_service_grep_inactive && ${msg27} || ( ${msg28} && exit 0 ; ) ;
			 check_cash_var_service_grep_active && ${msg29} || ( ${msg30} && exit 0 ; ) ;
			 check_cash_var_service_grep_activating && ${msg31} && file_cash_var_service || ( ${msg32} && exit 0 ; ) ;
			 
			  #&& exit || return ;
			 
			 
			 # 
		 }	
 
	function if_then() {
		# Если $up_sec содержит целое число, меньше или равное '120' то up_sec=120. Если убрать знак "!" то условие изменится наоборот.
		
		lang_def ; ${msg9} ;
		if 
		[ ! $up_sec -ge 120 ]; 
		then
		up_sec=120 && ${msg1} ; else ${msg10} ; return ;
		fi 
	}
 
 


function start_msg() {
	
	help_Up_OR_Remove ;
	
	lang_def ; ${msg2} ;
	
	echo -e "\n $(black_U23A7 ) " ;
	echo -en " $(white_1     ) " && ttb=$( echo -e " Укажите время в секундах, как часто обновлять ") && lang="nix" && bpn_p_lang ;
	echo -en " $(white_1     ) " && ttb=$( echo -e " ip адрес tor на актуальность?") && lang="nix" && bpn_p_lang ;
	echo -en " $(white_1     ) " && ttb=$( echo -e " Обновление будет происходить в фоновом режиме.") && lang="nix" && bpn_p_lang ;
	echo -en " $(white_1     ) " && ttb=$( echo -e " (интервал от 120 до 299 сек. или up, rm.)") && lang="nix" && bpn_p_lang ;
	echo -en " $(red_1       )  : ${green}" ; read up_sec 
	echo -en " $(blue_1      ) " && ttb=$( echo -e " Вы выбрали: $up_sec.") && lang="nix" && bpn_p_lang ;
	echo -en " $(cyan_1      ) " && ttb=$( echo -e " Удалить и оставновить сервис можно командой:") && lang="nix" && bpn_p_lang ;
	echo -e " $(white_1     ) " ;
	echo -en " $(white_1     )  $(red_U0023)" && ttb=$(echo -e " remove_unit_stop_cashing" ) && lang="nix" && bpn_p_lang ; ttb='' ;
	echo -e " $(white_1     ) " ;
	echo -e " $(black_U23A9 )\n" ;
	return ;
} 


function update_cash() {
		 lang_def ; ${msg3} ;
		
		/root/vdsetup.2/bin/utility/.cash_var_update_now.sh ;
		
		
	exit 1 ; 
}



# Смотрим его статус systemctl status cash_var.service
function unit_cash_var_create_and_start() {
	
	${msg9}
	
	
	${msg11}
	echo $up_sec > /tmp/up_sec.txt ;
	${msg12}
	lang_def ; ${msg4} ;
	
	
	echo -e "[Unit]
Description=Poll something each $up_sec second

[Service]
Type=simple
ExecStart=/root/vdsetup.2/bin/utility/.cash_var_update_now.sh
Restart=always
RestartSec=$up_sec
StartLimitInterval=0

[Install]
WantedBy=multi-user.target" > /etc/systemd/system/cash_var.service ;

# Unit Системные юниты systemd
# https://habr.com/ru/company/southbridge/blog/255845/


	OUTPUT_systemctl="$(systemctl enable cash_var.service)" &>/dev/null ;
	
	
	
 	( ttb=$(echo -e "\n Service cash_var.service Enabled\n Update Tor Ip every $up_sec seconds.\n To change update time run: # $0" ) && lang_nix && bpn_p_lang && lang_def ) || ttb=$(echo -e " $OUTPUT_systemctl") && bpn_p_lang && lang="" && lang_def ;
	
	 lang_def ;
	
	systemctl daemon-reload ;
	systemctl restart cash_var.service || systemctl start cash_var.service ; echo ;
	systemctl status cash_var.service ;
	 
	exit ;
} ;




function help_Up_OR_Remove() {
	echo -en "" ;
	ttb=$(echo -e " # $0 с ключами:   \n up | update | -up | --update - принудительно обновить \n rm | remove | -rm | --remove - удалить юнит и выключить кеширование	\n # systemctl status cash_var.service - статус юнита.\n") && lang_nix && bpn_p_lang ;
}

function Up_OR_Remove() {
		
		
			#help_Up_OR_Remove ;
			#read a
			case $1 in
			
			up | update | -up | --update ) update_cash ; exit  ;;
			rm | remove | -rm | --remove ) remove_unit_stop_cashing ; exit  ;;
			
			*) 
			preload_check ;
			([[ $1 == ?(-)+([[:digit:]]) ]] && ttb=$(echo -e "\n Вы установили обновление файла кеша ip Tor через каждые $1 сек.\n Оптимальное время обновления не чаще 1 раза в 120 сек. ") && lang_nix && bpn_p_lang  && up_sec=$1 && if_then && lang_def &&  unit_cash_var_create_and_start || ttb=$(echo -e "\n \"$1\"  Не правильный ввод, будет установлено значение по умолчанию в 125 секунд!\n") && lang_nix && bpn_p_lang  ; up_sec=125 ; lang_def && unit_cash_var_create_and_start $up_sec ) ; lang_def ; exit ;;
			
			
		    
			
			esac
			
	}



#preload_check


if [[ "$1" != '' ]] ; 
then echo -en "" && lang_def ; ${msg5} ; Up_OR_Remove $1 ;  
exit ;
fi 

start_msg ;

if [[ "$up_sec" == '' ]] ; 
then lang_def ; ${msg6} ; exit ; 
fi 


if [[ "$up_sec" != '' ]] ; 
then lang_def ; ${msg7} ; Up_OR_Remove $up_sec;
fi 



[[ -n /etc/systemd/system/cash_var.service ]] &>/dev/null && lang_def && systemctl status cash_var.service 2>/dev/null || lang_def ; unit_cash_var_create_and_start ;


# ttb=$(echo -e "Вы выбрали:") && lang="nix" && bpn_p_lang ;
ttb=$(echo -e "\n # systemctl status cash_var.service\n   view status\n ") && lang_def && bpn_p_lang ; 




exit 0 ; 



# https://habr.com/ru/company/southbridge/blog/255845/

#https://github.com/hightemp/docLinux/blob/master/articles/Условия%20в%20скриптах%20bash%20(условные%20операторы).md?ysclid=latligducx329041784






