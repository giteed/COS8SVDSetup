#!/bin/bash

   # Листинг файлов/папок и их цифровых прав доступа:
function lk-f() 
{ 
   # Convert KB To MB using Bash
   # https://stackoverflow.com/questions/19059944/convert-kb-to-mb-using-bash	
   # man numfmt
   
   if [ "$1" == "" ]; 
      then 
      GLIG_ASTRX_OF ;
      echo -e "\n Пустой запрос "$cyan""lk""$NC" покажет все,\n кроме скрытых файлов и папок\n путь:"$ELLOW""$(pwd)""$NC"\n"
      ttb=$( stat -c '%a:%A %U %G %s %n' . .. * | numfmt --header --field 4 --from=iec --to=si | column -t ) && lang=java && bpn_p_lang ;
      return; 
   fi
   
   if [ "$1" == "." ]; 
      then 
      GLIG_ASTRX_OF ;
      echo -e "\n Запрос "$cyan""lk""$NC" c $NC\""$RED"."$NC"\" покажет все,\n включая cкрытые файлы и папки\n путь:"$ELLOW""$(pwd)""$NC"\n"
      ttb=$( stat -c '%a:%A %U %G %s %n' .* ** | numfmt --header --field 4 --from=iec --to=si | column -t ) && lang=java && bpn_p_lang ;
      return; 
   fi
   
      GLIG_ASTRX_OF ;
      echo -e "\n Вы можете выводить файлы и папки,\n используя маску. Пример: "$RED"# "$cyan"lk "$RED"*"$NC"e"$RED"*"$NC"\n путь:"$ELLOW""$(pwd)""$NC" \n"
      ttb=$( stat -c '%a:%A %U %G %s %n' $* | numfmt --header --field 4 --from=iec --to=si | column -t ) && lang=java && bpn_p_lang ;
}
