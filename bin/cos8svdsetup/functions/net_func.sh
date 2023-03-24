#!/bin/bash




 function start_http_server() {
     /root/vdsetup.2/bin/utility/file_to_http_start_stop.sh start ;
  }
 
 function stop_http_server() {
     /root/vdsetup.2/bin/utility/file_to_http_start_stop.sh stop ;
  }
  
  function status_http_server() {
      /root/vdsetup.2/bin/utility/file_to_http_start_stop.sh status ;
   }
 
 function start_light_server() {
      /root/vdsetup.2/bin/utility/file_to_light_server_start_stop.sh start ;
  }
  
  function stop_light_server() {
      /root/vdsetup.2/bin/utility/file_to_light_server_start_stop.sh stop ;
  }
  
  function status_light_server() {
        /root/vdsetup.2/bin/utility/file_to_light_server_start_stop.sh status ;
  }

  function lastf() {
          /root/vdsetup.2/bin/utility/lastf.sh ;
    }


  


   function open_port_and_services_firewall() {
    ttb=$(echo -e " \n  FirewallD инфо: (Открытые ports и services)\n" ;) && lang="passwd" && bpn_p_lang ;
    ttb=$( firewall-cmd --list-all | rg "(services|ports)" | rg -v "(forward|source)"  2>/dev/null ) && lang="passwd" && bpn_p_lang ;
}




   function fw_i()
{
   echo -e " ${ELLOW}\n	FirewallD инфо: ${NC}(Открытые ports и services)${NC}" ;
   echo -e "	$(green_tick) $(red_U0023) firewall-cmd --list-all\n" ;
   ( firewall-cmd --list-all | rg "(services|ports)" | rg -v "(forward|source)"  2>/dev/null | bat --paging=never -l nix -p 2>/dev/null ; ) || ( firewall-cmd --list-all | grep -E "(services:|ports:)" | grep -v "(forward|source)" ;)
}

function netstat_i ()
{
   echo -e "\n	$(green_tick) $(red_U0023) netstat -tupln | grep ssh" ;
   ( netstat -tupln | grep ssh ) | bat -l nix -p 2>/dev/null || ( netstat -tupln | grep ssh ) ;
}




   
function TopRAM25()
   {
      
         echo -e " "
         ps axo rss,comm,pid \
      | awk '{ proc_list[$2]++; proc_list[$2 "," 1] += $1; } \
         END { for (proc in proc_list) { printf("%d\t%s\n", \
         proc_list[proc "," 1],proc); }}' | sort -n | tail -n 25 | sort -rn \
      | awk '{$1/=1024;printf "%.0fMB\t",$1}{print $2}'
   }

function t25r()
{
   TopRAM25 | bat -p -l c
}

function wport() {
   
   function netstat_tulanp_nogrep() {
      ( echo -e "\n${green}$(netstat -tulanp | head --lines 2 | grep -v "Active Internet" )${NC}\n" ; netstat -tulanp | grep -v "Active Internet" | grep -v " Foreign Address" |  bat --paging=never -l nix -p ) || ( echo -e "\n${green}$(netstat -tulanp | head --lines 2 | grep -v "Active Internet" )${NC}\n" ; netstat -tulanp | grep -v "Active Internet" | grep -v " Foreign Address" ) ;
   }
   
   function netstat_tulanp() {
      
      ( echo -e "\n${green}$(netstat -tulanp | head --lines 2 | grep -v "Active Internet" )${NC}\n" ; netstat -tulanp | rg "$1" | bat --paging=never -l nix -p ) || ( echo -e "\n${green}$(netstat -tulanp | head --lines 2 | grep -v "Active Internet" )${NC}\n" ; netstat -tulanp | rg $1 ) ;
   }
   
   function help_wport() {
       echo -e "\n ${green}This function print${NC}:\n  netstat -tulanp | grep \"\$1\"\n\n ${green}Usage${NC}:\n  wport \"keyword\" or \":port\"\n  wport all or \"${red}.${NC}\"\n  wport :22\n  wport :80\n  wport tcp\n  wport udp\n  wport LISTEN\n  wport ESTABLISHED\n  wport 127.0.0.1 "
       # Usage: grep [OPTION]... PATTERN [FILE]...
   }
    if [[ $1 == "" ]] ; then help_wport && return ; fi ;
    if [[ $1 == "all" ]] ; then netstat_tulanp_nogrep && return ; fi ;
    if [[ $1 == "." ]] ; then netstat_tulanp_nogrep && return ; fi ;
    if [[ $1 == "-h" ]] ; then help_wport && return ; fi ;
    
    netstat_tulanp $1 ;
}


   function memc() # Показать первые 10 прожорливых процессов CPU/RAM
{ 
   echo -en "\n${cyan}*** ${green}MEMORY RAM/SWAP ${RED}***$NC"; mem; echo -e "\n"${cyan}*** ${green}Top 25 RAM ${RED}"***$NC"; t25r ;
   echo -e "\n${cyan}*** ${green}Top 10 RAM ${RED}***$NC"; ttb=$(ps auxf | sort -nr -k 4 | head -10 ) && lang=bash && bpn_p_lang ;
   echo -e "\n${cyan}*** ${green}Top 10 CPU ${RED}***$NC"; ttb=$(ps auxf | sort -nr -k 3 | head -10 ) && lang=bash && bpn_p_lang ;
   echo -en "\n${cyan}*** ${green}FILE SYSTEM ${RED}***$NC"; df; 
   
   ttb=$(echo -e "\n # ps ax | awk '/[s]nippet/ { print $1 }' | xargs kill\n Убить процесс по имени ")&& lang=bash && bpn_p_lang ;
}




   
function lip-f() # local address
{
   echo -e "\n"$green""internal"$NC":" " ;
   ifconfig | grep -Eo 'inet (addr:)?([0-9]*\.){3}[0-9]*' | grep -Eo '([0-9]*\.){3}[0-9]*' | grep -v '127.0.0.1'
   echo -e "$cyan""\nexternal"$NC":" ;
   myip ;
   
   echo -e "\n"$green""Privoxy TOR Socks5 127.0.0.1:9050"$NC":" " ;
   curl --socks5 127.0.0.1:9050 http://2ip.ua
}