#!/bin/bash

   
   #------------------------------------
   # баннер
   #------------------------------------
   
   
   function reload_cash() {
       /root/bin/utility/.cash_var.sh $1
   }
   

   
   function auto_update_on() {
      # Включить  автоматические обновления:
      new_V=$(cat /tmp/.ver.txt)
      current_V=$(cat /root/.ver.txt)
      
    echo on > /tmp/autoupdate_vdsetup.txt ;
    echo -e "\n $(black_U23A7 ) " ;
    echo -e " $(green_1       )  \"VDSetup\" $(Version_vdsetup_Ver_RED_or_GREEN)" ; 
    echo -en " $(green_1      ) " ; (ttb=$(echo -e " Автоматические обновления - Включены." ) && bpn_p_lang ; ttb="" ) ;
    echo -en " $(red_1        ) " ; (ttb=$(echo -e " Выключить автоматические обновления: " ) && bpn_p_lang ; ttb="" ) ;
    echo -en " $(red_1        ) " ; (ttb=$(echo -e " # auto_update_off  " ) && bpn_p_lang ; ttb="" ) ;
    echo -e " $(black_U23A9   ) \n" ;
   }
   
   function auto_update_off() {
      # Отключить автоматические обновления:
      new_V=$(cat /tmp/.ver.txt)
      current_V=$(cat /root/.ver.txt)
      
    echo -e "\n $(black_U23A7  ) " ;
    echo off > /tmp/autoupdate_vdsetup.txt ;
    echo -e " $(green_1        )  \"VDSetup\" $(Version_vdsetup_Ver_RED_or_GREEN)" ; 
    echo -en " $(red_1         ) " ; (ttb=$(echo -e " Автоматические обновления - Отключены." ) && bpn_p_lang ; ttb="" ) ;
    echo -en " $(green_1       ) " ; (ttb=$(echo -e " Включить автоматические обновления: " ) && bpn_p_lang ; ttb="" ) ;
    echo -en " $(green_1       ) " ; (ttb=$(echo -e " # auto_update_on " ) && bpn_p_lang ; ttb="" ) ;
    echo -e " $(black_U23A9    ) \n" ;
   }
   
   function auto_update_status() {
      # Показать статус автоматических обновлений:
      #cash_var_sh_150_start_and_stop ;
      [ $( cat /tmp/autoupdate_vdsetup.txt ) == "on" ] && auto_update_on || auto_update_off ;
      
      return ;
   }
   

   
   function RED_VER()
   {
      echo -e "${RED}$(Version_vdsetup) $(red_U0023) vsync ${red}${blink}!${NC} New beta: ${red}${new_V}${NC}" ;
   }
   
   function GREEN_VER()
   {
      source /root/.bashrc ;
      echo -e "${green}$(Version_vdsetup) $(red_U0023) vdsetup sync" ;
      
   }
   
   #new_V=$(cat /tmp/.ver.txt)
   #current_V=$(cat /root/.ver.txt)
   
   #function new_V() {
   #   $(cat /tmp/.ver.txt)
   #}
   #function current_V() {
   #   $(cat /root/.ver.txt)
   #}
   
   function Version_vdsetup_Ver_RED_or_GREEN()
   {
       #cd /tmp/ ; wget -q  -O .ver.txt https://raw.githubusercontent.com/giteed/VDSInstaller/main/.ver.txt 2>/dev/null &
        
        
        
        
        function ver_CH_GH()
        {
           cd /tmp/ ; wget -q  -O .ver.txt https://raw.githubusercontent.com/giteed/VDSInstaller/main/.ver.txt ;
           
           
           new_V=$(cat /tmp/.ver.txt)
           current_V=$(cat /root/.ver.txt)
           
           if [ ! ${new_V} != ${current_V} ] 
           then 
              echo -e $(GREEN_VER) ; 
           else 
              echo -e $(RED_VER) ;
           
           fi 
           
        }
        
        ver_CH_GH ;
        return ;
        
        
         
         
         
       #  if [ ${new_V} != ${current_V} ] 
       #  then 
       #     echo -e "$(GREEN_VER)" 
       #  else 
       #     echo -e "$(RED_VER)" 
       #  
       #  fi 
         
      
      
     # if  ( '$(new_V)' != '$(current_V)' ) &>/dev/null ; then echo -e "$(GREEN_VER)" ; else echo -e "$(RED_VER)" ; fi ;
   
}
   
function hip() # host/ip
      {
         
         function cash_tor_ip() {
            
            cat /tmp/tor_ip 2>/dev/null ;
            #(curl -s --socks5 127.0.0.1:${tor_port} icanhazip.com) >/tmp/tor_ip & 
            
         }
         
         
         
         tor_ip="${green}TOR${NC} ip: ${green}$(cash_tor_ip)${NC}"
         tor_Socks5_ip_port=" | ${green}TOR Socks5${NC}: 127.0.0.1 ${green}port${NC}: $tor_port"
         
         
         
         if [[ $tor_port == "" ]] ; then tor_ip="" ; fi
         if [[ $tor_ip == "" ]] ; then tor_Socks5_ip_port="" ; fi
         
       
         
         
         echo -e "${NC} ¯\_("$RED"ツ"${NC}")_/¯  :  ${gray}$(cat /etc/redhat-release)"
         echo -e "${green} Host ${white} Name  : ${RED} ${HOSTNAME}"${NC} ${tor_Socks5_ip_port}
         echo -e "${green} Server ${white} ip  : ${gray} $(ifconfig_real_ip) ${white} ${tor_ip}"
         
        
      }

   #------------------------------------
   # баннер
   #------------------------------------

function cash_var_sh_150() {
      
       up_sec=$(cat /tmp/up_sec.txt)
       
       ( /root/bin/utility/.cash_var.sh $up_sec & ) &>/dev/null || ( /root/bin/utility/.cash_var.sh 151 & ) &>/dev/null 
       return ;
   }


function css() 
   { 
      
      Version_vdsetup &>/dev/null ;
      echo -en "$( clear && source /root/.bashrc && hip )\n ${RED}-${ellow}=---${ELLOW}=${ellow}-${GREEN}-${green}-${NC}-------------------------------------------------------------------------\n ${NC}$(green_tick) ${BLACK}VDSetup ${GREEN}version${NC}: $(Version_vdsetup_Ver_RED_or_GREEN)${NC}" ;  echo -e " ${msg_debug_stat}" ; 
   }
   
   

      
      # ФУНКЦИЯ: Мой ip
      function mi() { wget -qO- icanhazip.com ; } ;
      # ФУНКЦИЯ: User
      function im() { whoami ; } ;
      

   function msg_done() {
      echo -e "\n${green}  ✓ Done ${nc}"
   }
   
   function vcc() {
       vsync;c;c;
   }
   

   
   #------------------------------------
   # my ip
   #------------------------------------ 

function myip() { echo -e "$( wget -qO- icanhazip.com )" ; }


  