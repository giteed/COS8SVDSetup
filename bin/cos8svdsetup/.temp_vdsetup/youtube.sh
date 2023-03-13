#!/bin/bash





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

  