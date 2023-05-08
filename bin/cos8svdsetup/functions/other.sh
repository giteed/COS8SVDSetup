
#!/bin/bash

# Функция: Очистка ( полная, включая промотку вверх ) экрана терминала 
function cv() { (clear && clear) }

# Очистка ( не полная, не включая промотку вверх ) экрана терминала 
function c() { (clear) }

# Функция: User
function im() { whoami ; } ;

# Поиск программ, по 6 утилитам
function wis() { (GLIG_ASTRX_ON && wis-f $1 $2) } ;

# Запуск инсталляции/удаления/управления пользователями wireguard
function wg_ins() {
	/root/vdsetup.2/bin/utility/install/vpn/wireguard-install.sh
}

# Исправление ошибки "Failed to set locale, defaulting to C.UTF-8" 
function locale_fix() {
	/root/vdsetup.2/bin/utility/system/locale.sh ;
}

function ssh_port_change() {
	
	/root/vdsetup.2/bin/utility/system/ssh_port_ch.sh ;
}

function info_vds() {
	/root/vdsetup.2/bin/utility/system/ii.sh ;
}