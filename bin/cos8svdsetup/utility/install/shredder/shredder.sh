#!/bin/bash

# --> Source global definitions
# --> Прочитать настройки из /root/.bashrc
. /root/.bashrc

# Удаляет пустые папки с именем в котом только нули
function deleting_empty_zero_folders() {
    ds_path=$1
    iteration_n=$2
    # Команда find будет искать папки в указанном пути ($ds_path), фильтровать папки,
    # в названии которых содержатся только нули (-regex '.*/0+$'), и выбирать 
    # только пустые папки (-empty). Затем найденные папки будут удалены (-delete).
    find "$ds_path" -mindepth 1 -type d -regex '.*/0+$' -empty -delete ;
    
  }

# Проверяем что shredder не запущен и уже не работает
function check_screen_process() {
    #timer "10 sec"; # таймер для отладки
    ds_path=$1
    # Получаем имя текущего процесса
    local screen_name="d_s_h_r_e_d_d_e_r"
    local check_1="shred"
    local check_2="find /root/temp/shredder/"
    local check_3="rm"
    local check_4="mv"
    
    ttb=$(echo -e "\n | Проверяем наличие процессов с помощью pgrep") && lang=cr && bpn_p_lang ;
    
    ps aux | (pgrep -x "$check_1" || pgrep -x "$check_2"|| pgrep -x "$check_3"|| pgrep -x "$check_4")
    
    # Проверяем наличие процессов shredder.sh с помощью pgrep
    if ps aux | (pgrep -x "$check_1" || pgrep -x "$check_2"|| pgrep -x "$check_3"|| pgrep -x "$check_4") >/dev/null; 
      then
        ttb=$(echo -e "\n | Процесс $screen_name уже запущен.\n | Дождитесь завершения работы Shredder.\n | Проверить процесс: # screen -r $screen_name\n | Или: # systemctl status -n0 --no-pager desktop_shredder.service") && lang=cr && bpn_p_lang; echo ;
        # Удаляет пустые папки с именем в котом только нули
        deleting_empty_zero_folders $ds_path $iteration_n ;
        #timer "10 sec"; # таймер для отладки
        exit 1
      else
        ttb=$(echo -e "\n Процесс \"Desktop Shredder\" не найден\n Проверить процесс: # screen -r $screen_name\n Или: # systemctl status -n0 --no-pager desktop_shredder.service") && lang=cr && bpn_p_lang ; echo ;
           
        tree -aC -L 2 $ds_path ; echo ;
        ttb=$(echo -e  "\n | \"Desktop Shredder\" \n | скоро начнет очистку этой папки: $ds_path\n  \n | Ctrl+C для отмены.") && lang=cr && bpn_p_lang ; echo ;
        timer "10 sec"; # таймер для отладки
        # Удаляет пустые папки с именем в котом только нули
        deleting_empty_zero_folders $ds_path $iteration_n ;
        #press_enter_to_continue_or_ESC_or_any_key_to_cancel ;
        return ;
    fi
  }

# Перезапись имен дирректорий нулями, включая вложенные папки
function replace_folder_name_with_zeros() {
    
    ds_path=$1
    iteration_n=$2
    # Считает количество символов в названии переданной на вход папки 
    # от переменной folder_name и отдает столько-же нулей на выход
   function _replace_folder_name_with_zeros() {
     ds_path=$1
     name=$(basename "$ds_path")
     num_chars=${#name}
     zero_string=$(printf '%*s' "$num_chars" | tr ' ' '0')
     echo "$zero_string"
    }
    
    # Получаем список папок внутри заданного пути, отсортированных по глубине вложенности
    # Передаем список папок через конвейер в awk для обработки
    find "$ds_path" -mindepth 1 -type d | awk -F/ 'NF{print NF-1,$0}' | sort -nr | cut -d" " -f2- | while read folder_name; 
    do
      
      # Генерируем новое имя для папки из нулей
      new_name="${folder_name%/*}/$(_replace_folder_name_with_zeros "$(basename "$folder_name")")"
     
      # Если новое имя папки уже существует, добавляем один нолик в конец имени
      while [[ -e "$new_name" ]]; do
        new_name="${new_name%/*}/$(_replace_folder_name_with_zeros "${new_name##*/}0")"
      done
      
      # Получаем новое имя папки, проверяем что мы не перемещаем папку внутрь себя
      # Если новое имя папки не существует, переименовываем
      if [[ "$new_name" != "$folder_name" ]]; then
        if [[ "$new_name" != "$folder_name"/* ]]; then
         mv -- "$folder_name" "$new_name" 
        fi
        ttb=$(echo -e "\n Переименована папка: $folder_name -> $new_name") && lang=cr && bpn_p_lang
      fi
      
    done
  }

# Функция вызова утилиты shred в указанной директории и ее поддиректориях
function shred_files() {
    
    ds_path=$1
    iteration_n=$2
    # Удаляем все файлы в указанной директории и ее поддиректориях
    find "$ds_path" -type f -exec shred -n 1 -f -u -v -z {} \;
  }

# Функция перезаписи имен файлов генерируемых утилитой 
# openssl rand -hex который выполняется iteration_n раз
function rename_folder_name_with_openssl_hex() {
    
    ds_path=$1
    iteration_n=$2
     # Получаем список папок внутри заданного пути, отсортированных по глубине вложенности
     # Передаем список папок через конвейер в awk для обработки
     find "$ds_path" -mindepth 1 -type d | awk -F/ 'NF{print NF-1,$0}' | sort -nr | cut -d" " -f2- | while read folder; 
      do
        # Генерируем случайное имя для новой папки утилитой openssl
        new_name="${folder%/*}/$(openssl rand -hex 3)"
       
        # Получаем новое имя папки, проверяем что мы не перемещаем папку внутрь себя
        # Если новое имя папки не существует, переименовываем
        if [[ ! -e "$new_name" ]]; then
          if [[ "$new_name" != "$folder"/* ]]; then
            mv -- "$folder" "$new_name"
          fi
          ttb=$(echo -e "\n Переименована папка: $folder -> $new_name") && lang=cr && bpn_p_lang
        fi
    done
  }

# Цикл, перезаписи имен файлов генерируемых утилитой 
# openssl rand -hex который выполняется iteration_n раз
function cycle_openssl_hex() {
    
    ds_path=$1
    iteration_n=$2
    # Цикл, который выполняется iteration_n раз
    for (( i=1; i<=$iteration_n; i++ ))
      do
        rename_folder_name_with_openssl_hex $ds_path $iteration_n ;
        ttb=$(echo -e "\n Выполнение cycle_openssl_hex  номер $i") && lang=cr && bpn_p_lang
    done
    
  }

# Цикл, перезаписи имен файлов/папок который выполняется iteration_n раз
function cycle_zero() {
   
   ds_path=$1
   # Количества интераций заданное в функции desktop_shredder
   iteration_n=$2 
    # Цикл, который выполняется iteration_n раз
    for (( i=1; i<=$iteration_n; i++ ))
      do
        replace_folder_name_with_zeros $ds_path $iteration_n ;
        ttb=$(echo -e "\n Выполнение cycle_zero номер $i") && lang=cr && bpn_p_lang
    done
    
  }

# Запрос рабочей папки для измельчения файлов Shredder-ом (в ручном режиме)
function request_ds_path() {
    
    while true; do
      echo -en "\n " 
      read -p " Введите путь до папки: " ds_path
       if [ ! -d "$ds_path" ]; then
          ttb=$(echo -e " Папка не найдена. Попробуйте еще раз.") && lang=cr && bpn_p_lang
        else
          echo $ds_path > /tmp/shredder_request_ds_path.txt
          break
       fi
    done
    
  }

# Запрос количества интераций (повторений действий с файлами/папками)
function request_iteration_n() {
    
    while true; do
      echo -en "\n " 
      read -p " Введите количество выполнений цикла: " iteration_n
       if [[ ! "$iteration_n" =~ ^[0-9]+$ ]]; then
          ttb=$(echo -e " Неверный формат. Введите только цифры.") && lang=cr && bpn_p_lang
        elif [ "$iteration_n" -eq 0 ]; then
          ttb=$(echo -e " Количество выполнений должно быть больше 0.") && lang=cr && bpn_p_lang
        else
          break
        fi
    done
    
  }

# Удаляем пустые директории кроме родительской папки
function deleting_empty_folders() {
    
    ds_path=$1
    iteration_n=$2
    # Удаляем пустые директории кроме родительской папки
    rm -rf $(find "$ds_path" -mindepth 1 -type d | awk -F/ 'NF{print NF-1,$0}' | sort -nr | cut -d" " -f2-)
    tree -aC -L 2 $ds_path ;
    #find "$ds_path" -mindepth 1 -type d -regex '.*/0+$' -empty -delete
  }

# Старт с запросом папки и количества интераций
function shred_request() {
    
    # Засекаем время начала работы скрипта
    tstart ; 
    # Получаем путь и количество повторений операции с файлами/папками
    request_ds_path && request_iteration_n 
    # Путь до рабочей папки с которой производим действия
    ds_path=$(cat /tmp/shredder_request_ds_path.txt)
    echo ;
    # Проверяем что shredder не запущен и уже не работает
    check_screen_process $ds_path $iteration_n ; 
    tree -aC -L 2 $ds_path ; echo ; timer 5 sec ; tstart
    # Удаляет пустые папки с именем в котом только нули
    deleting_empty_zero_folders $ds_path $iteration_n ; 
    # Запускает по очереди все функции Shredder для очистки
    shred_files $ds_path $iteration_n && cycle_openssl_hex $ds_path $iteration_n && cycle_zero $ds_path $iteration_n && deleting_empty_folders $ds_path $iteration_n ; 
    
    ttb=$(echo -e  "\n Готово! Очистка папки $ds_path завершена.\n Количество сделанных повторений $iteration_n\n Теперь удалите вручную пустую папку: rm -rf $ds_path") && lang=cr && bpn_p_lang
    tendl ;
  }

# Автоматически чистим папку "Desktop Shredder"
# Время очистки регулируется в секундах в файле /etc/systemd/system/desktop_shredder.service
# в строке RestartSec=120
# Чтобы быстро изменить время и перезапустить [Unit] измените файл ./shredder/shredder_unit.sh
# и после сохранения запустите его. Он создаст новый юнит и правильно перезапустит [Unit].
function desktop_shredder() {
    
    # Путь до рабочей папки "Desktop Shredder"
    ds_path="/root/temp/shredder/"
    # Создаем рабочую папку для "Desktop Shredder", если ее нет.
    mkdir -p $ds_path
    # записываем путь в файл для функции mvds() (перемещение папки или файла в папку Desktop Shredder)
    echo $ds_path > /tmp/Desktop_Shredder_path.txt
    # Количество интераций (повторений) выставленное вручную 
    iteration_n=1 
    
    # Проверяем содержимое папки "Desktop Shredder" и если пуста выходим.
    check_empty_folder() {
      shredder_folder="$ds_path"
     
      if [ -z "$(ls -A "$shredder_folder")" ]; then
        ttb=$(echo -e "\n | Папка Desktop Shredder, пуста.\n | Нечего мельчить!\n | Переместить файл или папку в Shredder:\n | # mvds [папка/файл]\n\n | Выход.\n") && lang=nix && bpn_p_lang
        exit 1
      fi
    }
     
    # Проверяем что shredder не запущен и уже не работает
    check_screen_process $ds_path $iteration_n ;
    # Засекаем время начала работы скрипта
    tstart ;
    # Проверяем содержимое папки "Desktop Shredder" и если пуста выходим.
    check_empty_folder $ds_path $iteration_n;
    # Удаляет пустые папки с именем в котом только нули
    deleting_empty_zero_folders $ds_path $iteration_n ;
    # Запускает по очереди все функции Shredder для очистки
    shred_files $ds_path $iteration_n && cycle_openssl_hex $ds_path $iteration_n && cycle_zero $ds_path $iteration_n && deleting_empty_folders $ds_path $iteration_n
    
    ttb=$(echo -e  "\n | \"Desktop Shredder\" старательно измельчил\n | все содержимое папки: $ds_path\n $iteration_n раз(а) подряд.\n | Установить другое время между очистками\n | # dsunit_reinstall [время в сек]. ") && lang=cr && bpn_p_lang ; echo ; tendl ;
    
  }


  if [[ "$1" == "ds" ]]; then
      desktop_shredder ;
      
    elif [[ "$1" == "man" ]]; then
      shred_request ;
      
    else
      ttb=$(echo -e  "\n Используйте скрипт $0 с ключем man или ds") && lang=cr && bpn_p_lang
  fi



exit 0

# Функции отсчета времени начала и конца выполнения скрипта
# tstart # начало 
# tendl # конец
#