#!/bin/bash

# --> Source global definitions
# --> Прочитать настройки из /root/.bashrc
. /root/.bashrc


# Создание файла юнита
unit_file="/etc/systemd/system/desktop_shredder.service"

# Проверка наличия юнита
if [ -f "$unit_file" ]; then
	ttb=$(echo -e "\n The desktop_shredder.service unit already exists.") && lang=cr && bpn_p_lang ;
	exit 1
fi

# Создание юнита
cat << EOF > "$unit_file"
[Unit]
Description=The Linux Desktop Shredders.

[Service]
Type=oneshot
ExecStart=/bin/bash /usr/bin/screen -dmS shredder sudo -u root /root/vdsetup.2/bin/utility/install/shredder/shredder.sh
ExecStop=/usr/bin/screen -S shredder -X quit

[Timer]
OnUnitActiveSec=5m
Unit=desktop_shredder.service

[Install]
WantedBy=timers.target
EOF

# Перезагрузка конфигурации юнитов
systemctl daemon-reload

# Включение и запуск юнита
systemctl enable desktop_shredder.service
systemctl start desktop_shredder.service

ttb=$(echo -e "\n The desktop_shredder.service unit was successfully created and started." ) && lang=cr && bpn_p_lang ;


exit 0

