#!/bin/bash

# Source global definitions
# --> Прочитать настройки из /root/.bashrc
. /root/.bashrc

# --> Этот функция проверяет, запущен ли скрипт с правами суперпользователя (root) в Linux.
. /root/vdsetup.2/bin/functions/run_as_root.sh


# Получаем номер последнего коммита
commit=$(git rev-parse --short HEAD)

# Получаем дату создания последнего коммита в формате ГГГГММДД
date=$(git log -1 --format=%cd --date=format:%Y%m%d)

# Определяем версию
version="$date-$commit"

# Выводим версию
echo "Версия скрипта: $version"

exit 0
