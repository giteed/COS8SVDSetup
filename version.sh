#!/bin/bash

# --> Получаем номер последнего коммита
	LAST_COMMIT=$(git rev-parse --short HEAD)

# --> Получаем текущую дату
	DATE=$(date '+%Y-%m-%d %H:%M:%S')

# --> Получаем текущую версию
	VERSION=$(grep 'VERSION=' script.sh | sed 's/VERSION=//')

# --> Увеличиваем номер версии
	VERSION=$(echo $VERSION | awk -F. '{$NF = $NF + 1;} 1' OFS=. )

# --> Обновляем номер версии в скрипте
	sed -i '' "s/VERSION=.*/VERSION=$VERSION/" script.sh

# --> Обновляем номер версии в README.md
	sed -i '' "s/version: [0-9]\+\.[0-9]\+\.[0-9]\+/version: $VERSION/" README.md

# --> Обновляем номер коммита и дату в script.sh
	sed -i '' "1i\
# Version $VERSION, last commit: $LAST_COMMIT, $DATE" script.sh

# --> Обновляем номер коммита и дату в README.md
	sed -i '' "s/last commit: [0-9a-f]\+/last commit: $LAST_COMMIT, $DATE/" README.md

	exit 0

