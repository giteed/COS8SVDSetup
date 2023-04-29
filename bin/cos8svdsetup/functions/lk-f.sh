#!/bin/bash

# Листинг файлов/папок и их цифровых прав доступа:
function lk-f() { 
   # Convert KB To MB using Bash
   # https://stackoverflow.com/questions/19059944/convert-kb-to-mb-using-bash	
   # man numfmt
   
   if [ "$1" == "" ]; 
      then 
      GLIG_ASTRX_OF ;
      ttb=$(echo -e "\n Пустой запрос "lk" покажет все,\n кроме скрытых файлов и папок\n путь: $(pwd)") && lang=cr && bpn_p_lang ;
      ttb=$( echo && stat -c '%a:%A %U %G %s %n' . .. * | numfmt --header --field 4 --from=iec --to=si | column -t ) && lang=java && bpn_p_lang ;
      return; 
   fi
   
   if [ "$1" == "." ]; 
      then 
      GLIG_ASTRX_OF ;
      ttb=$(echo -e "\n Запрос "lk" \".\" покажет все,\n включая cкрытые файлы и папки\n путь: $(pwd)") && lang=cr && bpn_p_lang ;
      ttb=$( echo && stat -c '%a:%A %U %G %s %n' .* ** | numfmt --header --field 4 --from=iec --to=si | column -t ) && lang=java && bpn_p_lang ;
      return; 
   fi
   
      GLIG_ASTRX_OF ;
      ttb=$(echo -e "\n Вы можете выводить файлы и папки,\n используя маску. Пример: # lk *e*\n путь: $(pwd) ") && lang=cr && bpn_p_lang ;
      ttb=$( echo && stat -c '%a:%A %U %G %s %n' $* | numfmt --header --field 4 --from=iec --to=si | column -t ) && lang=java && bpn_p_lang ;
}

 #ttb=$(echo -e "\n $(stat -c '%a:%A %U %G %n' $( (locate "/$arg_2") | (rg "/$arg_2" | rg "/$arg_2") ) 2>/dev/null | column -t ;)\n") && lang=cr && bpn_p_lang ;
 
 function lk() {
    ('GLIG_ASTRX_OF && lk-f') 2>/dev/null ;
   }