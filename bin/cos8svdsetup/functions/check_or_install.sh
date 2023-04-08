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
      [[ -z $(cat /etc/yum.repos.d/epel.repo 2>/dev/null) ]] && ( dnf -y install epel-release tar 2>/dev/null && msg_in1 || msg_in2 ) || msg_in3 ;
      
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

        ( [[ -n $(type /usr/local/bin/bat 2>/dev/null) ]] && msg_in3 || /root/vdsetup.2/bin/utility/install/bat_install.sh bat_install && msg_in1 ) || msg_in2 ;
      
}


# Функция: Скрипт проверяет файл .screenrc на существование, а так же на присутствие в нем записи необходимой для работы колеса мышки в окне терминала. После добавления этой записи в .screenrc проматывать содержимое экрана в screen станет гораздо удобнее.
  function ch_screen()
  {
    ( echo -e \n" Проверяем файл /root/.screenrc на существование, а так же на присутствие\n в нем записи необходимой для работы колеса мышки в окне терминала.\n После добавления этой записи в .screenrc проматывать содержимое экрана\n в screen станет удобнее! \n" ) ;
    
    if 
      [[ $(grep 'termcapinfo \* ti@:te@' /root/.screenrc| head -n 1) == 'termcapinfo * ti@:te@' ]] 2> /dev/null
     then 
      echo -e "${GREEN} Файл .screenrc уже настроен ${NC}..."
     else 
      touch /root/.screenrc && echo -e 'termcapinfo * ti@:te@' >> /root/.screenrc && echo -e ${NC} " Добавляем запись для ${RED}screen ${NC}..."
    fi 
    
    
  }


   function nginx_repo_Check_or_install() {
       
       yum_nginx=nginx.repo
       
       function msg_in1() {
          ttb=$(echo -e " $yum_nginx успешно установлен.") && lang="nix" && bpn_p_lang ;
       }
       
       function msg_in2() {
          ttb=$(echo -e " Ошибка установки. $yum_nginx") && lang="nix" && bpn_p_lang ;
       }
       
       function msg_in3() {
          ttb=$(echo -e " $yum_nginx уже был установлен.") && lang="nix" && bpn_p_lang ;
       }
       
       
        [[ -z $( cat /etc/yum.repos.d/nginx.repo ) ]] 2>/dev/null && ( vdsetup --nginx && msg_in1 || msg_in2 ) || msg_in3 ;
        return ;
    }
   

   function ramfetch_install() {
     /root/vdsetup.2/bin/utility/ramfetch.sh install
   }
   
   function ramfetch_remove() {
     /root/vdsetup.2/bin/utility/ramfetch.sh remove
   }


    function snap_install() {
      /root/vdsetup.2/bin/utility/install/snap_install.sh ;
    }


