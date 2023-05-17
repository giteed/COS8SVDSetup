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
 Функция timer позволяет назначать время таймера 
 в разных форматах для удобства использования. 
 Вот несколько вариантов, как можно указывать время в функции timer:
 
 1. В секундах: timer \"300\" - таймер на 300 секунд (5 минут).
 2. В минутах: timer \"5 minutes\" - таймер на 5 минут.
 3. В часах: timer \"1 hour\" - таймер на 1 час.
 4. В днях: timer \"2 days\" - таймер на 2 дня.
 
 Функция timer использует команду date с опцией -d, которая 
 поддерживает разные форматы для определения времени. 
 
 Вы можете указывать продолжительность таймера в том формате,
 который вам удобен.
 
 Кроме того, вы также можете комбинировать значения времени
 для создания более сложных интервалов. 
 Например:
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
     
      printf "\r Time remaining: %02d:%02d:%02d" \
        $((remaining/3600)) $((remaining%3600/60)) $((remaining%60))
      sleep 1
    done
   
    printf "\n"
    
  }

# Таймер цветной красоты неописуемой :)
  function countdown() {
    #tstart
    # Цифры в счетчике убавляются по мене уменьшения самого числа в счетчике
    function countdown_1() {
        for digit in $(echo $i | grep -o .); do
          case $digit in
            1) printf "\e[37;1m%s\e[0m" "$digit";;
            2) printf "\e[36;1m%s\e[0m" "$digit";;
            3) printf "\e[35;1m%s\e[0m" "$digit";;
            4) printf "\e[34;1m%s\e[0m" "$digit";;
            5) printf "\e[33;1m%s\e[0m" "$digit";;
            6) printf "\e[32;1m%s\e[0m" "$digit";;
            7) printf "\e[32;0m%s\e[0m" "$digit";;
            8) printf "\e[31;1m%s\e[0m" "$digit";;
            9) printf "\e[32;1m%s\e[0m" "$digit";;
            0) printf "\e[31;1m%s\e[0m" "$digit";;
          esac
        done
    }
    
    # Цифры в счетчике стоят через пробел и не убавляются
    function countdown_2() {
        for digit in $(echo $i | grep -o .); do
          case $digit in
            1) printf "\e[37;1m%s\e[0m" " $digit";;
            2) printf "\e[36;1m%s\e[0m" " $digit";;
            3) printf "\e[35;1m%s\e[0m" " $digit";;
            4) printf "\e[34;1m%s\e[0m" " $digit";;
            5) printf "\e[33;1m%s\e[0m" " $digit";;
            6) printf "\e[32;1m%s\e[0m" " $digit";;
            7) printf "\e[32;1m%s\e[0m" " $digit";;
            8) printf "\e[31;1m%s\e[0m" " $digit";;
            9) printf "\e[32;1m%s\e[0m" " $digit";;
            0) printf "\e[31;1m%s\e[0m" " $digit";;
          esac
        done
    }
    
    
    # Hide cursor (спрятать курсор в терминале)
    tput civis
    echo -e " "
    local i=$1
    while (( i >= 0 )); do
      # Если число меньше чем указано ниже то выполняется условие после else:
      if (( i >= 2000 )); then
        
        printf "\r \e[37;1m%3d${nc}" "$i"
        echo -en " "
      else
        # Измените на countdown_1 или countdown_2 чтобы получить другую разновидность отображения
        countdown_1
      fi
      ((i--))
      sleep 0.1
      echo -en " "
      printf "\r "
    done
    
    # Show cursor (показать курсор в терминале)
    tput cnorm
    
    printf "\n"
    #tendl
    # вызвать countdown $1 (число 1900 = примерно 10 сек выполнения на слабом VDS)
  }
  