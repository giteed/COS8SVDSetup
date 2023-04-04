#!/bin/bash

# Source global definitions
# --> Прочитать настройки из /root/.bashrc
#. /root/.bashrc

# --> Этот ссылка на функцию проверяет, запущен-ли скрипт с правами суперпользователя (root) в Linux.
#. /root/vdsetup.2/bin/functions/run_as_root.sh



function check_unit_Auth_Warn_SSH_service() {

if test -S /etc/systemd/system/Auth_Warn_SSH.service; then
  echo " Unit file /etc/systemd/system/Auth_Warn_SSH.service exists."
else
  echo " Create, enable and start Unit /etc/systemd/system/Auth_Warn_SSH.service"
   cp /root/vdsetup.2/bin/units_systemd/Auth_Warn_SSH.service /etc/systemd/system/Auth_Warn_SSH.service
   systemctl daemon-reload
   systemctl enable Auth_Warn_SSH.service
   systemctl start Auth_Warn_SSH.service
fi

}

check_unit_Auth_Warn_SSH_service ;
sudo -u root /root/vdsetup.2/bin/utility/auth/ssh/auth_warn.sh ;


