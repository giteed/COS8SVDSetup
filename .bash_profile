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
run_socket__ssh_auth_log_unix.sock 2>/dev/null ;
# Проверка на существование Unit /etc/systemd/system/Auth_Warn_SSH.service
# Еслии файла нет то создаст и запустит его auth_warn_ssh
# Посмотреть работу /root/vdsetup.2/bin/utility/auth/ssh/auth_warn.sh - screen -r auth_warn_ssh
check_unit_Auth_Warn_SSH_service &>/dev/null ;




# User specific environment and startup programs
# --> Настройки окружения и запуск пользовательских программ
PATH=$PATH:$HOME/bin

export PATH


# source /root/.bash_profile
