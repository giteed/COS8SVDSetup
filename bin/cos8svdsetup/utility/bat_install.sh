#!/bin/bash

# Source global definitions
# --> Прочитать настройки из /root/.bashrc
. /root/.bashrc


# --> Функция автоматизирует установку bat на CentOS 8.
 function bat_install() {
 # --> Проверяет наличие или устанавливает репозиторий EPEL, который содержит пакеты, не включенные в официальный репозиторий CentOS.
 	epel_repository_Check_or_install ;
 # --> Устанавливает необходимые зависимости: wget, gcc, make.
 	dnf install -y wget gcc make
 # --> Загружает и устанавливает bat, используя последнюю версию на момент написания скрипта (0.18.3). Для этого он скачивает архив с бинарными файлами bat с официального сайта, распаковывает его и копирует файл bat в директорию /usr/local/bin/.
 	BAT_VERSION="0.22.1"
 	BAT_FILENAME="bat-v${BAT_VERSION}-x86_64-unknown-linux-musl.tar.gz"
 	BAT_URL="https://github.com/sharkdp/bat/releases/download/v${BAT_VERSION}/${BAT_FILENAME}"
# --> Ввсе сообщения о процессе загрузки будут подавлены, кроме ошибок, если таковые возникнут.
	wget --quiet "${BAT_URL}"
 # --> Эта команда распакует архив из переменной BAT_FILENAME и сохранит файлы в каталоге /usr/local/bin/, пропуская первый уровень вложенности путей файлов с помощь флага --strip-components=1, при этом подавляя все сообщения о процессе распаковки.
 # --> В команде "tar -xzf" -x означает извлечение содержимого, -z указывает на то, что архив является сжатым файлом формата gzip, а -f указывает на имя файла архива. -C /path/to/extract задает директорию, в которую будет производиться извлечение содержимого архива, В данном случае это /usr/local/bin/. -q минимизирует вывод но не исключает возможные ошибки. 
 	tar -xzf "${BAT_FILENAME}" --warning=no-file-changed -C /usr/local/bin/ --strip-components=1
 # --> Удаляет загруженный архив.
 	rm "${BAT_FILENAME}"
# --> Выводит сообщение об успешном завершении установки.
	echo -e " 
  ⎧ $(green_tick) Установка bat ${BAT_VERSION} успешно завершена!
  ⎩ ${NC}посмотреть список пакетов в системе # ypr -rl
   "
 }


# --> Если значение $1 на входе в скрипт равно "bat_install", то вызывается функция "bat_install" и происходит выход из скрипта с кодом 0. В противном случае, вызывается функция "bat_Check_or_install".
 if [[ $1 == "bat_install" ]]; then
	  bat_install && exit 0;
 else
# --> Функция "bat_Check_or_install" определена в загружаемых функциях из /root/vdsetup.2/bin/functions/check_or_install.sh которая проверяет или устанавливает проверяемые компоненты.	
	  bat_Check_or_install
 fi


exit 0 ; 

















Скачивание YouTube видео youtube-dl

После установки, достаточно просто указать ссылку, youtube-dl загрузит видео и сохранит его в формате mp4 / flv.


youtube-dl https://www.youtube.com/watch?v=dQw4w9WgXcQ
Скачивание видео с YouTube в разных форматах

Большинство видео на YouTube доступны в разных форматах и разном качестве. Для начала необходимо проверить какие форматы доступны


youtube-dl -F https://www.youtube.com/watch?v=dQw4w9WgXcQ
youtube-dl -F https://www.youtube.com/watch?v=dQw4w9WgXcQ

Выбираем необходимый формат и скачиваем его


youtube-dl -f 140 https://www.youtube.com/watch?v=dQw4w9WgXcQ
Пакетное скачивание видео с YouTube

для скачивания множества видео с YouTube используем параметр -a

youtube-dl -a video.list.txt
Извлечь аудио (MP3) из видео YouTube

Если необходимо извлечь звук видео и сохранить его в аудио формате (mp3), необходимо установить ffmpeg, после этого можно будет конвертировать видео YouTube в аудио файлы.


youtube-dl https://www.youtube.com/watch?v=dQw4w9WgXcQ --extract-audio --audio-format mp3
