#!/bin/bash

# --> Source global definitions
# --> Прочитать настройки из /root/.bashrc
. /root/.bashrc

function deleting_empty_zero_folders() {
    path=$1
    n=$2
    #ttb=$(echo -e  "deleting_empty_zero_folders n= $n") && lang=cr && bpn_p_lang
    #ttb=$(echo -e  "deleting_empty_zero_folders path $path") && lang=cr && bpn_p_lang
    # команда find будет искать папки в указанном пути ($path), фильтровать папки, в названии которых содержатся только нули (-regex '.*/0+$'), и выбирать только пустые папки (-empty). Затем найденные папки будут удалены (-delete).
    find "$path" -mindepth 1 -type d -regex '.*/0+$' -empty -delete ;
    
  }

function check_screen_process() {
    path=$1
    n=$2
    local process_name='shredder'
    ttb=$(echo -e "\n Проверяем наличие процесса $(pgrep -f "$process_name" | grep -v "$$") с помощью pgrep, исключая текущий процесс "$$" "\n) && lang=cr && bpn_p_lang
    timer "10 sec";
    # Проверяем наличие процесса с помощью pgrep, исключая текущий процесс
    if pgrep -f "$process_name" | grep -v "$$" >/dev/null; then
      ttb=$(echo -e "\n Процесс $process_name уже запущен.\n Дождитесь завершения работы Shredder.\n Проверить процесс: # screen -r $process_name") && lang=cr && bpn_p_lang
      exit 1
    fi
  }




function replace_with_zeros() {
    
    path=$1
    n=$2
    #ttb=$(echo -e  "replace_with_zeros n= $n") && lang=cr && bpn_p_lang
    #ttb=$(echo -e  "replace_with_zeros path $path") && lang=cr && bpn_p_lang
    # Считает количество символов в названии переданной на вход папки 
    # от переменной folder_name и отдает столько-же нулей на выход
   function _replace_with_zeros() {
     path=$1
     name=$(basename "$path")
     num_chars=${#name}
     zero_string=$(printf '%*s' "$num_chars" | tr ' ' '0')
     echo "$zero_string"
    }
    
    # Получаем список папок внутри заданного пути, отсортированных по глубине вложенности
    # Передаем список папок через конвейер в awk для обработки
    find "$path" -mindepth 1 -type d | awk -F/ 'NF{print NF-1,$0}' | sort -nr | cut -d" " -f2- | while read folder_name; 
    do
      
      # Генерируем новое имя для папки из нулей
      new_name="${folder_name%/*}/$(_replace_with_zeros "$(basename "$folder_name")")"
     
      # Если новое имя папки уже существует, добавляем один нолик в конец имени
      while [[ -e "$new_name" ]]; do
        new_name="${new_name%/*}/$(_replace_with_zeros "${new_name##*/}0")"
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


function shred() {
    
    path=$1
    n=$2
    #ttb=$(echo -e  "shred n= $n") && lang=cr && bpn_p_lang
    #ttb=$(echo -e  "shred path $path") && lang=cr && bpn_p_lang
    # Удаляем все файлы в указанной директории и ее поддиректориях
    find "$path" -type f -exec shred -n 1 -f -u -v -z {} \;
  }


function rename_ssl() {
    
    path=$1
    n=$2
    #ttb=$(echo -e  "rename_ssl n= $n") && lang=cr && bpn_p_lang
    #ttb=$(echo -e  "rename_ssl path $path") && lang=cr && bpn_p_lang
     # Получаем список папок внутри заданного пути, отсортированных по глубине вложенности
     # Передаем список папок через конвейер в awk для обработки
     find "$path" -mindepth 1 -type d | awk -F/ 'NF{print NF-1,$0}' | sort -nr | cut -d" " -f2- | while read folder; 
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


function cycle_ssl() {
    
    path=$1
    n=$2
    #ttb=$(echo -e  "cycle_ssl n= $n") && lang=cr && bpn_p_lang
    #ttb=$(echo -e  "cycle_ssl path $path") && lang=cr && bpn_p_lang
    # Цикл, который выполняется n раз
    for (( i=1; i<=$n; i++ ))
      do
        rename_ssl $path $n ;
        ttb=$(echo -e " Выполнение cycle_ssl  номер $i") && lang=cr && bpn_p_lang
    done
    
  }


function cycle_zero() {
   
   path=$1
   #n=$2
   n=1
   #ttb=$(echo -e  "cycle_zero n= $n") && lang=cr && bpn_p_lang
   #ttb=$(echo -e  "cycle_zero path $path") && lang=cr && bpn_p_lang
    # Цикл, который выполняется n раз
    for (( i=1; i<=$n; i++ ))
      do
        replace_with_zeros $path $n ;
        ttb=$(echo -e " Выполнение cycle_zero номер $i") && lang=cr && bpn_p_lang
    done
    
  }


function request_path() {
    
    while true; do
      read -p " Введите путь до папки: " path
       if [ ! -d "$path" ]; then
          ttb=$(echo -e " Папка не найдена. Попробуйте еще раз.") && lang=cr && bpn_p_lang
        else
          echo $path > /tmp/shredder_request_path.txt
          #ttb=$(echo -e  "request_path n= $n") && lang=cr && bpn_p_lang
          #ttb=$(echo -e  "request_path path $path") && lang=cr && bpn_p_lang
          break
       fi
    done
    
  }


function request_n() {
    
    while true; do
      read -p " Введите количество выполнений цикла: " n
       if [[ ! "$n" =~ ^[0-9]+$ ]]; then
          ttb=$(echo -e " Неверный формат. Введите только цифры.") && lang=cr && bpn_p_lang
        elif [ "$n" -eq 0 ]; then
          ttb=$(echo -e " Количество выполнений должно быть больше 0.") && lang=cr && bpn_p_lang
        else
          #ttb=$(echo -e  "request_n n= $n") && lang=cr && bpn_p_lang
          #ttb=$(echo -e  "request_n path $path") && lang=cr && bpn_p_lang
          break
        fi
    done
    
  }

  
function deleting_empty_folders() {
    
    path=$1
    n=$2
    #ttb=$(echo -e  "deleting_empty_folders n= $n") && lang=cr && bpn_p_lang
    #ttb=$(echo -e  "deleting_empty_folders path $path") && lang=cr && bpn_p_lang
    # Удаляем пустые директории кроме родительской папки
    rm -rf $(find "$path" -mindepth 1 -type d | awk -F/ 'NF{print NF-1,$0}' | sort -nr | cut -d" " -f2-)
    tree -aC -L 2 $path ;
    #find "$path" -mindepth 1 -type d -regex '.*/0+$' -empty -delete
  }

# Старт с запросом папки и количества интераций
function shred_request() {
    
    request_path && request_n 
    
    # Путь до рабочей папки с которой производим действия
    path=$(cat /tmp/shredder_request_path.txt)
    #ttb=$(echo -e  "shred_request n= $n") && lang=cr && bpn_p_lang
    #ttb=$(echo -e  "shred_request path $path") && lang=cr && bpn_p_lang
    echo ;
    tree -aC -L 2 $path ; echo ; timer 5 sec ; tstart
    deleting_empty_zero_folders $path $n ;
    shred $path $n && cycle_ssl $path $n && cycle_zero $path $n && deleting_empty_folders $path $n ;
    
    ttb=$(echo -e  " Готово \"shred_request\" !") && lang=cr && bpn_p_lang
    
  }
  
  
function desktop_shredder() {
    
    mkdir -p /root/temp/shredder
    path=$(echo /root/temp/shredder/)
    n=1 # Количество интераций (проходов)
    #ttb=$(echo -e  "desktop_shredder n= $n") && lang=cr && bpn_p_lang
    #ttb=$(echo -e  "desktop_shredder path $path") && lang=cr && bpn_p_lang
    
    check_empty_folder() {
      shredder_folder="$path"
     
      if [ -z "$(ls -A "$shredder_folder")" ]; then
        echo -en "\n Папка Desktop Shredder, пуста.\n Нечего мельчить!\n Выход.\n"
        tendl
        exit 1
      fi
    }
    
    # Проверяем наличие процесса с помощью screen -list
    deleting_empty_zero_folders $path $n ; 
    check_screen_process $path $n ;
    
    ttb=$(echo -en  "\n \"Desktop Shredder\" скоро начнет\n очистку папки: \n") && lang=cr && bpn_p_lang ; 
    tree -aC -L 2 $path ;
    echo ;
    timer "15 sec";
    check_empty_folder ;
    
    deleting_empty_zero_folders $path $n ;
    shred $path $n && cycle_ssl $path $n && cycle_zero $path $n && deleting_empty_folders $path $n
    
    ttb=$(echo -e  "\n \"Desktop Shredder\" старательно измельчил\n все содержимое папки: $path") && lang=cr && bpn_p_lang ; echo ;
    
  }

tstart

  if [[ "$1" == "ds" ]]; then
      desktop_shredder ;
      
    elif [[ "$1" == "sr" ]]; then
      shred_request ;
      
    else
      ttb=$(echo -e  "\n Используйте с ключем sr или ds") && lang=cr && bpn_p_lang
  fi

tendl

exit 0

