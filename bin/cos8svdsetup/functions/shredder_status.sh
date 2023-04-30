
#!/bin/bash

function desktop_shredder_status() {
    local status_output=$(systemctl status desktop_shredder.service)
    local auto_restart=$(echo "$status_output" | grep -oE '[0-9]+' | head -n 1)
    local last_start_time=$(echo "$status_output" | grep -oE '[A-Za-z]{3} [0-9]{2} [0-9]{2}:[0-9]{2}:[0-9]{2}' | tail -n 1)
    local current_time=$(date +%H:%M:%S) # только время
    local current_d_time=$(date +"%b %d %H:%M:%S") # дата время
    local next_start_time=$(date -d "+$auto_restart seconds $last_start_time" +%H:%M:%S)
    local next_start_will_be_in=$(($(date -d "$next_start_time" +%s) - $(date -d "$current_time" +%s)))

    # Обработка случая, когда юнит остановлен
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
    echo "│ Авто рестарт каждые                  │ $auto_restart сек.                      "
    echo "├───────────────────────────────────────────────────────────────────────────────┤"
    echo "│ Прошло времени с последнего старта   │ $elapsed_time                           "
    echo "├───────────────────────────────────────────────────────────────────────────────┤"
    echo "│ Время следующего старта              │ $next_start_time                        "
    echo "├───────────────────────────────────────────────────────────────────────────────┤"
    echo "│ Следующий старт через минут:секунд   │ $next_start_will_be_in                  "
    echo "└──────────────────────────────────────┴────────────────────────────────────────┘"

# Показать статус Desktop Shredder
# ttb=$(echo -e "$(desktop_shredder_status)") && lang=cr && bpn_p_lang ;
}