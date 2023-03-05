#!/bin/bash

# Source global definitions
# --> Прочитать настройки из /root/.bashrc
. /root/.bashrc

# --> Прочитать настройки из:
. ~/cos8svdsetup/bin/styles/.load_styles.sh
. ~/cos8svdsetup/bin/functions/.load_function.sh
 

function gh_install()
{

ttb=$(echo -e "
 ⎧ 
 | GitHub (gh) не установлен!
 ⎩ # /root/bin/cos8svdsetup/utility/github.sh 2>/dev/null
 " ) && lang_nix && bpn_p_lang ; ttb=""  ;

 sleep 1 ;
	/root/bin/cos8svdsetup/utility/github.sh 2>/dev/null ;
}

( (gh) &>/dev/null || gh_install )
