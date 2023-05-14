#!/bin/bash

# Source global definitions
# --> Прочитать настройки из /root/.bashrc
. /root/.bashrc

# функция для задания вопросов и чтения ответа
ask_question() {
  read -p "$1: " answer
  echo "$answer"
}

# меню для выбора типа поиска
menu() {
  echo "Выберите тип поиска:"
  echo "1. По имени файла"
  echo "2. По расширению файла"
  echo "3. По размеру файла"
  echo "4. По дате изменения файла"
  read -p "Выберите вариант (1-4): " option
  case $option in
    1) search_type="-name";;
    2) search_type="-iname";;
    3) search_type="-size";;
    4) search_type="-mtime";;
    *) echo "Ошибка: неправильный вариант"; exit 1;;
  esac
}

# задаем вопросы и получаем ответы
pattern=$(ask_question "Введите паттерн для поиска")
menu
value=$(ask_question "Введите значение для поиска")

# выполнение поиска
echo "Поиск файлов с паттерном \"$pattern\" и $search_type \"$value\"..."
find . $search_type "$value" -type f -iname "$pattern" | head -n 25
