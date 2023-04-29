#!/bin/bash

# --> Source global definitions
# --> Прочитать настройки из /root/.bashrc
. /root/.bashrc

# Удаляет пустые папки с именем в котом только нули
function deleting_empty_zero_folders() {
    sw_path=$1
    iteration_n=$2
    # Команда find будет искать папки в указанном пути ($sw_path), фильтровать папки,
    # в названии которых содержатся только нули (-regex '.*/0+$'), и выбирать 
    # только пустые папки (-empty). Затем найденные папки будут удалены (-delete).
    find "$sw_path" -mindepth 1 -type d -regex '.*/0+$' -empty -delete ;
    
  }

# Проверяем что shredder не запущен и уже не работает
function check_screen_process() {
    #timer "10 sec"; # таймер для отладки
    sw_path=$1
    # Получаем имя текущего процесса
    local screen_name="d_s_h_r_e_d_d_e_r"
    local check_1="shred"
    local check_2="find /root/temp/shredder/"
    local check_3="rm"
    local check_4="mv"
    
    ttb=$(echo -e "\n Проверяем наличие процессов с помощью pgrep") && lang=cr && bpn_p_lang ;
    
    ps aux | (pgrep -x "$check_1" || pgrep -x "$check_2"|| pgrep -x "$check_3"|| pgrep -x "$check_4")
    
    # Проверяем наличие процессов shredder.sh с помощью pgrep
    if ps aux | (pgrep -x "$check_1" || pgrep -x "$check_2"|| pgrep -x "$check_3"|| pgrep -x "$check_4") >/dev/null; 
      then
        ttb=$(echo -e "\n Процесс $screen_name уже запущен.\n Дождитесь завершения работы Shredder.\n Проверить процесс: # screen -r $screen_name\n Или: systemctl status -n0 --no-pager desktop_shredder.service") && lang=cr && bpn_p_lang
        # Удаляет пустые папки с именем в котом только нули
        deleting_empty_zero_folders $sw_path $iteration_n ;
        #timer "10 sec"; # таймер для отладки
        exit 1
      else
        ttb=$(echo -e "\n Процесс \"Desktop Shredder\" не найден\n Проверить процесс: # screen -r $screen_name") && lang=cr && bpn_p_lang
           
        tree -aC -L 2 $sw_path ; echo ;
        ttb=$(echo -en  "\n \"Desktop Shredder\" скоро начнет очистку этой папки: $sw_path\n") && lang=cr && bpn_p_lang ;
        timer "10 sec"; # таймер для отладки
        # Удаляет пустые папки с именем в котом только нули
        deleting_empty_zero_folders $sw_path $iteration_n ;
        #press_enter_to_continue_or_ESC_or_any_key_to_cancel ;
        return ;
    fi
  }

# Перезапись имен дирректорий нулями, включая вложенные папки
function replace_folder_name_with_zeros() {
    
    sw_path=$1
    iteration_n=$2
    # Считает количество символов в названии переданной на вход папки 
    # от переменной folder_name и отдает столько-же нулей на выход
   function _replace_folder_name_with_zeros() {
     sw_path=$1
     name=$(basename "$sw_path")
     num_chars=${#name}
     zero_string=$(printf '%*s' "$num_chars" | tr ' ' '0')
     echo "$zero_string"
    }
    
    # Получаем список папок внутри заданного пути, отсортированных по глубине вложенности
    # Передаем список папок через конвейер в awk для обработки
    find "$sw_path" -mindepth 1 -type d | awk -F/ 'NF{print NF-1,$0}' | sort -nr | cut -d" " -f2- | while read folder_name; 
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
        ttb=$(echo -e " Переименована папка: $folder_name -> $new_name") && lang=cr && bpn_p_lang
      fi
      
    done
  }

# Функция вызова утилиты shred в указанной директории и ее поддиректориях
function shred_files() {
    
    sw_path=$1
    iteration_n=$2
    # Удаляем все файлы в указанной директории и ее поддиректориях
    find "$sw_path" -type f -exec shred -n 1 -f -u -v -z {} \;
  }

# Функция перезаписи имен файлов генерируемых утилитой 
# openssl rand -hex который выполняется iteration_n раз
function rename_folder_name_with_openssl_hex() {
    
    sw_path=$1
    iteration_n=$2
     # Получаем список папок внутри заданного пути, отсортированных по глубине вложенности
     # Передаем список папок через конвейер в awk для обработки
     find "$sw_path" -mindepth 1 -type d | awk -F/ 'NF{print NF-1,$0}' | sort -nr | cut -d" " -f2- | while read folder; 
      do
        # Генерируем случайное имя для новой папки утилитой openssl
        new_name="${folder%/*}/$(openssl rand -hex 3)"
       
        # Получаем новое имя папки, проверяем что мы не перемещаем папку внутрь себя
        # Если новое имя папки не существует, переименовываем
        if [[ ! -e "$new_name" ]]; then
          if [[ "$new_name" != "$folder"/* ]]; then
            mv -- "$folder" "$new_name"
          fi
          ttb=$(echo -e " Переименована папка: $folder -> $new_name") && lang=cr && bpn_p_lang
        fi
    done
  }

# Цикл, перезаписи имен файлов генерируемых утилитой 
# openssl rand -hex который выполняется iteration_n раз
function cycle_openssl_hex() {
    
    sw_path=$1
    iteration_n=$2
    # Цикл, который выполняется iteration_n раз
    for (( i=1; i<=$iteration_n; i++ ))
      do
        rename_folder_name_with_openssl_hex $sw_path $iteration_n ;
        ttb=$(echo -e " Выполнение cycle_openssl_hex  номер $i") && lang=cr && bpn_p_lang
    done
    
  }

# Цикл, перезаписи имен файлов/папок который выполняется iteration_n раз
function cycle_zero() {
   
   sw_path=$1
   # Количества интераций заданное в функции desktop_shredder
   iteration_n=$2 
    # Цикл, который выполняется iteration_n раз
    for (( i=1; i<=$iteration_n; i++ ))
      do
        replace_folder_name_with_zeros $sw_path $iteration_n ;
        ttb=$(echo -e " Выполнение cycle_zero номер $i") && lang=cr && bpn_p_lang
    done
    
  }

# Запрос рабочей папки для измельчения файлов Shredder-ом (в ручном режиме)
function request_sw_path() {
    
    while true; do
      read -p " Введите путь до папки: " sw_path
       if [ ! -d "$sw_path" ]; then
          ttb=$(echo -e " Папка не найдена. Попробуйте еще раз.") && lang=cr && bpn_p_lang
        else
          echo $sw_path > /tmp/shredder_request_sw_path.txt
          break
       fi
    done
    
  }

# Запрос количества интераций (повторений действий с файлами/папками)
function request_iteration_n() {
    
    while true; do
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
    
    sw_path=$1
    iteration_n=$2
    # Удаляем пустые директории кроме родительской папки
    rm -rf $(find "$sw_path" -mindepth 1 -type d | awk -F/ 'NF{print NF-1,$0}' | sort -nr | cut -d" " -f2-)
    tree -aC -L 2 $sw_path ;
    #find "$sw_path" -mindepth 1 -type d -regex '.*/0+$' -empty -delete
  }

# Старт с запросом папки и количества интераций
function shred_request() {
    
    # Засекаем время начала работы скрипта
    tstart ; 
    # Проверяем что shredder не запущен и уже не работает
    check_screen_process ; 
    # Получаем путь и количество повторений операции с файлами/папками
    request_sw_path && request_iteration_n 
    
    # Путь до рабочей папки с которой производим действия
    sw_path=$(cat /tmp/shredder_request_sw_path.txt)
    echo ;
    tree -aC -L 2 $sw_path ; echo ; timer 5 sec ; tstart
    # Удаляет пустые папки с именем в котом только нули
    deleting_empty_zero_folders $sw_path $iteration_n ; 
    # Запускает по очереди все функции Shredder для очистки
    shred_files $sw_path $iteration_n && cycle_openssl_hex $sw_path $iteration_n && cycle_zero $sw_path $iteration_n && deleting_empty_folders $sw_path $iteration_n ; 
    
    ttb=$(echo -e  " Готово! \"Очистка вручную\" папки $sw_path завершена\n Количество сделанных повторений $iteration_n !") && lang=cr && bpn_p_lang
    tendl ;
  }

# Автоматически чистим папку "Desktop Shredder"
# Время очистки регулируется в секундах в файле /etc/systemd/system/desktop_shredder.service
# в строке RestartSec=120
# Чтобы быстро изменить время и перезапустить [Unit] измените файл ./shredder/shredder_unit.sh
# и после сохранения запустите его. Он создаст новый юнит и правильно перезапустит [Unit].
function desktop_shredder() {
    
    # Создаем рабочую папку для "Desktop Shredder", если ее нет.
    mkdir -p /root/temp/shredder
    # Путь до рабочей папки "Desktop Shredder"
    sw_path="/root/temp/shredder/"
    # Количество интераций (повторений) выставленное вручную 
    iteration_n=1 
    
    # Проверяем содержимое папки "Desktop Shredder" и если пуста выходим.
    check_empty_folder() {
      shredder_folder="$sw_path"
     
      if [ -z "$(ls -A "$shredder_folder")" ]; then
        echo -en "\n Папка Desktop Shredder, пуста.\n Нечего мельчить!\n Выход.\n"
        exit 1
      fi
    }
     
    # Проверяем что shredder не запущен и уже не работает
    check_screen_process $sw_path $iteration_n ;
    # Засекаем время начала работы скрипта
    tstart ;
    # Проверяем содержимое папки "Desktop Shredder" и если пуста выходим.
    check_empty_folder $sw_path $iteration_n;
    # Удаляет пустые папки с именем в котом только нули
    deleting_empty_zero_folders $sw_path $iteration_n ;
    # Запускает по очереди все функции Shredder для очистки
    shred_files $sw_path $iteration_n && cycle_openssl_hex $sw_path $iteration_n && cycle_zero $sw_path $iteration_n && deleting_empty_folders $sw_path $iteration_n
    
    ttb=$(echo -e  "\n \"Desktop Shredder\" старательно измельчил\n все содержимое папки: $sw_path\n $iteration_n раз(а) подряд.") && lang=cr && bpn_p_lang ; echo ; tendl ;
    
  }


  if [[ "$1" == "ds" ]]; then
      desktop_shredder ;
      
    elif [[ "$1" == "sr" ]]; then
      shred_request ;
      
    else
      ttb=$(echo -e  "\n Используйте скрипт $0 с ключем sr или ds") && lang=cr && bpn_p_lang
  fi



exit 0

# Функции отсчета времени начала и конца выполнения скрипта
# tstart # начало 
# tendl # конец
#