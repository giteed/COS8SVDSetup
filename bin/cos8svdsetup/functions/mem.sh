#!/bin/bash



# Функция: Выводит ТОП 25 процессов занимающих RAM (окрашивает текст lang="nix") 
function TopRAM25() {
   
    function top() {
       echo -e " "
       ps axo rss,comm,pid \
       | awk '{ proc_list[$2]++; proc_list[$2 "," 1] += $1; } \
       END { for (proc in proc_list) { printf("%d\t%s\n", \
       proc_list[proc "," 1],proc); }}' | sort -n | tail -n 25 | sort -rn \
       | awk '{$1/=1024;printf "%.0f MB\t",$1}{print $2}'
    }
    
    ttb=$(top) && lang="nix" && bpn_p_lang ;
}


# Функция: Выводит ТОП 25 процессов занимающих RAM (окрашивает текст lang="c") 
function t25r() { ( TopRAM25 | bat -p -l c ) }


# Функция: Показывает первые 10 прожорливых процессов CPU/RAM
function memc() { 
     
   echo -en "\n${cyan}*** ${green}MEMORY RAM/SWAP ${RED}***$NC"; mem; echo -e "\n"${cyan}*** ${green}Top 25 RAM ${RED}"***$NC"; t25r ;
   echo -e "\n${cyan}*** ${green}Top 10 RAM ${RED}***$NC"; ttb=$(ps auxf | sort -nr -k 4 | head -10 ) && lang=bash && bpn_p_lang ;
   echo -e "\n${cyan}*** ${green}Top 10 CPU ${RED}***$NC"; ttb=$(ps auxf | sort -nr -k 3 | head -10 ) && lang=bash && bpn_p_lang ;
   echo -en "\n${cyan}*** ${green}FILE SYSTEM ${RED}***$NC"; df; 
   
   ttb=$(echo -e "\n # ps ax | awk '/[s]nippet/ { print $1 }' | xargs kill\n Убить процесс по имени, или # kkill  ")&& lang=bash && bpn_p_lang ;
}


# Функция: информация о памяти системы
function mem() { 
  ramfetch 2>/dev/null ;
  ttb=$( echo -e "\n $( free -h -t )") && lang=meminfo && bpn_p_lang ;
  ttb=$( echo -e "\n # free -h -t\n") && lang=cr && bpn_p_lang ; 
}


# Функция: информации о доступном дисковом пространстве на файловой системе
function df() { ttb=$( echo -e "\n $(/usr/bin/df -kTh)") && lang_cr && bpn_p_lang ; }



