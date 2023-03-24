#!/bin/bash

lang_x 2>/dev/null ;

# Source global definitions
# --> Прочитать настройки из /root/.bashrc
. /root/.bashrc

# --> Этот ссылка на функцию проверяет, запущен-ли скрипт с правами суперпользователя (root) в Linux.
. /root/vdsetup.2/bin/functions/run_as_root.sh

 function epel_repository_packages_install() {
	 dnf install -y epel-release yum-utils npm || ( error_MSG ; ) ; echo ;
	 dnf install -y net-tools network-scripts iptables || ( error_MSG ; ) ; echo ;
	 dnf install -y dialog mlocate ncdu ranger tldr || ( error_MSG ; ) ; echo ;
	 dnf install -y youtube-dl ffmpeg || ( error_MSG ; ) ; echo ;
	 dnf install -y git tar curl wget || ( error_MSG ; ) ; echo ;
	 dnf install -y whois || ( error_MSG ; ) ; echo ;
	 dnf install -y atop htop bpytop iftop stacer lsof nethogs ripgrep || ( error_MSG ; ) ; echo ;
	 dnf install -y python3 ruby  || ( error_MSG ; ) ; echo ;
	 dnf install -y mc nano hstr ncdu || ( error_MSG ; ) ; echo ;
	 dnf install -y unzip p7zip || ( error_MSG ; ) ; echo ;
	 dnf install -y screen qrencode || ( error_MSG ; ) ; echo ;
	 dnf install -y @perl perl perl-Net-SSLeay perl-Encode-Detect openssl || ( error_MSG ; ) ; echo ;
 }
 
 function epel_repository_packages_Check_or_install() {
	  
	  function msg_install_anyway() {
	   ttb=$(echo -e "\n ⎧ По всей видимости, все программы из epel_repository_packages\n | уже были установлены. Нажмите Enter, если желаете\n ⎩ перепроверить установку, или ESC для выхода. ") && lang="nix" && bpn_p_lang ;
	   press_enter_to_continue_or_ESC_or_any_key_to_cancel ;
	   epel_repository_packages_install ;
      }
	  yum_epel=epel.repo
	  function msg_in3() {
		   ttb=$(echo -e " $yum_epel уже был установлен.") && lang="nix" && bpn_p_lang ;
		   msg_install_anyway ;
	  }
	  
	  function msg_in1() {
		 ttb=$(echo -e " $yum_epel успешно установлен.") && lang="nix" && bpn_p_lang ;
	  }
	  
	  function msg_in2() {
		 ttb=$(echo -e " Ошибка установки. $yum_epel") && lang="nix" && bpn_p_lang ;
	  }
	  
	  
	   [[ -z $(cat /etc/yum.repos.d/epel.repo 2>/dev/null) ]]  && ( dnf install -y epel-release 2>/dev/null && msg_in1 || msg_in2 ) || msg_in3 ;
   }

  function epel_repository_packages()
  {
	ttb=$( echo -e "
 ⎧ Установка дополнительных пакетов \"Epel Repository Packages\": 
 | 
 | epel-release, iptables, python3, ruby, npm, unzip, 
 | hstr, lsof, screen, tar, p7zip, mc, nano, whois, 
 | wget, curl, atop, htop, nethogs, bpytop, iftop, 
 | stacer, yum-utils, net-tools, network-scripts, git, 
 | dialog, mlocate qrencode, ncdu, ranger, tldr, whois, 
 ⎩ youtube-dl, ffmpeg. \n" ) && bpn_p_lang ; echo ;
	
	press_enter_to_continue_or_ESC_or_any_key_to_cancel ;

	epel_repository_packages_Check_or_install || epel_repository_packages_install ;
	
	echo -e " 
 ⎧ Установка дополнительных пакетов завершена!
 ${GREEN}| ${NC}Посмотреть список repo в системе # ypr -rl
 ⎩ \"Epel Repository Packages\" installed $(green_tick)"
	
  }
  
  epel_repository_packages ;
  
  # ФУНКЦИЯ: Установка fzf
   function fzfIN() 
   { 
		   echo -e " Установка fzf." 
		   
		   ( ( git clone --depth 1 https://github.com/junegunn/fzf.git ~/.fzf && ~/.fzf/install --all ) ) && ( echo -e " ${GREEN}Установка fzf завершена${NC}" && echo -e " ($( green_tick )) - fzf version ${RED}    |${NC} $($HOME/.fzf/bin/fzf --version)" && ( echo -e "\n Для обновления настроек введите:\n ${RED}#${NC} source ${CYAN}~/.bashrc\n${NC}" ) ; ) || ( echo -en " Функция fzfIN завешилась с ошибкой: " && error_MSG ; ) ;
		   # &>/dev/null 
   }  
  
  
  # Проверка на наличие fzf или установка fzf
   ( [[ -z $(fzf --version) ]] ) &>/dev/null  && fzfIN || ( echo -e "\n   fzf version $(fzf --version)" );


exit 0 ; 


