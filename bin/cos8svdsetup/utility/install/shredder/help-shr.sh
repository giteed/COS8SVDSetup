#!/bin/bash

# --> Source global definitions
# --> Прочитать настройки из /root/.bashrc
. /root/.bashrc

  
  function check_screen_process() {
    path=$1
    # Получаем PID текущего процесса

    local process_name="d_s_h_r_e_d_d_e_r"
    
    echo -e "\n "\$process_name d_s_h_r_e_d_d_e_r:" "$process_name" "
    
    ttb=$(echo -e "\n Проверяем наличие процесса d_s_h_r_e_d_d_e_r $(ps aux | grep "$process_name" | grep -v grep ) с помощью pgrep \n") && lang=cr && bpn_p_lang
    
    
    
    # Проверяем наличие процесса с помощью pgrep
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