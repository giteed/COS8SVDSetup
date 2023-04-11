#!/bin/bash

# Source global definitions
# --> Прочитать настройки из /root/.bashrc
. /root/.bashrc


# --> Этот ссылка на функцию проверяет, запущен-ли скрипт с правами суперпользователя (root) в Linux.
. /root/vdsetup.2/bin/functions/run_as_root.sh ;

function core_up() {

	press_enter_to_continue_or_ESC_or_any_key_to_cancel ;
	/root/vdsetup.2/bin/utility/system/core/kernel-up.sh ;
}



# Выводим описание вывода uname -r
echo -en "\n Output of 'uname -r': "

# Выводим результат команды uname -r
uname -r

# Выводим описание вывода ls -l /boot/vmlinuz-*
echo -e "\n Output of 'ls -l /boot/vmlinuz-*':"

# Выводим результат команды ls -l /boot/vmlinuz-*
ls -l /boot/vmlinuz-*

# Ищем в выводе ls -l /boot/vmlinuz-* строку с ядром '6.'
if ls -l /boot/vmlinuz-* | grep -q "vmlinuz-6\."
then
  # Если в выводе ls -l /boot/vmlinuz-* присутствует ядро '6.' и uname -r выводит ядро меньше чем 6.,
  # то выполняем команду fix.sh
  if [ "$(uname -r | cut -d'.' -f1)" -lt 6 ]
  then
	echo -e "\n Kernel version is less than 6, running core_grubby_help"
	core_grubby_help ;
  fi
else
  # Если в выводе ls -l /boot/vmlinuz-* не присутствует ядро '6.' и uname -r выводит ядро меньше чем 6.,
  # то выполняем команду upcore.sh
  if [ "$(uname -r | cut -d'.' -f1)" -lt 6 ]
  then
	echo -e "\n Kernel version is less than 6 and vmlinuz-6.* is not found, running core_up"
	echo -e " Версия ядра "$(uname -r)" не поддерживает WireGuard\n Перед установкой WireGuard вам нужно обновить ядро Linux CentOS." && core_up ; echo ;
  fi
fi

echo -e "\n All OK\n"

exit 0

