
#!/bin/bash


function _tor_onion_test() {
   
    # Получаем .torproject.org onion адрес
    onion_addr="http://2gzyxa5ihm7nsggfxnu52rck2vv4rvmdlkiu3zzui5du4xyclen53wid.onion/"
    
    echo -e "\n Проверяем доступность .onion адреса через Tor\n # curl --socks5-hostname "127.0.0.1:${tor_port}" -s "\$onion_addr"\n http://2gzyxa5ihm7nsggfxnu52rck2vv4rvmdlkiu3zzui5du4xyclen53wid.onion/ "
    if curl --socks5-hostname "127.0.0.1:${tor_port}" -s "$onion_addr" | grep -m 1 -E "Browse Privately" &>/dev/null ; then
      echo -e "\n Tor Socks5 работает нормально!\n Сайт в зоне .onion получен через Socks5 успешно.\n You Browse Privately!"
      echo -en " $(curl --insecure -s --socks5-hostname "127.0.0.1:${tor_port}" https://check.torproject.org/ | grep -m 1 -E 'Sorry | Congratulations' | sed 's/  //g')\n"
      
    else
      echo -e "\n Tor Socks5 \"127.0.0.1:${tor_port}\" не работает!\n Перезапустить: # tor_restart_status"
    fi
  }


function tor_onion_test() { ttb=$(_tor_onion_test) && lang=cr && bpn_p_lang ; }


function systemctl_status_tor-service() {
    
    # Wait for Tor to fully bootstrap
    while ! systemctl status tor.service | grep -q "Bootstrapped 100% (done): Done"; do
      sleep 1
    done
    
    # Run your command here
    ttb=$(echo -e "\n Bootstrapped 100% (done): Done!") && echo && lang=nix && bpn_p_lang && tor_onion_test ;
  }


# tor restart && check status 
function tor_restart_status() { (systemctl restart tor.service && systemctl_status_tor-service) }


# Функция, которая проверяет, удалось ли получить IP-адрес 
# с помощью wget --proxy=on и выводит соответствующее сообщение.
function tor_check_ip_or_restart() {
    ttb=$(echo -e "\n Ответ от wget -qO- --no-check-certificate --proxy=on https://check.torproject.org/api/ip:" 
    echo -en " ";
      wget -qO- --no-check-certificate --proxy=on https://check.torproject.org/api/ip | jq -r '.IP') && lang=cr && bpn_p_lang ;
    ttb=$(echo -e " Ответ от wget -qO- --no-check-certificate --proxy=on https://icanhazip.com:" 
    echo -en " ";
      wget -qO- --no-check-certificate --proxy=on https://icanhazip.com) && lang=cr && bpn_p_lang ;
    ttb=$(echo -e " Ответ от curl --insecure -s --socks5-hostname 127.0.0.1:${tor_port} https://check.torproject.org/api/ip:"
    echo -en " ";
      curl --insecure -s --socks5-hostname 127.0.0.1:${tor_port} https://check.torproject.org/api/ip | jq -r '.IP') && lang=cr && bpn_p_lang ;
    ttb=$(echo -e " Ответ от curl --insecure -s --socks5-hostname 127.0.0.1:${tor_port} https://icanhazip.com"
    echo -en " ";
      curl --insecure -s --socks5-hostname 127.0.0.1:${tor_port} https://icanhazip.com) && lang=cr && bpn_p_lang ;
    
    
    unset ip ;
    tor_port_ch ;
    local ip=$(wget -qO- --no-check-certificate --proxy=on https://icanhazip.com/ ;) 
    if [ -z "$ip" ]; then
      ttb=$(echo -e "\n Не удалось получить IP-адрес, перезапускаю TOR...\n # tor_restart_status\n") && lang=nix && bpn_p_lang ;
      echo ;
      ( tor_restart_status && tor_check_ip_or_restart);
    else
      ttb=$(echo -e "\n TOR IP-адрес: $ip") && lang=nix && bpn_p_lang ;
    fi
    
    # Команда для просмотра журнала системы с подробными сообщениями об ошибках
    # systemctl --failed
    # команда для просмотра подробного журнала системы
    # journalctl -xe или journalctl -xef для непрерывного вывода журнала
    
    # Команды для определения IP Через socks5 Tor с испольльзованием DNS Tor. (на сайте torproject)
    # --insecure без проверки сертификата шифрования
    # curl --insecure -s --socks5-hostname 127.0.0.1:9050 https://check.torproject.org/api/ip | jq -r '.IP'
    # wget -qO- --no-check-certificate --proxy=on https://check.torproject.org/api/ip | jq -r '.IP'
    # 
    # wget -qO- --no-check-certificate --header="Proxy-Agent: socks5://127.0.0.1:9050/" https://check.torproject.org/api/ip
  }

# Функция: Проверяет работает ли TOR в связке с wget
function tor_check_ip_wget() {
   
   ttb="$( echo -e "
  БЕЗ указания прокси socks5 127.0.0.1:"${tor_port}"
  # wget -qO- --no-check-certificate https://icanhazip.com
  "$(wget -qO- --no-check-certificate https://icanhazip.com)"
  
  wget настроен по умолчанию для работы 
  через socks5 127.0.0.1:"${tor_port}"
  Вы можете отключить это в файле /etc/wgetrc
  
    
  С ВКЛ-юченным прокси socks5 127.0.0.1:"${tor_port}"
  # wget -qO- --no-check-certificate --proxy=on https://icanhazip.com
  "$(wget -qO- --no-check-certificate --proxy=on https://icanhazip.com)"
   
  С ВЫКЛ-юченным прокси socks5 127.0.0.1:"${tor_port}"
  # wget -qO- --no-check-certificate --proxy=off https://icanhazip.com
  "$(wget -qO- --no-check-certificate --proxy=off https://icanhazip.com)"
  ")" && lang=cr && bpn_p_lang ;
   
  }

# Функция: Обращение к функции в скрипте tor_installer.sh Перезапускает TOR Wireguard privoxy и тд (переделать)
function tor-restart() {
    /root/vdsetup.2/bin/utility/install/tor/tor_installer.sh tor-restart
    
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


# Функция: Обращение к toriptables2.py очистка маршрутов iptables остановка tor
function tor-stop() {
    #toriptables2.py -i ;
    toriptables2.py -f ;
    systemctl stop tor.service ;
    ttb=$(echo -e "\n Tor is now stopped\n") && bpn_p_lang ;
    tor_check_ip ;
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
   tor_onion_test ;
   
  }

# Создание в systemd unit tor0.service, который будет автоматически создавать интерфейс tor0 
function tor_Interface_unit_reinstall() {
   /root/vdsetup.2/bin/utility/install/tor/create_unit_tor0_service.sh $1 ;
  }


function status_tor_service() {
    echo ;
    ttb=$(echo -e "$(systemctl status -n0 --no-pager tor0.service)") && lang=cr && bpn_p_lang ;
    echo ;
    ttb=$(echo -e "$(ifconfig tor0)") && lang=cr && bpn_p_lang ;
  }

  
# Если запрос завершился успешно с кодом 200, то функция выводит сообщение о том, что прокси работает, 
# иначе - что прокси не работает, и выводит HTTP-код ответа.
function check_socks5_proxy() {
    local proxy_address="127.0.0.1:${tor_port}"
    local url="https://example.com"
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
  

  
  function full_port_scan() {
    rm /tmp/full_port_scan-tcp.txt
    local host="127.0.0.1"
    local start_port=1
    local end_port=65535
    local output_file="/tmp/full_port_scan-tcp.txt"
    echo 
    echo " Начался процесс сканирования..."
    echo -n "   Порт: "${green}""
  
    for port in $(seq "$start_port" "$end_port"); do
      {
          (echo >/dev/tcp/"$host"/"$port") &>/dev/null && result="open" || result="closed"
          echo -ne "\r   Порт: $port ($result)     "
        if [ "$result" == "open" ]; then
          echo "$port" >> "$output_file"
          cat $output_file 
          #sleep 3 ;
        fi
      }
    done
  
    echo -e "${cr}\n\n Полное сканирование завершено. Открытые порты сохранены в файл: $output_file\n"
    ttb=$(echo "$(cat $output_file)") && lang="nix" && bpn_lang
  }
