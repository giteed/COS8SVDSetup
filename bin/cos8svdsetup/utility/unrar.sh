#!/bin/bash

# Source global definitions
# --> Прочитать настройки из /root/.bashrc
. /root/.bashrc


# ФУНКЦИЯ: выводит UnrarOK так как файл /usr/bin/unrar найден 
function UnrarOK() 
{ 
	echo -e " ($( green_tick )) - forensics-Unrar ${RED}|${NC} ($( green_tick )) " ; 
}

# ФУНКЦИЯ: файл /usr/bin/unrar НЕ найден установка forensics REPO и unrar
function UnrarIN() 
{ 
	( echo -e " Установка forensics REPO, Unrar. \n" ;
	mkdir -p /tmp/installer/rar && cd /tmp/installer/rar && wget https://forensics.cert.org/cert-forensics-tools-release-el8.rpm && rpm -Uvh cert-forensics-tools-release*rpm && yum-config-manager --enable forensics )  ;
	( ( dnf install unrar -y )  || ( ( echo -en " функция установки UnrarIN: " )  && ( error_MSG ; ) ) ) ;
	( cd /tmp/ && rm -rf /tmp/installer/rar )  ;
	
	( echo -en " " &&  (( unrar -v | grep UNRAR | awk ' { print $1, $2, $3 }' ) 2>/dev/null ) && ( echo -e "\n $( green_tick )${GREEN} Forensics REPO, Unrar установлены.${NC}\n") && ( echo -e " ($( green_tick )) - forensics-Unrar${RED} | $( green_OK ) # ypr -rl " )) && UnrarOK || ( ( echo -en " функция установки UnrarIN: " )  && ( error_MSG ; ) ) ;
}


# ФУНКЦИЯ: Проверка на наличие Rar / Unrar или установка
function UnrarCH()
{
	[[ -f /usr/bin/unrar ]] 2>/dev/null && UnrarOK || UnrarIN ;
}

# Проверка на наличие Rar / Unrar или установка
UnrarCH || UnrarIN ;

exit 0 ; 
