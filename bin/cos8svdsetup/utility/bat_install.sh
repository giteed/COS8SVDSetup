#!/bin/bash

# Source global definitions
# --> Прочитать настройки из /root/.bashrc
. ~/.bashrc

# --> Функция автоматизирует установку bat на CentOS 8.
 function bat_install() {

 # --> Устанавливает репозиторий EPEL, который содержит пакеты, не включенные в официальный репозиторий CentOS.
 yum install -y epel-release
 
 # --> Устанавливает необходимые зависимости: wget, gcc, make.
 yum install -y wget gcc make
 
 # --> Загружает и устанавливает bat, используя последнюю версию на момент написания скрипта (0.18.3). Для этого он скачивает архив с бинарными файлами bat с официального сайта, распаковывает его и копирует файл bat в директорию /usr/local/bin/.
 BAT_VERSION="0.18.3"
 BAT_FILENAME="bat-${BAT_VERSION}-x86_64-unknown-linux-musl.tar.gz"
 BAT_URL="https://github.com/sharkdp/bat/releases/download/v${BAT_VERSION}/${BAT_FILENAME}"
 wget "${BAT_URL}"
 tar -xzf "${BAT_FILENAME}" -C /usr/local/bin/ --strip-components=1
 
 # --> Удаляет загруженный архив.
 rm "${BAT_FILENAME}"
 
# --> Выводит сообщение об успешном завершении установки.
	echo -e " 
  ⎧ $(green_tick) Установка bat ${BAT_VERSION} успешно завершена!
  ⎩ ${GREEN}| ${NC}посмотреть список пакетов в системе # ypr -rl
   "
 }
bat_install ;

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
