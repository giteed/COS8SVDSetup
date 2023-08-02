#!/bin/bash

# --> Source global definitions
# --> Прочитать настройки из /root/.bashrc
. /root/.bashrc

# --> Эта ссылка на функцию проверяет, запущен-ли скрипт с правами суперпользователя (root) в Linux.
. /root/vdsetup.2/bin/functions/run_as_root.sh ;

echo 
echo -e " Перед установкой рекомендуется обновить ПО сервера "
echo -e " # dnf update\n"

function menu_vdsetup() {



# Функция для печати меню
print_menu() {
	echo " Выберите опцию:"
	echo " 1. Пакет программ и репозиториев для удобства работы с сервером"
	echo " 2. Создание unit для Shredder Desktop, автоматический запуск. (Посмотреть статус: # dsus)"
	echo " 3. Установка и управление WireGuard"
	echo " 4. Установка и управление OpenVPN"
	echo " 5. Установка и управление Transmission (# transmission / удаление # tr_rm)"
	echo " -- Забрать загруженные файлы с торрентов # start_light_server"
	echo " -- Остановить HTTP доступ к папке Downloads # stop_light_server"
	echo " 6. Проверка обновлений или установка GitHub"
	echo " 7. Опция 3"
	echo " 8. Опция 3"
	echo " 9. Опция 3"
	echo " 0. Выход"
	echo
}

# Функция для обработки выбранной опции
handle_option() {
	local choice=$1
	case $choice in
		1)
			echo -e " Вы выбрали Опцию 1"
			echo " 1. Пакет программ и репозиториев для удобства работы с сервером"\n
			# Здесь можете добавить код для выполнения действий для Опции 1
			/root/vdsetup.2/bin/utility/install/epel_repo_pack.sh ;
			;;
		2)
			echo -e " Вы выбрали Опцию 2"
			echo " 2. Создание unit для Shredder Desktop, автоматический запуск. (Посмотреть статус: # dsus)"\n
			
			/root/vdsetup.2/bin/utility/install/shredder/shredder_unit.sh ;
			;;
		3)
			echo -e " Вы выбрали Опцию 3"
			echo " 3. Установка и управление WireGuard"
			/root/vdsetup.2/bin/utility/install/vpn/wireguard-install.sh ;
			;;
		4)
			echo -e " Вы выбрали Опцию 4"
			echo " 4. Установка и управление OpenVPN"
			/root/vdsetup.2/bin/utility/install/vpn/openvpn-install.sh ;
			;;
		5)
			echo -e " Вы выбрали Опцию 5"
			echo " 5. Установка и управление Transmission (# transmission / удаление # tr_rm)"
			echo " -- Забрать загруженные файлы с торрентов # start_light_server"
			echo " -- Остановить HTTP доступ к папке Downloads # stop_light_server"
			transmission ;
			;;
		6)
			echo -e " Вы выбрали Опцию 6"
			echo " 6. Проверка обновлений или установка GitHub"
			/root/vdsetup.2/bin/utility/install/github.sh ;
			;;
		7)
			echo -e " Вы выбрали Опцию 7"
			# Здесь можете добавить код для выполнения действий для Опции 3
			;;
		8)
			echo -e " Вы выбрали Опцию 8"
			# Здесь можете добавить код для выполнения действий для Опции 3
			;;
		9)
			echo -e " Вы выбрали Опцию 9"
			# Здесь можете добавить код для выполнения действий для Опции 3
			;;

		0)
			echo " До свидания!"
			exit 0 ;
			;;
		*)
			echo " Недопустимая опция"
			;;
	esac
}

# Основной цикл меню
while true; do
	print_menu
	read -p " Введите номер опции: " option
	handle_option $option
	echo # Добавим пустую строку для улучшения читаемости
done

	
}

menu_vdsetup ;