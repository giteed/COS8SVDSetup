#!/bin/bash

# Source global definitions
# --> Прочитать настройки из /root/.bashrc
. /root/.bashrc

# --> Эта ссылка на функцию проверяет, запущен-ли скрипт с правами суперпользователя (root) в Linux.
. /root/vdsetup.2/bin/functions/run_as_root.sh

 function epel_repository_packages_install() {
	 
	 function wireguard_tools() {
		 
			# (Вы можете установить WireGuard вручную. Вы можете загрузить исходный код с https://www.wireguard.com/install/, затем распаковать и скомпилировать его в соответствии с инструкциями на странице загрузки.)
			
			# Включить репозиторий PowerTools
			sudo dnf config-manager --enable powertools
			# Установите ключ GPG для репозитория ELRepo:
			sudo rpm --import https://www.elrepo.org/RPM-GPG-KEY-elrepo.org
			# Установите репозиторий ELRepo:
			sudo rpm -Uvh https://www.elrepo.org/elrepo-release-8.el8.elrepo.noarch.rpm
			sudo dnf install kernel-ml wireguard-tools
	    }
	 
		function ffmpeg_install() {
			sudo dnf install https://mirrors.rpmfusion.org/free/el/rpmfusion-free-release-8.noarch.rpm
			sudo dnf install https://mirrors.rpmfusion.org/nonfree/el/rpmfusion-nonfree-release-8.noarch.rpm
			sudo dnf install -y ffmpeg ffmpeg-devel youtube-dl || ( error_MSG ; ) ; echo ;
			return ;
		}	
	 
	 
	 sudo dnf install -y epel-release yum-utils npm || ( error_MSG ; ) ; echo ;
	 sudo dnf install -y net-tools bind-utils network-scripts iptables socat dnstracer nyx || ( error_MSG ; ) ; echo ;
	 sudo dnf install -y dialog mlocate ncdu ranger tldr || ( error_MSG ; ) ; echo ;
	 sudo dnf install -y git tar curl wget jq nc || ( error_MSG ; ) ; echo ;
	 sudo dnf install -y whois || ( error_MSG ; ) ; echo ;
	 sudo dnf install -y tree atop htop bpytop iftop stacer lsof nethogs ripgrep || ( error_MSG ; ) ; echo ;
	 sudo dnf install -y python3 ruby  || ( error_MSG ; ) ; echo ;
	 sudo dnf install -y mc nano hstr ncdu || ( error_MSG ; ) ; echo ;
	 sudo dnf install -y unzip p7zip || ( error_MSG ; ) ; echo ;
	 sudo dnf install -y screen qrencode || ( error_MSG ; ) ; echo ;
	 sudo dnf install -y @perl perl perl-Net-SSLeay perl-Encode-Detect openssl || ( error_MSG ; ) ; echo ;
	 
	 wireguard_tools ;
	 
 }
 
 function epel_repository_packages_Check_or_install() {
	  
	  function msg_install_anyway() {
	   ttb=$(echo -e "\n ⎧ Возможно, что некоторые пакеты уже были установлены.\n | Нажмите Enter, если желаете перепроверить их установку,\n ⎩ или ESC для выхода. ") && lang="nix" && bpn_p_lang ;
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
	  
	  
	   [[ -z $(cat /etc/yum.repos.d/epel.repo 2>/dev/null) ]]  && ( sudo dnf install -y epel-release 2>/dev/null && msg_in1 || msg_in2 ) || msg_in3 ;
   }

  function epel_repository_packages()
  {
	ttb=$( echo -e "
 ⎧ Установка дополнительных пакетов:: 
 | 
 | epel-release, iptables, nyx, python3, ruby, npm, unzip, 
 | hstr, lsof, screen, tar, p7zip, mc, nano, whois, Webmin,
 | wget, curl, jq, nc, atop, htop, nethogs, bpytop, iftop, bat,
 | stacer, yum-utils, net-tools, network-scripts, git, tree,
 | dialog, mlocate qrencode, ncdu, ranger, tldr, whois, 
 ⎩ youtube-dl, ffmpeg. \n" ) && bpn_p_lang ; echo ;
	
	press_enter_to_continue_or_ESC_or_any_key_to_cancel ;

	epel_repository_packages_Check_or_install || epel_repository_packages_install ;
	
	echo -e " 
 ⎧ Установка дополнительных пакетов завершена!
 ${GREEN}| ${NC}Посмотреть список repo в системе # wis -rl
 ⎩ All packages installed $(green_tick)\n"
	
  }

# Проверка или установка epel-release repo и пакетов для 
# первоначальной настройки и удобства работы на сервере
  epel_repository_packages ;

# Bat подсветка синтаксиса кода
   /root/vdsetup.2/bin/utility/install/bat_install.sh ;

# Webmin
   /root/vdsetup.2/bin/utility/install/web-panels/webmin_install.sh ;

# Проверка на наличие fzf или установка fzf
   fzfCH ;

# Функция: проверяет файл .screenrc на существование
   ch_screen ;

# Функция: проверяет или устанавливает Nano (syntax)
   NanoSyntaxCH ;

# Проверка на наличие Rar / Unrar или установка   
   /root/vdsetup.2/bin/utility/install/unrar.sh ;

# Installing snapd
   snap_install ;

# ДОПОЛНИТЕЛЬНЫЕ ПАКЕТЫ:

# Installing ffmpeg, youtube-dl   
#  epel_repository_packages_install ffmpeg_install

# Installing kmod-wireguard-ml, wireguard-tools
# 	sudo dnf install kmod-wireguard-ml wireguard-tools

# Redirect connections through socks4 proxy servers 
# sudo dnf install -y proxychains-ng || ( error_MSG ; ) ; echo ;


exit 0 ; 


