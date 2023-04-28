#!/bin/bash

# --> Source global definitions
# --> Прочитать настройки из /root/.bashrc
. /root/.bashrc

  
  function check_screen_process() {
    path=$1
    # Получаем PID текущего процесса

    local process_name="dmS shredder"
    
    echo -e " "shredder-\$process_name :" "$process_name" "
    
    ttb=$(echo -e "\n Проверяем наличие процесса shredder $(ps aux | grep "$process_name" | grep -v grep ) с помощью grep \n") && lang=cr && bpn_p_lang
    
    
    
    # Проверяем наличие процесса с помощью grep
    if ps aux | grep "$process_name" | grep -v grep >/dev/null; 
      then
        ttb=$(echo -e "\n Процесс $process_name уже запущен.\n Дождитесь завершения работы Shredder.\n Проверить процесс: # screen -r $process_name") && lang=cr && bpn_p_lang
        exit 1
      else
        ttb=$(echo -e "\n Процесс shredder $process_name не найден в памяти\n можно запускать.\n Проверить процесс: # screen -r ") && lang=cr && bpn_p_lang
           
        echo 
        timer "30 sec";
        press_enter_to_continue_or_ESC_or_any_key_to_cancel ;
        sudo screen -dmS shredder /root/vdsetup.2/bin/utility/install/shredder/shredder.sh ds
    fi
  }


  
  # Вызываем функцию check_screen_process с передачей пути и текущего PID
  check_screen_process #"$path" 