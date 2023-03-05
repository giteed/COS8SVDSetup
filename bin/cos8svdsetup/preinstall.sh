#!/bin/bash

# Source global definitions
# --> Прочитать настройки из /root/.bashrc
. /root/.bashrc


function gh_install()
{
	echo -e "\n $(black_U23A7 ) " ;
	echo -e " $(blue_1      ) GitHub (gh) не установлен!" ;
	echo -e " $(black_U23A9 ) " ; sleep 1 ;
	/root/bin/cos8svdsetup/utility/github.sh 2>/dev/null ;
}
( (gh) &>/dev/null || gh_install )