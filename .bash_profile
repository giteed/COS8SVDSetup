# .bash_profile

# Get the aliases and functions
if [ -f /root/.bashrc ]; then
	. /root/.bashrc
fi

# --> Прочитать настройки из:
. /root/vdsetup.2/bin/styles/.load_styles.sh
. /root/vdsetup.2/bin/functions/.load_function.sh

# --> Использовать ~/.bash_ali*
. ~/.bash_aliases

# --> Использовать . /root/vdsetup.2/bin/utility/.root (требует для скрипта права root)
. /root/vdsetup.2/bin/utility/.root

# User specific environment and startup programs
#hip ; #. ~/bin/lastf ;
PATH=$PATH:$HOME/bin

export PATH


# source ~/.bash_profile
