# .bash_profile

# Get the aliases and functions
if [ -f ~/.bashrc ]; then
	. ~/.bashrc
fi

# --> Прочитать настройки из:
. ~/cos8svdsetup/bin/styles/.load_styles.sh
. ~/cos8svdsetup/bin/functions/.load_function.sh

# --> Использовать ~/.bash_ali*
. ~/.bash_aliases

# --> Использовать . ~/cos8svdsetup/bin/utility/.root (требует для скрипта права root)
. ~/cos8svdsetup/bin/utility/.root

# User specific environment and startup programs
#hip ; #. ~/bin/lastf ;
PATH=$PATH:$HOME/bin

export PATH


# source ~/.bash_profile
