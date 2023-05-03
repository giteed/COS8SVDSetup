#!/bin/bash

# --> Эта ссылка на функцию проверяет, запущен-ли скрипт с правами суперпользователя (root) в Linux.

# Определение функции run_as_root()
function run_as_root() {
    # Проверка, что скрипт запущен с правами суперпользователя (root)
    if [[ "$EUID" -ne 0 ]]; then
        # Вывод сообщения об ошибке на экран
        echo "Error: Script must be run as root. $(error_exit_MSG)"
    fi
}

# --> Первая строка if [[ "$EUID" -ne 0 ]]; then проверяет, равен ли идентификатор пользователя, запустившего скрипт (EUID) нулю, что соответствует идентификатору пользователя root. Если значение EUID не равно нулю, то это означает, что скрипт не запущен с правами root, и код продолжает выполнение.

# --> В целом, этот код используется для защиты скрипта от случайного выполнения с недостаточными правами доступа, которые могут привести к нежелательным последствиям.