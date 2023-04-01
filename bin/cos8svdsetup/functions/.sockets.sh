#!/bin/bash

function run_socket__ssh_auth_log_unix.sock() {
# tail -f /var/log/secure просмотр лога вручную.
# Проверка на существование ssh_auth_log_unix.sock и если его нет, он будет создан.
# Сокет предназначен для обмена со скриптом auth_warn.sh который информирует о попытках входа по SSH на данной машине.
if test -S /tmp/ssh_auth_log_unix.sock; then
  echo " Socket file /tmp/ssh_auth_log_unix.sock exists."
else
  echo " Create /tmp/ssh_auth_log_unix.sock."
  # Команда, которая будет выполнена, если файл не существует
  # Условие создает UNIX сокет /tmp/mysocket.sock и запускает процесс "socat" в режиме прослушивания данного сокета. Флаг "fork" означает, что для каждого соединения, устанавливаемого с помощью сокета, будет создаваться отдельный процесс. Знак "-" указывает на использование стандартного ввода/вывода в качестве терминала (для передачи данных между клиентом и сервером через сокет). В целом, эта команда позволяет устанавливать соединения с помощью созданного сокета и обмениваться данными между клиентом и сервером.
  sudo socat unix-listen:/tmp/ssh_auth_log_unix.sock,fork - &
fi

}












function primer_mysocket_no-run_this() {

# Условие создает UNIX сокет /tmp/mysocket.sock и запускает процесс "socat" в режиме прослушивания данного сокета. Флаг "fork" означает, что для каждого соединения, устанавливаемого с помощью сокета, будет создаваться отдельный процесс. Знак "-" указывает на использование стандартного ввода/вывода в качестве терминала (для передачи данных между клиентом и сервером через сокет). В целом, эта команда позволяет устанавливать соединения с помощью созданного сокета и обмениваться данными между клиентом и сервером.
if test -S /tmp/mysocket.sock; then
  echo "Socket file /tmp/mysocket.sock exists."
else
  echo "Create /tmp/mysocket.sock."
  # Команда, которая будет выполнена, если файл не существует
  socat unix-listen:/tmp/mysocket.sock,fork - &
fi

}