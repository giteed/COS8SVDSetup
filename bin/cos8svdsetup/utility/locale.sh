#!/bin/bash

# Source global definitions
# --> Прочитать настройки из /root/.bashrc
. /root/.bashrc

lang_x 2>/dev/null ;

# --> Этот функция проверяет, запущен ли скрипт с правами суперпользователя (root) в Linux.
. /root/vdsetup.2/bin/functions/run_as_root.sh

# --> Иправляет ошибку "Failed to set locale, defaulting to C.UTF-8"
  function locale() {
	echo -e "
	Если вы хотите исправить ошибку: 
	\"Failed to set locale, defaulting to C.UTF-8\" 
	для только вашей учетной записи введите 
	команды приведенные ниже:
	
	# echo \"export LC_ALL=en_US.utf-8\" >> /root/.bashrc
	# echo \"export LANG=en_US.utf-8\" >> /root/.bashrc
	# source /root/.bashrc
	
	Если вы хотите исправить ошибку глобально для 
	всех пользователей системы нажмите Enter
	
	Будут внесены изменения в Файл /etc/environment 
	- это системный файл конфигурации в Linux, 
	который содержит переменные среды для всех 
	пользователей системы. Когда пользователь входит 
	в систему, эти переменные среды устанавливаются 
	глобально для всех процессов, выполняемых в системе. 
	В этом файле могут быть определены различные 
	переменные среды, такие как переменные 
	PATH, LANG, LC_ALL и другие. Он используется для 
	установки глобальных переменных среды, которые 
	могут быть доступны для всех пользователей в с
	истеме и не зависят от логина.
	"
press_enter_to_continue_or_ESC_or_any_key_to_cancel ;

	# --> создаю копию файла перед внесением изменений /etc/environment_$(date '+%Y-%m-%d_%H-%M-%S').bak
	 sudo cp /etc/environment /etc/environment_$(date '+%Y-%m-%d_%H-%M-%S').bak
	echo -e " Копия файла перед внесением изменений 
	сделана в файл /etc/environment_$(date '+%Y-%m-%d_%H-%M-%S').bak"
	echo -e "
	# --> Файл /etc/environment 	- это системный файл конфигурации в Linux, 
	который содержит переменные среды для всех 
	пользователей системы. Когда пользователь входит 
	в систему, эти переменные среды устанавливаются 
	глобально для всех процессов, выполняемых в системе. 
	В этом файле могут быть определены различные 
	переменные среды, такие как переменные 
	PATH, LANG, LC_ALL и другие. Он используется для 
	установки глобальных переменных среды, которые 
	могут быть доступны для всех пользователей в с
	истеме и не зависят от логина.
	#
	LANGUAGE=en_US.utf8
	LC_ALL=en_US.utf8
	LANG=en_US.utf8
	LC_TYPE=en_US.utf8
	 " > /etc/environment ;
	 echo -e "\n Исправлено! ($( green_tick ))\n Перезапустите ssh сессию или введите source /root/.bashrc\n"  ;
	 ( bat /etc/environment --paging=never -l nix -p ; ) 2>/dev/null || ( cat /etc/environment ; ) ;
	 
  }

locale ;


exit 0 ; 
