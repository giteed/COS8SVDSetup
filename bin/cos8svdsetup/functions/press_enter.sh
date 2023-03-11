
#!/bin/bash


function press_enter_to_continue_or_any_key_to_cancel() {
         echo -en "\n     " ; ttb=$(echo -e "Press 'ENTER' to continue or 'ESC' to cancel...  \n") && lang="nix" && bpn_p_lang ;
         read -s answ ;
      if 
         [[ "$answ" == "" ]] 
      then 
         echo ;
      else 
         exit 0 ;
         
      fi
      
   }
   
function press_enter_to_continue_or_any_key_to_cancel2() {
#  --> выводим пустую строку, чтобы сделать вывод более читабельным
       echo -en "\n     " 
#  --> создаем переменную ttb для вывода сообщения пользователю
       ttb=$(echo -e "Press 'ENTER' to continue or 'ESC' to cancel...  \n") && lang="nix" && bpn_p_lang ; 
#  --> читаем один символ в переменную answ, без отображения ввода       
       read -s -n 1 answ 
#  --> проверяем, является ли введенный символ ESC-кодом
       if [[ "$answ" == $'\x1b' ]] ; then 
#  --> если да, то завершаем выполнение программы с кодом 0 (успешное завершение)
           exit 0
       else
#  --> иначе, выводим пустую строку для удобства
           echo 
       fi
   }
   
 function press_enter() {
       read -p "Press ENTER to continue $(echo -e $BLACK)(Ctrl+c to quit)" || read -p "Press ENTER to continue (Ctrl+c to quit)" ;
    }
 
#read -n1 -r -p " Нажмите любую кнопку..." 
function press_enter_or_cancel() {
       echo -en "                "$RED"# ${BLACK}PRESS ${NC}\"${ELLOW}ENTER${NC}\" ${green}to Continue ${NC}...\n\n${NC}     ${BLACK}... or ${NC}\"${cyan}any key${NC}\" ${GREEN}+ ${NC}\"${ellow}ENTER${NC}\" ${red}to Cancel.\n ${NC}"
       read yesno
       
       if [[ "$yesno" == "" ]]
       then echo ; test ;
          echo -e ;
       else 
          exit 0 ;
             
       fi ;
    }
    
    function press_anykey2() {
       #( read -n1 -r -p " $(echo -e $ELLOW)PRESS $(echo -e $NC)any key $(echo -e $ELLOW)to continue...$(echo -e "$NC \n")" ) ;
       ( read -n 1 -s -r -p " $(echo -e "$ELLOW\n")    Press $(echo -e $BLACK)any key ...$(echo -e "$NC \n")" ) ;
    }
     
    function press_anykey() {
      read -n1 -r -p "	$(ttb=$(echo -e "Press any key to continue...") && bpn_p_lang ) " ;
    }