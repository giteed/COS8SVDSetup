#!/bin/bash

# Source global definitions
# --> Прочитать настройки из /root/.bashrc
. /root/.bashrc

# --> Этот ссылка на функцию проверяет, запущен-ли скрипт с правами суперпользователя (root) в Linux.
#. /root/vdsetup.2/bin/functions/run_as_root.sh


# Только для CentOs 8 - ВКЛЮЧЕНО для ВСЕХ попыток авторизаций (secure_auth_OK_and_fail)
function ssh_auth_login() {
	  # Только для CentOs 8 для всех попыток авторизаций 
	  function secure_auth_OK_and_fail() {
		  
		  # путь к файлу логов
		  LOG_FILE="/var/log/secure"   
		  # строка, которая указывает на вход по SSH (успешный или неуспешный)
		  LOGIN_PATTERN="(Accepted publickey|Accepted password|Failed password)"  
		  
		  # Открыть лог-файл в "tail" в режиме follow и прочитать каждую новую строку
		  tail -f $LOG_FILE | while read line
		  do
			# Если строка содержит указанную подстроку, то вывести сообщение в консоль
			if [[ "$line" =~ $LOGIN_PATTERN ]]; then
			  # Извлечь имя пользователя и IP-адрес из строки лога
			  user=$(echo "$line" | awk '{print $9}')
			  ip=$(echo "$line" | awk '{print $11}')
			  # Эта команда использует утилиту awk для выборки 6 и 7 полей из строки $line, и результат сохраняется в переменной $reason. в этих полях может быть: Accepted publickey, Accepted password, Failed password и т.д.
			  reason=$(echo "$line" | awk '{print $6,$7}')
			 
			  # Определить, был ли вход успешным или нет
			 if [[ "$line" == *"Accepted publickey"* || "$line" == *"Accepted password"* ]]; then
			 # 
				 status="${green}$reason!${nc}"
				 echo $line
			 else
				 status="${red}$reason!${nc}"
				 echo $line
			 fi
			 
			  # Вывести сообщение в консоль (можно изменить на что-то другое, например, отправку электронной почты)
			  echo -e "\n | $(date '+%Y-%m-%d %T') \n ${red}|${nc} Обнаружен вход по SSH: ($status)\n ${red}|${nc} User: $user / ip: $ip " | socat - unix-connect:/tmp/mysocket.sock ;
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
