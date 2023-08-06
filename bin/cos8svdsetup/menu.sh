#!/bin/bash

# --> Source global definitions
# --> Прочитать настройки из /root/.bashrc
. /root/.bashrc

# --> Эта ссылка на функцию проверяет, запущен-ли скрипт с правами суперпользователя (root) в Linux.
. /root/vdsetup.2/bin/functions/run_as_root.sh ;

echo -e " Перед установкой рекомендуется обновить ПО сервера "
echo -e " # dnf update"

function menu_vdsetup() {

# Функция для печати меню
print_menu() {
	
	echo -e
	echo -e " Выберите опцию:"\n
	echo -e " 1. Пакет программ и репозиториев для удобства работы с сервером."
	echo -e
	echo -e " 2. Создание Unit для Shredder Desktop, автоматический запуск. "
	echo -e " -- Посмотреть статус Unit Shredder Desktop: # dsus"
	echo -e " -- Стереть файл или папку с помощью Unit Shredder Desktop: # mvds [путь/папка/файл]"
	echo -e
	echo -e " 3. Установка и управление VPN WireGuard устранение проблем с неподходящим ядром."
	echo -e
	echo -e " 4. Установка и управление VPN OpenVPN."
	echo -e
	echo -e " 5. Установка и управление Transmission (# transmission / удаление # tr_rm)"
	echo -e " -- Забрать загруженные файлы с торрентов # start_light_server"
	echo -e " -- Остановить HTTP доступ к папке Downloads # stop_light_server"
	echo -e
	echo -e " 6. Проверка обновлений или установка GitHub."
	echo -e
	echo -e " 7. Установка TOR и Privoxy."
	echo -e " -- Включить/отключить TOR для всей системы # toriptables2.py -h (help)/ -l (вкл)/ -f (выкл)"
	echo -e " -- Отключит TOR для всей системы, но оставит рабочим TOR Socks5 127.0.0.1:9050 # toriptables2.py -f (выкл)"
	echo -e " -- Полностью отключит TOR в системе # tor-stop"
	echo -e " -- Проверит работает-ли TOR покажет доп инфо # tor_check_ip"
	echo -e " -- Проверяет доступность .onion адреса через TOR # tor_onion_test"
	echo -e " -- Перезапустит TOR и проверит его работу # tor_restart_status"
	echo -e " -- Проверит работу и ip или перезапустит если нет ответа от socks5 # tor_check_ip_or_restart"
	echo -e " -- Проверит работу wget через socks5 # tor_check_ip_wget"
	echo -e " -- Создает отдельный интерфейс с именем tor0 # tor_Interface_unit_reinstall [intrface_name] "
	echo -e " -- Показывает статус tor интерфейса # status_tor_service"
	echo -e "    (не дописано - в разработке)."
	echo -e " -- Жестко перезапустит несколько сервисов включая TOR # tor-restart"
	echo -e "    (без необходимости не использовать), перезапускает:"
	echo -e "    tor, privoxy, firewalld, wg-quick, network - сервисы"
	echo -e
	echo -e " 8. Опция 8"
	echo -e
	echo -e " 9. Опция 9"
	echo -e
	echo -e " 0. Выход"
	echo -e 
   
}

# Функция для обработки выбранной опции
handle_option() {
	local choice=$1
	case $choice in
		1)
			echo -e " Вы выбрали Опцию 1"
			echo -e " 1. Пакет программ и репозиториев для удобства работы с сервером."\n
			/root/vdsetup.2/bin/utility/install/epel_repo_pack.sh ;
			;;
		2)
			echo -e " Вы выбрали Опцию 2"
			echo -e " 2. Создание Unit для Shredder Desktop, автоматический запуск. "\n
			/root/vdsetup.2/bin/utility/install/shredder/shredder_unit.sh ;
			;;
		3)
			echo -e " Вы выбрали Опцию 3"
			echo -e " 3. Установка и управление VPN WireGuard устранение проблем с неподходящим ядром."\n
			/root/vdsetup.2/bin/utility/install/vpn/wireguard-install.sh ;
			;;
		4)
			echo -e " Вы выбрали Опцию 4"
			echo -e " 4. Установка и управление VPN OpenVPN."\n
			/root/vdsetup.2/bin/utility/install/vpn/openvpn-install.sh ;
			;;
		5)
			echo -e " Вы выбрали Опцию 5"
			echo -e " 5. Установка и управление Transmission (# transmission / удаление # tr_rm)"\n
			transmission ;
			;;
		6)
			echo -e " Вы выбрали Опцию 6"
			echo -e " 6. Проверка обновлений или установка GitHub."\n
			/root/vdsetup.2/bin/utility/install/github.sh ;
			;;
		7)
			echo -e " Вы выбрали Опцию 7"
			echo -e " 7. Установка TOR и Privoxy."\n
			/root/vdsetup.2/bin/utility/install/tor/tor_installer.sh ;
			#/root/vdsetup.2/bin/utility/install/tor/tor-for-all-sys-app.sh ;
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
	#print_menu
	ttb=$(echo -e "$(print_menu)" ) && lang="cr" && bpn_p_lang 
	echo # Добавим пустую строку для улучшения читаемости
	read -p " Введите номер опции: " option
	handle_option $option
	echo # Добавим пустую строку для улучшения читаемости
done

	
}

menu_vdsetup ;