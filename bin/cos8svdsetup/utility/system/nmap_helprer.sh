
#!/bin/bash
. /root/.bashrc
tstart

function del_temp_files() {
    rm /tmp/find_domains.txt
    rm /tmp/all_find_hosts.txt
    rm /tmp/clean_ip_list.txt
    rm /tmp/clean_domains_list.txt
  }

del_temp_files 2>/dev/null ;


  function nmapp_help() {
    echo -e "
 Использование: nmapp [ДОМЕН/АДРЕС IP]
 
 Описание: Этот скрипт использует утилиту nmap для 
 сканирования портов на заданном домене или адресе IP.
 
 Аргументы:
   ДОМЕН/АДРЕС IP  Доменное имя или адрес IP для сканирования портов.
 
 Примеры использования:
   nmapp google.com  Сканирование портов на домене google.com
   nmapp 8.8.8.8     Сканирование портов на адресе IP 8.8.8.8 "
   
   
  }

  function nmap_help_min() {
    echo -e "
 1)  "-sS" # SYN сканирование
 2)  "-sV" # Версионное сканирование
 3)  "-sA" # Порт Открыт/закрыт/Защищён фаерволом.
 4)  "-sO" # Какие протоколы используются на целевой машине
 5)  "-sU" # UDP сканирование
 6)  "-sN" # Null сканирование
 7)  "-sF" # FIN сканирование
 8)  "-sX" # XMAS сканирование
 9)  "-sW" # Какой размер окна используется для TCP на хосте
 10) "-sM" # TCP Maimon, откр-ли порт, посыл пустого TCP-пакета 
 11) "-O"  # Определение ОС
 12) "-A"  # Агрессивный сканинг
 13) "-p-" # Сканирование всех портов
 14) "-T5" # Наивысший уровень скорости сканирования
 15) "-sT -sU -p-" # Сканировать все TCP, UDP порт
 16) "--top-ports 65000 " # 65000 частых портов :)
 17) "--system-dns" # Системный DNS-сервера вместо встроенного в Nmap"
    
  }

function nmap_help() {
    echo -e "
     Некоторые распространенные ключи для nmap:
    
 -sS или --syn: сканирование портов 
     (использует TCP SYN пакеты для определения открытых портов).
     -------------------------------------------------------------------------
 -sP сканирование хостов для определения того, какие из 
     них находятся в сети.
     -------------------------------------------------------------------------
 -sU или --udp: сканирование открытых UDP портов.
     -------------------------------------------------------------------------
 -sT или --tcp: сканирование открытых TCP
     -------------------------------------------------------------------------
 -sn используется пинг, то Nmap отправляет ICMP эхо-запросы 
     (ping) на каждый указанный хост
     -------------------------------------------------------------------------
 -Pn в утилите nmap указывает ей не пытаться обнаружить состояние 
     узлов (ping), а сразу сканировать указанные порты на всех целевых хостах. 
     -------------------------------------------------------------------------
 -sL список хостов, которые будут сканироваться 
     (без их фактического сканирования).
     -------------------------------------------------------------------------
 -A  или --osscan-guess: выводит информацию об операционной системе и 
     сервисах агрессивное сканирование, включая операционную систему, 
     версии приложений, а также сканирование TCP и UDP портов.
     -------------------------------------------------------------------------
 -O  или --osscan-limit: ограниченное сканирование операционной системы, 
     определение операционной системы хоста на основе ответов на сетевые запросы.
     -------------------------------------------------------------------------
 --top-ports <number>: сканирование указанного количества наиболее 
     популярных портов (от 1 до 65535).
     -------------------------------------------------------------------------
 -p  или --ports: сканируемые порты
     -------------------------------------------------------------------------
 -p- сканирование всех портов на хосте.
     -------------------------------------------------------------------------
 -v  или --verbose: выводить более подробную информацию о процессе сканирования.
     -------------------------------------------------------------------------
 -iL <file> или --input-file: чтение сканирование списка IP-адресов 
     или хостов из файла
     -------------------------------------------------------------------------
 -oN или --normal-output: сохранение результатов в файл в обычном формате
    -------------------------------------------------------------------------
 -oX или --xml-output: сохранение результатов в файл в формате XML
    -------------------------------------------------------------------------
 -sV или --version-all: выводит информацию о версиях сервисов
    -------------------------------------------------------------------------
 -T или --timing: устанавливает скорость сканирования (от 0 до 5)
    -------------------------------------------------------------------------
    
    Это только некоторые из множества ключей, которые можно использовать в nmap.
    Cуществует большое количество других ключей nmap, но эти наиболее часто 
    используются в повседневной работе.     $ nmap --help Справка на английском.
    "
  }



# ДОПОЛНИТЕЛЬНЫЕ ПРОВЕРКИ ДОМЕНОВ И IP АДРЕСОВ

function extract_host() {
    input=$1
    # Проверяем, начинается ли входная строка с http:// или www.
    if [[ "$input" == http://* || "$input" == https://* || "$input" == www.* || "$input" == ftp.* ]]; then
      # Извлекаем домен из входной строки
      domain_ip2=$(echo "$input" | awk -F/ '{print $3}')
      domain_ip=$(echo "$input" | awk -F/ '{print $3}' | sed 's/^www\.//' | sed 's/^ftp\.//')
      
      # ttb=$(echo -e "\n отладка then "$domain_ip" "$domain_ip2"") && lang=cr && bpn_p_lang ;
      return 
    else
      domain_ip=$1
      domain_ip2=$1
        #ttb=$(echo -e "\n отладка else "$domain_ip" "$domain_ip2"") && lang=cr && bpn_p_lang ;
      return 
    fi
  }

function check_domains_list() {
    # сортировка и проверка списка доменов, очистка от всего лишнего, на выходе только уникальные домены в столбик 
    local find_domains="$1"
    local clean_domains_list=$(echo "$find_domains" | grep -oE '[[:alnum:]][-[:alnum:]]+(\.[[:alnum:]][-[:alnum:]]+)*(\.[[:alpha:]]{2,})+' | sort -u | sed -E 's/(https?:\/\/)?(www\.)?//g' | tr ' ' '\n' | sort)
    local clean_domains_list=$(echo "$clean_domains_list" | sed -E 's/(https?:\/\/)?(www\.)?//g' | awk -F '/' '{print $1}' | awk '{print $1}')
     echo "$clean_domains_list"
  }
 
function check_ip_list() {
    # Очищаем список ip от дубликатов, ipv6 и лишних символов, оставляем только ip адреса
    # сортировка и проверка списка ip адресов, очистка от всего лишнего, на выходе только уникальные ip в столбик
    local all_find_hosts="$(cat /tmp/all_find_hosts.txt 2>/dev/null)"
    local clean_ip_list=$(echo "$all_find_hosts" |  tr '\n' ' ' | grep -Eo '([0-9]{1,3}\.){3}[0-9]{1,3}' | grep -v "0.0.0.0" |  sort -u )
     echo "$clean_ip_list"
  }

split_ip_list() {
    local all_ips="$1"
    local_ip_addr=$(echo "$(check_ip_list)" | grep -E "^127\.|^10\.|^192\.168\.|^172\.(1[6-9]|2[0-9]|3[01])\.|^169\.254\." | sort -u)
    internet_ip_addr=$(echo "$(check_ip_list)" | grep -Ev "^127\.|^10\.|^192\.168\.|^172\.(1[6-9]|2[0-9]|3[01])\.|^169\.254\." | sort -u)
     #echo -e "\n Local IPs:"
     #echo -e  "$local_ip_addr"
     #echo -e "\n Internet IPs:"
     #echo -e "$internet_ip_addr" ; echo ;
      return 
  }


function _nslookup() {
    
    wait=$( printf "${ellow}   Пожалуйста подождите...                   ${NC}\r" | tee /dev/tty >&2 && sleep 0.5 )
    function _nslookup_() {
        local local_check_ip=$(ip addr show | grep "inet " | awk '{print $2}' | cut -d/ -f1 | while read IP; do echo -ne "\r   Идет запрос nslookup для $IP... "; nslookup $IP | grep 'name =' | awk '{print $4}'; done | tee /dev/tty >&2)
    }
    _nslookup_
    return $local_check_ip
  }
  
  function ping_c_102() {
    selected_host="$1"
    wait=$( printf "${ellow}   Пожалуйста подождите...                   ${NC}\r" | tee /dev/tty >&2 && sleep 0.5 )
    function _ping_c_10_() {
        
        ping_host=$( "$selected_host" | while read HOST; do echo -ne "\r   Идет ping для $HOST... "; ping -c 10 $HOST | grep 'ttl' | awk '{print $4, $5, $6, $8}'; done | tee /dev/tty >&2)
    }
    _ping_c_10_
    return $local_check_ip
  }

function ping_c_10() {
      selected_host="$1"
      echo "$selected_host"
      wait=$( printf "${ellow}   Пожалуйста подождите...                   ${NC}\r" | tee /dev/tty >&2 && sleep 0.5 )
      function _ping_c_10_() {
        ping_host=$( echo -e "$selected_host" | while read HOST; do echo -ne "\r   Идет ping для $HOST... "; ping -c 10 $HOST ; done | tee /dev/tty >&2)
      }
      _ping_c_10_ $selected_host
      #echo "$ping_host"
      
  }



# Функция поиска хостов
find_hosts() {
    
    
    if [[ -n "$1" ]]; then
        extract_host "$1";
    else 
        nmapp_help ;
        exit 0;
    fi
    
    # Получаем список IP-адресов хоста
    local ips=$(nmap -sn "$domain_ip" | grep -E '^Nmap scan report for' | awk -F ' ' '{print $(NF-1), $NF}') 
    ips1=$(nmap -sL "$domain_ip" | grep -E '^Nmap scan report for' | awk '{print $NF}' | sed 's/[()]//g') 
    ips2=$(nmap -sL $ips1 | grep -E '^Nmap scan report for' | awk -F ' ' '{print $(NF-1), $NF}' | sed 's/[()]//g')
    ips3=$(nmap -sL $domain_ip2 | grep -E '^Nmap scan report for' | awk -F ' ' '{print $(NF-1), $NF}' | sed 's/[()]//g') 
    ips4="$ips"$'\n'"$ips1"$'\n'"$ips2"$'\n'"$ips3"'\n'"$domain_ip"
    ips4=$(echo -e "$ips4" | sort -u)
    
    # Проверяем, нужно ли добавить локальные адреса
    read -p $'\n \033[32m> Добавить локальные IP-адреса? \033[0m(y/n): ' -e -i "y" local_ips
    #wait=$(echo | tee /dev/tty >&2 ) # не удалять!
    if [[ "$local_ips" =~ ^[Yy]$ ]]; then
      # Получаем локальные IP-адреса
      local local_ips=$(hostname -I)
      _nslookup ;
      local local_check_ip=$1
      
      echo -en "\n\n   Спасибо за ожидание.                \r" ;
      
      local etc_networks=$(cat /etc/networks)
      local etc_hosts=$(cat /etc/hosts)
      local etc_sysconfig_networks=$(cat /etc/sysconfig/network)
      
      
    fi
    # Объединяем списки
    
    local all_find_hosts="$ips4"$'\n'"$local_ips"$'\n'"$local_check_ip"'\n'"$etc_networks"'\n'"$etc_hosts"'\n'"$etc_sysconfig_networks" 
    echo -e "$all_find_hosts" > /tmp/all_find_hosts.txt
    
    ping_c_10 $local_ips
  }

  # Вызываем функцию поиска хостов с переданным аргументом
  ttb=$(find_hosts "$1") && lang=help && bpn_p_lang ;

function sort_host_ip() {
    
    local all_find_hosts="$(cat /tmp/all_find_hosts.txt 2>/dev/null)"
    
    # Если в списке $ips были домены, то кладем их в переменную $find_domains
    local find_domains=$(echo -e "$all_find_hosts" | grep -vE '([0-9]{1,3}\.){3}[0-9]{1,3}' | grep -v "localhost" | tr ' ' '\n' | sort )
    local find_domains=$(echo -e "$find_domains" | tr ' ' '\n' | sort)
    
    local clean_domains_list=$(check_domains_list "$find_domains")
    echo -e "$clean_domains_list" > /tmp/clean_domains_list.txt
    
    # Очищаем $ips от дубликатов, ipv6 и лишних символов, оставляем только ip адреса
    local clean_ip_list=$(check_ip_list)
    
    # Сортируем список ip адресов и кладем в переменную $clean_ip_list
    local clean_ip_list=$(echo "$clean_ip_list" | sort)
    
    echo -e "$find_domains" > /tmp/find_domains.txt
    echo -e "$clean_ip_list" > /tmp/clean_ip_list.txt
    echo -e "$clean_domains_list" > /tmp/clean_domains_list.txt
    
  }

  ttb=$(sort_host_ip) && lang=cr && bpn_p_lang ;

# СКАНИРОВАНИЕ nmap ДОМЕНОВ И IP АДРЕСОВ
  
  function _nmap_scan() {
    selected_host="$1"
    param_nmap="$2"
    
    ttb=$(echo -e "\n (Отладка) Команда:  nmap "$param_nmap" "$selected_host" \n ") && lang=cr && bpn_p_lang ;
    echo -e " Вы выбрали с параметрами "$param_nmap" "$selected_host"\n "
    
    #scan=$(nmap $param_nmap $selected_host | grep -vE 'tcp\s+closed|udp\s+closed')
    scan=$(nmap $param_nmap $selected_host)
    #nmap $param_nmap $selected_host
     
    nmap_scan "$scan"
  }
  
  nmap_scan() {
    out_from_nmap="$1"
    ttb="$(echo -e "$out_from_nmap")" && lang_cr && bpn_p_lang ;
  }

  function menu_param() {
    
    selected_host="$1"
     # Массив с параметрами для сканирования
     declare -a nmap_params=(
     "-sS" # SYN сканирование
     "-sV" # Версионное сканирование
     "-sA" # Порт Открыт/закрыт/Защищён фаерволом.
     "-sO" # Какие протоколы используются на целевой машине
     "-sU" # UDP сканирование
     "-sN" # Null сканирование
     "-sF" # FIN сканирование
     "-sX" # XMAS сканирование
     "-sW" # Какой размер окна используется для TCP на хосте
     "-sM" # TCP Maimon, откр-ли порт, посыл пустого TCP-пакета 
     "-O"  # Определение ОС
     "-A"  # Агрессивный сканинг
     "-p-" # Сканирование всех портов
     "-T5" # Наивысший уровень скорости сканирования
     "-sT -sU -p-" # Сканировать все TCP, UDP порт
     "--top-ports 65000 " # 65000 частых портов :)
     "--system-dns" # Системный DNS-сервера вместо встроенного в Nmap
    )
    
    PS3=$(echo -e "\n${green} Введите номер параметра >${NC} \c")
    
    # Выводим меню выбора параметров сканирования
    ttb=$(nmap_help_min) && lang=cr && bpn_p_lang ;
    echo -e "\n Выберите параметр для сканирования адреса "$selected_host":\n -----------------------------------------------------------------------"
    select param_nmap in "${nmap_params[@]}" "Назад в Хосты" "Все Ключи nmap" "Выход из утилиты"; do
      # Проверяем, был ли сделан выбор
      if [[ "$param_nmap" == "Выход из утилиты" ]]; then
        exit
      elif [[ "$param_nmap" == "Назад в Хосты" ]]; then
        menu_select_host
      elif [[ "$param_nmap" == "Все Ключи nmap" ]]; then
        ttb=$(nmap_help) && lang=cr && bpn_p_lang ;
      elif [[ -n "$param_nmap" ]]; then
        # Запускаем функцию для сканирования выбранного хоста с выбранным параметром Nmap
        _nmap_scan "$selected_host" "$param_nmap"
        menu_param "$selected_host"
      else
        echo -e "\n Ошибка: выберите параметр из списка.\n"
      fi
    done
    
    # Запускаем функцию для сканирования выбранного хоста с выбранным параметром Nmap
    _nmap_scan "$selected_host" "$param_nmap"
    #menu_param "$selected_host"
  }


function menu_select_host() {
    
    # Считываем список хостов и IP адресов из файлов
    clean_ip_list="$(cat /tmp/clean_ip_list.txt)"
    split_ip_list "$clean_ip_list"
    #local_ip_addr=
    #internet_ip_addr=
    clean_domains_list="$(cat /tmp/clean_domains_list.txt)"
    
    
    # Объединяем список хостов и IP адресов
    #ip_hosts_list="$clean_domains_list $clean_ip_list"
    ip_hosts_list="$clean_domains_list $internet_ip_addr $local_ip_addr"
    
    PS3=$(echo -e "\n${green} Введите номер строки >${NC} \c")
    
    # Выводим меню
    ttb=$(echo -e " Выберите хост для сканирования:\n -----------------------------------------------------------------------\n") && lang=cr && bpn_p_lang
    select selected_host in $ip_hosts_list; do
      # Проверяем, был ли сделан выбор
      if [[ -n "$selected_host" ]]; then
      menu_param "$selected_host";
      break
      else
      ttb=$(echo -e "\n Ошибка: выберите хост из списка.\n") && lang=cr && bpn_p_lang
      fi
    done
  }

menu_select_host

del_temp_files 2>/dev/null ;

exit 0 ;





Вот некоторые управляющие последовательности ANSI, которые используются в командной строке:

    \n - перевод строки (LF, line feed), используется для переноса вывода на новую строку.
    \r - возврат каретки (CR, carriage return), используется для перемещения курсора на начало строки.
    \t - символ табуляции (HT, horizontal tab), используется для добавления отступов между выводом.
    \b - возврат на один символ назад (BS, backspace), используется для удаления одного символа перед курсором.
    \c - прекратить вывод (EOC, end of content), используется для остановки вывода без перевода строки.
    \e - символ ESC (escape), используется для вставки управляющей последовательности ANSI.

Каждый из этих символов имеет свое назначение и может использоваться в различных сценариях. Например, \n и \r используются для форматирования текста в консоли, а \t может использоваться для добавления отступов между выводом. Символ \b может быть полезен, если нужно удалить символ перед курсором, а \c может использоваться для остановки вывода без перевода строки. Символ \e используется для вставки управляющей последовательности ANSI, которая может использоваться для изменения цвета текста или других аспектов вывода.


nmap -p 22919 --script=/usr/share/nmap/scripts/ --script-args='ssh.user=root' 10.66.66.1
запуск скриптов
https://networkguru.ru/nmap-scripting-engine-rukovodstvo/
https://xakep.ru/2016/02/25/pimp-my-nmap/