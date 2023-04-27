#!/bin/bash

# Определение функции для показа текущего времени
function show_current_time() {
  current_time=$(date +"%T")
  echo "Current time: $current_time"
}

# Вызов функции-таймера на 5 минут, пример вызова ниже:
# timer "00:05:00"
function timer() {
   
   function timer_help() {
ttb=$( echo -e "
 Функция timer позволяет назначать время таймера в р
 азных форматах для удобства использования. 
 Вот несколько вариантов, как можно указывать время 
 в функции timer:
 1. В секундах: timer \"300\" - таймер на 300 секунд (5 минут).
 2. В минутах: timer \"5 minutes\" - таймер на 5 минут.
 3. В часах: timer \"1 hour\" - таймер на 1 час.
 4. В днях: timer \"2 days\" - таймер на 2 дня.
 Функция timer использует команду date с опцией -d, которая 
 поддерживает разные форматы для определения времени. 
 Вы можете указывать продолжительность таймера в том формате,
 который вам удобен.
 Кроме того, вы также можете комбинировать значения времени
 для создания более сложных интервалов. Например, 
 timer \"1 hour 30 minutes\" устанавливает таймер на 1 час и 30 минут.
 Форматы времени должны быть согласованы с командой date 
 и поддерживаться в вашей операционной системе.
 ") && lang=nix && bpn_p_lang ;
    }
    
    if [ -z "$1" ]; then
      timer_help
      return 1
    fi
    
      duration=$1
      end_time=$(date -ud "+$duration" +%s)
   
    while true; do
      current_time=$(date -u +%s)
      remaining=$((end_time - current_time))
     
      if ((remaining <= 0)); then
        break
      fi
     
      ttb=$(printf "\rTime remaining: %02d:%02d:%02d" \) && lang=cr && bpn_p_lang
        $((remaining/3600)) $((remaining%3600/60)) $((remaining%60))
      sleep 1
    done
   
    printf "\nTimer completed!\n"
    
  }

