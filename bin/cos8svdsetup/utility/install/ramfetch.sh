#!/bin/bash

# Source global definitions
# --> Прочитать настройки из /root/.bashrc
. /root/.bashrc

# --> Прочитать настройки:
. /root/bin/utility/.varfunc.sh &>/dev/null ;
. /root/bin/utility/.css.sh &>/dev/null ;

echo ;
debug_message ;

function install_ramfetch() {
    cd ~/temp/ ; git clone https://github.com/gentoo-btw/ramfetch ; cp ramfetch/ramfetch /usr/local/bin/ ; chmod +x /usr/local/bin/ramfetch ; rm -rf ramfetch/ ;
}

function remove_ramfetch() {
    rm -rf /usr/local/bin/ramfetch ;
}


function install() {
    
ttb=$(echo -e "
 ⎧ Устанавливаем ramfetch (GitHub):
 |
 | # cd ~/temp/ ; git clone https://github.com/gentoo-btw/ramfetch 
 | # cp ramfetch/ramfetch /usr/local/bin/ 
 | # chmod +x /usr/local/bin/ramfetch 
 ⎩ # rm -rf ramfetch/ 
 " ) && bpn_p_lang ; ttb=""  ;
 
     install_ramfetch && msg_done ;
     
ttb=$(echo -e "
 ⎧ ramfetch успешно установлен!
 |
 | https://github.com/gentoo-btw/ramfetch
 ⎩ # ramfetch
 " ) && bpn_p_lang ; ttb=""  ;
 
      ramfetch ;
  
  exit 0; 
}

function remove() {
    
ttb=$(echo -e "
 ⎧ Удаляем ramfetch
 |
 ⎩ # rm -rf /usr/local/bin/ramfetch " ) && bpn_p_lang ; ttb=""  ;

      remove_ramfetch && msg_done ;
 
  ttb=$(echo -e "
 ⎧ ramfetch полностью удален!
 ⎩ https://github.com/gentoo-btw/ramfetch
  " ) && bpn_p_lang ; ttb=""  ; 
  
  exit 0 ;
}

  if [[ $1 == install ]] ; then install ; fi ;
  if [[ $1 == remove ]] ; then remove ; fi ;
  
  exit 0;