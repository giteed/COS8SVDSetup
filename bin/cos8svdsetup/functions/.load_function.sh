#!/bin/bash

# --> Прочитать настройки из файла с функциями:

#  --> vdsetup вызов меню утилиты
. /root/vdsetup.2/bin/functions/vdsetup.sh

# --> Загрузка функций с HELP
	. /root/vdsetup.2/bin/.help/.load_help_func.sh
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
# --> Листинг файлов/папок и их цифровых прав доступа:
	. /root/vdsetup.2/bin/functions/lk-f.sh
#  --> Поиски
	. /root/vdsetup.2/bin/functions/find.sh
#  --> net_func
	. /root/vdsetup.2/bin/functions/net_func.sh
#  --> netstat -tulanp | head --lines 2 | grep -v "Active Internet"
	. /root/vdsetup.2/bin/functions/wport.sh
#  --> tor
	. /root/vdsetup.2/bin/functions/tor.sh
#  --> delay таймеры
	. /root/vdsetup.2/bin/functions/delay.sh
#  --> Часы таймеры
	. /root/vdsetup.2/bin/functions/timer.sh
#  --> Память и диски
	. /root/vdsetup.2/bin/functions/mem.sh
#  --> Разные функции
	. /root/vdsetup.2/bin/functions/other.sh
#  --> Desktop Shredder status и управление функциями
	. /root/vdsetup.2/bin/functions/desktop_shredder.sh

