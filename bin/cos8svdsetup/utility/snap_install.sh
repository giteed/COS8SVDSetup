#!/bin/bash

# Source global definitions
# --> Прочитать настройки из /root/.bashrc
. /root/.bashrc

echo ;


ttb=$(echo -e "
 ⎧ 1. Удаляем certbot установленный с помощью yum или dnf ;
 |
 ⎩ # dnf -y remove certbot
 " ) && bpn_p_lang ; ttb=""  ;
 
     ( dnf -y remove certbot ) && msg_done || error_MSG ;

ttb=$(echo -e "
 ⎧ 2. Устанавливаем snapd включаем snapd.socket
 |
 | # dnf -y install snapd
 | # systemctl unmask snapd.service
 | # systemctl enable snapd.socket --now
 | # systemctl start snapd.service
 | # ln -s /var/lib/snapd/snap /snap
 ⎩ # snap install core; sudo snap refresh core
 " ) && bpn_p_lang ; ttb=""  ;
      epel_repo_Check_or_install && msg_done ;
      dnf -y install snapd && msg_done ;
      systemctl unmask snapd.service && msg_done ;
      systemctl enable snapd.socket --now && msg_done ;
      systemctl start snapd.service && msg_done ;
      ln -s /var/lib/snapd/snap /snap && msg_done ;
      snap install core && msg_done ; sudo snap refresh core && msg_done ;
 
  ttb=$(echo -e "
 ⎧ Внимание!
 | После включения Snap socket выйдите из системы один раз.
 | И снова войдите обратно, чтобы гарантировать обновление snap,
 | Затем вы сможете устанавливать приложения из магазина snap.
 | Если в процессе установки вы получили ошибку:
 | \" error: snap "core" is not installed \" - 
 | запустите еще раз после обновления ssh сессии - # snap_install ;
 |
 | Зажмите Ctrl A+D чтобы выйти из этой сессии. или введите:
 |
 ⎩ # exit  (или обновите сессию # source ~/.bashrc)
 
  " ) && bpn_p_lang ; ttb=""  ; 
  exit 0;