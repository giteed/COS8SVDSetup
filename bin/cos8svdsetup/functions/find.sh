#!/bin/bash

   # --> Поиск в текущем каталоге
   function ff-f() 
   {
      fndvalue=$1;
      colvalue=("$RED"$1"$NC") ;
      
      if [ "$1" == "" ] ; 
         then GLIG_ASTRX_OF ;
         echo -e "\n Пустой запрос \""$cyan"ff"$NC"\" покажет все, кроме скрытых\n файлов и папок в:"$ELLOW" "$(pwd)" "$NC" \n"
         stat -c '%a/%A %U %G %n' . .. * | bat  --paging=never -l c -p ;
         return ; 
      fi
      
      
      if [ "$1" == "*" ] ; 
         then GLIG_ASTRX_OF ;
         echo -e " Запрос \""$cyan"ff"$NC"\" с \""$RED"*"$NC"\" выводит результат:\n "$RED"# "$cyan"tree -Csuh"$ELLOW""$(pwd)"/" "$NC"
         tree -Csuh | more ;
         return ; 
      fi
      
      if [ "$1" == "." ] ; 
         then GLIG_ASTRX_OF ; 
         echo -e " Запрос с \""$RED"."$NC"\" выведет результат:\n "$RED"# "$cyan"stat"$NC" -c '%a/%A %U %G %n' * \n"
         stat -c '%a/%A %U %G %n' * | bat  --paging=never -l log -p ;
         return ; 
      fi
      
      GLIG_ASTRX_OF ;
      echo -e "$cyan""\nfind "$gray"- поиск файлов в текущей папке совпадающих с: "$colvalue"\n " ;
      find $(pwd) \( -type f -iname "*""$fndvalue""*" \)  2>/dev/null | rg --hidden "$fndvalue" ;
      colvalue="" ;
      fndvalue="" ; 
   
   echo -e ""
   }
   
   # Убить процесс по неточному совадению
   function kkill() {
      /root/vdsetup.2/bin/utility/k-i-l-l_b-y_k-e-y-w-o-r-d.sh ;
   }
   
   # Убить процесс по неточному совадению - должен быть установлен fzf (brew install fzf)
   function fkill() 
   {
     local pid
     pid=$(ps -ef | sed 1d | fzf -m | awk '{print $2}')
   
     if [ "x$pid" != "x" ]
     then
      echo $pid | xargs kill -${1:-9}
     fi
   }
   
   
   function killl() {
       /root/vdsetup.2/bin/utility/k-i-l-l_b-y_p-i-d.sh $1 ;
   }
   

   function etc_passwd_help() {
         ttb=$(echo -e " 
 ⎧ Файл /etc/passwd в Linux содержит информацию о 
 | пользователях системы, включая их имена, домашние 
 | директории, пароли (зашифрованные), UID 
 | (уникальный идентификатор пользователя), GID 
 | (идентификатор группы пользователя) и другие 
 | дополнительные сведения. Этот файл используется 
 | системой для проверки учетных записей пользователей 
 | и для определения их привилегий.
 |
 | Когда пользователь входит в систему, система смотрит 
 | в файл /etc/passwd, чтобы найти соответствующую 
 | учетную запись пользователя, и использует информацию 
 | из этого файла для настройки среды пользователя, 
 | задания начальной директории и других параметров.
 |
 | Обычно, файл /etc/passwd доступен только для чтения 
 | для всех пользователей на системе, чтобы обеспечить 
 | безопасность и защитить конфиденциальную информацию 
 | пользователей. Чтобы изменить содержимое этого 
 ⎩ файла, нужно иметь права суперпользователя (root)") && lang=cr && bpn_p_lang ;
    
}

function etc_passwd_all() {
    (cat /etc/passwd | bat -l passwd ) ;
}
   
   # Функция: просмотр /etc/passwd
   function etc_passwd() {      
      ttb=$(echo -e " 
 ⎧ Сейчас в системе работают, (исключая 
 ⎩ nologin, shutdown, sync, false, halt):
 " ) && lang=cr && bpn_p_lang ; 
    
    (cat /etc/passwd | rg -v nologin | rg -v shutdown | rg -v sync | rg -v false | rg -v halt | bat -l passwd) ;
      
       ttb=$(echo -e " 
 ⎧ Посмотреть /etc/passwd: # etc_passwd_all
 ⎩ Справка  о /etc/passwd: # etc_passwd_help" ) && lang=nix && bpn_p_lang ;
      
      
   }
   
# Только для CentOs 8 - ВКЛЮЧЕНО для всех попыток авторизаций (secure_auth_OK_and_fail)
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
   
   
   function fbr() # Поиск и переключение репозитариев .git
   # в начале необходимо перейти repository в папке .git или .github 
   # (ссылка на статью: https://habr.com/ru/company/wrike/blog/344770/)
   # должен быть установлен fzf (brew install fzf)
   {
     local branches branch
     branches=$(git branch --all | grep -v HEAD) &&
     branch=$(echo "$branches" |
            fzf-tmux -d $(( 2 + $(wc -l <<< "$branches") )) +m) &&
     git checkout $(echo "$branch" | sed "s/.* //" | sed "s#remotes/[^/]*/##")
   }
   
   # Если ali используется без аргументов == "" то просто alias, если ali с аргументами != "", то подставляются они после alias "$Val2"
   function ali() # alias | bat
   {
   
      if [ "$*" == "" ] ; 
         then Val1="" ;
         echo -e "$green""\n***"$NC" Все Алиасы $(whoami)"$green" ***"$NC"\n " ;
         ( alias | bat -p --paging=never -l .bash_aliases ) || ( alias ) ;
         return ;
      fi
         if [ "$*" != "" ] ; 
         then Val2="$*"
         echo -e "$green""\n***"$NC" Алиас "$cyan""$Val2""$NC" для $(whoami)"$green" ***"$NC"\n " ;
         alias "$Val2" | bat -p --paging=never -l .bash_aliases ||  ( alias "$Val2" ) ;
         return ;
      fi	
      
   }