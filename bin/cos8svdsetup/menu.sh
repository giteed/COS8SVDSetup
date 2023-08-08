#!/bin/bash

# --> Source global definitions
# --> Прочитать настройки из /root/.bashrc
. /root/.bashrc

# --> Эта ссылка на функцию проверяет, запущен-ли скрипт с правами суперпользователя (root) в Linux.
. /root/vdsetup.2/bin/functions/run_as_root.sh ;

tor_port_ch ;
 
check_os_compatibility() {
	expected_os="CentOS Stream"
	expected_version="8"

	current_os=$(cat /etc/centos-release | awk '{print $1}')
	current_version=$(cat /etc/centos-release | awk '{print $4}')
	
	function msg_os() {
		echo
		echo -en " Ожидаемая ОС: $expected_os"
		echo -en " $expected_version, "
		echo -en " Текущая ОС: $current_os"
		echo " $current_version"
	}
	#ttb=$(echo -e "$(msg_os)" ) && lang="nix" && bpn_p_lang  ;

	if [[ "$current_os" == "$expected_os" || "$current_os" == "CentOS" ]] && [[ "$current_version" == "$expected_version" ]]; then
		function msg_os_ok() {
			echo 
			
			#ttb=$(echo -e "$(msg_os)" ) && lang="nix" && bpn_p_lang  ;
			echo " Данный скрипт тестировался только с \"CentOS Stream release 8\" "
			echo -en " Версия вашей ОС: $(cat /etc/centos-release)" && echo -en " - OK!" && echo -e " $(uname -r)" || echo -e "$current_os $current_version"
		}
		#ttb=$(echo -e "$(msg_os_ok)" ) && lang="nix" && bpn_p_lang  ;
				
	else
		function msg_os_not_match() {
			msg_os ;
			echo -en " Версия вашей ОС: $(cat /etc/centos-release)" && echo -en " - не соответствует требованиям скрипта!" && echo -e " $(uname -r)" || echo -e "$current_os $current_version"
			echo " Данный скрипт тестировался только с \"CentOS Stream release 8\" "
			echo " Вы продолжаете на свой риск!"
		}
		ttb=$(echo -e "$(msg_os_not_match)" ) && lang="nix" && bpn_p_lang  ;
		press_enter_to_continue_or_ESC_or_any_key_to_cancel ;
	fi
}

# Вызываем функцию
check_os_compatibility ;

ttb=$(echo -e "
 Перед установкой рекомендуется обновить ПО сервера: # dnf update
" ) && lang="nix" && bpn_p_lang 

function menu_vdsetup() {

# Функция для печати меню
print_menu() {
	
	echo -e
	echo -e "  Выберите опцию (цифра или цифра с буквой):"
	echo -e
	echo -e "  1. Пакет программ и репозиториев для удобства работы с сервером."
	echo -e
	echo -e "  2. Создание Unit для \"Desktop Shredder\", автоматический запуск. "
	echo -e " -- 2a Посмотреть статус Unit \"Desktop Shredder\": # dsus"
	echo -e " -- 2b Начать очистку немедленно # dsnow"
	echo -e " -- Стереть файл или папку с помощью \"Desktop Shredder\": # mvds [путь/папка/файл]"
	echo -e
	echo -e "  3. Установка и управление VPN \"WireGuard\" устранение проблем с неподходящим ядром."
	echo -e "  4. Установка и управление VPN \"OpenVPN\"."
	echo -e
	echo -e "  5. Установка и управление \"Transmission\" # transmission / удаление # tr_rm"
	echo -e " -- 5a Забрать загруженные файлы с торрентов # start_light_server"
	echo -e " -- 5b Остановить \"HTTP\" доступ к папке \"Downloads\" # stop_light_server"
	echo -e " -- 5c Удаление \"Transmission\" # tr_rm"
	echo -e
	echo -e "  6. Проверка обновлений или установка \"GitHub\"."
	echo -e
	echo -e "  7. Установка \"TOR\" и \"Privoxy\". Установка автоматическая настройка и добавление в автозапуск."
	echo -e " -- 7a Установить/Включить/отключить \"TOR\" для всей системы # toriptables2.py -h (help)/ -l (вкл)/ -f (выкл)"
	echo -e " -- 7b Отключит \"TOR\" для всей системы, но оставит рабочим \"TOR Socks5 127.0.0.1:9050\" # toriptables2.py -f (выкл)"
	echo -e " -- 7c Полностью отключит \"TOR\" в системе # tor-stop"
	echo -e " -- 7d Проверит работает-ли \"TOR\" покажет доп инфо # tor_check_ip"
	echo -e " -- 7e Проверяет доступность \".onion\" адреса через \"TOR\" # tor_onion_test"
	echo -e " -- 7f Перезапустит \"TOR\" и проверит его работу # tor_restart_status"
	echo -e " -- 7g Проверит работу и \"ip\" или перезапустит если нет ответа от \"socks5\" # tor_check_ip_or_restart"
	echo -e " -- 7h Проверит работу \"wget\" через \"socks5\" # tor_check_ip_wget"
	echo -e " -- 7i Создает отдельный интерфейс с именем \"tor0\" # tor_Interface_unit_reinstall [intrface_name] (в разработке)"
	echo -e " -- 7j Показывает статус \"tor\" интерфейса # status_tor_service"
	echo -e " -- 7k Жестко перезапустит несколько сервисов включая \"TOR\" # tor-restart"
	echo -e "    (без необходимости не использовать), перезапускает:"
	echo -e "    \"tor\", \"privoxy\", \"firewalld\", \"wg-quick\", \"network\" - сервисы."
	echo -e
	echo -e "  8. Обновление \"vdsetup\" # vsync"
	echo -e " -- 8a Обновляет скрипты из repo \"GitHub\" (требуется API ключ) # vsync"
	echo -e " -- 8b Переустановка скриптов из repo \"GitHub\" (не требуется API ключ) # rm_clone"
	echo -e " -- 8c Удаление \"vdsetup\" (не удаляет программы установленные скриптом) # rm_vdsetup"
	echo -e " -- 8d Обновление настроек из \".bashrc\", или введите: # source /root/.bashrc или # urc"
	echo -e
	echo -e "  9. Смена \"ssh\" порта."
	echo -e " 10. Назначение имени хоста."
	echo -e " 11. Создание/изменение \"SWAP\" без перезагрузки сервера."
	echo -e " 12. Исправление ошибки \"Failed to set locale, defaulting to C.UTF-8\"  "
	echo -e
	echo -e " 13. Простое сканирование всех localhost TCP/UDP 65535 портов с выводом во временный файл. # full_tcp_port_scan и # fw_i_r"
	echo -e " --  13a NMAP helper с примерами и небольшой справкой подсказок. # nmapp [localhost]"
	echo -e
	echo -e " 14. Пустой шаблон."
	echo -e
	echo -e " 15. Пустой шаблон."
	echo -e
	echo -e "  0. Выход"
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
			echo -e " 2. Создание Unit для \"Desktop Shredder\", автоматический запуск. "
			echo -e 
			/root/vdsetup.2/bin/utility/install/shredder/shredder_unit.sh ;
			;;
		2a | dsus)
			echo -e " Вы выбрали Опцию 2a"
			echo -e " -- 2x Посмотреть статус Unit \"Desktop Shredder\": # dsus"
			echo -e 
			dsus ;
			;;
		2b | dsnow)
			echo -e " Вы выбрали Опцию 2b"
			echo -e " -- 2b Начать очистку немедленно # dsnow"
			echo -e 
			dsnow ;
			;;
			
			
		3)
			echo -e " Вы выбрали Опцию 3"
			echo -e " 3. Установка и управление VPN \"WireGuard\" устранение проблем с неподходящим ядром."
			echo -e 
			/root/vdsetup.2/bin/utility/install/vpn/wireguard-install.sh ;
			;;
		4)
			echo -e " Вы выбрали Опцию 4"
			echo -e " 4. Установка и управление VPN \"OpenVPN\"."
			echo -e 
			/root/vdsetup.2/bin/utility/install/vpn/openvpn-install.sh ;
			;;
		5 | transmission)
			echo -e " Вы выбрали Опцию 5"
			echo -e " 5. Установка и управление \"Transmission\" # transmission / удаление # tr_rm"
			echo -e 
			transmission ;
			;;
		5a | start_light_server)
			echo -e " Вы выбрали Опцию 5a"
			echo -e " -- 5a Забрать загруженные файлы с торрентов # start_light_server"
			echo -e 
			start_light_server ;
			;;
		5b | stop_light_server)
			echo -e " Вы выбрали Опцию 5b"
			echo -e " -- 5b Остановить \"HTTP\" доступ к папке \"Downloads\" # stop_light_server"
			echo -e 
			stop_light_server ;
			;;
		5c | tr_rm)
			echo -e " Вы выбрали Опцию 5c"
			echo -e " -- 5c Удаление \"Transmission\" # tr_rm"
			echo -e 
			tr_rm ;
			;;

		6)
			echo -e " Вы выбрали Опцию 6"
			echo -e " 6. Проверка обновлений или установка \"GitHub\"."
			echo -e 
			/root/vdsetup.2/bin/utility/install/github.sh ;
			;;
		7)
			echo -e " Вы выбрали Опцию 7"
			echo -e "  7. Установка \"TOR\" и \"Privoxy\". Установка автоматическая настройка и добавление в автозапуск."
			echo -e 
			/root/vdsetup.2/bin/utility/install/tor/tor_installer.sh ;
			#/root/vdsetup.2/bin/utility/install/tor/tor-for-all-sys-app.sh ;
			;;
		7a)
			echo -e " Вы выбрали Опцию 7a"
			echo -e " -- 7a Установить/Включить/отключить \"TOR\" для всей системы # toriptables2.py -h (help)/ -l (вкл)/ -f (выкл)"
			echo -e 
			toriptables2.py -h ;
			;;
		7b)
			echo -e " Вы выбрали Опцию 7b"
		    echo -e " -- 7b Отключит \"TOR\" для всей системы, но оставит рабочим \"TOR Socks5 127.0.0.1:9050\" # toriptables2.py -f (выкл)"
			echo -e 
			toriptables2.py -f ;
			;;
		7c | tor-stop)
			echo -e " Вы выбрали Опцию 7c"
			echo -e " -- 7c Полностью отключит \"TOR\" в системе # tor-stop"
			echo -e 
			tor-stop ;
			;;
		7d | tor_check_ip)
			echo -e " Вы выбрали Опцию 7d"
			echo -e " -- 7d Проверит работает-ли \"TOR\" покажет доп инфо # tor_check_ip"
			echo -e 
			tor_check_ip ;
			;;
		7e | tor_onion_test)
			echo -e " Вы выбрали Опцию 7e"
			echo -e " -- 7e Проверяет доступность \".onion\" адреса через \"TOR\" # tor_onion_test"
			echo -e 
			tor_onion_test ;
			;;
		7f | tor_restart_status)
			echo -e " Вы выбрали Опцию 7f"
			echo -e " -- 7f Перезапустит \"TOR\" и проверит его работу # tor_restart_status"
			echo -e 
			tor_restart_status ;
			;;
		7g | tor_check_ip_or_restart)
			echo -e " Вы выбрали Опцию 7g"
			echo -e " -- 7g Проверит работу и \"ip\" или перезапустит если нет ответа от \"socks5\" # tor_check_ip_or_restart"
			echo -e 
			tor_check_ip_or_restart ;
			;;
		7h | tor_check_ip_wget)
			echo -e " Вы выбрали Опцию 7h"
			echo -e " -- 7h Проверит работу \"wget\" через \"socks5\" # tor_check_ip_wget"
			echo -e 
			tor_check_ip_wget ;
			;;
		7i | tor_Interface_unit_reinstall)
			echo -e " Вы выбрали Опцию 7i"
			echo -e " -- 7i Создает отдельный интерфейс с именем \"tor0\" # tor_Interface_unit_reinstall [intrface_name] "
			echo -e 
			tor_Interface_unit_reinstall ;
			;;
		7j | status_tor_service)
			echo -e " Вы выбрали Опцию 7j"
		    echo -e " -- 7j Показывает статус \"tor\" интерфейса # status_tor_service"
			echo -e 
			status_tor_service ;
			;;
		7k | tor-restart)
			echo -e " Вы выбрали Опцию 7k"
			echo -e " -- 7k Жестко перезапустит несколько сервисов включая \"TOR\" # tor-restart"
			echo -e 
			tor-restart ;
			;;
		8 | vsync)
			echo -e " Вы выбрали Опцию 8"
			echo -e " 8. Обновление \"vdsetup\" # vsync"
			vsync ;
			echo -e 
			;;
		8a | vsync)
			echo -e " Вы выбрали Опцию 8a"
			echo -e " -- 8a Обновляет скрипты из repo \"GitHub\" (требуется API ключ) # vsync"
			vsync ;
			echo -e 
			;;
		8b | rm_clone)
			echo -e " Вы выбрали Опцию 8b"
			echo -e " -- 8b Переустановка скриптов из repo \"GitHub\" (не требуется API ключ) # rm_clone"
			rm_clone ;
			echo -e 
			;;
		8c | rm_vdsetu)
			echo -e " Вы выбрали Опцию 8c"
			echo -e " -- 8c Удаление \"vdsetup\" (не удаляет программы установленные скриптом) # rm_vdsetup"
			rm_vdsetup ;
			echo -e 
			;;
		8d | urc)
			echo -e " Вы выбрали Опцию 8d"
			echo -e " -- 8d Обновление настроек из \".bashrc\", или введите: # source /root/.bashrc или # urc"
			urc-f 2>/dev/null || echo " Type urc or source /root/.bashrc";
			echo -e 
			;;
		9)
			echo -e " Вы выбрали Опцию 9"
			echo -e " 9. Смена \"ssh\" порта."
			/root/vdsetup.2/bin/utility/system/ssh_port_ch.sh ;
			echo -e 
			;;
		10)
			echo -e " Вы выбрали Опцию 10"
			echo -e " 10. Назначение имени хоста."
			/root/vdsetup.2/bin/utility/system/hostnamectl.sh
			echo -e 
			;;
		11)
			echo -e " Вы выбрали Опцию 11"
			echo -e " 11. Создание/изменение \"SWAP\" без перезагрузки сервера."
			/root/vdsetup.2/bin/utility/system/swap_edit.sh
			echo -e 
			;;
		12)
			echo -e " Вы выбрали Опцию 12"
			echo -e " 12. Исправление ошибки \"Failed to set locale, defaulting to C.UTF-8\"  "
			/root/vdsetup.2/bin/utility/system/locale.sh
			echo -e 
			;;
		13 | full_tcp_port_scan)
			echo -e " Вы выбрали Опцию 13"
			echo -e " 13. Простое сканирование всех localhost TCP/UDP 65535 портов\n с выводом во временный файл. # full_tcp_port_scan и # fw_i_r"
			full_tcp_port_scan ;
			echo -e 
			;;
		13a | nmapp)
			echo -e " Вы выбрали Опцию 13a"
			echo -e " --  13a NMAP helper с примерами и небольшой справкой подсказок. # nmapp [localhost]"
			nmapp localhost ;
			echo -e 
			;;

		14)
			echo -e " Вы выбрали Опцию 14"
			echo -e " Пустой шаблон."
			echo -e 
			;;
		15)
			echo -e " Вы выбрали Опцию 15"
			echo -e " Пустой шаблон."
			echo -e 
			;;
		0)
			echo -e " До свидания! https://github.com/giteed/COS8SVDSetup"
			echo -e 
			exit 0 ;
			;;
		*)
			echo
			ttb=$(echo -e " --> Недопустимая опция!") && lang="cr" && bpn_p_lang 
			;;
	esac
}

# Основной цикл меню
while true; do
	#print_menu
	ttb=$(echo -e "$(print_menu)" ) && lang="cr" && bpn_p_lang 
	echo # Добавим пустую строку для улучшения читаемости
	read -p " Введите номер опции (цифра или цифра с буквой): " option
	handle_option $option
	echo # Добавим пустую строку для улучшения читаемости
	echo -en " Возврат в меню через: " && countdown 25 ;
done

	
}

menu_vdsetup ;