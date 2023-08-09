#!/bin/bash


function epel_repository_Check_or_install() {
  # --> Проверка существования файла репозитория /etc/yum.repos.d/epel.repo, 
  # --> который является индикатором его наличия. 
    
# Определяется название репозитория и помещается в переменную yum_epel
      yum_epel=epel.repo 
      
# Сообщение, если репозиторий уже установлен
      function msg_in3() { 
# Создание сообщения и установка языка сообщения
         ttb=$(echo -e " $yum_epel уже был установлен.") && lang="nix" && bpn_p_lang ; 
      }
      
# Сообщение об успешной установке репозитория
      function msg_in1() { 
# Создание сообщения и установка языка сообщения
         ttb=$(echo -e " $yum_epel успешно установлен.") && lang="nix" && bpn_p_lang ;  
      }
      
# Сообщение об ошибке установки репозитория
      function msg_in2() {  
# Создание сообщения и установка языка сообщения
         ttb=$(echo -e " Ошибка установки. $yum_epel") && lang="nix" && bpn_p_lang ; 
      }
      
# Это проверка существования файла репозитория /etc/yum.repos.d/epel.repo, который является индикатором его наличия. 
# Если файл отсутствует, значит репозиторий не установлен. Тогда происходит попытка установить его
      [[ -z $(cat /etc/yum.repos.d/epel.repo 2>/dev/null) ]] && ( dnf -y install epel-release tar 2>/dev/null && msg_in1 || msg_in2 ) || msg_in3 ;
      
}



function bat_Check_or_install() {
  # --> Проверка существования файла bat, 
  # --> который является индикатором его наличия. 
    
# Определяется название репозитория и помещается в переменную bat
      bat=bat 
      
# Сообщение, если репозиторий уже установлен
      function msg_in3() { 
# Создание сообщения и установка языка сообщения
         ttb=$(echo -e " $bat уже был установлен.") && lang="nix" && bpn_p_lang ; 
      }
      
# Сообщение об успешной установке репозитория
      function msg_in1() { 
# Создание сообщения и установка языка сообщения
         ttb=$(echo -e " $bat успешно установлен.") && lang="nix" && bpn_p_lang ;  
      }
      
# Сообщение об ошибке установки репозитория
      function msg_in2() {  
# Создание сообщения и установка языка сообщения
         ttb=$(echo -e " Ошибка установки. $bat") && lang="nix" && bpn_p_lang ; 
      }
      
# Это проверка существования файла репозитория /usr/local/bin/bat, который является индикатором его наличия. 
# Если файл отсутствует, значит bat не установлен. Тогда происходит попытка установить его

        ( [[ -n $(type /usr/local/bin/bat 2>/dev/null) ]] && msg_in3 || /root/vdsetup.2/bin/utility/install/bat_install.sh bat_install && msg_in1 ) || msg_in2 ;
      
}



function ch_screen() {
  # -->  Проверяет файл .screenrc на существование, а так же
  # -->  на присутствие в нем записи необходимой для работы колеса мышки в окне терминала. 
  # -->  После добавления этой записи в .screenrc проматывать содержимое экрана в screen станет гораздо удобнее.
    
  ttb=$(echo -e "\n ⎧ Проверяем файл /root/.screenrc на существование, а так же на присутствие\n | в нем записи необходимой для работы колеса мышки в окне терминала.\n | После добавления этой записи в .screenrc проматывать содержимое экрана\n ⎩ в screen станет удобнее! \n" ) && lang=cr && bpn_p_lang ; 
  
  if 
    [[ $(grep 'termcapinfo \* ti@:te@' /root/.screenrc | head -n 1) == 'termcapinfo * ti@:te@' ]] 2> /dev/null
    then 
     ttb=$(echo -e "\n | Файл .screenrc уже настроен ") && lang=cr && bpn_p_lang ; echo ;
     else 
     touch /root/.screenrc && echo -e 'termcapinfo * ti@:te@' >> /root/.screenrc && ttb=$(echo -e "\n | Добавляем запись для screen ...") && lang=cr && bpn_p_lang ;
    fi 
    
}



function NanoSyntaxOK() {
  # -->  Nano (syntax):
  # -->  Выводит NanoSyntaxOK, так как cat нашел и открыл /root/.nanorc
      echo -e " ($( green_tick )) - Nano syntax ${RED}    | $( green_OK )" ;
}



function NanoSyntaxIN() {
  # -->  Установка из дропбокса архива nano-syntax, так как cat получает пустое значение, потому что /root/.nanorc нет или он пуст
    ttb=$(echo -e "\n ⎧ Скачиваю / распаковываю и копирую содержимое архива:\n | nano-syntax.tar.gz в /usr/share/ \n | Копирую /tmp/installer/nano-syntax/.nanorc \n ⎩ в: /root/ \n") && lang="nix" && bpn_p_lang ;
    
      ( ( mkdir -p /tmp/installer && cd /tmp/installer && wget https://www.dropbox.com/s/f6hceijljbprvny/nano-syntax.tar.gz &>/dev/null && tar -xzvf nano-syntax.tar.gz &>/dev/null && rm -f nano-syntax.tar.gz && cd /tmp/installer/nano-syntax/ && rm -rf /usr/share/nano/ && cp -r --force /tmp/installer/nano-syntax/nano/ /usr/share/ && cp -n /tmp/installer/nano-syntax/.nanorc /root/ ) && ttb=$(echo -e "\n ⎧ Настройка nano-syntax завершена\n ⎩ ($( green_tick )) - Nano syntax $( green_OK )") && lang=help && bpn_p_lang ) || ttb=$(echo -en "\n Функция NanoSyntaxIN завешилась с ошибкой: " && error_MSG ; ) && lang=help && bpn_p_lang ;
       
}



function NanoSyntaxCH(){
  # -->  Проверка или установка Nano (syntax)
    [[ -z $( cat /root/.nanorc ) ]] 2>/dev/null && NanoSyntaxIN || NanoSyntaxOK ;
}



function fzfIN() { 
  # -->  Установка fzf
    ttb=$(echo -e "\n |  Установка fzf. ") && lang=nix && bpn_p_lang ;
    
    ( ( git clone --depth 1 https://github.com/junegunn/fzf.git ~/.fzf && ~/.fzf/install --all ) ) && ( echo -e "\n ⎧ ${GREEN}Установка fzf завершена${NC}" && echo -e " | ($( green_tick )) - fzf version $($HOME/.fzf/bin/fzf --version)" && ( echo -e " | Для обновления настроек введите:\n ⎩ ${RED}#${NC} source ${CYAN}~/.bashrc\n${NC}" ) ) || ttb=$(echo -en " | Функция fzfIN завешилась с ошибкой: " && error_MSG ) && lang=help && bpn_p_lang ;
    
}  

    
function fzfCH() {
  # -->  Проверка на наличие fzf или установка fzf 
    (( [[ -z $(fzf --version) ]] ) &>/dev/null && fzfIN ) || ( ttb=$(echo -e "\n | (fzf version $(fzf --version)" && lang=cr && bpn_p_lang )) ;
 }



function nginx_repo_Check_or_install() {
  # -->  Проверяет или устанавливает nginx repo
    
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
  # -->  Установка ramfetch
     /root/vdsetup.2/bin/utility/install/ramfetch.sh install ;
}
   
function ramfetch_remove() {
  # -->  Удаление ramfetch
     /root/vdsetup.2/bin/utility/install/ramfetch.sh remove ;
}

function snap_install() {
  # -->  Установка snapd
      /root/vdsetup.2/bin/utility/install/snap_install.sh ;
}

function core_ch_for_WireGuard() {
  # -->  Помощь и возможность автоматического исправлению ошибки с ядром ОС для работы VPN WireGuard
      /root/vdsetup.2/bin/utility/install/vpn/core_ch_for_WireGuard.sh ;
}

function webmin_install() {
    # -->  Установка/проверка Webmin
     /root/vdsetup.2/bin/utility/install/web-panels/webmin_install.sh ;
}

function bat_install() {
    # -->  Установка/проверка Bat
     /root/vdsetup.2/bin/utility/install/bat_install.sh ;
}

function dtfex() {
    # -->   Качалка файлов с файло-обменников через сеть TOR
    /root/vdsetup.2/bin/utility/install/downloader_tor_fex/data_processing.sh ;
}
