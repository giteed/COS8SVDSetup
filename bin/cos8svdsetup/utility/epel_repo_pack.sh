#!/bin/bash

# Source global definitions
# --> Прочитать настройки из /root/.bashrc
. ~/.bashrc



  function epel_repo_pack()
  {
 
	
	ttb=$( echo -e "\n Установка дополнительных пакетов: epel-release, iptables, python3, ruby, npm, unzip, hstr, lsof, screen, tar, p7zip, mc, nano, whois, wget, curl, atop, htop, nethogs, bpytop, iftop, stacer, yum-utils, net-tools, network-scripts, git, dialog, mlocate qrencode, ncdu, ranger, tldr, whois. \n" ) && bpn_p_lang ; echo ; echo ;
	
	dnf install git tar curl wget whois -y 
	dnf install -y epel-release 
	dnf install -y net-tools network-scripts 
	dnf install -y dialog mlocate ncdu ranger tldr 
	
	( ( yum install -y iptables qrencode python3 ruby npm unzip hstr lsof screen p7zip mc nano whois atop htop nethogs bpytop iftop stacer yum-utils  -y ) ) && ( ( echo -e "\n Установка дополнительных пакетов завершена!" ) && ( echo -e " ($( green_tick )) - packages plus${RED}   | ${NC}посмотреть список пакетов в системе ypr -rl"  ) ) || ( error_MSG ; ) ;
	
	dnf install -y ncdu ;
	dnf install -y @perl perl perl-Net-SSLeay openssl perl-IO-Tty perl-Encode-Detect ;
	
	
	
  }

epel_repo_pack ;


exit 0 ; 
