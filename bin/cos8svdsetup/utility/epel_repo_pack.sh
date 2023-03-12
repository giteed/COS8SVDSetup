#!/bin/bash

# Source global definitions
# --> Прочитать настройки из /root/.bashrc
. ~/.bashrc

  function epel_repo_pack()
  {
	ttb=$( echo -e "\n Установка дополнительных пакетов: 
	epel-release, iptables, python3, ruby, npm, unzip, 
	hstr, lsof, screen, tar, p7zip, mc, nano, whois, 
	wget, curl, atop, htop, nethogs, bpytop, iftop, 
	stacer, yum-utils, net-tools, network-scripts, git, 
	dialog, mlocate qrencode, ncdu, ranger, tldr, whois, 
	youtube-dl. \n" ) && bpn_p_lang ; echo ;
	
	press_enter_to_continue_or_ESC_or_any_key_to_cancel ;
	
	dnf install -y epel-release yum-utils npm || ( error_MSG ; ) ; echo ;
	dnf install -y net-tools network-scripts iptables || ( error_MSG ; ) ; echo ;
	dnf install -y dialog mlocate ncdu ranger tldr || ( error_MSG ; ) ; echo ;
	dnf install -y youtube-dl || ( error_MSG ; ) ; echo ;
	dnf install -y git tar curl wget || ( error_MSG ; ) ; echo ;
	dnf install -y whois || ( error_MSG ; ) ; echo ;
	dnf install -y atop htop bpytop iftop stacer lsof nethogs  || ( error_MSG ; ) ; echo ;
	dnf install -y python3 ruby  || ( error_MSG ; ) ; echo ;
	dnf install -y mc nano hstr ncdu || ( error_MSG ; ) ; echo ;
	dnf install -y unzip p7zip || ( error_MSG ; ) ; echo ;
	dnf install -y screen qrencode || ( error_MSG ; ) ; echo ;
	dnf install -y @perl perl perl-Net-SSLeay perl-Encode-Detect openssl || ( error_MSG ; ) ; echo ;
	dnf install -y perl-IO-Tty || ( error_MSG ; ) ; echo ;
	
	echo -e "\n Установка дополнительных пакетов завершена!" 
	echo -e " ($( green_tick )) - packages plus${RED}   | ${NC}посмотреть список пакетов в системе ypr -rl"   
	
  }
  
  epel_repo_pack ;

exit 0 ; 
