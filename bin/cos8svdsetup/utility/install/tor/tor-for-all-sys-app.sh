
#!/bin/bash

# Source global definitions
# --> Прочитать настройки из /root/.bashrc
. /root/.bashrc

echo test 123;

debug_stat=0 # дебаг выключен, чтобы включить измените на 1

# Функция cash_var_sh_150_start_and_stop включает и отключает кеширование ip адреса тора и версии vdsetup на 150 секунд.
cash_var_sh_150_start_and_stop

if [[ $debug_stat == '0' ]] ; 
then test ;



function lang_def() {
	lang=nix ;
}


function msg7() {
#
echo ;
ttb=$(echo -e "$( python2 /root/vdsetup.2/bin/utility/install/tor/toriptables2.py -h 2>/dev/null)"  ) && lang="help" && bpn_p_lang && return ; } ; msg7=(msg7)	


function msg8() {
#echo ;
ttb=$(echo -e "$( python2 /root/vdsetup.2/bin/utility/install/tor/toriptables2.py -f 2>/dev/null )") && lang=".git" && bpn_p_lang && tor_check_ip && return ; } ; msg8=(msg8)	


function msg9() {
	#echo ;
	tor_check_ip ;
	
	#ttb=$(echo -e "$( python2 /root/vdsetup.2/bin/utility/install/tor/toriptables2.py -i 2>/dev/null )") && lang=".git" && bpn_p_lang && echo && ( ttb=$(echo -e " # curl -s 2ip.ua\n" ) && lang_nix && bpn_p_lang ; ) && ( ttb=$( curl -s 2ip.ua ) && lang_nix && bpn_p_lang ; ) && (echo) ; ( ttb=$(echo -e " # curl -s --socks5 127.0.0.1:${tor_port} 2ip.ua\n" ) && lang_nix && bpn_p_lang ; ) && ( ttb=$( curl -s --socks5 127.0.0.1:${tor_port} 2ip.ua ) && lang_nix && bpn_p_lang ; ) && return ; 
	} ; msg9=(msg9)	

function msg10() {
		
		tor_check_ip ;
		
		
		
		#echo ;
		#( python2 /root/vdsetup.2/bin/utility/install/tor/toriptables2.py -r ) ; (echo) ; ( ttb=$(echo -e " # curl -s 2ip.ua\n" ) && lang_nix && bpn_p_lang ; ) && ( ttb=$( curl -s 2ip.ua ) && lang_nix && bpn_p_lang ; ) && (echo) ; ( ttb=$(echo -e " # curl -s --socks5 127.0.0.1:${tor_port} 2ip.ua\n" ) && lang_nix && bpn_p_lang ; ) && ( ttb=$( curl -s --socks5 127.0.0.1:${tor_port} 2ip.ua ) && lang_nix && bpn_p_lang ; )
	} ; msg10=(msg10)


else # НЕ_СТИРАТЬ # echo -en "\n Отладка: Показывать дебаг сообщения. " ;
#clear ; css ; 



function lang_def() {
	lang=bash ;
}


function msg1() {
	echo ;
	ttb=$(echo -e " 1.0) function enable_tor_for_all_app_in_this_system ") && lang_def && bpn_p_lang && return ; } ; msg1=(msg1)


function msg2() {
	#echo ;
	ttb=$(echo -e " 2.0) function install_toriptables2_py \n") && lang_def && bpn_p_lang && return ; } ; msg2=(msg2)


function msg3() {
	#echo ;
	ttb=$(echo -e " m.3) toriptables2.py Not found, download from DropBox.\n") && lang_nix && bpn_p_lang && return ; } ; msg3=(msg3)


function msg4() {
	#echo ;
	ttb=$(echo -e "\n m.4) function enable_tor_for_all_app_in_this_system\n      Done!\n") && lang_nix && bpn_p_lang && echo && return ; } ; msg4=(msg4)


function msg5() {
	#echo ;
	ttb=$(echo -e "\n m.5) Flushes the iptables rules to default!\n") && lang_nix && bpn_p_lang && return ; } ; msg5=(msg5) ;


function msg6() {
	#echo ;
	ttb=$(echo -e "\n m.6) function install_toriptables2_py\n      Install from DropBox, Done!\n") && lang_nix && bpn_p_lang && return ; } ; msg6=(msg6)
	

function msg7() {
	#echo ;
	ttb=$(echo -e "$( python2 /root/vdsetup.2/bin/utility/install/tor/toriptables2.py -h 2>/dev/null )") && lang="help" && bpn_p_lang && return ; } ; msg7=(msg7)	


function msg8() {
	#echo ;
	ttb=$(echo -e "$( python2 /root/vdsetup.2/bin/utility/install/tor/toriptables2.py -f 2>/dev/null )") && lang=".git" && bpn_p_lang && tor_check_ip && return ; } ; msg8=(msg8)	

function msg9() {
	#echo ;
	tor_check_ip ;
	
	#ttb=$(echo -e "$( python2 /root/vdsetup.2/bin/utility/install/tor/toriptables2.py -i 2>/dev/null )") && lang=".git" && bpn_p_lang && echo && ( ttb=$(echo -e " # curl -s 2ip.ua\n" ) && lang_nix && bpn_p_lang ; ) && ( ttb=$( curl -s 2ip.ua ) && lang_nix && bpn_p_lang ; ) && (echo) ; ( ttb=$(echo -e " # curl -s --socks5 127.0.0.1:${tor_port} 2ip.ua\n" ) && lang_nix && bpn_p_lang ; ) && ( ttb=$( curl -s --socks5 127.0.0.1:${tor_port} 2ip.ua ) && lang_nix && bpn_p_lang ; ) && return ; 
	} ; msg9=(msg9)	

function msg10() {
		
		tor_check_ip ;
		
		
		
		#echo ;
		#( python2 /root/vdsetup.2/bin/utility/install/tor/toriptables2.py -r ) ; (echo) ; ( ttb=$(echo -e " # curl -s 2ip.ua\n" ) && lang_nix && bpn_p_lang ; ) && ( ttb=$( curl -s 2ip.ua ) && lang_nix && bpn_p_lang ; ) && (echo) ; ( ttb=$(echo -e " # curl -s --socks5 127.0.0.1:${tor_port} 2ip.ua\n" ) && lang_nix && bpn_p_lang ; ) && ( ttb=$( curl -s --socks5 127.0.0.1:${tor_port} 2ip.ua ) && lang_nix && bpn_p_lang ; )
	} ; msg10=(msg10)



fi ;



# 1.0
function enable_tor_for_all_app_in_this_system() {
	
	${msg1} ; echo ;
	
	( ( python2 /root/vdsetup.2/bin/utility/install/tor/toriptables2.py -l 2>/dev/null ) && echo && ttb=$( curl -s 2ip.ua ) && lang_nix && bpn_p_lang ) && ${msg4}  || return ;
}

# 2.0
function install_toriptables2_py() {
	
	${msg2} ;
	
	[[ -z $( ls /root/vdsetup.2/bin/utility/install/tor/toriptables2.py ) ]] 2>/dev/null && cd /root/vdsetup.2/bin/utility/install/tor/ && wget -q https://www.dropbox.com/s/14x9ggq5pzj679o/toriptables2.py && chmod +x toriptables2.py && ${msg6} && enable_tor_for_all_app_in_this_system ; 
}



function l_load() {
	( ${msg5} ; python2 /root/vdsetup.2/bin/utility/install/tor/toriptables2.py -f &>/dev/null ) && (${msg7} ; echo ) && ( enable_tor_for_all_app_in_this_system ) || ( ${msg3} ; echo ; install_toriptables2_py ; )
}


[[ -z $( ls /root/vdsetup.2/bin/utility/install/tor/toriptables2.py ) ]] 2>/dev/null && install_toriptables2_py ;
[[ -z $( ls /usr/bin/python2 ) ]] 2>/dev/null && dnf install -y python2 &>/dev/null ; 


if [[ $1 == "" ]] ; then ${msg7} && exit ; fi ;
if [[ $1 == "-h" ]] ; then ${msg7} && exit ; fi ;
if [[ $1 == "-f" ]] ; then ${msg7} && echo && ${msg8} ; exit ; fi ;
if [[ $1 == "-i" ]] ; then ${msg7} && echo && ${msg9} ; exit ; fi ;
if [[ $1 == "-r" ]] ; then ${msg7} && echo && ${msg10} ; exit ; fi ;
if [[ $1 == "-l" ]] ; then echo && l_load ; fi ;



exit 0 ; 

# https://hackware.ru/?p=3138
# toriptables2.py
# https://kali.tools/?p=3278
