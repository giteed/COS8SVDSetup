#!/bin/bash

# Source global definitions
# --> Прочитать настройки из /root/.bashrc
. ~/.bashrc


  function locale()
  {
	echo -e "
	Если вы хотите исправить ошибку для только вашей учетной записи введите команды приведенные ниже:
	# echo "export LC_ALL=en_US.utf-8" >> ~/.bashrc
	# echo "export LANG=en_US.utf-8" >> ~/.bashrc
	# source ~/.bashrc
	Если вы хотите исправить ошибку глобально для всех пользователей системы нажмите Enter
	
	Будут внесены изменения в Файл /etc/environment - это системный файл конфигурации в Linux, который содержит переменные среды для всех пользователей системы. Когда пользователь входит в систему, эти переменные среды устанавливаются глобально для всех процессов, выполняемых в системе. В этом файле могут быть определены различные переменные среды, такие как переменные PATH, LANG, LC_ALL и другие. Он используется для установки глобальных переменных среды, которые могут быть доступны для всех пользователей в системе и не зависят от логина.
	"
	press_enter_to_continue_or_any_key_to_cancel()
	
} locale ; exit 
	echo -e "
	# --> Файл /etc/environment - это системный файл конфигурации в Linux, который содержит переменные среды для всех пользователей системы. Когда пользователь входит в систему, эти переменные среды устанавливаются глобально для всех процессов, выполняемых в системе. В этом файле могут быть определены различные переменные среды, такие как переменные PATH, LANG, LC_ALL и другие. Он используется для установки глобальных переменных среды, которые могут быть доступны для всех пользователей в системе и не зависят от логина.
	#
	LANGUAGE=en_US.utf8
	LC_ALL=en_US.utf8
	LANG=en_US.utf8
	LC_TYPE=en_US.utf8
	 " > /etc/environment ;
	 echo -e "\n Исправлено ($( green_tick ))\n Перезапустите ssh сессию!\n"  ;
	 ( bat /etc/environment --paging=never -l nix -p ; ) 2>/dev/null || ( cat /etc/environment ; ) ;
  }

locale ;


exit 0 ; 
