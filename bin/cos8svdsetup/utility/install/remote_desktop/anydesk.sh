#!/bin/bash

# Source global definitions
# --> Прочитать настройки из /root/.bashrc
. /root/.bashrc


# --> Этот ссылка на функцию проверяет, запущен-ли скрипт с правами суперпользователя (root) в Linux.
. /root/vdsetup.2/bin/functions/run_as_root.sh ;

  echo ;

lang=$1 ;
if [[ $1 == "" ]] ; then lang=cr ; fi ;



ttb=$(echo -e "
 ⎧ Установка AnyDesk на CentOS 8.
 | 
 | Мы установим Install AnyDesk на CentOS 8 
 | из репозитория AnyDesk Yum с предварительно 
 | упакованными RPM-пакетами.Вы можете вручную 
 | загрузить пакет RPM и установить его, но это
 | означает, что обновления придется выполнять 
 | тоже вручную. 
 ⎩ https://anydesk.com/ru/downloads/linux") && bpn_p_lang ;

ttb=$(echo -e "
 ⎧ Шаг 1: Добавляем репозиторий AnyDesk в CentOS 8:
 ⎩ # bat /etc/yum.repos.d/AnyDesk-CentOS.repo") && bpn_p_lang ;




function addrepo() {
cat > /etc/yum.repos.d/AnyDesk-CentOS.repo << "EOF"
[anydesk]
name=AnyDesk CentOS - stable
baseurl=http://rpm.anydesk.com/centos/$basearch/
gpgcheck=1
repo_gpgcheck=1
gpgkey=https://keys.anydesk.com/repos/RPM-GPG-KEY
EOF
}

addrepo && msg_done ;



ttb=$(echo -e "
 ⎧ Шаг 2. Установка AnyDesk в CentOS 8 Linux,
 ⎩ YUM или DNF.") && bpn_p_lang ;
 
ttb=$(echo -e "
 ⎧ После добавления репозитория AnyDesk в вашу систему
 | Linux установка AnyDesk в CentOS 8 может быть 
 | выполнена с помощью инструментов командной строки, 
 | YUM или DNF.
 | 
 | # sudo dnf makecache
 | # sudo dnf install -y redhat-lsb-core
 ⎩ # sudo dnf install -y anydesk libcanberra-gtk2

") && bpn_p_lang ;
echo ;
sudo dnf makecache && msg_done && echo ;
sudo dnf install -y redhat-lsb-core && msg_done && echo ;
sudo dnf install -y anydesk && msg_done ;
sudo dnf install -y libcanberra-gtk2 && msg_done ; 

ttb=$(echo -e "
 ⎧ Согласитесь импортировать ключ GPG 
 | при появлении запроса.
 | Is this ok [y/N]: y
 | Нажмите Y клавишу, чтобы начать 
 ⎩ установку AnyDesk на CentOS 8.

 ⎧ Вы можете проверить версию AnyDesk, 
 | установленную с помощью команды:
 | 
 ⎩ # rpm -qi anydesk 

") && bpn_p_lang ;

 echo ;
( lang=nix && ttb=$(rpm -qi anydesk) && bpn_p_lang ;)

ttb=$(echo -e "
 ⎧ Шаг 3: Запускаем AnyDesk на CentOS 8
 ⎩ и проверяем статус.") && bpn_p_lang ;

ttb=$(echo -e "
 ⎧ В AnyDesk есть служба, которая автоматически 
 | запускается после успешной установки.
 |
 ⎩ # systemctl status anydesk.service

") && bpn_p_lang ;
 echo ;
 systemctl status anydesk.service && msg_done 

ttb=$(echo -e "
 ⎧ Сервис также должен быть включен.
 |
 ⎩ # systemctl is-enabled anydesk.service

") && bpn_p_lang ;
 echo ;
 ttb=$(systemctl is-enabled anydesk.service) && bpn_p_lang && msg_done;

ttb=$(echo -e "
 ⎧ Запустите AnyDesk на CentOS 8 с рабочего стола 
 | или интерфейса командной строки.
 |
 ⎩ CLI:$ anydesk
") && bpn_p_lang ;

#CLI:$ anydesk

ttb=$(echo -e "
 ⎧ Используйте AnyDesk Address удаленной системы 
 | для подключения к ней.
 | 
 | Удаленному пользователю также потребуется ваш адрес
 | AnyDesk, чтобы иметь возможность управлять вашей 
 | машиной из удаленного местоположения. 
 | Наслаждайтесь использованием AnyDesk на 
 ⎩ CentOS 8 Linux Desktop.

 ⎧ Ваше программное обеспечение удаленного доступа 
 | для Linux. Простая и стабильная работа.
 | Эффективное удаленное подключение на базе Linux.
 | Простой и беспрепятственный удаленный доступ 
 | к любому компьютеру. Непрерывное соединение с любой 
 | операционной системой. Простой и удобный процесс 
 | установки, а также инструменты администрирования.
 | Вам понравятся его простые и удобные 
 | инструменты настройки и администрирования, которые 
 | позволяют легко управлять удаленной системой.
 | По умолчанию не работает от учетной записи root.
 |
 | Поддерживаются любые платформы. Любые устройства:
 | https://anydesk.com/ru/downloads/linux
 ⎩ # man anydesk
 
 
 Всо.
") && bpn_p_lang ;



exit 0;


