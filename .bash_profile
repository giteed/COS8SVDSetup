# .bash_profile

# Get the aliases and functions
if [ -f ~/.bashrc ]; then
	. ~/.bashrc
fi

# --> Прочитать настройки из:
. ~/.COS8SVDSetup/bin/cos8svdsetup/styles/.load_styles.sh
. ~/.COS8SVDSetup/bin/cos8svdsetup/functions/.load_function.sh

# --> Использовать ~/.bash_ali*
. ~/.bash_aliases

# --> Использовать . ~/.COS8SVDSetup/bin/cos8svdsetup/utility/.root (требует для скрипта права root)
. ~/.COS8SVDSetup/bin/cos8svdsetup/utility/.root

# User specific environment and startup programs
#hip ; #. ~/bin/lastf ;
PATH=$PATH:$HOME/bin

export PATH


# source ~/.bash_profile
