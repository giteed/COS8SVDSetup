#!/bin/bash

# Source global definitions
# --> Прочитать настройки из /root/.bashrc
. /root/.bashrc


# --> Этот ссылка на функцию проверяет, запущен-ли скрипт с правами суперпользователя (root) в Linux.
. /root/vdsetup.2/bin/functions/run_as_root.sh ;
    
    echo ;
    
    
    function cockpit_Activate()
    {
      
      function cockpitOK()
       {
        echo -e "\n $(black_U23A7 ) " ;
        echo -en " $(green_U23A6) " ; echo -en " Cockpit IP      : " ; ttb="$( echo -e "https://$( ifconfig_real_ip ):9090/" )" && lang="passwd" && bpn_p_lang ;
        echo -en " $(green_U23A6) " ; echo -en " Cockpit URL     : " ; ttb="$( echo -e "https://$( hostname ):9090/" )" && lang="passwd" && bpn_p_lang ;
         
        echo -en " $(purple_U23A6) " ; echo -e " Login           : ${CYAN}root ${NC}" ;
        echo -en " $(purple_U23A6) " ; echo -e " Password        : ${RED}root_password${NC} " ;
        echo -e " $(black_U23A9 )  " ;
        
        open_port_and_services_firewall ;
        }
        
       function cockpitIN()
       {
         echo -e "\n $(black_U23A7 ) " ;
         echo -en " $(green_1     ) " ; ttb=$(echo -e " Активация или установка Cockpit Web Panel ") && lang="nix" && bpn_p_lang ;
         echo -en " $(white_1     ) " ; ttb=$(echo -e " Пожалуйста подождите...") && lang="nix" && bpn_p_lang ;
         echo -e " $(black_U23A9  ) " ;
         
         
         
         (( systemctl start cockpit.socket ) && ( systemctl enable --now cockpit.socket ) 2>/dev/null ) && check.cockpit.socket || ( (( yum install cockpit -y ;) &>/dev/null ) && check.cockpit.socket || error_MSG ; echo -e " Ошибка установки cockpit" ; check.cockpit.socket ;)
         
       }
       
        
      function check.cockpit.socket()
      {
        echo -en "\n $(black_U23A7 ) " ; ttb=$(echo -e "Проверка установки Cockpit Web Panel ") && lang="nix" && bpn_p_lang ;
        #systemctl enable --now cockpit.socket 2>/dev/null ;
        
        ttb="$( systemctl status cockpit.socket | grep " active " | awk '/active/ { print $2 }' )"
        echo -en " $(black_U23A9 ) " ; [[ $( systemctl status cockpit.socket | rg " active " | awk '/active/ { print $2 }' ) == 'active' ]] 2> /dev/null && ( echo -en "Cockpit          : $( green_tick_en )Найден, " && lang="nix" && bpn_p_lang  && cockpitOK ) || ( echo -en "$(not_found_MSG)" ; echo -e " или не активен. " ; echo -e " $(black_U23A9 ) " ; cockpitIN );
        
        
        
      }
      
      check.cockpit.socket 
      return ;
      
      
    }