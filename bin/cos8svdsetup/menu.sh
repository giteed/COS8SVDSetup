#!/bin/bash

# --> Source global definitions
# --> Прочитать настройки из /root/.bashrc
. /root/.bashrc

# --> Эта ссылка на функцию проверяет, запущен-ли скрипт с правами суперпользователя (root) в Linux.
. /root/vdsetup.2/bin/functions/run_as_root.sh ;

echo -en " Перед установкой рекомендуется обновить ПО сервера "
echo -e "# dnf update\n"

# Функция для печати меню
print_menu() {
	echo " Выберите опцию:"
	echo " 1. Пакет программ и репозиториев для удобства работы с сервером"
	echo " 2. Создание shredder_unit (автоматический запуск / Посмотреть статус: # dsus)"
	echo " 3. Опция 3"
	echo " 4. Выход"
}

# Функция для обработки выбранной опции
handle_option() {
	local choice=$1
	case $choice in
		1)
			echo -en " Вы выбрали Опцию 1"
			echo " 1. Пакет программ и репозиториев для удобства работы с сервером"
			# Здесь можете добавить код для выполнения действий для Опции 1
			/root/vdsetup.2/bin/utility/install/epel_repo_pack.sh ;
			;;
		2)
			echo -en " Вы выбрали Опцию 2"
			# Здесь можете добавить код для выполнения действий для Опции 2
			/root/vdsetup.2/bin/utility/install/shredder/shredder_unit.sh ;
			;;
		3)
			echo -en " Вы выбрали Опцию 3"
			# Здесь можете добавить код для выполнения действий для Опции 3
			;;
		4)
			echo " До свидания!"
			exit 0
			;;
		*)
			echo " Недопустимая опция"
			;;
	esac
}

# Основной цикл меню
while true; do
	print_menu
	read -p "Введите номер опции: " option
	handle_option $option
	echo # Добавим пустую строку для улучшения читаемости
done
