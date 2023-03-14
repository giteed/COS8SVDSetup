#!/bin/bash

# Получаем текущую версию
VERSION=$(grep 'VERSION=' script.sh | sed 's/VERSION=//')

# Увеличиваем номер версии
VERSION=$(echo $VERSION | awk -F. '{$NF = $NF + 1;} 1' OFS=. )

# Обновляем номер версии в скрипте
sed -i '' "s/VERSION=.*/VERSION=$VERSION/" script.sh

# Обновляем номер версии в README.md
sed -i '' "s/version: [0-9]\+\.[0-9]\+\.[0-9]\+/version: $VERSION/" README.md

exit 0

# Получаем номер последнего коммита
commit=$(git rev-parse --short HEAD)

# Получаем дату создания последнего коммита в формате ГГГГММДД
date=$(git log -1 --format=%cd --date=format:%Y%m%d)

# Определяем версию
version="$date-$commit"

# Выводим версию
echo "Версия скрипта: $version"

