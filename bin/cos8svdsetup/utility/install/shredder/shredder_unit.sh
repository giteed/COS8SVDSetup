#!/bin/bash

# --> Source global definitions
# --> Прочитать настройки из /root/.bashrc
. /root/.bashrc


# Создание файла юнита
unit_file="/etc/systemd/system/desktop_shredder.service"

# Проверка наличия юнита
if [ -f "$unit_file" ]; then
	ttb=$(echo -e "\n The desktop_shredder.service unit already exists.\n Remove it?\n") && lang=cr && bpn_p_lang ; press_enter_to_continue_or_ESC_or_any_key_to_cancel ;
	# Вsключение и удаление старого юнита
	systemctl disable desktop_shredder.service 2>/dev/null ;
	systemctl stop desktop_shredder.service ;
	# Перезагрузка конфигурации юнитов
	systemctl daemon-reload
	# Удаление файла старого юнита
	rm /etc/systemd/system/desktop_shredder.service ;
	$0
	exit 1
fi

# Создание юнита
cat << EOF > "$unit_file"
[Unit]
Description=The Linux Desktop Shredders.

[Service]
Type=simple
User=root
ExecStart=sudo screen -dmS shredder /root/vdsetup.2/bin/utility/install/shredder/shredder.sh ds
#ExecStop=screen -S shredder -X quit

# Опция Restart установлена на always, 
# юнит будет перезапускаться всегда, когда он
# завершается, независимо от причины.
Restart=always

# Опция RestartSec указывает задержку 
# в секундах между перезапусками. 
RestartSec=45

# Опция StartLimitInterval установлена на 0
# чтобы отключить любые ограничения на перезапуск в случае неудачи.
StartLimitInterval=0


[Install]
WantedBy=multi-user.target
EOF

# Перезагрузка конфигурации юнитов
systemctl daemon-reload

# Включение и запуск юнита
systemctl enable desktop_shredder.service ;
systemctl start desktop_shredder.service ;
systemctl status -n0 --no-pager desktop_shredder.service ;

ttb=$(echo -e "\n The desktop_shredder.service unit was successfully created and started." ) && lang=cr && bpn_p_lang ;


exit 0
