#!/bin/bash

# --> Source global definitions
# --> Прочитать настройки из /root/.bashrc
. /root/.bashrc

# --> Эта ссылка на функцию проверяет, запущен-ли скрипт с правами суперпользователя (root) в Linux.
. /root/vdsetup.2/bin/functions/run_as_root.sh ;

auto_restart="$1"
#echo -e " Auto-Restart unit до условия = $auto_restart"

if [ -z $auto_restart ]; then
	auto_restart=180
fi
#echo -e " Отладка: Auto-Restart unit после условия = $auto_restart"

# Создание файла юнита
unit_file="/etc/systemd/system/desktop_shredder.service"

# Проверка наличия файла юнита
if [ -f "$unit_file" ]; 
		then
			ttb=$(echo -e "$(desktop_shredder_status)") && lang=cr && bpn_p_lang ;
			ttb=$(echo -e "\n The desktop_shredder.service unit already exists.\n Remove it?\n") && lang=cr && bpn_p_lang ;
			press_enter_to_continue_or_ESC_or_any_key_to_cancel ;
		# Выключение и удаление старого юнита
			systemctl disable desktop_shredder.service 2>/dev/null ;
			systemctl stop desktop_shredder.service ;
		# Перезагрузка конфигурации юнитов
			systemctl daemon-reload
		# Удаление файла старого юнита
			rm /etc/systemd/system/desktop_shredder.service ;
		$0 "$auto_restart"
	 exit 1
fi

auto_restart="$1"
# Создание юнита

function create_desktop_shredder_service() {
	 
cat << EOF > "$unit_file"
[Unit]
Description=The Linux Desktop Shredder $auto_restart sec auto-start.

[Service]
Type=simple
User=root
# Запуск Desktop Shredder в автоматическом режиме: /root/vdsetup.2/bin/utility/install/shredder/shredder.sh ds
# Запуск Shredder в ручном режиме: /root/vdsetup.2/bin/utility/install/shredder/shredder.sh man
# Для контроля работы Desktop Shredder: # screen -r d_s_h_r_e_d_d_e_r
ExecStart=sudo screen -dmS d_s_h_r_e_d_d_e_r /root/vdsetup.2/bin/utility/install/shredder/shredder.sh ds

# Опция Restart установлена на always, 
# Unit будет перезапускаться всегда, когда он
# завершается, независимо от причины.
Restart=always

# Опция RestartSec указывает задержку 
# в секундах между перезапусками. 
RestartSec=$auto_restart

# Опция StartLimitInterval установлена на 0
# чтобы отключить любые ограничения на перезапуск в случае неудачи.
StartLimitInterval=0


[Install]
WantedBy=multi-user.target
EOF
      
     	# Перезагрузка конфигурации юнитов
	 	systemctl daemon-reload ;
	 	
	 	# Включение и запуск юнита
	 	systemctl enable desktop_shredder.service ;
	 	systemctl start desktop_shredder.service ;
	 	systemctl status -n0 --no-pager desktop_shredder.service ; 
	 	ttb=$(cat /etc/systemd/system/desktop_shredder.service) && lang=nix && bpn_lang ;
	 	ttb=$(echo -e "\n The desktop_shredder.service unit was successfully created and started.\n\n To set a different auto restart time for a unit,\n enter # dsunit_reinstall [time in seconds]\ For example: # dsunit_reinstall 600\n View Status of Desktop Shredder # dsus" ) && lang=cr && bpn_p_lang ;
	 	echo ; 
	 	ttb=$(echo -e "$(desktop_shredder_status)") && lang=cr && bpn_p_lang ;
	 
	}

	create_desktop_shredder_service $auto_restart ;
	
	exit 0

