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
  
function kill_help() {
   
   ttb=$(echo -e " 
    Используйте скрипт \"killl\" так:
    # killl PID_процесса
   
   
    Утилита: \"pkill\":
    ----------------------------------------------
 ⎧ 1) Для завершения процесса с определенным 
 | именем можно использовать следующую 
 | команду: # pkill имя_процесса
 ⎩ Например: # pkill firefox

 ⎧ 2) Если нужно завершить несколько процессов с одним 
 | именем, можно использовать опцию -f для указания 
 | полного имени процесса: # pkill -f имя_процесса
 ⎩ Например: # pkill -f firefox

 ⎧ 3) Можно использовать опцию -u для завершения 
 | процессов, запущенных от указанного 
 | пользователя: # pkill -u имя_пользователя имя_процесса
 ⎩ Например: # pkill -u john firefox 
 
 
    Cкрипты: \"kkill\", \"fkill\" утилита \"killall\":
    ----------------------------------------------
 ⎧ 1) Убить процесс по неточному совадению:
 ⎩ # kkill
 
 ⎧ 2) Убить процесс с помощью посика (fzf):
 ⎩ # fkill
 
 ⎧ В крайнем случае можно (НО ОПАСНО!)
 ⎩ # sudo killall -9 имя_процесса_целиком
 
 ⎧ !!! Это приведет к немедленному завершению всех 
 | процессов, связанных с указанным именем, без 
 | возможности сохранения данных. Это может быть
 | опасно и привести к потере данных или коррупции 
 | файлов, если процесс был активен в момент 
 | завершения. Поэтому не рекомендуется использовать
 ⎩ killall и опцию -9 без крайней необходимости!
 
 
   !!! Убедитесь, что программа которую вы хотите 
   убить, не находится в фоновом режиме.
    ----------------------------------------------
 ⎧ Если программа была запущена в фоновом режиме,  
 | &, ctrl+z, bg, то ее можно достать на передний 
 | план с помощью команды fg:
 |
 | 1) Введите команду jobs для просмотра списка задач.
 | Вы увидите номер каждой задачи и ее состояние.
 |
 | 2) Выберите задачу, которую вы хотите достать на 
 | передний план, используя ее номер в списке задач.
 |
 | 3) Введите команду fg %номер_задачи (из списка).
 |
 | - После этого выбранная задача будет перемещена на 
 ⎩ передний план, и ее вывод будет отображаться в терминале.
 
 " ) && lang="cr" && bpn_p_lang ;
 
 ttb=$(echo -e " 
 ⎧  Убить процесс по ключевому так-же слову можно командой:
 |  # ps ax | awk '/[n]ame/ { print $1 }' | xargs kill
 |  # pidof name | awk '{ print $1 }' | xargs kill
 ⎩  # ps ax | grep <name> | grep -v grep | awk '{print $1}' | xargs kill
 
 " ) && lang=d && bpn_p_lang ;
}  

# Убить процесс по неточному совадению
   function kkill() {
      /root/vdsetup.2/bin/utility/kill/k-i-l-l_b-y_k-e-y-w-o-r-d.sh ;
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
       /root/vdsetup.2/bin/utility/kill/k-i-l-l_b-y_p-i-d.sh $1 ;
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
   
# Поиск текста в файлах скриптов в указанной папке
sis() {
      
      function help_sis() {
         
          if [ $# -eq 0 ]; then
              echo -e "\n Использование: sis <паттерн> [<директория>]"
              echo -e "  <паттерн>     - Строка для поиска"
              echo -e "  <директория>  - Путь к директории, в которой выполняется поиск (по умолчанию: /)"
              echo -e " Используемая для поиска команда:"
              echo -e " grep -rl "$pattern" --include "$filetype" "$directory" "
              exit 1
          fi
      }
      
         #ttb=$(help_sis) && lang=cr && bpn_p_lang
         help_sis
        
         pattern="$1"
         directory="${2:-/}"  # Если путь не указан, то используется корневая директория /
         filetype="*.sh"
         
         
         grep -rl "$pattern" --include "$filetype" "$directory"
  }


