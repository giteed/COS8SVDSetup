#!/bin/bash

# --> Функция проверки существования файла репозитория /etc/yum.repos.d/epel.repo, 
# --> который является индикатором его наличия. 
function epel_repository_Check_or_install() {
# Определяется название репозитория и помещается в переменную yum_epel
      yum_epel=epel.repo 
      
# Функция сообщения, если репозиторий уже установлен
      function msg_in3() { 
# Создание сообщения и установка языка сообщения
         ttb=$(echo -e " $yum_epel уже был установлен.") && lang="nix" && bpn_p_lang ; 
      }
      
# Функция сообщения об успешной установке репозитория
      function msg_in1() { 
# Создание сообщения и установка языка сообщения
         ttb=$(echo -e " $yum_epel успешно установлен.") && lang="nix" && bpn_p_lang ;  
      }
      
# Функция сообщения об ошибке установки репозитория
      function msg_in2() {  
# Создание сообщения и установка языка сообщения
         ttb=$(echo -e " Ошибка установки. $yum_epel") && lang="nix" && bpn_p_lang ; 
      }
      
# Это проверка существования файла репозитория /etc/yum.repos.d/epel.repo, который является индикатором его наличия. 
# Если файл отсутствует, значит репозиторий не установлен. Тогда происходит попытка установить его
      [[ -z $(cat /etc/yum.repos.d/epel.repo 2>/dev/null) ]] && ( dnf install epel-release 2>/dev/null && msg_in1 || msg_in2 ) || msg_in3 ;
      
}


# --> Функция проверки существования файла bat, 
# --> который является индикатором его наличия. 
function bat_Check_or_install() {
# Определяется название репозитория и помещается в переменную bat
      bat=bat 
      
# Функция сообщения, если репозиторий уже установлен
      function msg_in3() { 
# Создание сообщения и установка языка сообщения
         ttb=$(echo -e " $bat уже был установлен.") && lang="nix" && bpn_p_lang ; 
      }
      
# Функция сообщения об успешной установке репозитория
      function msg_in1() { 
# Создание сообщения и установка языка сообщения
         ttb=$(echo -e " $bat успешно установлен.") && lang="nix" && bpn_p_lang ;  
      }
      
# Функция сообщения об ошибке установки репозитория
      function msg_in2() {  
# Создание сообщения и установка языка сообщения
         ttb=$(echo -e " Ошибка установки. $bat") && lang="nix" && bpn_p_lang ; 
      }
      
# Это проверка существования файла репозитория /usr/local/bin/bat, который является индикатором его наличия. 
# Если файл отсутствует, значит bat не установлен. Тогда происходит попытка установить его

        ( [[ -n $(type /usr/local/bin/bat 2>/dev/null) ]] && msg_in3 || /root/vdsetup.2/bin/utility/bat_install.sh bat_install && msg_in1 ) || msg_in2 ;
      
}
