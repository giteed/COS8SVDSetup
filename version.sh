#!/bin/bash

# Получаем текущую версию
VERSION=$(grep 'Version' VERSION | awk '{print $2}')

# Увеличиваем номер версии
VERSION=$(echo $VERSION | awk -F. '{$NF = $NF + 1;} 1' OFS=. )

# Обновляем номер версии в файле VERSION
sed -i '' "s/Version.*/Version $VERSION/" VERSION

# Обновляем номер версии в файле README.md
sed -i '' "s/Version.*/Version $VERSION/" README.md

# Добавляем изменения в Git
git add VERSION README.md

# Делаем коммит с сообщением о версии
#git commit -m "Bump version to $VERSION"

# Завершаем работу скрипта
exit 0

