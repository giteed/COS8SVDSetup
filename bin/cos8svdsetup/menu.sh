#!/bin/bash

# --> Source global definitions
# --> Прочитать настройки из /root/.bashrc
. /root/.bashrc

# --> Эта ссылка на функцию проверяет, запущен-ли скрипт с правами суперпользователя (root) в Linux.
. /root/vdsetup.2/bin/functions/run_as_root.sh ;

check_os_compatibility() {
	expected_os="CentOS Stream"
	expected_version="8"

	current_os=$(cat /etc/centos-release | awk '{print $1}')
	current_version=$(cat /etc/centos-release | awk '{print $4}')
	
	echo
	echo -en " Ожидаемая ОС: $expected_os"
	echo " ver: $expected_version"
	echo -en " Текущая ОС: $current_os"
	echo " ver: $current_version"

	if [[ "$current_os" == "$expected_os" || "$current_os" == "CentOS" ]] && [[ "$current_version" == "$expected_version" ]]; then
		echo " Данный скрипт тестировался только с CentOS Stream release 8"
		echo -en " Версия вашей ОС: $(cat /etc/centos-release)" && echo -en " - OK!" && echo -e " $(uname -r)" || echo -e "$current_os $current_version"
		
	else
		echo -en " Версия вашей ОС: $(cat /etc/centos-release)" && echo -en " - The OS version does not match!" && echo -e " $(uname -r)" || echo -e "$current_os $current_version"
		echo " Ваша операционная система не соответствует требованиям скрипта!"
		echo " Продолжаете на свой риск!"
		press_enter_to_continue_or_ESC_or_any_key_to_cancel ;
	fi
}

# Вызываем функцию
ttb=$(echo -e "$(check_os_compatibility)" ) && lang="nix" && bpn_p_lang  ;

ttb=$(echo -e "
 Перед установкой рекомендуется обновить ПО сервера: # dnf update
" ) && lang="nix" && bpn_p_lang 

function menu_vdsetup() {

# Функция для печати меню
print_menu() {
	
	echo -e
	echo -e " Выберите опцию:"
	echo -e
	echo -e " 1. Пакет программ и репозиториев для удобства работы с сервером."
	echo -e
	echo -e " 2. Создание Unit для Desktop Shredder, автоматический запуск. "
	echo -e " -- 2a Посмотреть статус Unit Desktop Shredder: # dsus"
	echo -e " -- 2b Начать очистку немедленно # dsnow"
	echo -e " -- Стереть файл или папку с помощью Desktop Shredder: # mvds [путь/папка/файл]"
	echo -e
	echo -e " 3. Установка и управление VPN WireGuard устранение проблем с неподходящим ядром."
	echo -e
	echo -e " 4. Установка и управление VPN OpenVPN."
	echo -e
	echo -e " 5. Установка и управление Transmission (# transmission / удаление # tr_rm)"
	echo -e " -- 5a Забрать загруженные файлы с торрентов # start_light_server"
	echo -e " -- 5b Остановить HTTP доступ к папке Downloads # stop_light_server"
	echo -e " -- 5c Удаление Transmission # tr_rm"
	echo -e
	echo -e " 6. Проверка обновлений или установка GitHub."
	echo -e
	echo -e " 7. Установка TOR и Privoxy."
	echo -e " -- 7a Установить/Включить/отключить TOR для всей системы # toriptables2.py -h (help)/ -l (вкл)/ -f (выкл)"
	echo -e " -- 7b Отключит TOR для всей системы, но оставит рабочим TOR Socks5 127.0.0.1:9050 # toriptables2.py -f (выкл)"
	echo -e " -- 7c Полностью отключит TOR в системе # tor-stop"
	echo -e " -- 7d Проверит работает-ли TOR покажет доп инфо # tor_check_ip"
	echo -e " -- 7e Проверяет доступность .onion адреса через TOR # tor_onion_test"
	echo -e " -- 7f Перезапустит TOR и проверит его работу # tor_restart_status"
	echo -e " -- 7g Проверит работу и ip или перезапустит если нет ответа от socks5 # tor_check_ip_or_restart"
	echo -e " -- 7h Проверит работу wget через socks5 # tor_check_ip_wget"
	echo -e " -- 7i Создает отдельный интерфейс с именем tor0 # tor_Interface_unit_reinstall [intrface_name] (в разработке)"
	echo -e " -- 7j Показывает статус tor интерфейса # status_tor_service"
	echo -e " -- 7k Жестко перезапустит несколько сервисов включая TOR # tor-restart"
	echo -e "    (без необходимости не использовать), перезапускает:"
	echo -e "    tor, privoxy, firewalld, wg-quick, network - сервисы."
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
			echo -e " 1. Пакет программ и репозиториев для удобства работы с сервером."
			echo -e 
			/root/vdsetup.2/bin/utility/install/epel_repo_pack.sh ;
			;;
		2)
			echo -e " Вы выбрали Опцию 2"
			echo -e " 2. Создание Unit для Desktop Shredder, автоматический запуск. "
			echo -e 
			/root/vdsetup.2/bin/utility/install/shredder/shredder_unit.sh ;
			;;
		2a)
			echo -e " Вы выбрали Опцию 2a"
			echo -e " -- 2x Посмотреть статус Unit Desktop Shredder: # dsus"
			echo -e 
			dsus ;
			;;
		2b)
			echo -e " Вы выбрали Опцию 2b"
			echo -e " -- 2b Начать очистку немедленно # dsnow"
			echo -e 
			dsnow ;
			;;
			
			
		3)
			echo -e " Вы выбрали Опцию 3"
			echo -e " 3. Установка и управление VPN WireGuard устранение проблем с неподходящим ядром."
			echo -e 
			/root/vdsetup.2/bin/utility/install/vpn/wireguard-install.sh ;
			;;
		4)
			echo -e " Вы выбрали Опцию 4"
			echo -e " 4. Установка и управление VPN OpenVPN."
			echo -e 
			/root/vdsetup.2/bin/utility/install/vpn/openvpn-install.sh ;
			;;
		5)
			echo -e " Вы выбрали Опцию 5"
			echo -e " 5. Установка и управление Transmission (# transmission / удаление # tr_rm)"
			echo -e 
			transmission ;
			;;
		5a)
			echo -e " Вы выбрали Опцию 5a"
			echo -e " -- 5a Забрать загруженные файлы с торрентов # start_light_server"
			echo -e 
			start_light_server ;
			;;
		5b)
			echo -e " Вы выбрали Опцию 5b"
			echo -e " -- 5b Остановить HTTP доступ к папке Downloads # stop_light_server"
			echo -e 
			stop_light_server ;
			;;
		5c)
			echo -e " Вы выбрали Опцию 5c"
			echo -e " -- 5c Удаление Transmission # tr_rm"
			echo -e 
			tr_rm ;
			;;

		6)
			echo -e " Вы выбрали Опцию 6"
			echo -e " 6. Проверка обновлений или установка GitHub."
			echo -e 
			/root/vdsetup.2/bin/utility/install/github.sh ;
			;;
		7)
			echo -e " Вы выбрали Опцию 7"
			echo -e " 7. Установка TOR и Privoxy."
			echo -e 
			/root/vdsetup.2/bin/utility/install/tor/tor_installer.sh ;
			#/root/vdsetup.2/bin/utility/install/tor/tor-for-all-sys-app.sh ;
			;;
		7a)
			echo -e " Вы выбрали Опцию 7a"
			echo -e " -- 7a Установить/Включить/отключить TOR для всей системы # toriptables2.py -h (help)/ -l (вкл)/ -f (выкл)"\n
			echo -e 
			toriptables2.py -h ;
			;;
		7b)
			echo -e " Вы выбрали Опцию 7b"
		    echo -e " -- 7b Отключит TOR для всей системы, но оставит рабочим TOR Socks5 127.0.0.1:9050 # toriptables2.py -f (выкл)"
			echo -e 
			toriptables2.py -f ;
			;;
		7c)
			echo -e " Вы выбрали Опцию 7c"
			echo -e " -- 7c Полностью отключит TOR в системе # tor-stop"
			echo -e 
			tor-stop ;
			;;
		7d)
			echo -e " Вы выбрали Опцию 7d"
			echo -e " -- 7d Проверит работает-ли TOR покажет доп инфо # tor_check_ip"
			echo -e 
			tor_check_ip ;
			;;
		7e)
			echo -e " Вы выбрали Опцию 7e"
			echo -e " -- 7e Проверяет доступность .onion адреса через TOR # tor_onion_test"
			echo -e 
			tor_onion_test ;
			;;
		7f)
			echo -e " Вы выбрали Опцию 7f"
			echo -e " -- 7f Перезапустит TOR и проверит его работу # tor_restart_status"
			echo -e 
			tor_restart_status ;
			;;
		7g)
			echo -e " Вы выбрали Опцию 7g"
			echo -e " -- 7g Проверит работу и ip или перезапустит если нет ответа от socks5 # tor_check_ip_or_restart"
			echo -e 
			tor_check_ip_or_restart ;
			;;
		7h)
			echo -e " Вы выбрали Опцию 7h"
			echo -e " -- 7h Проверит работу wget через socks5 # tor_check_ip_wget"
			echo -e 
			tor_check_ip_wget ;
			;;
		7i)
			echo -e " Вы выбрали Опцию 7i"
			echo -e " -- 7i Создает отдельный интерфейс с именем tor0 # tor_Interface_unit_reinstall [intrface_name] "
			echo -e 
			tor_Interface_unit_reinstall ;
			;;
		7j)
			echo -e " Вы выбрали Опцию 7j"
		    echo -e " -- 7j Показывает статус tor интерфейса # status_tor_service"
			echo -e 
			status_tor_service ;
			;;
		7k)
			echo -e " Вы выбрали Опцию 7k"
			echo -e " -- 7k Жестко перезапустит несколько сервисов включая TOR # tor-restart"
			echo -e 
			tor-restart ;
			;;
		8)
			echo -e " Вы выбрали Опцию 8"
			# Здесь можете добавить код для выполнения действий для Опции 3
			echo -e 
			;;
		9)
			echo -e " Вы выбрали Опцию 9"
			# Здесь можете добавить код для выполнения действий для Опции 3
			echo -e 
			;;

		0)
			echo -e " До свидания!"
			echo -e 
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
	sleep 3 ;
done

	
}

menu_vdsetup ;