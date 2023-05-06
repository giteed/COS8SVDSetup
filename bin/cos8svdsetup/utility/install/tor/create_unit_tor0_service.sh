#!/bin/bash

# Source global definitions
# --> Прочитать настройки из /root/.bashrc
. /root/.bashrc

# --> Эта ссылка на функцию проверяет, запущен-ли скрипт с правами суперпользователя (root) в Linux.
. /root/vdsetup.2/bin/functions/run_as_root.sh ;


intrface_name="$1"
#echo -e " Interface Name unit до условия = $intrface_name"

if [ -z $intrface_name ]; then
    intrface_name="tor0"
fi
#echo -e " Отладка: Interface Name unit после условия = $intrface_name"
# Получение $ip_mask с $intrface_name
ip_mask="$(ip -o -f inet addr show | grep "$intrface_name" | awk '{print $4}')"

# Создание файла юнита
unit_file="/etc/systemd/system/tor0.service"

# Проверка наличия файла юнита
if [ -f "$unit_file" ]; 
        then
            echo ;
            ttb=$(echo -e "$(ifconfig "$intrface_name")") && lang=cr && bpn_p_lang ;
            
            ttb=$(echo -e "\n The "$intrface_name".service unit already exists.\n Remove it?\n") && lang=cr && bpn_p_lang ;
            ttb=$(echo -e " This command will remove the "$intrface_name" interface from the system: # sudo ip link delete "$intrface_name" ") && lang=cr && bpn_p_lang ;
            ttb=$(echo -e " This command will turn off the "$intrface_name" interface in the system: # sudo ip link set dev $intrface_name down ") && lang=cr && bpn_p_lang ;
            ttb=$(echo -e " You can delete the current IP address of the "$intrface_name" interface using the command: # sudo ip addr del "$ip_mask" dev "$intrface_name" ") && lang=cr && bpn_p_lang ;
            
            
            press_enter_to_continue_or_ESC_or_any_key_to_cancel ;
        # Вsключение и удаление старого юнита
            systemctl disable tor0.service 2>/dev/null ;
            systemctl stop tor0.service ;
        # Перезагрузка конфигурации юнитов
            systemctl daemon-reload
        # Удаление файла старого юнита
            rm /etc/systemd/system/tor0.service ;
        $0 "$intrface_name"
     exit 1
fi

intrface_name="$1"

# Создание юнита
create_tor0_service() {
  cat <<EOF > /etc/systemd/system/tor0.service
[Unit]
  Description=Tor network interface
  After=network.target
  
  [Service]
  Type=oneshot
  RemainAfterExit=yes
  Requires=network-online.target
  ExecStartPre=/usr/sbin/ip link add tor0 type bridge
  ExecStart=/usr/sbin/ip addr add 10.0.0.1/24 dev tor0
  ExecStart=/usr/sbin/ip link set tor0 up
  ExecStop=/usr/sbin/ip link del tor0
  
  [Install]
  WantedBy=multi-user.target

EOF
    
      # Перезагрузка конфигурации юнитов
      systemctl daemon-reload
      
      # Включение и запуск юнита
      systemctl enable tor0.service ;
      systemctl start tor0.service ;
      systemctl status -n0 --no-pager tor0.service ;
      ttb=$(cat /etc/systemd/system/tor0.service)&& lang=nix && bpn_lang ;
      
      ttb=$(echo -e "\n The desktop_shredder.service unit was successfully created and started.\n\n To set a different Interface Name for a unit,\n enter # tor_Interface_unit_reinstall [intrface_name]\n For example: # tor_Interface_unit_reinstall tor1\n View Status of TOR service unit # status_tor_service" ) && lang=cr && bpn_p_lang ;
      echo ;
      
      status_tor_service ; echo ;
      ttb=$(echo -e "$(ifconfig tor0)") && lang=cr && bpn_p_lang ;
    
  }
  
  create_tor0_service $intrface_name ;