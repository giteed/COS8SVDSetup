#!/bin/bash

# Функция информация о памяти системы
function mem() { ( echo && free -h -t ) | ( bat  --paging=never -l meminfo -p ) || ( echo -e '' && free -h -t ) }


# Функция информации о доступном дисковом пространстве на файловой системе
function df() {  ( echo && /usr/bin/df -kTh | bat --paging=never -l nix -p ) || ( echo && /usr/bin/df -kTh ) }


# ФУНКЦИЯ: Мой ip
  function mi() { wget -qO- icanhazip.com ; } ;


# ФУНКЦИЯ: User
  function im() { whoami ; } ;


# Функция myip() ссылается на другую функцию mi() и показывает ip в цвете с помощью bat
function myip() { 
  echo -e $(mi) | bat -p -l cr || echo -e $(mi) ; 
}

   function reload_cash() {
    /root/vdsetup.2/bin/utility/.cash_var.sh $1
}


# Функция cash_var_sh_150_start_and_stop включает и отключает кеширование ip адреса тора и версии vdsetup на 150 секунд.
function cash_var_sh_150_start_and_stop() {
     ( cash_var_sh_150 ) &>/dev/null 
     
     ps ax | awk '/[s]leep_kill/ { print $1 }' | xargs kill &>/dev/null 
     pkill -f "sleep_kill" &>/dev/null
     screen -wipe &>/dev/null 
     # ps ax | awk '/[s]nippet/ { print $1 }' | xargs kill (тоже рабочий вариант вместо snippet имя скрипта или программы)
    ( /usr/bin/screen -dmS sleep_kill /bin/bash /root/vdsetup.2/bin/utility/.sleep_kill.sh ) &>/dev/null ; 
    return ;
 }


# Функция удаляет юнит кеширования ip адреса Тора и версии vdsetup 
function remove_unit_stop_cashing() {
   ${msg9} ;
   
   systemctl disable cash_var.service &>/dev/null || ttb=$(echo -e "\n Error disable Unit /etc/systemd/system/cash_var.service could not be found. \n") && bpn_p_lang  ;
   systemctl stop cash_var.service &>/dev/null ||  ttb=$(echo -e "\n Error stop Unit /etc/systemd/system/cash_var.service could not be found. \n") && bpn_p_lang  ;
   rm /etc/systemd/system/cash_var.service &>/dev/null || ttb=$(echo -e "\n Error remove Unit /etc/systemd/system/cash_var.service could not be found. \n") && bpn_p_lang  ;
   systemctl daemon-reload &>/dev/null ||  ttb=$(echo -e "\n Error daemon-reload \n") && bpn_p_lang  ;
 
   ttb=$(echo -e "\n Unit /etc/systemd/system/cash_var.service removed \n") && bpn_p_lang  ;
   #systemctl status -n0 cash_var.service 2>/dev/null;
   return ;
}


# Функция определяет port на котором работает ТОР, и назначает переменную tor_port которая потом используется
# другими функциями vdsetup.
function tor_port_ch() {
   lang_nix
    for test in 9150 9050 ''; do
        { >/dev/tcp/127.0.0.1/$test; } 2>/dev/null && { tor_port="$test"; break; }
        [ -z "$test" ] && ttb=$(echo -e "\n ⎧ ! Нет открытого Tor порта (9150 9050).\n ⎩ # systemctl start tor\n") && bpn_p_lang ;
    done
}
tor_port_ch &>/dev/null ;


function tor_check_ip() {
   tor_port_ch ;
   /root/vdsetup.2/bin/utility/tor_check.sh ;
}


# Функция возвращает бекап файл /etc/wgetrc_old на прежнее место /etc/wgetrc (отключает использование прокси ТОР http://localhost:8118 ) "
function wgetrc_config_revert() {
   
   function revert_MSG() {
      echo -e " $(black_U23A7 ) " ;
      echo -e " $(ellow_1     ) Отключить TOR Socks5 proxy для wget ${red}?${NC}" ;
      echo -e " $(white_1     ) "
      echo -e " $(ellow_1     ) wget будет настроен без TOR ${red}!${NC}" ;
      
      echo -e " $(ellow_1     ) Оригинал /etc/wgetrc будет заменен  " ;
      echo -e " $(ellow_1     ) сохраненным бекапом: /etc/wgetrc_old"
      echo -e " $(white_1     ) "
      echo -e " $(ellow_1     ) Вы можете в любой момент вернуть это обратно." ;
      echo -e " $(white_1     ) "
      echo -e " $(ellow_1     ) Включить или выключить для wget эти настройки: "
      echo -e " $(ellow_1     ) ${green}Включить${NC} : $(red_U0023) vdsetup ${green}wget-proxy-on${NC}"
      echo -e " $(ellow_1     ) ${red}Выключить${NC}: $(red_U0023) vdsetup ${red}wget-proxy-off${NC}"
      echo -e " $(black_U23A9 ) \n" ;
   }
   
   function not_found_wgetrc_old_MSG() {
       echo -e "\n ${not_found_MSG} Файл /etc/wgetrc_old не существует!"
   }
   
   
      if [[ -z /etc/wgetrc_old ]] ; then not_found_wgetrc_old_MSG ; else revert_MSG ; fi ;
   
   
      press_enter_to_continue_or_ESC_or_any_key_to_cancel ;
   
   
   function OK_wgetrc_old() {
      echo -e " $(black_U23A7 ) " ;
      echo -e " $(ellow_1     ) $(green_tick) Оригинал /etc/wgetrc заменен  " ;
      echo -e " $(ellow_1     ) сохраненным бекапом: /etc/wgetrc_old"
      echo -e " $(white_1     ) "
      echo -e " $(ellow_1     ) ${green}Включить${green} TOR Socks5 proxy${NC} для wget :"
      echo -e " $(ellow_1     ) $(red_U0023) vdsetup ${green}wget-proxy-on${NC}"
      echo -e " $(black_U23A9 ) \n" ;
   }
   
      cp -a /etc/wgetrc_old /etc/wgetrc && OK_wgetrc_old || not_found_wgetrc_old_MSG ;
   
}


function tor-restart() {
    /root/vdsetup.2/bin/utility/tor_installer.sh tor-restart
    
}


function tor-stop() {
    toriptables2.py -i ;
    toriptables2.py -f ;
    systemctl stop tor ;
    ttb=$(echo -e "\n Tor is now stopped\n") && bpn_p_lang ;
}


tcurl() {
   curl -x "socks5://127.0.0.1:${tsport}" \
   -A "Mozilla/5.0 (Windows NT 10.0; rv:78.0) Gecko/20100101 Firefox/78.0" \
   -H "Accept: text/html,application/xhtml+xml,application/xml;q=0.9,image/webp,*/*;q=0.8" \
   -H "Accept-Language: en-US,en;q=0.5" \
   -H "Accept-Encoding: gzip, deflate" \
   -H "Connection: keep-alive" \
   -H "Upgrade-Insecure-Requests: 1" \
   -H "Expect:" --compressed "$@"
}


toriptables2.py() {
   /root/vdsetup.2/bin/utility/tor-for-all-sys-app.sh $1 ;
}
 

  function msg_done() {
   echo -e "\n${green}  ✓ Done ${nc}"
 }


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

# 
function lastf() {
          /root/vdsetup.2/bin/utility/lastf.sh $1 ;
    }


# 
function open_port_and_services_firewall() {
    ttb=$(echo -e " \n  FirewallD инфо: (Открытые ports и services)\n" ;) && lang="passwd" && bpn_p_lang ;
    ttb=$( firewall-cmd --list-all | rg "(services|ports)" | rg -v "(forward|source)"  2>/dev/null ) && lang="passwd" && bpn_p_lang ;
}


#
function fw_i()
{
   echo -e " ${ELLOW}\n	FirewallD инфо: ${NC}(Открытые ports и services)${NC}" ;
   echo -e "	$(green_tick) $(red_U0023) firewall-cmd --list-all\n" ;
   ( firewall-cmd --list-all | rg "(services|ports)" | rg -v "(forward|source)"  2>/dev/null | bat --paging=never -l nix -p 2>/dev/null ; ) || ( firewall-cmd --list-all | grep -E "(services:|ports:)" | grep -v "(forward|source)" ;)
}


#
function netstat_i ()
{
   echo -e "\n	$(green_tick) $(red_U0023) netstat -tupln | grep ssh" ;
   ( netstat -tupln | grep ssh ) | bat -l nix -p 2>/dev/null || ( netstat -tupln | grep ssh ) ;
}


# 
function TopRAM25()
   {
      
         echo -e " "
         ps axo rss,comm,pid \
      | awk '{ proc_list[$2]++; proc_list[$2 "," 1] += $1; } \
         END { for (proc in proc_list) { printf("%d\t%s\n", \
         proc_list[proc "," 1],proc); }}' | sort -n | tail -n 25 | sort -rn \
      | awk '{$1/=1024;printf "%.0fMB\t",$1}{print $2}'
   }


#
function t25r()
{
   TopRAM25 | bat -p -l c
}


# 
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


# Показать первые 10 прожорливых процессов CPU/RAM
   function memc() { 
     
   echo -en "\n${cyan}*** ${green}MEMORY RAM/SWAP ${RED}***$NC"; mem; echo -e "\n"${cyan}*** ${green}Top 25 RAM ${RED}"***$NC"; t25r ;
   echo -e "\n${cyan}*** ${green}Top 10 RAM ${RED}***$NC"; ttb=$(ps auxf | sort -nr -k 4 | head -10 ) && lang=bash && bpn_p_lang ;
   echo -e "\n${cyan}*** ${green}Top 10 CPU ${RED}***$NC"; ttb=$(ps auxf | sort -nr -k 3 | head -10 ) && lang=bash && bpn_p_lang ;
   echo -en "\n${cyan}*** ${green}FILE SYSTEM ${RED}***$NC"; df; 
   
   ttb=$(echo -e "\n # ps ax | awk '/[s]nippet/ { print $1 }' | xargs kill\n Убить процесс по имени, или # kkill  ")&& lang=bash && bpn_p_lang ;
}


function ifc() { ( echo -e "" && ifconfig | bat -p --paging=never -l conf ) || ( echo -e "" && ifconfig ) }

# local address
function lip-f() {
  
   echo -e "\n"$green""internal"$NC":" " ;
   ifconfig | grep -Eo 'inet (addr:)?([0-9]*\.){3}[0-9]*' | grep -Eo '([0-9]*\.){3}[0-9]*' | grep -v '127.0.0.1'
   echo -e "$cyan""\nexternal"$NC":" ;
   myip ;
   
   echo -e "\n"$green""Privoxy TOR Socks5 127.0.0.1:9050"$NC":" " ;
   curl --socks5 127.0.0.1:9050 http://2ip.ua
   
}