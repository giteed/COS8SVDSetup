#!/bin/bash

   #-----------------------------------
   # Цвета терминала
   # https://www.shellhacks.com/bash-colors/
   #-----------------------------------
      blink='\e[5m' ; NC='\e[0m' ; nc='\e[0m' ; WHITE='\e[1;1m' ; white='\e[0;0m' ; BLACK='\e[1;30m' ; black='\e[0;30m' ; RED='\e[1;31m' ; red='\e[0;31m' ; GREEN='\e[1;32m' ; green='\e[0;32m' ; ELLOW='\e[1;33m' ; ellow='\e[0;33m' ; PURPLE='\e[1;35m' ; purple='\e[0;35m' ; BLUE='\e[1;34m' ; blue='\e[0;34m'  ; CYAN='\e[1;36m' ; cyan='\e[0;36m' ; GRAY='\e[1;37m' ; gray='\e[0;37m' ; 
      #-----------------------------------
      # Дата: $D $T $Day $Month $Data $DMY
      D=$(date  +%Y-%m-%d) ; T=$(date +%H:%M:%S) ; Day="$(echo -e $( date | awk '{ print $1 } '))" ; Month="$(echo -e $( date | awk '{ print $2 } '))" ; Data="$(echo -e $( date | awk '{ print $3 } '))" ; DMY="$(echo -e "${red}"$( date | awk '{ print $1, $2, $6 } ')"${NC}")" 
  
 