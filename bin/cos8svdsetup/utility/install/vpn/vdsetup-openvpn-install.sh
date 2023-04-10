#!/bin/bash

# Source global definitions
# --> Прочитать настройки из /root/.bashrc
. /root/.bashrc


# --> Этот ссылка на функцию проверяет, запущен-ли скрипт с правами суперпользователя (root) в Linux.
. /root/vdsetup.2/bin/functions/run_as_root.sh ;
  
  echo ;

    
    if [[ "$EUID" -ne 0 ]]; then
      echo -e " Скрипт нужно запустить с правами root $( error_exit_MSG )"
      
    fi
    
  
  
  if grep -qs " Ubuntu 16.04" "/etc/os-release"; then
    cs ;
    echo -e ' Ubuntu 16.04 не поддерживается в текущей версии openvpn-install, установите Ubuntu 18.04'  ;
    exit
  fi
  
  if readlink /proc/$$/exe | grep -q "dash"; then
    cs ;
    echo -e " Этот скрипт нужно запускать с помощью bash, а не sh. Запустите скрипт командой: bash openvpn-install.sh"  ;
    exit
  fi
  
  
  if [[ ! -e /dev/net/tun ]]; then
    cs ;
    echo -e " Устройство TUN недоступно
   Вам нужно включить TUN перед запуском этого скрипта"  ;
    exit
  fi
  
  if [[ -e /etc/debian_version ]]; then
    OS=debian
    GROUPNAME=nogroup
  elif [[ -e /etc/centos-release || -e /etc/redhat-release ]]; then
    OS=centos
    GROUPNAME=nobody
  else
    cs ;
    echo -e " Похоже, вы запускаете этот установщик не в Debian, Ubuntu или CentOS"  ;
    exit
  fi
  
  newclient () {
    cp /etc/openvpn/server/client-common.txt ~/$1.ovpn
    echo "<ca>" >> ~/$1.ovpn
    cat /etc/openvpn/server/easy-rsa/pki/ca.crt >> ~/$1.ovpn
    echo "</ca>" >> ~/$1.ovpn
    echo "<cert>" >> ~/$1.ovpn
    sed -ne '/BEGIN CERTIFICATE/,$ p' /etc/openvpn/server/easy-rsa/pki/issued/$1.crt >> ~/$1.ovpn
    echo "</cert>" >> ~/$1.ovpn
    echo "<key>" >> ~/$1.ovpn
    cat /etc/openvpn/server/easy-rsa/pki/private/$1.key >> ~/$1.ovpn
    echo "</key>" >> ~/$1.ovpn
    echo "<tls-auth>" >> ~/$1.ovpn
    sed -ne '/BEGIN OpenVPN Static key/,$ p' /etc/openvpn/server/ta.key >> ~/$1.ovpn
    echo "</tls-auth>" >> ~/$1.ovpn
  }
  
  if [[ -e /etc/openvpn/server/server.conf ]]; then
    while :
    do
      css ;
      function oi_1()
      {
        echo -e "\n Похоже, OpenVPN уже установлен."  ;
        echo
        echo -e " Что вы хотите сделать?\n"  
        echo -e "   1) Добавить нового пользователя"  
        echo -e "   2) Удалить пользователя"  
        echo -e "   3) Просмотр списка пользователей"  
        echo -e "   4) Удалить OpenVPN"  
        echo -e "   5) Выход\n" 
      }
      (( oi_1 ) | bat -l nix -p ) 2>/dev/null || oi_1 ;
      
      read -p " Выберите пункт [1-5]: " -e option
      
     
      case $option in
        1) 
        function un_1()
        {
          echo
          echo -e " Укажите имя пользователя OpenVpn."  
          echo -e " Пожалуйста, используйте только одно слово,"  
          echo -e " без специальных символов\n"  
        }
        
        (( un_1 ) | bat -l nix -p ) 2>/dev/null || un_1 ;
        read -p " Имя пользователя: " -e CLIENT
        
        function gen_1()
        {
          cd /etc/openvpn/server/easy-rsa/
        EASYRSA_CERT_EXPIRE=3650 ./easyrsa build-client-full $CLIENT nopass
        newclient "$CLIENT"
        }
        (( gen_1 ) | bat -l nix -p ) 2>/dev/null || gen_1 ;
        
        function un_2()
        {
          
          echo
          echo -e " $(black_U23A7    ) " ;
          echo -e " $(ellow_1        )   Пользователь $CLIENT создан, конфигурация доступна в файле:"
          echo -e " $(ellow_1        )   "~/"${ELLOW}$CLIENT.ovpn${NC}"
          echo -e " $(ellow_1        )   Если вы хотите добавить больше клиентов, вам просто нужно" ;
          echo -e " $(ellow_1        )   снова запустить этот скрипт командой: $(red_U0023) ${BLACK}vdsetup -ov${NC}" ;
          echo -e " $(black_U23A9    )\n" ;
        }
         
         un_2 ;
         
         exit
        ;;
        
        2)
        NUMBEROFCLIENTS=$(tail -n +2 /etc/openvpn/server/easy-rsa/pki/index.txt | grep -c "^V")
        if [[ "$NUMBEROFCLIENTS" = '0' ]]; then
          function un_3()
          {
             echo
             echo -e " Пользователи не найдены!"  ;
          }
         (( un_3 ) | bat -l nix -p ) 2>/dev/null || un_3 ;
          exit
        fi
        function un_4()
        {
          echo
          echo -e " Выберите существующий сертификат клиента OpenVpn,\n который вы хотите отозвать: \n"  
        }
        
        (( un_4 ) | bat -l nix -p ) 2>/dev/null || un_4 ;
        
        tail -n +2 /etc/openvpn/server/easy-rsa/pki/index.txt | grep "^V" | cut -d '=' -f 2 | nl -s ') '  ; echo ;
        if [[ "$NUMBEROFCLIENTS" = '1' ]]; then
          
          read -p " Укажите номер клиента [1]: " CLIENTNUMBER
        else
          read -p " Укажите номер клиента [1-$NUMBEROFCLIENTS]: " CLIENTNUMBER
        fi
        CLIENT=$(tail -n +2 /etc/openvpn/server/easy-rsa/pki/index.txt | grep "^V" | cut -d '=' -f 2 | sed -n "$CLIENTNUMBER"p)
        echo
        
        function un_5()
        {
          echo -e " Вы действительно хотите отменить доступ\n для клиента $CLIENT [y/N] ?\n"  ;
        }
          
          (( un_5 ) | bat -l nix -p ) 2>/dev/null || un_5 ;
          
          read -p  " [$( im )@OpenVpnSetup] # " -e REVOKE  ;
        if [[ "$REVOKE" = 'y' || "$REVOKE" = 'yes' ]]; then  echo 
          cd /etc/openvpn/server/easy-rsa/
          ./easyrsa --batch revoke $CLIENT
          EASYRSA_CRL_DAYS=3650 ./easyrsa gen-crl
          rm -f pki/reqs/$CLIENT.req
          rm -f pki/private/$CLIENT.key
          rm -f pki/issued/$CLIENT.crt
          rm -f /etc/openvpn/server/crl.pem
          cp /etc/openvpn/server/easy-rsa/pki/crl.pem /etc/openvpn/server/crl.pem
          chown nobody:$GROUPNAME /etc/openvpn/server/crl.pem
          function un_5()
          {
            echo
            echo -e " Сертификат клиента $CLIENT удален!"  ;
          }
             (( un_5 ) | bat -l nix -p ) 2>/dev/null || un_5 ;
             else
          function un_55()
          {
            echo
            echo -e " Сертификат клиента $CLIENT удален!"  ;
            echo
            echo -e " Отзыв сертификата для клиента $CLIENT прерван!"  ;
          }
          (( un_55 ) | bat -l nix -p ) 2>/dev/null || un_55 ;
        fi
        exit
        ;;
        
        
        3)
        function un_6()
        {
          echo -e "\n Просмотр списка пользователей: "  ;
        
        }
        (( un_6 ) | bat -l nix -p ) 2>/dev/null || un_6 ;
        ( tail -n +2 /etc/openvpn/server/easy-rsa/pki/index.txt | grep "^V" | cut -d '=' -f 2 | nl -s ') ' )  ;
       sleep 5 ;
        
        
        ;;
        
        4) 
        function un_7()
        {
          echo
          echo -e " Подтвердите удаление OpenVPN? [y/N]: \n" 
        }
         (( un_7 ) | bat -l nix -p ) 2>/dev/null || un_7 ;
        
        read -p  " [$( im )@OpenVpnSetup] # " -e REMOVE
        
        if [[ "$REMOVE" = 'y' || "$REMOVE" = 'yes' ]]; then 
          echo
          
          PORT=$(grep '^port ' /etc/openvpn/server/server.conf | cut -d " " -f 2) &>/dev/null ;
          PROTOCOL=$(grep '^proto ' /etc/openvpn/server/server.conf | cut -d " " -f 2) &>/dev/null ;
          
          if pgrep firewalld ; then
            IP=$(firewall-cmd --direct --get-rules ipv4 nat POSTROUTING | grep '\-s 10.10.0.0/24 '"'"'!'"'"' -d 10.10.0.0/24 -j SNAT --to ' | cut -d " " -f 10) &>/dev/null ;
            firewall-cmd --remove-port=$PORT/$PROTOCOL &>/dev/null ;
            firewall-cmd --zone=trusted --remove-source=10.10.0.0/24 &>/dev/null ;
            firewall-cmd --permanent --remove-port=$PORT/$PROTOCOL &>/dev/null ;
            firewall-cmd --permanent --zone=trusted --remove-source=10.10.0.0/24 &>/dev/null ;
            firewall-cmd --direct --remove-rule ipv4 nat POSTROUTING 0 -s 10.10.0.0/24 ! -d 10.10.0.0/24 -j SNAT --to $IP &>/dev/null ;
            firewall-cmd --permanent --direct --remove-rule ipv4 nat POSTROUTING 0 -s 10.10.0.0/24 ! -d 10.10.0.0/24 -j SNAT --to $IP &>/dev/null ;
          
          else
          
            systemctl disable --now openvpn-iptables.service &>/dev/null ;
            rm -f /etc/systemd/system/openvpn-iptables.service &>/dev/null ;
          fi
          
          if sestatus 2>/dev/null | grep "Current mode" | grep -q "enforcing" && [[ "$PORT" != '1194' ]]; then
            semanage port -d -t openvpn_port_t -p $PROTOCOL $PORT &>/dev/null ;
          fi
          
          systemctl disable --now openvpn-server@server.service &>/dev/null ;
          rm -rf /etc/openvpn/server
          rm -f /etc/sysctl.d/30-openvpn-forward.conf
          if [[ "$OS" = 'debian' ]]; then
            apt-get remove --purge -y openvpn &>/dev/null ;
          else
            yum remove openvpn -y &>/dev/null ;
          fi
          function un_8()
          {
            echo
            echo -e " OpenVPN удален!"  ;
          }
          (( un_8 ) | bat -l nix -p ) 2>/dev/null || un_8 ;
          
        else
        function un_9()
        {
          echo
          echo -e " Удаление прервано!" 
        }
        (( un_9 ) | bat -l nix -p ) 2>/dev/null || un_9 ;

        fi
        exit
        ;;
        
        5) exit
        ;;
        
      esac
      
    done
    
  else
  
   
  
    (echo -e '\n   Добро пожаловать в установщик OpenVPN\n   для Debian, Ubuntu, CentOS\n') | bat -l nix -p 2>/dev/null || echo -e '\n   Добро пожаловать в установщик OpenVPN\n   для Debian, Ubuntu, CentOS\n'
    echo -e " $(black_U23A7    ) " ;
    echo -e " $(ellow_1        ) $(green_arrow)  Перед установкой дайте ответы на несколько вопросов. " ;
    echo -e " $(white_1        ) Вы можете оставить параметры по умолчанию и просто" ;
    echo -e " $(white_1        ) нажать Enter, если вы согласны с ними." ;
    echo -e " $(black_U23A9    )\n" ;
    
    press_enter ;
    
    
    function a_a()
    {
      echo
      echo -e " A) Укажите IPv4-адрес сетевого интерфейса, " 
      echo -e " на котором будет работать OpenVPN\n " 
      
    }
    (( a_a ) | bat -l nix -p ) 2>/dev/null || a_a ;
    
    echo -e " $(black_U23A7    ) " ;
    echo -e " $(purple_U23A6   ) Поиск IPv4-адреса...." ;
    echo -en " $(purple_U23A6  ) " ;
    
    IP=$(ip addr | grep 'inet' | grep -v inet6 | grep -vE '127\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}' | grep -oE '[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}' | head -1)
    read -p " IP адрес: " -e -i $IP IP
    echo -e " $(black_U23A9    )\n" ;
    
    if echo "$IP" | grep -qE '^(10\.|172\.1[6789]\.|172\.2[0-9]\.|172\.3[01]\.|192\.168)'; then
    echo -e " $(red_1           ) " ;
    echo -e " $(red_1           )  Этот сервер находится за NAT. Укажите общедоступный IPv4-адрес или имя хоста?" ;
      
    read -p " $( echo -e " $(red_1           ) Публичный IPv4-адрес / hostname: " ) " -e PUBLICIP 
    fi
    
    function a_b()
    {
      echo
      echo -e " B) Какой протокол вы хотите использовать\n для соединений с OpenVPN?\n"  
      echo -e "   1) UDP (рекомендуется)"  
      echo -e "   2) TCP\n"
    }
      
      (( a_b ) | bat -l nix -p ) 2>/dev/null || a_b ;
      read -p " Протокол [1-2]: " -e -i 1 PROTOCOL
    
    case $PROTOCOL in
      1) 
      PROTOCOL=udp
      ;;
      2) 
      PROTOCOL=tcp
      ;;
    esac
    
    function a_c()
    {
      echo
      echo -e " C) Укажите порт для входящих соединений к OpenVPN?\n" 
      
    }
      (( a_c ) | bat -l nix -p ) 2>/dev/null || a_c ;
      read -p "   Порт: " -e -i 1194 PORT
    
    function a_d()
    {
      echo
      echo -e " D) Какой DNS вы хотите использовать с VPN?\n" 
      echo -e "   1) Текущий который установлен в системе" 
      echo -e "   2) 1.1.1.1" 
      echo -e "   3) Google" 
      echo -e "   4) OpenDNS" 
      echo -e "   5) Yandex\n" 
      
    }
    (( a_d ) | bat -l nix -p ) 2>/dev/null || a_d ;
    read -p " DNS [1-5]: " -e -i 1 DNS 
   
    
    
    function a_e()
    {
      echo
      echo -e " E) Укажите имя сертификата клиента OpenVpn" 
      echo -e "    Пожалуйста, используйте только одно слово,\n    без специальных символов"  ; echo ;
      
    }
    (( a_e ) | bat -l nix -p ) 2>/dev/null || a_e ;
    read -p "    Имя клиента: " -e -i client CLIENT
    
  
    echo
    echo -e " $(black_U23A7    ) " ;
    echo -e " $(ellow_1        ) Все данные для установки OpenVPN и создания нового пользователя собраны."
    echo -e " $(ellow_1        ) Можем приступать к настройке." ;
    #echo -e " $(purple_U23A6   )" ;
    echo -e " $(black_U23A9    )\n" ;
    #read -n1 -r -p " Нажмите любую кнопку..." 
    
    press_anykey ;
    
    
    
    if [[ "$OS" = ' debian' ]]; then
      apt-get update
      apt-get install openvpn iptables openssl ca-certificates -y &>/dev/null ;
    else
      yum install epel-release -y &>/dev/null ;
      yum install openvpn iptables openssl ca-certificates -y &>/dev/null ;
    fi
    EASYRSAURL='https://github.com/OpenVPN/easy-rsa/releases/download/v3.0.5/EasyRSA-nix-3.0.5.tgz'
    wget -O ~/easyrsa.tgz "$EASYRSAURL" 2>/dev/null || curl -Lo ~/easyrsa.tgz "$EASYRSAURL" &>/dev/null ;
    tar xzf ~/easyrsa.tgz -C ~/ &>/dev/null ;
    mv ~/EasyRSA-3.0.5/ /etc/openvpn/server/
    mv /etc/openvpn/server/EasyRSA-3.0.5/ /etc/openvpn/server/easy-rsa/
    chown -R root:root /etc/openvpn/server/easy-rsa/
    rm -f ~/easyrsa.tgz
    cd /etc/openvpn/server/easy-rsa/
    ./easyrsa init-pki ;
    ./easyrsa --batch build-ca nopass ;
    EASYRSA_CERT_EXPIRE=3650 ./easyrsa build-server-full server nopass ;
    EASYRSA_CERT_EXPIRE=3650 ./easyrsa build-client-full $CLIENT nopass ;
    EASYRSA_CRL_DAYS=3650 ./easyrsa gen-crl ;
    ./easyrsa gen-dh ;
    cp pki/ca.crt pki/private/ca.key pki/issued/server.crt pki/private/server.key pki/crl.pem pki/dh.pem /etc/openvpn/server
    chown nobody:$GROUPNAME /etc/openvpn/server/crl.pem
    openvpn --genkey --secret /etc/openvpn/server/ta.key ;
    echo "port $PORT
  proto $PROTOCOL
  dev tun
  sndbuf 0
  rcvbuf 0
  ca ca.crt
  cert server.crt
  key server.key
  dh dh.pem
  auth SHA512
  tls-auth ta.key 0
  topology subnet
  server 10.10.0.0 255.255.255.0
  ifconfig-pool-persist ipp.txt" > /etc/openvpn/server/server.conf
    echo 'push "redirect-gateway def1 bypass-dhcp"' >> /etc/openvpn/server/server.conf
    case $DNS in
      1)
  
      if grep -q "127.0.0.53" "/etc/resolv.conf"; then
        RESOLVCONF='/run/systemd/resolve/resolv.conf'
      else
        RESOLVCONF='/etc/resolv.conf'
      fi
  
      grep -v '#' $RESOLVCONF | grep 'nameserver' | grep -E -o '[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}' | while read line; do
        echo "push \"dhcp-option DNS $line\"" >> /etc/openvpn/server/server.conf
      done
      ;;
      2)
      echo 'push "dhcp-option DNS 1.1.1.1"' >> /etc/openvpn/server/server.conf
      echo 'push "dhcp-option DNS 1.0.0.1"' >> /etc/openvpn/server/server.conf
      ;;
      3)
      echo 'push "dhcp-option DNS 8.8.8.8"' >> /etc/openvpn/server/server.conf
      echo 'push "dhcp-option DNS 8.8.4.4"' >> /etc/openvpn/server/server.conf
      ;;
      4)
      echo 'push "dhcp-option DNS 208.67.222.222"' >> /etc/openvpn/server/server.conf
      echo 'push "dhcp-option DNS 208.67.220.220"' >> /etc/openvpn/server/server.conf
      ;;
      5)
      echo 'push "dhcp-option DNS 77.88.8.8"' >> /etc/openvpn/server/server.conf
      echo 'push "dhcp-option DNS 77.88.8.1"' >> /etc/openvpn/server/server.conf
      ;;
    esac
    echo "keepalive 10 120
  cipher AES-256-CBC
  user nobody
  group $GROUPNAME
  persist-key
  persist-tun
  status openvpn-status.log
  verb 3
  crl-verify crl.pem" >> /etc/openvpn/server/server.conf
  
    echo 'net.ipv4.ip_forward=1' > /etc/sysctl.d/30-openvpn-forward.conf
  
    echo 1 > /proc/sys/net/ipv4/ip_forward
    if pgrep firewalld; then
      firewall-cmd --add-port=$PORT/$PROTOCOL &>/dev/null ;
      firewall-cmd --zone=trusted --add-source=10.10.0.0/24 &>/dev/null ;
      firewall-cmd --permanent --add-port=$PORT/$PROTOCOL &>/dev/null ;
      firewall-cmd --permanent --zone=trusted --add-source=10.10.0.0/24 &>/dev/null ;
      firewall-cmd --direct --add-rule ipv4 nat POSTROUTING 0 -s 10.10.0.0/24 ! -d 10.10.0.0/24 -j SNAT --to $IP &>/dev/null ;
      firewall-cmd --permanent --direct --add-rule ipv4 nat POSTROUTING 0 -s 10.10.0.0/24 ! -d 10.10.0.0/24 -j SNAT --to $IP &>/dev/null ;
    else
      echo "[Unit]
  Before=network.target
  [Service]
  Type=oneshot
  ExecStart=/sbin/iptables -t nat -A POSTROUTING -s 10.10.0.0/24 ! -d 10.10.0.0/24 -j SNAT --to $IP
  ExecStart=/sbin/iptables -I INPUT -p $PROTOCOL --dport $PORT -j ACCEPT
  ExecStart=/sbin/iptables -I FORWARD -s 10.10.0.0/24 -j ACCEPT
  ExecStart=/sbin/iptables -I FORWARD -m state --state RELATED,ESTABLISHED -j ACCEPT
  ExecStop=/sbin/iptables -t nat -D POSTROUTING -s 10.10.0.0/24 ! -d 10.10.0.0/24 -j SNAT --to $IP
  ExecStop=/sbin/iptables -D INPUT -p $PROTOCOL --dport $PORT -j ACCEPT
  ExecStop=/sbin/iptables -D FORWARD -s 10.10.0.0/24 -j ACCEPT
  ExecStop=/sbin/iptables -D FORWARD -m state --state RELATED,ESTABLISHED -j ACCEPT
  RemainAfterExit=yes
  [Install]
  WantedBy=multi-user.target" > /etc/systemd/system/openvpn-iptables.service
      systemctl enable --now openvpn-iptables.service &>/dev/null ;
    fi
  
    if sestatus 2>/dev/null | grep "Current mode" | grep -q "enforcing" && [[ "$PORT" != '1194' ]]; then
  
      if ! hash semanage 2>/dev/null; then
        if grep -qs "CentOS Linux release 7" "/etc/centos-release"; then
          yum install policycoreutils-python -y &>/dev/null ;
        else
          yum install policycoreutils-python-utils -y &>/dev/null ;
        fi
      fi
      semanage port -a -t openvpn_port_t -p $PROTOCOL $PORT &>/dev/null ;
    fi
  
    systemctl enable --now openvpn-server@server.service &>/dev/null ;
  
    if [[ "$PUBLICIP" != "" ]]; then
      IP=$PUBLICIP
    fi
  
    echo "client
  dev tun
  proto $PROTOCOL
  sndbuf 0
  rcvbuf 0
  remote $IP $PORT
  resolv-retry infinite
  nobind
  persist-key
  persist-tun
  remote-cert-tls server
  auth SHA512
  cipher AES-256-CBC
  setenv opt block-outside-dns
  key-direction 1
  verb 3" > /etc/openvpn/server/client-common.txt
  
    newclient "$CLIENT"
    
    function a_f()
    {
      
      echo
      echo -e " $(black_U23A7    ) " ;
      echo -e " $(ellow_1        )  Установка ${BLACK}OpenVpn${NC} успешно завершена!"
      echo -e " $(ellow_1        )  Конфигурационный файл клиента доступен в файле: " ;
      echo -e " $(ellow_1        )  ~/$CLIENT.ovpn" ;
      echo -e " $(ellow_1        )  Если вы хотите добавить больше клиентов, вам просто нужно" ;
      echo -e " $(ellow_1        )  снова запустить этот скрипт командой: $(red_U0023) ${BLACK}vdsetup -ov${NC}" ;
      echo -e " $(black_U23A9    )\n" ;
    }
     a_f ;
   
    
    
  
  
  fi
  

  
  
    exit 0
  
  
  