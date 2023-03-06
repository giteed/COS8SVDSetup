#!/bin/bash

# Source global definitions
# --> Прочитать настройки из /root/.bashrc
. /root/.bashrc

# --> Прочитать настройки из:
. ~/.COS8SVDSetup/bin/cos8svdsetup/styles/.load_styles.sh
. ~/.COS8SVDSetup/bin/cos8svdsetup/functions/.load_function.sh
 

function gh_install()
{

ttb=$(echo -e "
 ⎧ 
 | GitHub (gh) не установлен!
 ⎩ # /root/bin/cos8svdsetup/utility/github.sh 2>/dev/null
 " ) && lang_nix && bpn_p_lang ; ttb=""  ;

 sleep 1 ;
	/root/.COS8SVDSetup/bin/cos8svdsetup/utility/github.sh 2>/dev/null ;
}

( (gh) &>/dev/null || gh_install )
