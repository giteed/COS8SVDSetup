#!/bin/bash

# Source global definitions
# --> Прочитать настройки из /root/.bashrc
. /root/.bashrc

# --> Эта ссылка на функцию проверяет, запущен-ли скрипт с правами суперпользователя (root) в Linux.
. /root/vdsetup.2/bin/functions/run_as_root.sh ;


intrface_name="$1"
#echo -e " Interface Name unit до условия = $intrface_name"

# Если переменная $1 на вход не передана то назначается intrface_name="tor0"
if [ -z $intrface_name ]; then
    intrface_name="tor0"
fi
echo -e " Отладка: Interface Name unit после условия = $intrface_name"

# Получение $ip_mask с $intrface_name или значение по умолчанию 10.0.0.1/24
(ip_mask="$(ip -o -f inet addr show | grep "$intrface_name" | awk '{print $4}')") || $ip_mask="10.0.0.1/24"

# Если переменная $2 на вход не передана то назначается ip_mask="10.0.0.1/24"
if [ -z $ip_mask ]; then
    ip_mask="10.0.0.1/24"
fi


# Создание файла юнита
unit_file="/etc/systemd/system/"${intrface_name}".service"

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
            systemctl disable "$intrface_name".service 2>/dev/null ;
            systemctl stop "$intrface_name".service ;
        # Перезагрузка конфигурации юнитов
            systemctl daemon-reload
        # Удаление файла старого юнита
            rm /etc/systemd/system/"$intrface_name".service ;
        $0 "$intrface_name"
     exit 1
fi

intrface_name="$1"

# Создание юнита
create_intrface_name_service() {
  cat <<EOF > /etc/systemd/system/$intrface_name.service
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
  # Создает виртуальный сетевой мост $intrface_name типа bridge перед запуском сервиса
  ExecStartPre=/usr/sbin/ip link add $intrface_name type bridge
  # Добавляет IP-адрес $ip_mask в интерфейс $intrface_name
  ExecStart=/usr/sbin/ip addr add $ip_mask dev $intrface_name
  # Включает интерфейс $intrface_name
  ExecStart=/usr/sbin/ip link set $intrface_name up
  # Удаляет интерфейс $intrface_name при остановке сервиса
  ExecStop=/usr/sbin/ip link del $intrface_name
  
  # Определяет, когда и каким образом сервис должен быть запущен
  [Install]
  # Указывает, что сервис должен быть запущен в многопользовательской среде
  WantedBy=multi-user.target

EOF
    
      # Перезагрузка конфигурации юнитов
      systemctl daemon-reload
      
      # Включение и запуск юнита
      systemctl enable "$intrface_name".service ;
      systemctl start "$intrface_name".service ;
      systemctl status -n0 --no-pager "$intrface_name".service ;
      ttb=$(cat /etc/systemd/system/"$intrface_name".service)&& lang=nix && bpn_lang ;
      
      ttb=$(echo -e "\n The desktop_shredder.service unit was successfully created and started.\n\n To set a different Interface Name for a unit,\n enter # tor_Interface_unit_reinstall [intrface_name]\n For example: # tor_Interface_unit_reinstall tor1\n View Status of TOR service unit # status_tor_service" ) && lang=cr && bpn_p_lang ;
      echo ;
      
      status_tor_service ; echo ;
      ttb=$(echo -e "$(ifconfig "$intrface_name")") && lang=cr && bpn_p_lang ;
    
  }
  
  create_intrface_name_service $intrface_name ;