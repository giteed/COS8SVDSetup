#!/bin/bash

# Source global definitions
# --> Прочитать настройки из /root/.bashrc
. /root/.bashrc

# 6 марта 2023 года
# Скрипт для чистого VDS сервера на базе centos 8 stream, с ядром vmlinuz-4.18.0-448.el8.x86_64 , который установит на него новое ядро vmlinuz-6.2.2-1.el8.elrepo.x86_64

# Смотрим какое ядро используется в данный момент:
	uname -r

# Первым шагом обновим все установленные пакеты:
	sudo yum update -y ;

# Установим необходимые зависимости для установки нового ядра:
	sudo yum install -y elfutils-libelf-devel gcc gcc-c++ make rpm-build ;

# Скачаем и установим репозиторий ELRepo:
	sudo rpm --import https://www.elrepo.org/RPM-GPG-KEY-elrepo.org ;
	sudo rpm -Uvh https://www.elrepo.org/elrepo-release-8.0-2.el8.elrepo.noarch.rpm ;
	# sudo rpm -Uvh https://www.elrepo.org/elrepo-release-8.el8.elrepo.noarch.rpm
	# dnf install https://www.elrepo.org/elrepo-release-8.0-2.el8.elrepo.noarch.rpm

# Установим новое ядро из репозитория ELRepo:
	sudo yum --enablerepo=elrepo-kernel install -y kernel-ml ;

# Обновим конфигурацию загрузчика:
	sudo grub2-mkconfig -o /boot/grub2/grub.cfg ;

# Перезагрузим сервер:
	# sudo reboot

# После перезагрузки, можно убедиться, что новое ядро было успешно установлено, выполнив команду:
uname -r ;

# Команда должна вернуть 6.2.2-1.el8.elrepo.x86_64, что означает, что новое ядро успешно установлено и загружено.