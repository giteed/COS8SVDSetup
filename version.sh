#!/bin/bash

# Получаем номер последнего коммита
commit=$(git rev-parse --short HEAD)

# Получаем дату создания последнего коммита в формате ГГГГММДД
date=$(git log -1 --format=%cd --date=format:%Y%m%d)

# Определяем версию
version="$date-$commit"
sed -i '' "s/version: [0-9]\+\.[0-9]\+\.[0-9]\+/version: $VERSION/" README.md

# Выводим версию
echo "Версия скрипта: $version"

exit 0
