#!/bin/bash

# --> клонирование из gh repo запуск /preloader.sh (в планах частичная синхронизация)
 function vsync()
 {
    cd /root/ ; (git clone https://github.com/giteed/COS8SVDSetup.git /root/.COS8SVDSetup) ; (/root/.COS8SVDSetup/bin/cos8svdsetup/preloader.sh) ;
 }