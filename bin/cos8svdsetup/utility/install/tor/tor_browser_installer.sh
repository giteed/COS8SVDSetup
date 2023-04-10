#!/bin/bash

# Source global definitions
# --> Прочитать настройки из /root/.bashrc
. /root/.bashrc


# --> Этот ссылка на функцию проверяет, запущен-ли скрипт с правами суперпользователя (root) в Linux.
. /root/vdsetup.2/bin/functions/run_as_root.sh

	css ;
	ttb=$(echo -e "
 ⎧ Protect yourself against tracking,
 | surveillance, and censorship.
 | Get Tor Browser for Linux Cent OS 8.
 ⎩ https://www.torproject.org/download/
" ) && bpn_p_lang ; ttb=""  ;

cd /tmp/ ;
wget https://www.torproject.org/dist/torbrowser/12.0.1/tor-browser-linux64-12.0.1_ALL.tar.xz
tar -xf tor-browser-linux64-12.0.1_ALL.tar.xz
mkdir -p /root/myapp
mv tor-browser/ /root/myapp
cp /root/myapp/tor-browser/

    exit 0 ;


mv tor-browser/ /root/Desktop
cp tor-browser/start-tor-browser.desktop /root/Desktop
85 строка кода файла /root/tor-browser/tor-browser/Browser/start-tor-browser
команда запуска /root/tor-browser/tor-browser/Browser/start-tor-browser







#if [ "`id -u`" -eq 0 ]; then
#	complain "The Tor Browser should not be run as root.  Exiting."
#	exit 1
#fi




[Desktop Entry]
Type=Application
Name=Tor Browser
GenericName=Web Browser
Comment=Tor Browser  is +1 for privacy and −1 for mass surveillance
Categories=Network;WebBrowser;Security;
Exec=sh -c '"/root/tor-browser/tor-browser/Browser/start-tor-browser"'
X-TorBrowser-ExecShell=./Browser/start-tor-browser --detach
Icon=/root/tor-browser/tor-browser/Browser/browser/chrome/icons/default/default128.png
StartupWMClass=Tor Browser









exit 0 ;