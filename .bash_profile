# .bash_profile

# Get the aliases and functions
if [ -f /root/.bashrc ]; then
	. /root/.bashrc
fi


# --> Использовать ~/.bash_ali*
sudo /root/.bash_aliases


# User specific environment and startup programs
#hip ; #. ~/bin/lastf ;
PATH=$PATH:$HOME/bin

export PATH


# source /root/.bash_profile
