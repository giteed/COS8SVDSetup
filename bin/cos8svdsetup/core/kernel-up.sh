#!/bin/bash

# Source global definitions
# --> Прочитать настройки из /root/.bashrc
. /root/.bashrc

#  --> 6 марта 2023 года
#  --> Скрипт для чистого VDS сервера на базе centos 8 stream, с ядром vmlinuz-4.18.0-448.el8.x86_64 , который установит на него новое ядро vmlinuz-6.2.2-1.el8.elrepo.x86_64

#  --> Смотрим какое ядро используется в данный момент:
	echo -en "\n Смотрим какое ядро используется в данный момент: "
	uname -r ;
	echo -en " 
	Если вы продолжите ядро будет обновлено! 
	Нажмите ESC если вас устраивает текущая версия ядра!\n "
	press_enter_to_continue_or_ESC_or_any_key_to_cancel ;

#  --> Первым шагом обновим все установленные пакеты:
	sudo yum update -y ; echo ;

#  --> Установим необходимые зависимости для установки нового ядра:
	sudo yum install -y elfutils-libelf-devel gcc gcc-c++ make rpm-build ;  echo ;

#  --> Скачаем и установим репозиторий ELRepo:
	sudo rpm --import https://www.elrepo.org/RPM-GPG-KEY-elrepo.org ; echo ;
	sudo rpm -Uvh https://www.elrepo.org/elrepo-release-8.0-2.el8.elrepo.noarch.rpm ; echo ;
	#  --> или:
	# sudo rpm -Uvh https://www.elrepo.org/elrepo-release-8.el8.elrepo.noarch.rpm
	# dnf install https://www.elrepo.org/elrepo-release-8.0-2.el8.elrepo.noarch.rpm

#  --> Установим новое ядро из репозитория ELRepo:
	sudo yum --enablerepo=elrepo-kernel install -y kernel-ml ; echo ;

#  --> Обновим конфигурацию загрузчика:
	sudo grub2-mkconfig -o /boot/grub2/grub.cfg ; echo ;


echo -en " 
 Ядро до перезагрузки: "
 	uname -r ; echo ;
 
 echo -e "	Требуется перезагрузка сервера!
	Нажмите Enter
	# sudo reboot"
 
    press_enter_to_continue_or_ESC_or_any_key_to_cancel ;
 
 echo -e "	
	Подождите, сервер перезагружается...
	Перезайдите через минуту...
	После перезагрузки, можно убедиться, что новое 
	ядро было успешно установлено, выполнив команду:
	# uname -r "
	
#  --> Перезагрузим сервер:
	sudo reboot

 echo ;


exit 0


https://itisgood.ru/2020/05/07/kak-izmenit-defoltnoe-jadro-zagruzka-so-starogo-jadra-v-centos-rhel-8/

загрузка со старого ядра с использованием индекса
1. Перечислите доступные имена файлов ядра, доступные в вашей системе:

# ls -l /boot/vmlinuz-*
-rwxr-xr-x. 1 root root 7872864 Apr 26  2019 /boot/vmlinuz-0-rescue-d026443091424a74948f9f62d2adb9b5
-rwxr-xr-x. 1 root root 7868768 Jun 19  2019 /boot/vmlinuz-0-rescue-ec2b9a54dc859388d7bc348e87df5332
-rwxr-xr-x. 1 root root 8106848 Nov 11 13:07 /boot/vmlinuz-4.18.0-147.0.3.el8_1.x86_64
-rwxr-xr-x. 1 root root 7876960 Sep 15  2019 /boot/vmlinuz-4.18.0-80.11.2.el8_0.x86_64
-rwxr-xr-x. 1 root root 7881056 Jul 26  2019 /boot/vmlinuz-4.18.0-80.7.2.el8_0.x86_64
2. Для просмотра индекса любого из перечисленных выше ядер:

# grubby --info [kernel-filename] | grep index
Например:

# grubby --info /boot/vmlinuz-4.18.0-80.11.2.el8_0.x86_64 | grep index
index=1
3. Теперь, когда вы знаете индекс ядра, с которого хотите загрузиться, используйте команду:

# grubby --set-default-index=[kernel-entry-index]
Например:

# grubby --set-default-index=1