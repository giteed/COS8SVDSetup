#!/bin/bash

# Source global definitions
# --> Прочитать настройки из /root/.bashrc
. /root/.bashrc


#  --> 6 марта 2023 года
#  --> Скрипт для чистого VDS сервера на базе centos 8 stream, со стандартным ядром vmlinuz-*.x86_64 , который установит на него новое ядро из репозитория ELRepo

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
 
 echo -e "	Требуется перезагрузка сервера!
	Нажмите Enter
	# sudo reboot"
 
    press_enter_to_continue_or_ESC_or_any_key_to_cancel ;
 
 echo -e "	Подождите, сервер перезагружается...
	Перезайдите через пару минут...
	После перезагрузки, можно убедиться, что новое 
	ядро было успешно установлено, выполнив команду:
	# uname -r \n"
 
 echo -en " Ядро до перезагрузки: "
	 uname -r ; echo ;	
#  --> Перезагрузим сервер:
	sudo reboot

 echo ;


exit 0





https://itisgood.ru/2020/05/07/kak-izmenit-defoltnoe-jadro-zagruzka-so-starogo-jadra-v-centos-rhel-8/

Загрузка со старого ядра с использованием индекса
1. Перечислите доступные имена файлов ядра, доступные в вашей системе:

$ ls -l /boot/vmlinuz-*
-rwxr-xr-x. 1 root root 7872864 Apr 26  2019 /boot/vmlinuz-0-rescue-d026443091424a74948f9f62d2adb9b5
-rwxr-xr-x. 1 root root 7868768 Jun 19  2019 /boot/vmlinuz-0-rescue-ec2b9a54dc859388d7bc348e87df5332
-rwxr-xr-x. 1 root root 8106848 Nov 11 13:07 /boot/vmlinuz-4.18.0-147.0.3.el8_1.x86_64
-rwxr-xr-x. 1 root root 7876960 Sep 15  2019 /boot/vmlinuz-4.18.0-80.11.2.el8_0.x86_64
-rwxr-xr-x. 1 root root 7881056 Jul 26  2019 /boot/vmlinuz-4.18.0-80.7.2.el8_0.x86_64
2. Для просмотра индекса любого из перечисленных выше ядер:

$ grubby --info [kernel-filename] | grep index
Например:

$ grubby --info /boot/vmlinuz-4.18.0-80.11.2.el8_0.x86_64 | grep index
index=1
3. Теперь, когда вы знаете индекс ядра, с которого хотите загрузиться, используйте команду:

$  grubby --set-default-index=[kernel-entry-index]
Например:

$  grubby --set-default-index=1





=======================

Определите, какие версии ядер установлены в вашей системе, выполнив команду:
rpm -qa kernel*
rpm -qa | grep kernel

Выберите те версии ядер, которые вы хотите удалить, и выполните команду:
sudo dnf remove [название пакета ядра]

Например, для удаления ядра версии 4.18.0-147.8.1.el8_1.x86_64, выполните команду:

sudo dnf remove kernel-4.18.0-147.8.1.el8_1.x86_64
После удаления ядра выполните команду:

sudo grub2-mkconfig -o /boot/grub2/grub.cfg
Эта команда обновит конфигурацию загрузчика GRUB и удалит запись об удаленном ядре из меню загрузки.

Повторите шаги 2-3 для всех ядер, которые вы хотите удалить.
Примечание: перед удалением старых ядер убедитесь, что в системе остается хотя бы одно рабочее ядро, чтобы система могла загрузиться после перезагрузки.


-----------------------------------


Если вы хотите исключить определенный пакет из обновлений, то вы можете использовать команду dnf versionlock. 
Например, чтобы заблокировать обновление ядра до версии 4.18.0-485.el8, выполните следующую команду:


sudo dnf versionlock add kernel-core-4.18.0-485.el8
sudo dnf versionlock add kernel-core*
Эта команда добавит пакет kernel-core в список заблокированных пакетов, что предотвратит его обновление при выполнении команды dnf update. 

Если вы захотите разблокировать пакет, то используйте команду 
sudo dnf versionlock delete kernel-core-4.18.0-485.el8 
sudo dnf versionlock delete kernel-core*.


Кроме того, вы можете использовать опцию --exclude при выполнении команды dnf install, чтобы исключить установку определенного пакета и его зависимостей, например:
sudo dnf install kmod-wireguard --exclude kernel-core*

Таким образом, пакет kernel-core и его зависимости не будут установлены, но kmod-wireguard будет установлен, если его зависимости из других репозиториев уже установлены.

Также можно создать файл /etc/dnf/dnf.conf и добавить в него строку exclude=kernel* для того, чтобы исключить все пакеты, начинающиеся с "kernel" из обновлений. Обратите внимание, что это может привести к уязвимостям в системе без обновлений ядра.






