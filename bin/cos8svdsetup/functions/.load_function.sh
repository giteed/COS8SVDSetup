#!/bin/bash

# --> Прочитать настройки из файла с функциями:
# --> Работа с текстовым процессором bat для подсветки синтаксиса терминала.
	. /root/vdsetup.2/bin/functions/bat_or_bat_not_installed.sh
# --> Этот код, запрашивает пользователя подтверждение для продолжения.
	. /root/vdsetup.2/bin/functions/press_enter.sh
# --> Поиск программы/файла локально и в repository по 7 командам.
	. /root/vdsetup.2/bin/functions/wis.sh
# --> Поиск информации о программе сразу по 11 командам.
	. /root/vdsetup.2/bin/functions/ww.sh
# --> Информация о ip адресах и некоторые другие информационные функции о системе.
	. /root/vdsetup.2/bin/functions/ip_other_info_func.sh
# --> клонирование из gh repo запуск /preloader.sh (в планах частичная синхронизация)
	. /root/vdsetup.2/bin/functions/vsync.sh
# --> Проверяет или устанавливает проверяемые компоненты.	
	. /root/vdsetup.2/bin/functions/check_or_install.sh
 # Листинг файлов/папок и их цифровых прав доступа:
	. /root/vdsetup.2/bin/functions/lk-f.sh
#  --> Поиски
	. /root/vdsetup.2/bin/functions/find.sh
#  --> net_func
	. /root/vdsetup.2/bin/functions/net_func.sh




# --> Этот ссылка на функцию проверяет, запущен-ли скрипт с правами суперпользователя (root) в Linux.
#	. /root/vdsetup.2/bin/functions/run_as_root.sh