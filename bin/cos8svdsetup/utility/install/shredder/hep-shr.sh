#!/bin/bash

# --> Source global definitions
# --> Прочитать настройки из /root/.bashrc
. /root/.bashrc

  
  function check_screen_process() {
    path=$1
    # Получаем PID текущего процесса
    local current_pid=$$
    local process_name='shredder'
    
    echo -e " "\$process_name :" "$process_name" "
    echo -en " "\$$: "  "$$" должен быть равен = " echo -e " "\$current_pid: " "$current_pid" "
    
    ttb=$(echo -e "\n Проверяем наличие процесса $(pgrep -f "$process_name" | grep -v "$$" | grep -v "$current_pid") с помощью pgrep, исключая текущий процесс "$$" и "$current_pid" \n") && lang=cr && bpn_p_lang
    timer "30 sec";
  
    # Проверяем наличие процесса с помощью pgrep, исключая текущий процесс
    if pgrep -f "$process_name" | grep -v "$$" | grep -v "$current_pid" >/dev/null; then
      ttb=$(echo -e "\n Процесс $process_name уже запущен.\n Дождитесь завершения работы Shredder.\n Проверить процесс: # screen -r $process_name") && lang=cr && bpn_p_lang
      exit 1
      else
      echo mozhmo zapuskat
    fi
  }


  
  # Вызываем функцию check_screen_process с передачей пути и текущего PID
  check_screen_process "$path" 