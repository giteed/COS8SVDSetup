
#!/bin/bash

# Функция: Очистка ( полная, включая промотку вверх ) экрана терминала 
function cv() { (clear && clear) }


# Очистка ( не полная, не включая промотку вверх ) экрана терминала 
function c() { (clear) }


# Функция: User
function im() { whoami ; } ;

# Поиск программ, по 6 утилитам
function wis() { (GLIG_ASTRX_ON && wis-f $1 $2) } ;


# перемещение папки или файла в папку Desktop Shredder
function mvds() {
		
		function _mvds() {
			
			function check_valid_path() {
				local path=$1
				
				# Проверяем наличие пути
				if [[ -z "$path" ]]; then
					echo "Ошибка: Путь не указан."
					return 1
				fi
				
				# Проверяем существование пути
				if [[ ! -e "$path" ]]; then
					echo "Ошибка: Путь не существует."
					return 1
				fi
				
				# Проверяем доступность для чтения
				if [[ ! -r "$path" ]]; then
					echo "Ошибка: Путь не доступен для чтения."
					return 1
				fi
				
				# Если все проверки пройдены, возвращаем успешный статус
				return 0
			}
			
			check_valid_path $1
			
			# Путь до рабочей папки с которой производим действия
			ds_path=$(cat /tmp/Desktop_Shredder_path.txt)
			# Перемещение выбранной файла или папки в папку Desktop Shredder для последующего измельчения
			mv $1 $ds_path ;
			
		}
		
		_mvds $1 ;
		cur_path=pwd ;
		cd $ds_path && lk ;
		cd cur_path ;
		
		ttb=$(echo -e  "\n \"Desktop Shredder\" \n скоро начнет очистку этой папки: $ds_path\n  \n systemctl stop desktop_shredder.service для отмены.") && lang=cr && bpn_p_lang ; echo ;
		
	}