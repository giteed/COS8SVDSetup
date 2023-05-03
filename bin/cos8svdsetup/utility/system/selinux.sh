#!/bin/bash

# Source global definitions
# --> Прочитать настройки из /root/.bashrc
. /root/.bashrc


# --> Эта ссылка на функцию проверяет, запущен-ли скрипт с правами суперпользователя (root) в Linux.
. /root/vdsetup.2/bin/functions/run_as_root.sh ;

	echo ;

	echo -e ""${GRAY}"
	"${GREEN}"getenforce "${GRAY}"сообщает в каком состоянии находится "${GREEN}"SELinux"${GRAY}": 
	# Используйте следующую команду, чтобы временно отключить "${GREEN}"SElinux"${GRAY}".
	# "${GREEN}"setenforce 0 "${GRAY}"
	# Используйте следующую команду, чтобы временно включить "${GREEN}"SElinux"${GRAY}".
	# "${GREEN}"setenforce 1 "${GRAY}"
"${GREEN}"";
	echo -en "	" ; getenforce ;
	echo -e " 
"${GRAY}"
	# "${GREEN}"Enforcing "${GRAY}"(включен), 
	# "${GREEN}"Permissive "${GRAY}"(включен в режиме уведомлений), 
	# "${RED}"Disabled "${GRAY}"(отключен).
"${RED}"
	Отключаю на постоянной основе "${GREEN}"SELinux"${GRAY}"
	Если требуется включить "${GREEN}"SElinux"${GRAY}" 
	Откройте для редактирования файл "${GREEN}"$ nano "${RED}"/etc/selinux/config
	Содержимое файла "${GREEN}"cat "${RED}"/etc/selinux/config
"${GRAY}"
	"
cat /etc/selinux/config;
cp /etc/selinux/config /etc/selinux/config.backup;
echo \# This file controls the state of SELinux on the system. > /etc/selinux/config
echo \# SELINUX= can take one of these three values: >> /etc/selinux/config
echo \#     enforcing - SELinux security policy is enforced. >> /etc/selinux/config
echo \#     permissive - SELinux prints warnings instead of enforcing. >> /etc/selinux/config
echo \#     disabled - No SELinux policy is loaded. >> /etc/selinux/config
echo SELINUX=disabled >> /etc/selinux/config
echo \# SELINUXTYPE= can take one of three values: >> /etc/selinux/config
echo \#     targeted - Targeted processes are protected, >> /etc/selinux/config
echo \#     minimum - Modification of targeted policy. Only selected processes are protected. >> /etc/selinux/config
echo \#     mls - Multi Level Security protection. >> /etc/selinux/config
echo SELINUXTYPE=targeted >> /etc/selinux/config

	sestatus;



exit 0 ;




