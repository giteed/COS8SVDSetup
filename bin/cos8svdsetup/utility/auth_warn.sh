#!/bin/bash

# Source global definitions
# --> Прочитать настройки из /root/.bashrc
#. /root/.bashrc

# --> Этот ссылка на функцию проверяет, запущен-ли скрипт с правами суперпользователя (root) в Linux.
. /root/vdsetup.2/bin/functions/run_as_root.sh


# Только для CentOs 8 - ВКЛЮЧЕНО для ВСЕХ попыток авторизаций (secure_auth_OK_and_fail)
function ssh_auth_login() {
	  # Только для CentOs 8 для всех попыток авторизаций 
	  function secure_auth_OK_and_fail() {
		  
		  # путь к файлу логов
		  LOG_FILE="/var/log/secure"   
		  # строка, которая указывает на вход по SSH (успешный или неуспешный)
		  LOGIN_PATTERN="(Accepted publickey|Failed password)"  
		  
		  # Открыть лог-файл в "tail" в режиме follow и прочитать каждую новую строку
		  tail -f $LOG_FILE | while read line
		  do
			# Если строка содержит указанную подстроку, то вывести сообщение в консоль
			if [[ "$line" =~ $LOGIN_PATTERN ]]; then
			  # Извлечь имя пользователя и IP-адрес из строки лога
			  user=$(echo "$line" | awk '{print $9}')
			  ip=$(echo "$line" | awk '{print $11}')
			 
			  # Определить, был ли вход успешным или нет
			  if [[ "$line" == *"Accepted publickey"* ]]; then
				status="${green}Успешный вход!${nc}"
			  else
				status="${red}Попытка входа с неверным паролем!${nc}"
			  fi
			 
			  # Вывести сообщение в консоль (можно изменить на что-то другое, например, отправку электронной почты)
			  echo -e "\n ${red}|${nc} Обнаружен вход по SSH: ($status)\n ${red}|${nc} User: $user / ip: $ip "
			fi
		  done
	  }
	  
	  
	  # Только для CentOs 8 и ТОЛЬКО для УСПЕШНЫХ авторизаций ( secure_auth_OK можно ВКЛЮЧИТЬ вместо secure_auth_OK_and_fail)
	  function secure_auth_OK() {
	  # путь к файлу логов
	  LOG_FILE="/var/log/secure"   
	  # строка, которая указывает на успешный вход по SSH
	  LOGIN_PATTERN="Accepted publickey"  
	  
	  # Открыть лог-файл в "tail" в режиме follow и прочитать каждую новую строку
	  tail -f $LOG_FILE | while read line
	  do
		# Если строка содержит указанную подстроку, то вывести сообщение в консоль
		if [[ "$line" == *"$LOGIN_PATTERN"* ]]; then
		  # Извлечь имя пользователя и IP-адрес из строки лога
		  user=$(echo "$line" | awk '{print $9}')
		  ip=$(echo "$line" | awk '{print $11}')
	  
		  # Вывести сообщение в консоль (можно изменить на что-то другое, например, отправку электронной почты)
		  echo -e " Обнаружен успешный вход по SSH: $user : $ip"
		fi
	  done
		  
	  }
	  secure_auth_OK_and_fail ;
	  return ;
	  
   }
ssh_auth_login


exit 0 ; 
