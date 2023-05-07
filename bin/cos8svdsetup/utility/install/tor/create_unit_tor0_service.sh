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


function stop_disable_remove_unit() {
    
    # Выключение и удаление старого юнита из systemd
        systemctl disable tor0.service 2>/dev/null ;
        systemctl stop tor0.service 2>/dev/null ;
    # Перезагрузка конфигурации юнитов
        systemctl daemon-reload
}

ifconfig tor0 >/dev/null 2>&1 || stop_disable_remove_unit 2>/dev/null ;


#echo -e " Отладка: Interface Name unit после условия = $intrface_name"
# Получение $ip_mask с $intrface_name
ip_mask="$(ip -o -f inet addr show | grep "$intrface_name" | awk '{print $4}')"

# Создание файла юнита
unit_file="/etc/systemd/system/tor0.service"

# Проверка наличия файла юнита
if [ -f "$unit_file" ]; 
        then
            echo ;
            (ttb=$(echo -e "$(ifconfig "$intrface_name")") && lang=cr && bpn_p_lang ;) 2>/dev/null ;
            
            ttb=$(echo -e "\n The "$intrface_name".service unit already exists.\n Remove it?\n") && lang=cr && bpn_p_lang ;
            ttb=$(echo -e " This command will remove the "$intrface_name" interface from the system: # sudo ip link delete "$intrface_name" ") && lang=cr && bpn_p_lang ;
            ttb=$(echo -e " This command will turn off the "$intrface_name" interface in the system: # sudo ip link set dev $intrface_name down ") && lang=cr && bpn_p_lang ;
            ttb=$(echo -e " You can delete the current IP address of the "$intrface_name" interface using the command: # sudo ip addr del "$ip_mask" dev "$intrface_name" ") && lang=cr && bpn_p_lang ;
            ttb=$(echo -e " And then add another new IP address using the command: # sudo ip addr add 10.0.1.1/24 dev tor0 ") && lang=cr && bpn_p_lang ;
            ttb=$(echo -e "  ") && lang=cr && bpn_p_lang ;
            
            press_enter_to_continue_or_ESC_or_any_key_to_cancel ;
        # Выключение и удаление старого юнита из systemd
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
# Если переменная $1 на вход не передана то назначается intrface_name="tor0"
if [ -z $intrface_name ]; then
  intrface_name="tor0"
fi


# Создание юнита
create_tor0_service() {
  cat <<EOF > /etc/systemd/system/tor0.service
[Unit]
  # Описание сервиса, отображается при запуске системы
  Description=Tor network interface  
  # Сообщает системе, что сервис должен запускаться после того, как завершится загрузка сети
  After=network.target
  
  # Определяет конфигурацию сервиса
  [Service]
  # Указывает, что сервис должен выполнить одно действие и завершиться
  Type=oneshot 
  # Определяет, должен ли сервис оставаться в статусе active, даже после завершения выполнения
  RemainAfterExit=yes
  # Указывает, что сервис зависит от сетевого подключения
  Requires=network-online.target
  # Создает виртуальный сетевой мост tor0 типа bridge перед запуском сервиса
  ExecStartPre=/usr/sbin/ip link add tor0 type bridge
  # Добавляет IP-адрес 10.0.0.1/24 в интерфейс tor0
  ExecStart=/usr/sbin/ip addr add 10.0.0.1/24 dev tor0
  # Включает интерфейс tor0
  ExecStart=/usr/sbin/ip link set tor0 up
  # Удаляет интерфейс tor0 при остановке сервиса
  ExecStop=/usr/sbin/ip link del tor0
  
  # Определяет, когда и каким образом сервис должен быть запущен
  [Install]
  # Указывает, что сервис должен быть запущен в многопользовательской среде
  WantedBy=multi-user.target

EOF
    
      # Перезагрузка конфигурации юнитов
      systemctl daemon-reload
      
      # Включение и запуск юнита
      systemctl enable tor0.service ;
      systemctl start tor0.service ;
      systemctl status -n0 --no-pager tor0.service ;
      ttb=$(cat /etc/systemd/system/tor0.service) && lang=nix && bpn_lang ;
      
      ttb=$(echo -e "\n The tor0.service unit was successfully created and started.\n\n To set a different Interface Name for a unit,\n enter # tor_Interface_unit_reinstall [intrface_name]\n For example: # tor_Interface_unit_reinstall tor1\n View Status of TOR service unit # status_tor_service" ) && lang=cr && bpn_p_lang ;
      echo ;
      
      status_tor_service ; echo ;
      ttb=$(echo -e "$(ifconfig tor0)") && lang=cr && bpn_p_lang ;
    
  }
  
  create_tor0_service $intrface_name ;