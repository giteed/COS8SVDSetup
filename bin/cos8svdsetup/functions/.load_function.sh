#!/bin/bash

# --> Прочитать настройки из файла с функциями:
# --> Работа с текстовым процессором bat для подсветки синтаксиса терминала.
	sudo /root/vdsetup.2/bin/functions/bat_or_bat_not_installed.sh
# --> Этот код, запрашивает пользователя подтверждение для продолжения.
	sudo /root/vdsetup.2/bin/functions/press_enter.sh
# --> Поиск программы/файла локально и в репо по 7 командам.
	sudo /root/vdsetup.2/bin/functions/ypr.sh
# --> Поиск информации о программе сразу по 11 командам.
	sudo /root/vdsetup.2/bin/functions/ww.sh
# --> Информация о ip адресах и некоторые другие информационные функции о системе.
	sudo /root/vdsetup.2/bin/functions/ip_other_info_func.sh
# --> клонирование из gh repo запуск /preloader.sh (в планах частичная синхронизация)
	sudo /root/vdsetup.2/bin/functions/vsync.sh
# --> Проверяет или устанавливает проверяемые компоненты.	
	sudo /root/vdsetup.2/bin/functions/check_or_install.sh


# --> Этот функция проверяет, запущен ли скрипт с правами суперпользователя (root) в Linux.
#	sudo /root/vdsetup.2/bin/functions/run_as_root.sh