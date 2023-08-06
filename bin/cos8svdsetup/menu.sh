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
	echo -e " Выберите опцию:"
	echo -e " 1. Пакет программ и репозиториев для удобства работы с сервером"
	echo -e " 2. Создание unit для Shredder Desktop, автоматический запуск. (Посмотреть статус: # dsus)"
	echo -e " 3. Установка и управление WireGuard устранение проблем с неподходящим ядром"
	echo -e " 4. Установка и управление OpenVPN"
	echo -e " 5. Установка и управление Transmission (# transmission / удаление # tr_rm)"
	echo -e " -- Забрать загруженные файлы с торрентов # start_light_server"
	echo -e " -- Остановить HTTP доступ к папке Downloads # stop_light_server"
	echo -e " 6. Проверка обновлений или установка GitHub"
	echo -e " 7. Установка TOR и Privoxy"
	echo -e " -- Включить/отключить TOR для всей системы # toriptables2.py -h (help)/ -l (вкл)/ -f (выкл)"
	echo -e " -- Отключит для всей системы но оставит рабочим TOR Socks5 127.0.0.1:9050 # toriptables2.py -f (выкл)"
	echo -e " -- Полностью отключит TOR в системе # tor-stop"
	echo -e " -- Проверит работает-ли TOR покажет доп инфо # tor_check_ip"
	echo -e " -- Перезапустит TOR и проверит его работу # tor_restart_status"
	echo -e " -- Жестко перезапустит несколько сервисов включая TOR # tor-restart"
	echo -e "    (без необходимости не использовать, перезапускает: tor, privoxy, firewalld, wg-quick, network )"
	
	echo -e " 8. Опция 3"
	echo -e " 9. Опция 3"
	echo -e " 0. Выход"
	echo -e 
}

# Функция для обработки выбранной опции
handle_option() {
	local choice=$1
	case $choice in
		1)
			echo -e " Вы выбрали Опцию 1"
			echo -e " 1. Пакет программ и репозиториев для удобства работы с сервером"\n
			# Здесь можете добавить код для выполнения действий для Опции 1
			/root/vdsetup.2/bin/utility/install/epel_repo_pack.sh ;
			;;
		2)
			echo -e " Вы выбрали Опцию 2"
			echo -e " 2. Создание unit для Shredder Desktop, автоматический запуск. (Посмотреть статус: # dsus)"\n
			
			/root/vdsetup.2/bin/utility/install/shredder/shredder_unit.sh ;
			;;
		3)
			echo -e " Вы выбрали Опцию 3"
			echo -e " 3. Установка и управление WireGuard"
			/root/vdsetup.2/bin/utility/install/vpn/wireguard-install.sh ;
			;;
		4)
			echo -e " Вы выбрали Опцию 4"
			echo -e " 4. Установка и управление OpenVPN"
			/root/vdsetup.2/bin/utility/install/vpn/openvpn-install.sh ;
			;;
		5)
			echo -e " Вы выбрали Опцию 5"
			echo -e " 5. Установка и управление Transmission (# transmission / удаление # tr_rm)"
			echo -e " -- Забрать загруженные файлы с торрентов # start_light_server"
			echo -e " -- Остановить HTTP доступ к папке Downloads # stop_light_server"
			transmission ;
			;;
		6)
			echo -e " Вы выбрали Опцию 6"
			echo -e " 6. Проверка обновлений или установка GitHub"
			/root/vdsetup.2/bin/utility/install/github.sh ;
			;;
		7)
			echo -e " Вы выбрали Опцию 7"
			echo -e " 7. Установка TOR и Privoxy"
			/root/vdsetup.2/bin/utility/install/tor/tor_installer.sh ;
			/root/vdsetup.2/bin/utility/install/tor/tor-for-all-sys-app.sh ;
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
			echo -e " До свидания!"
			exit 0 ;
			;;
		*)
			echo -e " Недопустимая опция"
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