#!/bin/bash

# Source global definitions
# --> Прочитать настройки из /root/.bashrc
. /root/.bashrc
 

#------------------------------------
# WEBMIN
#------------------------------------ 

# ФУНКЦИЯ: Информация о webmin с проверками:
# Проверка установки webmin repo и вывод информации о вебмине на этом сервере
# Если webmin repo не найден (webminRepoCH) - пишет в отчет "не найден" или выдает его версию
# Если вебмин не найден поля в отчете IP URL Login Password = "не найден" 
 function webmininfo() {
   
   echo -en "\n $(black_U23A7 ) " ;  ttb=$(echo -e " Проверка установки WEBMIN") && bpn_p_lang ;
   echo -en " $(black_U23A9 ) " ;  echo -en " Webmin version : " ; webmin -v 2>/dev/null || not_found_MSG ;
   
   

 function info_ifOK() {
    
    echo -e "\n $(black_U23A7 ) " ;
    echo -en " $(green_U23A6  ) " ; echo -en " Webmin IP      : " ; ttb="$( echo -e "https://$( ifconfig_real_ip ):10000/" )" && lang="passwd" && bpn_p_lang ;
    echo -en " $(green_U23A6  ) " ; echo -en " Webmin URL     : " ; ttb="$( echo -e "https://$( hostname ):10000/" )" && lang="passwd" && bpn_p_lang ;
    echo -en " $(purple_U23A6 ) " ; echo -e " Login          : ${CYAN}root ${NC}" ;
    echo -en " $(purple_U23A6 ) " ; echo -e " Password       : ${RED}root_password${NC} " ;
    echo -e " $(black_U23A9   ) " ; 
 }
 
 function info_ifNO() {
   
    echo -e "\n $(black_U23A7 ) " ;
    echo -en " $(green_U23A6  ) " ; echo -en " Webmin IP      : " ; echo -e "$( not_found_MSG )" ;
    echo -en " $(green_U23A6  ) " ; echo -en " Webmin URL     : " ; echo -e "$( not_found_MSG )" ;
    echo -en " $(purple_U23A6 ) " ; echo -en " Login          : " ; echo -e "$( not_found_MSG )" ;
    echo -en " $(purple_U23A6 ) " ; echo -en " Password       : " ; echo -e "$( not_found_MSG )" ;
    echo -e " $(black_U23A9   ) " ;
 }
 
   [[ -z $( ls /usr/bin/webmin ) ]] 2>/dev/null && info_ifNO || info_ifOK ;
   
   open_port_and_services_firewall ;
   
 }
 
# ФУНКЦИЯ: Просмотр лога установки webmin 
 function webmin_install.log() {
   
   ttb=$(cat /tmp/webmin_install.log) 2>/dev/null && bpn_p_lang || ttb=$(echo -en " webmin_install.log:") && bpn_p_lang && $(not_found_MSG) ; echo ;
 }
 
 function webmin_install() {
    
 ttb=$(echo -en "\n ⎧ Приступаем к установке и настройке:
 | WEBMIN, FirewallD
 | 
 | 1. Добавляем репозиторий " ) && lang="nix" && bpn_p_lang ;  
 
 touch /etc/yum.repos.d/webmin.repo ;
 echo "[Webmin]" > /etc/yum.repos.d/webmin.repo ;
 echo "name=Webmin Distribution Neutral" >> /etc/yum.repos.d/webmin.repo ;
 echo "#baseurl=https://download.webmin.com/download/yum" >> /etc/yum.repos.d/webmin.repo ;
 echo "mirrorlist=https://download.webmin.com/download/yum/mirrorlist" >> /etc/yum.repos.d/webmin.repo ;
 echo "enabled=1" >> /etc/yum.repos.d/webmin.repo ;
 echo "gpgkey=https://download.webmin.com/jcameron-key.asc" >> /etc/yum.repos.d/webmin.repo ;
 echo "gpgcheck=1" >> /etc/yum.repos.d/webmin.repo ;
 
 # Сайт установки вебмина https://www.webmin.com/rpm.html
 
 ttb=$(echo -en " | 2. Импоритуем GPG ключ" ) && lang="nix" && bpn_p_lang ; 
 
 wget https://download.webmin.com/jcameron-key.asc &>/dev/null  ;
 rpm --import http://www.webmin.com/jcameron-key.asc &>/dev/null ;
 
 ttb=$(echo -en " | 3. Устанавливаем perl модули и openssl" ) && lang="nix" && bpn_p_lang ; 
 
 dnf -y install perl perl-Net-SSLeay openssl perl-IO-Tty perl-Encode-Detect &>/dev/null ;
 
 ttb=$(echo -en " | 4. Устанавливаем WEBMIN \n ⎩    Пожалуйста подождите..." ) && lang="nix" && bpn_p_lang ; 
 
 mkdir -p /root/temp/ ; cd /root/temp/ ; 
 #wget -q http://prdownloads.sourceforge.net/webadmin/webmin-2.000-1.noarch.rpm ; 
 #rpm -U /root/temp/webmin-2.000-1.noarch.rpm ;
 
 function msg_wait() {
  ttb=$(echo -en " | \n | Пожалуйста подождите...") && lang_nix && bpn_p_lang ; echo ; sleep 1 ;
 }
 
  echo > /tmp/webmin_install.log &>/dev/null ;
 
 ( dnf reinstall -y webmin &>/tmp/webmin_install.log || dnf install -y webmin &>/tmp/webmin_install.log ) || echo -e "\n    $(error_MSG) function webmin_install, try dnf clean packages" ;
 
 ttb=$(echo -en "\n ⎧ После установки WEBMIN запустится автоматически
 | Посмотреть лог установки: # "${0}" -wm.l
 | 5. Добавляем WEBMIN в автозагрузку
 |" ) && lang="nix" && bpn_p_lang ; 

 chkconfig webmin on &>>/tmp/webmin_install.log ;
 
 ttb=$(echo -e " | Чтобы удалить WEBMIN из автозагрузки
 ⎩ # chkconfig webmin of 

 ⎧ 6. Открываем порт для Webmin 10000/tcp и перезапускаем FirewallD
 ⎩ FirewallD перезапускается... " ) && lang="nix" && bpn_p_lang ; 
 echo -e "\n   ${green} $(firewall-cmd --reload) ${nc}" ;
 echo ;

 firewall-cmd --zone=public --permanent --add-service=http &>>/tmp/webmin_install.log ;
 firewall-cmd --zone=public --permanent --add-service=https &>>/tmp/webmin_install.log ;
 firewall-cmd --permanent --zone=public --add-port=10000/tcp &>>/tmp/webmin_install.log ;
 
 
 webmininfo ;
 
 }
 
 
 # ФУНКЦИЯ: webmin найден
 function webminOK() {
   
   webmininfo ;
  }
 
 # ФУНКЦИЯ: webmin НЕ найден
 function webminIN() {
   
 ttb=$(echo -en "\n ⎧ WEBMIN не найден!
 ⎩ Установка WEBMIN.\n" ) && lang="nix" && bpn_p_lang ; 
  
    webmin_install ;
  }
 
# ФУНКЦИЯ: Проверяем наличие, или делаем установку webmin
 function webminCH() {
   
  [[ -z $( ls /usr/bin/webmin ) ]] 2>/dev/null && webminIN || webminOK ;
 }
 
 webminCH ;
 
 exit 0 ;