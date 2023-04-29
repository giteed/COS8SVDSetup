#!/bin/bash

# --> Прочитать настройки из файла с функциями:

# --> Работа с текстовым процессором bat для подсветки синтаксиса терминала.
	source /root/vdsetup.2/bin/.help/.load_help_func.sh
# --> Работа с текстовым процессором bat для подсветки синтаксиса терминала.
	source /root/vdsetup.2/bin/functions/bat_or_bat_not_installed.sh
# --> Этот код, запрашивает пользователя подтверждение для продолжения.
	source /root/vdsetup.2/bin/functions/press_enter.sh
# --> Поиск программы/файла локально и в repository по 7 командам.
	source /root/vdsetup.2/bin/functions/wis.sh
# --> Поиск информации о программе сразу по 11 командам.
	source /root/vdsetup.2/bin/functions/ww.sh
# --> Информация о ip адресах и некоторые другие информационные функции о системе.
	source /root/vdsetup.2/bin/functions/ip_other_info_func.sh
# --> клонирование из gh repo запуск /preloader.sh (в планах частичная синхронизация)
	source /root/vdsetup.2/bin/functions/vsync.sh
# --> Проверяет или устанавливает проверяемые компоненты.	
	source /root/vdsetup.2/bin/functions/check_or_install.sh
# --> Листинг файлов/папок и их цифровых прав доступа:
	source /root/vdsetup.2/bin/functions/lk-f.sh
#  --> Поиски
	source /root/vdsetup.2/bin/functions/find.sh
#  --> net_func
	source /root/vdsetup.2/bin/functions/net_func.sh
#  --> netstat -tulanp | head --lines 2 | grep -v "Active Internet"
	source /root/vdsetup.2/bin/functions/wport.sh
#  --> tor
	source /root/vdsetup.2/bin/functions/tor.sh
#  --> delay таймеры
	source /root/vdsetup.2/bin/functions/delay.sh
#  --> часы таймеры
	source /root/vdsetup.2/bin/functions/timer.sh
#  --> память и диски
	source /root/vdsetup.2/bin/functions/mem.sh
#  --> разные функции
	source /root/vdsetup.2/bin/functions/other.sh


# --> Этот ссылка на функцию проверяет, запущен-ли скрипт с правами суперпользователя (root) в Linux.
#	source /root/vdsetup.2/bin/functions/run_as_root.sh