#!/bin/bash

# Source global definitions
# --> Прочитать настройки из /root/.bashrc
. /root/.bashrc


# --> Эта ссылка на функцию проверяет, запущен-ли скрипт с правами суперпользователя (root) в Linux.
. /root/vdsetup.2/bin/functions/run_as_root.sh ;

  echo ;

ttb=$(echo -e "
 ⎧ Проверка установки nginx repo:
 ⎩ # nginx_repo_Check_or_install
 ") && lang=cr && bpn_p_lang ; ttb="" ;

nginx_repo_Check_or_install ; 

ttb=$(echo -e "
 ⎧ Проверка установки epel repo:
 ⎩ # epel_repo_Check_or_install
 ") && lang=cr && bpn_p_lang ; ttb="" ;
 
epel_repo_Check_or_install ;

  ttb=$(echo -e "
 ⎧ Установка Certbot:
 ⎩ # dnf install certbot python3-certbot-nginx
  ") && lang=cr && bpn_p_lang ; ttb="" ;

dnf install certbot python3-certbot-nginx ;

  ttb=$(echo -e "
 ⎧ Устанавливаем Let’s Encrypt на Nginx.
 | После установки certbot следующим шагом будет
 | установка сертификата. Устанавливаем сертификат 
 | Let’s Encrypt с помощью следующей команды:
 |
 ⎩ # sudo certbot --nginx -d domain
  ") && lang=cr && bpn_p_lang ; ttb="" ;
 
  ttb=$(echo -en "
 ⎧ Введите имя домена для которого вы хотите
 | получить TLS сертификат Let’s Encrypt") && lang=cr && bpn_p_lang ; echo -en " ⎩ : ${green}" && read domain 

echo -e "${nc}" ;
certbot --nginx -d $domain ;

  ttb=$(echo -e "
 ⎧ Сначала введите адрес электронной почты 
 | администратора сайта. Затем примите условия 
 ⎩ лицензии, после чего процесс продолжится.
  ") && lang=cr && bpn_p_lang ; ttb="" ;


  ttb=$(echo -e "
 ⎧ На этом все, сертификат получен и установлен.
 ⎩ # tldr certbot
  ") && lang=cr && bpn_p_lang ; ttb="" ;
  
tldr certbot ;


















 
exit 0 ;

