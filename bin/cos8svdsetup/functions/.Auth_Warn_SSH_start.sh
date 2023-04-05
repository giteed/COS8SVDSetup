#!/bin/bash

function check_unit_Auth_Warn_SSH_service() {

  function Create_enable_start_sevice() {
      echo " Create, enable and start Unit /etc/systemd/system/Auth_Warn_SSH.service"
       cp /root/vdsetup.2/bin/units_systemd/Auth_Warn_SSH.service /etc/systemd/system/Auth_Warn_SSH.service
       systemctl daemon-reload
       systemctl enable Auth_Warn_SSH.service
       systemctl start Auth_Warn_SSH.service || systemctl restart Auth_Warn_SSH.service
  }

[[ -e /etc/systemd/system/Auth_Warn_SSH.service ]] && echo " Unit file /etc/systemd/system/Auth_Warn_SSH.service exists." || Create_enable_start_sevice ;

}





