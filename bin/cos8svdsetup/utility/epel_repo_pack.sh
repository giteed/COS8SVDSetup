#!/bin/bash

# Source global definitions
# --> Прочитать настройки из /root/.bashrc
. ~/.bashrc


 function epel_repository_packages_install() {
	 dnf install -y epel-release yum-utils npm || ( error_MSG ; ) ; echo ;
	 dnf install -y net-tools network-scripts iptables || ( error_MSG ; ) ; echo ;
	 dnf install -y dialog mlocate ncdu ranger tldr || ( error_MSG ; ) ; echo ;
	 dnf install -y youtube-dl ffmpeg || ( error_MSG ; ) ; echo ;
	 dnf install -y git tar curl wget || ( error_MSG ; ) ; echo ;
	 dnf install -y whois || ( error_MSG ; ) ; echo ;
	 dnf install -y atop htop bpytop iftop stacer lsof nethogs  || ( error_MSG ; ) ; echo ;
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
	   packages_plus ;
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
	  
	  
	   [[ -z $(cat /etc/yum.repos.d/epel.repo 2>/dev/null) ]]  && ( dnf install epel-release 2>/dev/null && msg_in1 || msg_in2 ) || msg_in3 ;
	   
	   #return ;
   }

  function epel_repository_packages()
  {
	ttb=$( echo -e "
 ⎧ Установка дополнительных пакетов: 
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
 ${GREEN}| ${NC}посмотреть список пакетов в системе # ypr -rl
 ⎩ \"Epel Repository Packages\" installed $(green_tick)"
	
  }
  
  epel_repository_packages ;

exit 0 ; 

















Скачивание YouTube видео youtube-dl

После установки, достаточно просто указать ссылку, youtube-dl загрузит видео и сохранит его в формате mp4 / flv.


youtube-dl https://www.youtube.com/watch?v=dQw4w9WgXcQ
Скачивание видео с YouTube в разных форматах

Большинство видео на YouTube доступны в разных форматах и разном качестве. Для начала необходимо проверить какие форматы доступны


youtube-dl -F https://www.youtube.com/watch?v=dQw4w9WgXcQ
youtube-dl -F https://www.youtube.com/watch?v=dQw4w9WgXcQ

Выбираем необходимый формат и скачиваем его


youtube-dl -f 140 https://www.youtube.com/watch?v=dQw4w9WgXcQ
Пакетное скачивание видео с YouTube

для скачивания множества видео с YouTube используем параметр -a

youtube-dl -a video.list.txt
Извлечь аудио (MP3) из видео YouTube

Если необходимо извлечь звук видео и сохранить его в аудио формате (mp3), необходимо установить ffmpeg, после этого можно будет конвертировать видео YouTube в аудио файлы.


youtube-dl https://www.youtube.com/watch?v=dQw4w9WgXcQ --extract-audio --audio-format mp3
