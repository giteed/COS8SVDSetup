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

# Проверка на существование ssh_auth_log_unix.sock и если его нет, он будет создан.
# Сокет предназначен для обмена со скриптом auth_warn.sh который информирует о попытках входа по SSH на данной машине. 
# tail -f /var/log/secure просмотр лога вручную.
run_socket__ssh_auth_log_unix.sock ;
check_unit_Auth_Warn_SSH_service ;




# User specific environment and startup programs
# --> Настройки окружения и запуск пользовательских программ
PATH=$PATH:$HOME/bin

export PATH


# source /root/.bash_profile
