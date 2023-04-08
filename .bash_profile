# .bash_profile

# Get the aliases and functions
# --> Импортируем алиасы и функции из файла .bashrc, если такой файл существует
if [ -f /root/.bashrc ]; then
	. /root/.bashrc
fi

# Use ~/.bash_aliases
# --> Импортируем дополнительные алиасы
if [ -f /root/.bash_aliases ]; then
	. /root/.bash_aliases
fi


# User specific environment and startup programs
# --> Настройки окружения и запуск пользовательских программ
PATH=$PATH:$HOME/bin

export PATH


# source /root/.bash_profile
