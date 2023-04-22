#!/bin/bash

# Функция: Информация о вебсервере nginx
function http() { ttb=$( echo -e "\n $( cat /tmp/nginx_http_ip 2>/dev/null )") && lang=meminfo && bpn_p_lang ; }


# Функция: Очистка ( полная, включая промотку вверх ) экрана терминала 
function cv() { (clear && clear) }


# Очистка ( не полная, не включая промотку вверх ) экрана терминала 
function c() { (clear) }


# network restart  
function network_restart() { (/etc/init.d/network restart) }


# tor restart && status && tor_check_ip
function tor_restart_status() { (systemctl restart tor.service && systemctl status tor.service && tor_check_ip) }


# Функция, которая проверяет, удалось ли получить IP-адрес с помощью wget и выводит соответствующее сообщение.
function check_ip() {
    local ip=$(wget -qO- --proxy=on http://ipinfo.io/ip)
    if [ -z "$ip" ]; then
        echo "Не удалось получить IP-адрес, перезапускаю TOR..."
        tor_restart_status ;
    else
        echo -e "\n  TOR IP-адрес: $ip" ; tor_check_ip_wget
    fi
}

# Вызываем функцию для проверки IP-адреса.
#check_ip


# Функция: информация о памяти системы
function mem() { 
  ramfetch 2>/dev/null ;
  ttb=$( echo -e "\n $( free -h -t )") && lang=meminfo && bpn_p_lang ;
  ttb=$( echo -e "\n # free -h -t\n") && lang=cr && bpn_p_lang ; 
}


# Функция: информации о доступном дисковом пространстве на файловой системе
function df() { ttb=$( echo -e "\n $(/usr/bin/df -kTh)") && lang_cr && bpn_p_lang ; }


# Функция: Мой ip
function mi() { wget -qO- icanhazip.com ; } ;


# Функция: User
function im() { whoami ; } ;


# Функция: Проверяет работает ли TOR в связке с wget
function tor_check_ip_wget() {
     
      ttb="$( echo -e "
  БЕЗ указания прокси socks5 127.0.0.1:"${tor_port}"
  # wget -qO- http://ipinfo.io/ip
  "$(wget -qO- http://ipinfo.io/ip)"
  
  Если ip БЕЗ прокси такой-же как и с включенным 
  прокси значит wget настроен по умолчанию для работы 
  через socks5 127.0.0.1:"${tor_port}"
  Вы можете отключить это в файле /etc/wgetrc
  
      
  С ВКЛ-юченным прокси socks5 127.0.0.1:"${tor_port}"
  # wget -qO- --proxy=on http://ipinfo.io/ip
  "$(wget -qO- --proxy=on http://ipinfo.io/ip)"
   
  С ВЫКЛ-юченным прокси socks5 127.0.0.1:"${tor_port}"
  # wget -qO- --proxy=off http://ipinfo.io/ip
  "$(wget -qO- --proxy=off http://ipinfo.io/ip)"
  ")" && lang=cr && bpn_p_lang ;
   
}
  
# Если запрос завершился успешно с кодом 200, то функция выводит сообщение о том, что прокси работает, 
# иначе - что прокси не работает, и выводит HTTP-код ответа.
function check_socks5_proxy() {
    local proxy_address="127.0.0.1:${tor_port}"
    local url="http://example.com"
    local curl_opts=(
        "--socks5"
        "${proxy_address}"
        "--max-time"
        "10"
        "--silent"
        "--output"
        "/dev/null"
        "--write-out"
        "%{http_code}"
        "${url}"
    )
    
    local http_code=$(curl "${curl_opts[@]}")
    if [[ "$http_code" == "200" ]]; then
        echo "SOCKS5 proxy $proxy_address is working"
    else
        echo "SOCKS5 proxy $proxy_address is not working, HTTP code: $http_code"
    fi
}

  
function test_tor() {
   
    # Получаем .torproject.org onion адрес
    onion_addr="http://2gzyxa5ihm7nsggfxnu52rck2vv4rvmdlkiu3zzui5du4xyclen53wid.onion/"
    
    echo -e "\n Проверяем доступность .onion адреса через Tor\n curl --socks5-hostname "127.0.0.1:${tor_port}" -s "\$onion_addr" "
    if curl --socks5-hostname "127.0.0.1:${tor_port}" -s "$onion_addr" | grep -m 1 -E "Browse Privately" &>/dev/null ; then
        echo -en " $(curl -s --socks5-hostname "127.0.0.1:${tor_port}" https://check.torproject.org/ | grep -m 1 -E 'Sorry | Congratulations' | sed 's/  //g')\n"
        echo -e " Tor Socks5 работает нормально!\n Сайт в зоне .onion получен через Socks5 успешно.\n You Browse Privately!"
    else
        echo -e " Tor Socks5 не работает!\n Перезапустить: # tor_restart_status"
    fi
  
}

function tor_onion_test() { ttb=$(test_tor ) && lang=cr && bpn_p_lang ; }


function check_tor() {
    # Сначала проверяем, что Tor запущен и работает как прокси
    if curl -s -x socks5h://127.0.0.1:"${tor_port}" https://check.torproject.org/ | grep -q "Congratulations" ; then
        echo " Tor Socks5 работает нормально."
        # Если Tor работает, проверяем, происходит ли через него соединение
        if curl -s --socks5-hostname 127.0.0.1:"${tor_port}" https://check.torproject.org/ | grep -q "This browser is configured to use Tor" ; then
            echo " Соединение через Tor происходит нормально."
            curl -s --socks5-hostname 127.0.0.1:9050 https://check.torproject.org/ | grep -m 1 -E 'Sorry | Congratulations' | sed 's/  //g'
        else
            echo " Соединение не происходит через Tor."
            # | sed 's/<[^>]*>//g', чтобы удалить все теги:
            curl -s --socks5-hostname 127.0.0.1:9050 https://check.torproject.org/ | grep -m 1 -E 'Sorry | Congratulations' | sed 's/<[^>]*>//g'
        fi
    else
        echo " Tor Socks5 не работает."
    fi
}





  

# Функция: myip() ссылается на другую функцию mi() и показывает ip в цвете с помощью bat
function myip() { 
   
  ttb=$( echo -e "$(echo -e $(mi) 2>/dev/null)") && lang_cr && bpn_p_lang ; 
}


# Функция: Кеширует ip адрес TOR
function reload_cash() {
    /root/vdsetup.2/bin/utility/.cash_var.sh $1
}


# Функция: cash_var_sh_150_start_and_stop включает и отключает кеширование ip адреса тора и версии vdsetup на 150 секунд.
function cash_var_sh_150_start_and_stop() {
     ( cash_var_sh_150 ) &>/dev/null 
     
     ps ax | awk '/[s]leep_kill/ { print $1 }' | xargs kill &>/dev/null 
     pkill -f "sleep_kill" &>/dev/null
     screen -wipe &>/dev/null 
     # ps ax | awk '/[s]nippet/ { print $1 }' | xargs kill (тоже рабочий вариант вместо snippet имя скрипта или программы)
    ( /usr/bin/screen -dmS sleep_kill /bin/bash /root/vdsetup.2/bin/utility/install/tor/.sleep_kill.sh ) &>/dev/null ; 
    return ; 
}


# Функция: удаляет юнит кеширования ip адреса Тора и версии vdsetup 
function remove_unit_stop_cashing() {
   ${msg9} ;
   
   systemctl disable cash_var.service &>/dev/null || ttb=$(echo -e "\n Error disable Unit /etc/systemd/system/cash_var.service could not be found. \n") && bpn_p_lang  ;
   systemctl stop cash_var.service &>/dev/null || ttb=$(echo -e "\n Error stop Unit /etc/systemd/system/cash_var.service could not be found. \n") && bpn_p_lang  ;
   rm /etc/systemd/system/cash_var.service &>/dev/null || ttb=$(echo -e "\n Error remove Unit /etc/systemd/system/cash_var.service could not be found. \n") && bpn_p_lang  ;
   systemctl daemon-reload &>/dev/null || ttb=$(echo -e "\n Error daemon-reload \n") && bpn_p_lang  ;
 
   ttb=$(echo -e "\n Unit /etc/systemd/system/cash_var.service removed \n") && bpn_p_lang  ;
   #systemctl status -n0 cash_var.service 2>/dev/null;
   return ;
}


# Функция: определяет port на котором работает ТОР, и назначает переменную tor_port которая потом используется
# другими функциями vdsetup.
function tor_port_ch() {
   lang_nix
    for test in 9150 9050 ''; do
        { >/dev/tcp/127.0.0.1/$test; } 2>/dev/null && { tor_port="$test"; break; }
        [ -z "$test" ] && ttb=$(echo -e "\n ⎧ ! Нет открытого Tor порта (9150 9050).\n ⎩ # systemctl start tor\n") && bpn_p_lang ;
    done
}
tor_port_ch &>/dev/null ;


# Функция: Проверка работы TOR и определение ip
function tor_check_ip() {
   tor_port_ch ;
   /root/vdsetup.2/bin/utility/install/tor/tor_check.sh ;
}


# Функция: возвращает бекап файл /etc/wgetrc_old на прежнее место /etc/wgetrc (отключает использование прокси ТОР http://localhost:8118 ) "
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


# Функция: Обращение к функции в скрипте tor_installer.sh Перезапускает TOR Wireguard privoxy и тд (переделать)
function tor-restart() {
    /root/vdsetup.2/bin/utility/install/tor/tor_installer.sh tor-restart
    
}


# Функция: Обращение к toriptables2.py очистка маршрутов iptables остановка tor
function tor-stop() {
    #toriptables2.py -i ;
    toriptables2.py -f ;
    systemctl stop tor.service ;
    ttb=$(echo -e "\n Tor is now stopped\n") && bpn_p_lang ;
    tor_check_ip ;
}


# Функция: Curl через TOR иммитирует работу браузера в TOR
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


# Функция: Вызов toriptables2.py, включение TOR для сети всего сервера
function toriptables2.py() {
     /root/vdsetup.2/bin/utility/install/tor/tor-for-all-sys-app.sh $1 ;
}

 
# Функция: Запускает http Node_js сервер
function start_http_server() {
     /root/vdsetup.2/bin/utility/torrent/file_to_http_start_stop.sh start ;
}

 
# Функция: Останавливает http Node_js сервер
function stop_http_server() {
     /root/vdsetup.2/bin/utility/torrent/file_to_http_start_stop.sh stop ;
}

 
# Функция: показывает статус http Node_js сервера
function status_http_server() {
     /root/vdsetup.2/bin/utility/torrent/file_to_http_start_stop.sh status ;
}

 
# Функция: Запускает http light Node_js сервер
  function start_light_server() {
     /root/vdsetup.2/bin/utility/torrent/file_to_light_server_start_stop.sh start ;
}

 
# Функция: Останавливает http light Node_js сервер
  function stop_light_server() {
     /root/vdsetup.2/bin/utility/torrent/file_to_light_server_start_stop.sh stop ;
}

 
# Функция: Показывает статус http light Node_js сервера
function status_light_server() {
     /root/vdsetup.2/bin/utility/torrent/file_to_light_server_start_stop.sh status ;
}


# Функция: 
function lastf() {
     /root/vdsetup.2/bin/utility/lastf.sh $1 ;
}


# Функция: Показывает открытые порты и сервисы на firewalld (окрашивает текст lang="passwd")
function open_port_and_services_firewall() {
   function services-ports() {
     echo -e "\n  firewalld services, ports: \n" ;
     echo -e "$( sudo firewall-cmd --list-all | grep -E "(services:|ports:)" | grep -v "(forward|source)" ;)"
     echo ;
     echo -e " # sudo firewall-cmd --list-all\n" ;
     ttb=$(services-ports) && lang="passwd" && bpn_p_lang ;
     }

}


# Функция: Показывает открытые порты и сервисы на firewalld (окрашивает текст lang="cr")
function fw_i()
{
   
   function services-ports() {
       echo -e "\n  firewalld services, ports: \n" ;
       echo -e "$( sudo firewall-cmd --list-all | grep -E "(services:|ports:)" | grep -v "(forward|source)" ;)"
       echo ;
       echo -e " # sudo firewall-cmd --list-all\n" ;
   }
   
   ttb=$(services-ports) && lang="cr" && bpn_p_lang ;
}


# Функция: Показывает открытые порты и сервисы и правила на firewalld (окрашивает текст lang="cr") 
function fw_i_r() {
   
   function get-all-rules() {
       echo -e "\n  firewalld services, ports, rules: \n" ;
       echo -e "$( sudo firewall-cmd --list-all | grep -E "(services:|ports:)" | grep -v "(forward|source)" ;)"
       echo "\n  rules:\n";
       echo -e "$( sudo firewall-cmd --direct --get-all-rules ;)"
       echo ;
       echo -e " # sudo firewall-cmd --direct --get-all-rules && sudo firewall-cmd --list-all\n" ;
       
   }
   
   ttb=$(get-all-rules) && lang="cr" && bpn_p_lang ;
}


# Функция: Вывод от команды netstat -tupln | grep ssh
function netstat_i () {
    
   function netstat-tupln() {
       echo ;
       ( netstat -tupln | grep ssh ) | bat -l nix -p 2>/dev/null || ( netstat -tupln | grep ssh ) ;
       echo -e "\n # netstat -tupln | grep ssh" ;
    }
   ttb=$(netstat-tupln) && lang="cr" && bpn_p_lang ;
}


# Функция: Выводит ТОП 25 процессов занимающих RAM (окрашивает текст lang="nix") 
function TopRAM25() {
   
    function top() {
       echo -e " "
       ps axo rss,comm,pid \
       | awk '{ proc_list[$2]++; proc_list[$2 "," 1] += $1; } \
       END { for (proc in proc_list) { printf("%d\t%s\n", \
       proc_list[proc "," 1],proc); }}' | sort -n | tail -n 25 | sort -rn \
       | awk '{$1/=1024;printf "%.0f MB\t",$1}{print $2}'
    }
    
    ttb=$(top) && lang="nix" && bpn_p_lang ;
}


# Функция: Выводит ТОП 25 процессов занимающих RAM (окрашивает текст lang="c") 
function t25r() { TopRAM25 | bat -p -l c }


# Функция: 
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


# Функция: Показывает первые 10 прожорливых процессов CPU/RAM
function memc() { 
     
   echo -en "\n${cyan}*** ${green}MEMORY RAM/SWAP ${RED}***$NC"; mem; echo -e "\n"${cyan}*** ${green}Top 25 RAM ${RED}"***$NC"; t25r ;
   echo -e "\n${cyan}*** ${green}Top 10 RAM ${RED}***$NC"; ttb=$(ps auxf | sort -nr -k 4 | head -10 ) && lang=bash && bpn_p_lang ;
   echo -e "\n${cyan}*** ${green}Top 10 CPU ${RED}***$NC"; ttb=$(ps auxf | sort -nr -k 3 | head -10 ) && lang=bash && bpn_p_lang ;
   echo -en "\n${cyan}*** ${green}FILE SYSTEM ${RED}***$NC"; df; 
   
   ttb=$(echo -e "\n # ps ax | awk '/[s]nippet/ { print $1 }' | xargs kill\n Убить процесс по имени, или # kkill  ")&& lang=bash && bpn_p_lang ;
}


# Функция: 
function ifc() { ( echo -e "" && ifconfig | bat -p --paging=never -l conf ) || ( echo -e "" && ifconfig ) }


# Функция: local address
function lip-f() {
   
   echo -e "\n"$green""internal"$NC":" " ;
   ifconfig | grep -Eo 'inet (addr:)?([0-9]*\.){3}[0-9]*' | grep -Eo '([0-9]*\.){3}[0-9]*' | grep -v '127.0.0.1'
   echo -e "$cyan""\nexternal"$NC":" ;
   myip ;
   
   echo -e "\n"$green""Privoxy TOR Socks5 127.0.0.1:9050"$NC":" " ;
   curl --socks5 127.0.0.1:9050 http://2ip.ua
   
}