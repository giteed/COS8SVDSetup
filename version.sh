#!/bin/bash

# Получаем номер последнего коммита
commit=$(git rev-parse --short HEAD)

# Получаем дату создания последнего коммита в формате ГГГГММДД
date=$(git log -1 --format=%cd --date=format:%Y%m%d)

# Определяем версию
version="$date-$commit"

# Выводим версию
echo "Версия скрипта: $version"

exit 0
