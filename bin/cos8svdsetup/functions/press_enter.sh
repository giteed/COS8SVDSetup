
#!/bin/bash

# --> функция Нажмите 'ENTER' или любую другую клавишу, чтобы продолжить , или 'ESC'  для отмены...   
function press_enter_to_continue_or_ESC_or_any_key_to_cancel() {
# --> выводим пустую строку, чтобы сделать вывод более читабельным
       echo -en "\n     " 
# --> создаем переменную ttb для вывода сообщения пользователю
       ttb=$(echo -e "Press 'ENTER' or any other key to continue, or 'ESC' to cancel...  \n") && lang="nix" && bpn_p_lang ; 
# --> читаем один символ в переменную answ, без отображения ввода       
       read -s -n 1 answ 
# --> проверяем, является ли введенный символ ESC-кодом
       if [[ "$answ" == $'\x1b' ]] ; then 
# --> если да, то завершаем выполнение программы exit 0
           exit 0 ;
       else
# --> иначе, выводим пустую строку для удобства
           echo 
       fi
       
       

   }

# --> Этот код, запрашивает пользователя подтверждение нажатия клавиши "Enter" для продолжения или любой другой клавиши, чтобы отменить:
# --> функция Нажмите 'ENTER', чтобы продолжить, или 'ESC' или любую другую клавишу для отмены...
function press_enter_to_continue_or_ESC_or_any_key_to_cancel() {
# --> выводим пустую строку, чтобы сделать вывод более читабельным
        echo -en "\n     " 
# --> Запрашиваем у пользователя подтверждение нажатия клавиши
        read -p "Press 'ENTER' to continue or 'ESC' or any other key to cancel..." -n 1 key
   
# --> Проверяем, была ли нажата клавиша "Enter"
       if [[ $key == "" ]]; then
          echo -e "\n     Continue...\n"
# --> Здесь можно продолжить выполнение скрипта
       else
# --> Проверяем, была ли нажата клавиша "ESC"
         if [[ $key == $'\e' ]]; then
           echo -e "\n\n     Cancel!\n"
           exit 0
         else
           echo -e "\n\n     Cancel!\n"
           exit 0
         fi
       fi
       
       # --> Этот код использует команду read для ожидания ввода пользователя. Флаг -p используется для вывода запроса на экран, а флаг -n 1 ожидает только одно нажатие клавиши.
       
       # --> Если пользователь нажимает "Enter", то скрипт продолжает выполнение. Если пользователь нажимает любую другую клавишу, то проверяется, является ли нажатая клавиша клавишей "ESC" (которая кодируется как $'\e') или любой другой клавишей, и соответствующе выводится сообщение "Cancelled." Затем скрипт завершается с кодом возврата 0 (успешно).
  }
   
function press_enter() {
# -->  Выводим сообщение для пользователя с подсказкой для отмены (Ctrl+C)
       read -p "Press any key to continue $(echo -e $BLACK)(Ctrl+C to quit)" -n 1 -s -r || read -p "Press ENTER to continue (Ctrl+C to quit)" -n 1 -s -r ;
       
       # --> В этой команде опция -n 1 для того, чтобы ожидать только одно нажатие любой клавиши, опция -s указывает, что символы, вводимые пользователем, не будут отображаться на экране, а опция -p позволяет задать сообщение-приглашение для ввода. Например: Вводимый пользователем пароль будет сохранен в переменную password.
    }

# --> функция: Ожидание нажатия клавиши "Enter" для продолжения работы программы
function press_enter_or_cancel() {
# Отображаем сообщение на экране терминала с инструкцией для пользователя
        echo -en "                ${RED}# ${BLACK}PRESS ${NC}\"${YELLOW}ENTER${NC}\" ${GREEN}to Continue ${NC}...\n${NC}     ${BLACK}... or ${NC}\"${cyan}any key${NC}\" ${GREEN}+ ${NC}\"${YELLOW}ENTER${NC}\" ${RED}to Cancel!\n${NC}"
        
# Ждем, пока пользователь нажмет клавишу
        read -r -n 1 -s key 
           
# Если пользователь нажал клавишу "Enter", то продолжаем работу программы
        if [ -z "$key" ]
        then 
            echo ; 
        else
# Если пользователь нажал любую другую клавишу, то завершаем программу 
            exit 0 ;
        fi ;
        # --> Эта функция может использоваться для задержки выполнения программы, пока пользователь не подтвердит свое желание продолжить работу. Она может быть полезна в случаях, когда программа должна ждать действий пользователя, прежде чем продолжить выполнение.
    }

function press_anykey() {
# Если пользователь нажал любую клавишу, то завершаем функцию и продолжаем выполнять то что идет за ней. 
      read -n 1 -s -r -p "	$(ttb=$(echo -e "Press any key to continue...") && bpn_p_lang ) " ;
        # --> Эта функция может использоваться для задержки выполнения программы, пока пользователь не подтвердит свое желание продолжить работу. Она может быть полезна в случаях, когда программа должна ждать действий пользователя, прежде чем продолжить выполнение.
    }