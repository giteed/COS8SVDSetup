#!/bin/bash

# --> Переключить загрузку ядра.
	. /root/vdsetup.2/bin/.help/core_grubby_help.sh
# --> Добавление пользователя в группу sudo (wheel).
	. /root/vdsetup.2/bin/.help/sudo_wheel_readme.sh
# --> Установка и удаление репозиториев/пакетов (packages) на CentOS.
	. /root/vdsetup.2/bin/.help/rpm_readme.sh
# --> Про функцию, предназначенную для определения доступных портов Tor на локальной машине и сохранения этой информации в переменной tor_port
	. /root/vdsetup.2/bin/.help/tor_port_ch_help
# --> Про функцию, wport.
	. /root/vdsetup.2/bin/.help/wport_help.sh
# --> Про менеджер пакетов Snapd - система управления приложениями для OS систем на базе Linux.
	. /root/vdsetup.2/bin/.help/snap_install_help.sh
# --> Качалка файлов с файло-обменников через сеть TOR
	. /root/vdsetup.2/bin/.help/dtfex_help.sh