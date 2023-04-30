
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
			shopt -s nullglob
			
			#100% рабочий вариант
			function check_valid_path() {
				shopt -s nullglob
				
				local path="$1"
				# Запретные пути
				local forbidden_paths=(
				  "."
				  ".."
				  "../."
				  "/"
				  "~/"
				  "/bin/"
				  "/boot/"
				  "/dev/"
				  "/etc/"
				  "/home/"
				  "/lib/"
				  "/lib64/"
				  "/lost+found/"
				  "/media/"
				  "/mnt/"
				  "/opt/"
				  "/proc/"
				  "/root/"
				  "/run/"
				  "/sbin/"
				  "/snap/"
				  "/srv/"
				  "/sys/"
				  "/tmp/"
				  "/usr/"
				  "/var/"
				)
				
				if [ -n "$path" ]; then
				# Проверка запрещенных путей
					if [[ " ${forbidden_paths[@]} " =~ " $path " ]]; then
						echo " Запретный путь."
						return 1
					fi
					
					# Проверка существования пути
					if [ -e "$path" ]; then
						echo " Введенный путь: $path"
						return 0
					else
						echo " Несуществующий путь."
						return 1
					fi
				else
					# Запрос ввода пути от пользователя
					while true; do
						read -p " Введите путь до директории или файла: " path
						# Проверка запрещенных путей
						if [[ " ${forbidden_paths[@]} " =~ " $path " ]]; 
							
						then
							echo " Запрещенный путь. Пожалуйста, введите другой путь."
							# Проверка существования пути
						elif [ -e "$path" ]; then
							echo " Введенный путь: $path"
							break
						else
							echo " Несуществующий путь. Пожалуйста, введите верный путь."
						fi
					done
				fi
			}
			
			check_valid_path "$1"
			
			path=$1
			#while ! check_valid_path "$path"; do
			#	read -p " Введите путь до директории или файла: " path
			#done
			
			echo " Путь прошел проверку: $path"
			
			#check_valid_path $1
			
			# Путь до рабочей папки с которой производим действия
			ds_path="$(cat /tmp/Desktop_Shredder_path.txt)"
			# Перемещение выбранной файла или папки в папку Desktop Shredder для последующего измельчения
			
			echo "Перемещение файлов: $@"
			for file in "$@"; do
			  mv "$file" "$ds_path"
			done
			
			#mv $1 $ds_path ;
			
		}
		
		shopt -s nullglob
		_mvds $1 ;
		cur_path=$(pwd) ;
		cd $ds_path && lk .;
		cd $cur_path ;
		
		ttb=$(echo -e  "\n \"Desktop Shredder\" \n скоро начнет очистку этой папки: $ds_path\n  \n systemctl stop desktop_shredder.service для отмены.") && lang=cr && bpn_p_lang ; echo ;
		
	}