
#!/bin/bash

# Просмотр подробного статуса Unit Desktop Shredder
function desktop_shredder_status() {
    local status_output=$(systemctl status desktop_shredder.service)
    local _auto_restart=$(echo "$status_output" | grep -oE '[0-9]+' | head -n 1)
    local last_start_time=$(echo "$status_output" | grep -oE '[A-Za-z]{3} [0-9]{2} [0-9]{2}:[0-9]{2}:[0-9]{2}' | tail -n 1)
    local current_time=$(date +%H:%M:%S) # только время
    local current_d_time=$(date +"%b %d %H:%M:%S") # дата время
    local next_start_time=$(date -d "+$_auto_restart seconds $last_start_time" +%H:%M:%S)
    local next_start_will_be_in=$(($(date -d "$next_start_time" +%s) - $(date -d "$current_time" +%s)))
    
    # Обработка случая, когда Unit остановлен
    if [ $next_start_will_be_in -lt 0 ]; then
        next_start_will_be_in="Unit stopped"
    else
        local minutes=$((next_start_will_be_in / 60))
        local seconds=$((next_start_will_be_in % 60))
        next_start_will_be_in=$(printf "%02d:%02d" "$minutes" "$seconds")
    fi
    
    # Высчитываем прошедшее время с последнего старта
    elapsed_seconds=$(($(date -d "$current_time" +%s) - $(date -d "$last_start_time" +%s)))
    
    # Обработка отрицательного времени
    if [ $elapsed_seconds -lt 0 ]; then
        elapsed_time="Unit остановлен"
    else
        elapsed_time=$(printf "%02d:%02d:%02d" $((elapsed_seconds/3600)) $(((elapsed_seconds/60)%60)) $((elapsed_seconds%60)))
    fi
    
    
    systemctl status desktop_shredder.service ;
    
    echo "┌───────────────────────────────────────────────────────────────────────────────┐"
    echo "│                      Информация о состоянии Desktop Shredder                   "
    echo "├───────────────────────────────────────────────────────────────────────────────┤"
    echo "│ Текущие дата и время                 │ $current_d_time                          "
    echo "├───────────────────────────────────────────────────────────────────────────────┤"
    echo "│ Время последнего старта              │ $last_start_time                        "
    echo "├───────────────────────────────────────────────────────────────────────────────┤"
    echo "│ Авто рестарт каждые                  │ $_auto_restart сек.                      "
    echo "├───────────────────────────────────────────────────────────────────────────────┤"
    echo "│ Прошло времени с последнего старта   │ $elapsed_time                           "
    echo "├───────────────────────────────────────────────────────────────────────────────┤"
    echo "│ Время следующего старта              │ $next_start_time                        "
    echo "├───────────────────────────────────────────────────────────────────────────────┤"
    echo "│ Следующий старт через минут:секунд   │ $next_start_will_be_in                  "
    echo "└──────────────────────────────────────┴────────────────────────────────────────┘"
    
    echo -e "\n To set a different auto restart time for a unit,\n enter # dsunit_reinstall [time in seconds]\n For example: # dsunit_reinstall 600\n View Status of Desktop Shredders # dsus\n Начать очистку немедленно # dsnow\n"
    
    # Показать статус Desktop Shredder
    # ttb=$(echo -e "$(desktop_shredder_status)") && lang=cr && bpn_p_lang ;
    
    # Возвращение значения "Следующий старт через минут:секунд " через аргумент функции для других функций которые находятся ниже и которым нужно значение next_start_will_be_in.
    # Если вы хотите использовать функцию desktop_shredder_status самостоятельно и она не предназначена только для возврата значения переменной, нужно передать аргумент, куда будет записано значение. 
    # В случае, если вы вызываете desktop_shredder_status без аргумента, она будет выполняться без ошибок, и вы можете использовать ее в нужных местах. Для этого нужно следующее условие:
    
      if [[ -n $1 ]]; then
        eval "$1='$next_start_will_be_in'"
      fi
  }

# desktop_shredder_status in bat
function dsus() {
    ttb=$(echo -e "$(desktop_shredder_status)") && lang=cr && bpn_p_lang ;
  }

# Очистить папку Desktop Shredder немедленно.
function dsnow() {
    /root/vdsetup.2/bin/utility/install/shredder/shredder.sh ds
  }

# Выбор папки/файла для ручного удаления в указанной локации 
function dsman() {
    /root/vdsetup.2/bin/utility/install/shredder/shredder.sh man
  }

# Перемещение папки или файла в папку Desktop Shredder
function mvds() {
    
    function _mvds() {
      #100% рабочий вариант
      function check_valid_path() {
          
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
            ttb=$(echo -e " Запретный путь.") && lang=cr && bpn_p_lang 
            return 1
          fi
          
          # Проверка существования пути
          if [ -e "$path" ]; then
            ttb=$(echo -e " Введенный путь: $path") && lang=cr && bpn_p_lang 
            return 0
          else
            ttb=$(echo " Несуществующий путь.") && lang=cr && bpn_p_lang 
            return 1
          fi
        else
          # Запрос ввода пути от пользователя
          while true; do
            read -p " Введите путь до директории или файла: " path
            # Проверка запрещенных путей
            if [[ " ${forbidden_paths[@]} " =~ " $path " ]]; 
              
            then
              ttb=$(echo -e " Запрещенный путь. Пожалуйста, введите другой путь.") && lang=cr && bpn_p_lang 
              # Проверка существования пути
            elif [ -e "$path" ]; then
              ttb=$(echo -e " Введенный путь: $path") && lang=cr && bpn_p_lang 
              break
            else
              ttb=$(echo -e " Несуществующий путь. Пожалуйста, введите верный путь.") && lang=cr && bpn_p_lang 
            fi
          done
        fi
      }
      
      check_valid_path "$1"
      
      path=$1
      #while ! check_valid_path "$path"; do
      #	read -p " Введите путь до директории или файла: " path
      #done
      
      # отладка не удалять!!
      #echo " Путь прошел проверку: $path"
      
      #check_valid_path $1
      
      # Путь до рабочей папки с которой производим действия
      ds_path="$(cat /tmp/Desktop_Shredder_path.txt)"
      # Перемещение выбранной файла или папки в папку Desktop Shredder для последующего измельчения
      
      ttb=$(echo -e " Перемещаю в Shredder: $@") && lang=cr && bpn_p_lang ;
      for file in "$@"; do
      
      
      prefix="DS_REMOVE_"
      random_number=$(shuf -i 100-999 -n 1)
      folder_name="${prefix}${random_number}"
      
      mkdir -p "${ds_path}${folder_name}"
      
      
      \mv "$file" "${ds_path}${folder_name}"
      done
      
     
      
    }
    
    
    _mvds $1 ;
    cur_path=$(pwd) ;
    cd $ds_path && lk .;
    cd $cur_path ;
    
    # Вызов функции desktop_shredder_status и передача аргумента для возврата значения
     desktop_shredder_status next_start_will_be_in_value  &>/dev/null
     
    ttb=$(echo -e  "\n Desktop Shredder начнет очистку через $next_start_will_be_in_value (min:sec) \n Для отмены: # systemctl stop desktop_shredder.service.\n Посмотреть статус: # dsus\n Начать очистку немедленно # dsnow\n" ) && lang=cr && bpn_p_lang ; echo ;
    
    
  }
  
  function next_start_ds() {
      # Использование возвращенного значения
      
      # Вызов функции desktop_shredder_status и передача аргумента для возврата значения
      desktop_shredder_status next_start_will_be_in_value  &>/dev/null
      ttb=$(echo -e " Очистка начнется через: $next_start_will_be_in_value \n View Status of Desktop Shredders # dsus") && lang=cr && bpn_p_lang ;
  }
  
  function dsunit_reinstall() {
    auto_restart="$1"
    #echo -e " Auto-Restart function dsunit_reinstall = $auto_restart"
      /root/vdsetup.2/bin/utility/install/shredder/shredder_unit.sh $1
  }