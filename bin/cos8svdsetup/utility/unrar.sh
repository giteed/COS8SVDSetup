#!/bin/bash

# Source global definitions
# --> Прочитать настройки из /root/.bashrc
. ~/.bashrc


	function UnrarOK() 
{ 
	echo -e " ($( green_tick )) - forensics-Unrar ${RED}|${NC} ($( green_tick )) " ; 
}


# ФУНКЦИЯ: файл /usr/bin/unrar НЕ найден установка forensics REPO и unrar
function UnrarIN() 
{ 
	( echo -e " Установка forensics REPO, Unrar. \n" ;
	mkdir -p /tmp/installer/rar && cd /tmp/installer/rar && wget https://forensics.cert.org/cert-forensics-tools-release-el8.rpm && rpm -Uvh cert-forensics-tools-release*rpm && yum-config-manager --enable forensics ) &>/dev/null ;
	( ( dnf install unrar -y ) &>/dev/null || ( ( echo -en " функция установки UnrarIN: " )  && ( error_MSG ; ) ) ) ;
	( cd /tmp/ && rm -rf /tmp/installer/rar ) &>/dev/null ;
	
	( echo -en " " &&  (( unrar -v | grep UNRAR | awk ' { print $1, $2, $3 }' ) 2>/dev/null ) && ( echo -e "\n $( green_tick )${GREEN} Forensics REPO, Unrar установлены.${NC}\n") && ( echo -e " ($( green_tick )) - forensics-Unrar${RED} | $( green_OK ) ypr -rl " )) || ( ( echo -en " функция установки UnrarIN: " )  && ( error_MSG ; ) ) ;
}

UnrarIN

exit 0 ; 
