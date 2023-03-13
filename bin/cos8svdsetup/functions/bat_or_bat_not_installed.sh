
#!/bin/bash

# --> функции работы с текстовым процессором bat для подсветки синтаксиса терминала.
# --> если bat не установлен, функция покажет любой текст отправленый в переменную ttb в обычном виде.
   if  [[ $lang == "" ]] ; then lang="nix" ; fi ;

   #------------------------------------
   # bat installed/not_installed
   #------------------------------------  
   
   function bpn_p_lang() {
	  
	 ( echo -e "${ttb}" | bat --paging=never -l ${lang} -p 2>/dev/null || echo -e "$ttb" ) 
	  ttb="" ;
	}

   function bpal_p_lang() {
	 
	 ( echo -e "${ttb}" | bat --paging=always -l ${lang} -p 2>/dev/null || echo -e "$ttb" ) 
	 ttb="" ;
	}
   
   #function lang_x() {
   #   lang=$1 ;
   #   if [[ $1 == "" ]] ; then lang=cr ; fi ;
   #}
   
   function lang_nix() {
	  lang=nix
   }
   function lang_cr() {
	  lang=cr
   }   
   
   function lang_bash() {
	  lang=bash ;
   }
   
   function lang_help() {
	  lang=help ;
   }