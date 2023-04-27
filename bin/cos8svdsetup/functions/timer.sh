#!/bin/bash

# Определение функции для показа текущего времени
function show_current_time() {
  current_time=$(date +"%T")
  echo "Current time: $current_time"
}

# Вызов функции-таймера на 5 минут, пример вызова ниже:
# timer "00:05:00"
function timer() {
  duration=$1
  end_time=$(date -ud "+$duration" +%s)

  while true; do
    current_time=$(date -u +%s)
    remaining=$((end_time - current_time))

    if ((remaining <= 0)); then
      break
    fi

    printf "\rTime remaining: %02d:%02d:%02d" \
      $((remaining/3600)) $((remaining%3600/60)) $((remaining%60))
    sleep 1
  done

  printf "\nTimer completed!\n"
}
