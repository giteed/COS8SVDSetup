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
   
   
   function pkill() {
       /root/vdsetup.2/bin/utility/k-i-l-l_b-y_p-i-d.sh
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