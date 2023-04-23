#!/bin/bash

# Функция: 
function wport() {
   
   function netstat_tulanp_nogrep() {
      ( echo -e "\n${green}$(netstat -tulanp | head --lines 2 | grep -v "Active Internet" )${NC}\n" ; netstat -tulanp | grep -v "Active Internet" | grep -v " Foreign Address" |  bat --paging=never -l nix -p ) || ( echo -e "\n${green}$(netstat -tulanp | head --lines 2 | grep -v "Active Internet" )${NC}\n" ; netstat -tulanp | grep -v "Active Internet" | grep -v " Foreign Address" ) ;
    }
   
   function netstat_tulanp() {
      
      ( echo -e "\n${green}$(netstat -tulanp | head --lines 2 | grep -v "Active Internet" )${NC}\n" ; netstat -tulanp | rg "$1" | bat --paging=never -l nix -p ) || ( echo -e "\n${green}$(netstat -tulanp | head --lines 2 | grep -v "Active Internet" )${NC}\n" ; netstat -tulanp | rg $1 ) ;
    }
   
   function help_wport() {
       echo -e "\n ${green}This function print${NC}:\n  netstat -tulanp | grep \"\$1\"\n\n ${green}Usage${NC}:\n  wport \"keyword\" or \":port\"\n  wport all or \"${red}.${NC}\"\n  wport :22\n  wport :80\n  wport tcp\n  wport udp\n  wport LISTEN\n  wport ESTABLISHED\n  wport 127.0.0.1 "
       # Usage: grep [OPTION]... PATTERN [FILE]...
    }
    if [[ $1 == "" ]] ; then help_wport && return ; fi ;
    if [[ $1 == "all" ]] ; then netstat_tulanp_nogrep && return ; fi ;
    if [[ $1 == "." ]] ; then netstat_tulanp_nogrep && return ; fi ;
    if [[ $1 == "-h" ]] ; then help_wport && return ; fi ;
    
    netstat_tulanp $1 ;
}