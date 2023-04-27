#!/bin/bash


# --> Для генерации рандомного числа в интервале от 1.5 до 2.7 секунд можно использовать следующую функцию. В этом случае функция генерирует случайное число в диапазоне от 1.5 до 2.7 и задерживает выполнение скрипта на это время.
function delay_1-5_2-7() {
    local min=1.5
    local max=2.7
    local duration=$(awk "BEGIN {srand(); print ($max-$min)*rand()+$min}")
    sleep $duration
  }


# --> В этом случае функция выводит сообщение, если время задержки меньше 3.5 секунд или больше или равно 3.5 секунд. Здесь используется утилита bc для выполнения математических операций с плавающей точкой в Bash.
function delay_msg_1-5_5-3() {
    local min=1.5
    local max=5.3
    local duration=$(awk "BEGIN {srand(); print ($max-$min)*rand()+$min}")
    sleep $duration
    if (( $(echo "$duration < 3.5" | bc -l) )); then
      ttb=$(echo "\n Duration is less than 3.5 seconds") && lang=cr && bpn_p_lang ;
    else
      ttb=$(echo "\n Duration is greater than or equal to 3.5 seconds") && lang=cr && bpn_p_lang ;
    fi
}


# --> рандомная задержка от 0,4 до 5,3 секунд
# Функция использует утилиту sleep для ожидания случайного количества времени между 0.5 и 5.5 секунд. Внутри функции вычисляется случайное число с плавающей точкой от 0 до 1, затем это число умножается на 5 и добавляется 0.5, чтобы получить случайное число от 0.5 до 5.5. Конструкция bc -l используется для работы с числами с плавающей точкой в Bash.
function delay_0-4_5-3() {
    sleep $(echo "0.4+$(bc -l <<< "scale=1; $RANDOM/32767*5")" | bc -l)
}


# --> Делать задержку от 1.5 до 5.5 секунд: Здесь мы вычитаем из максимального значения (5.3) минимальное значение (1.5), чтобы получить диапазон значений, затем добавляем минимальное значение (1.5) к случайно сгенерированному значению в этом диапазоне.
    delay_1-5_5-5() {
    sleep $(echo "1.5+$(bc -l <<< "scale=1; $RANDOM/32767*(5.5-1.5)")" | bc -l)
}


#  Таймер выполнения работы скрипта start
function tstart() {
    # Засекаем начало работы скрипта
    START_TIME=$(date +%s)
}

#  Таймер выполнения работы функции внутри скрипта start
function  tstart_f() {
    # Засекаем начало работы скрипта
    START_TIME_f=$(date +%s)
}

# Таймер выполнения работы скрипта end
function tend() {
    # Засекаем Время Конца работы скрипта
    END_TIME=$(date +%s)
    DIFF=$(( $END_TIME - $START_TIME ))
    ttb=$(echo -e "\n	Выполнение заняло $DIFF секунд.") && lang=cr && bpn_p_lang ;
}

# Таймер выполнения работы скрипта end с логикой сек/мин_сек
# В этой функции мы сначала вычисляем количество минут и секунд, 
# разделив общее количество секунд на 60.
# Затем, используя условную конструкцию if, проверяем, есть ли у нас минуты,
# и выводим соответствующее сообщение. Если у нас нет минут, мы выводим
# только количество секунд, если есть минуты, мы выводим 
# их количество, а также количество секунд.
function tendl() {
    END_TIME=$(date +%s)
    DIFF=$(( $END_TIME - $START_TIME ))
    MINUTES=$(( $DIFF / 60 ))
    SECONDS=$(( $DIFF % 60 ))
    if [ $MINUTES -eq 0 ]; then
        ttb=$(echo -e "\n Выполнение заняло $SECONDS секунд(ы).") && lang=cr && bpn_p_lang ;
    else
        ttb=$(echo -e "\n Выполнение заняло $MINUTES минут(ы) и $SECONDS секунд(ы).") && lang=cr && bpn_p_lang ;
    fi
}

# Таймер выполнения работы функции в скрипте end с логикой сек/мин_сек
function tendl_f() {
    END_TIME_f=$(date +%s)
    DIFF_f=$(( $END_TIME_f - $START_TIME_f ))
    MINUTES_f=$(( $DIFF_f / 60 ))
    SECONDS_f=$(( $DIFF_f % 60 ))
    if [ $MINUTES_f -eq 0 ]; then
        ttb=$(echo -e "\n Выполнение функции заняло $SECONDS_f секунд(ы).") && lang=cr && bpn_p_lang ;
    else
        ttb=$(echo -e "\n Выполнение функции заняло $MINUTES_f минут(ы) и $SECONDS_f секунд(ы).") && lang=cr && bpn_p_lang ;
    fi
}

