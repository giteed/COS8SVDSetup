#!/bin/bash



   


   #-----------------------------------
   
   # Листинг файлов/папок и их цифровых прав доступа:
   function lk-f-c() 
   { 
      # Convert KB To MB using Bash
      # https://stackoverflow.com/questions/19059944/convert-kb-to-mb-using-bash	
      # man numfmt
      
      if [ "$1" == "" ]; 
         then 
         GLIG_ASTRX_OF ;
         echo -e "path: "$ELLOW""$(pwd)""$NC"\n" ;
         stat -c '%a:%A %U %G %s %n' . .. * | numfmt --header --field 4 --from=iec --to=si | column -t | bat  --paging=never -l c -p ;
         return; 
      fi
      
      if [ "$1" == "." ]; 
         then 
         GLIG_ASTRX_OF ;
         echo -e "path: "$ELLOW""$(pwd)""$NC"\n" ;
         stat -c '%a:%A %U %G %s %n' .* ** | numfmt --header --field 4 --from=iec --to=si | column -t | bat  --paging=never -l c -p ;
         return; 
      fi
      
         GLIG_ASTRX_OF ;
         echo -e "path: "$ELLOW""$(pwd)""$NC"\n" ;
         stat -c '%a:%A %U %G %s %n' $* | numfmt --header --field 4 --from=iec --to=si | column -t | bat  --paging=never -l c -p ;
   }
   

   #-----------------------------------
   
   function vpn-f() # Connect to VPN - help
   {
      echo -e  "\n ${cyan}vpn${CYAN}u ${NC}- start   unit: ${cyan}systemctl start ${NC}Connect_to_VPN-155.service" ;
      echo -e  " ${cyan}vpn${CYAN}s ${NC}- show  status: ${cyan}systemctl status -n0 ${NC}Connect_to_VPN-155.service" ;
      echo -e  " ${cyan}vpn${CYAN}d ${NC}- deactivating: ${cyan}systemctl stop ${NC}Connect_to_VPN-155.service" ; 
   }
   
   function vpnu() # Connect to VPN-155
   { 
      echo -e "\n ${cyan}vpn${CYAN}u ${NC}- start vpn unit: ${cyan}systemctl start ${NC}Connect_to_VPN-155.service\n" ;
      echo -e " ${NC}$(myip)" ;
      echo -e " ${GREEN}Connecting\n\n${NC} Please, wait..\n" ;
      systemctl start Connect_to_VPN-155.service && sleep 2 && echo -en "${CYAN} $(myip)\n ${GREEN}Done ${NC}\n" ; 
   }
   
   function vpns() # Status connections VPN-155
   { 
      echo -e  "\n ${cyan}vpn${CYAN}s ${NC}- show status: ${cyan}systemctl status -n0 ${NC}Connect_to_VPN-155.service" ;
      echo -e "${CYAN}\n $(myip)" && echo -e "${NC}" 
      systemctl status -n0 Connect_to_VPN-155.service ; 
   }
   
   function vpnd() # Stop unit VPN-155
   { 
      echo -e  "\n ${cyan}vpn${CYAN}d ${NC}- deactivating unit: ${cyan}systemctl stop ${NC}Connect_to_VPN-155.service\n" ; 
      echo -e " ${CYAN}$(myip)\n ${RED}Deactivating\n\n${NC} Please, wait..\n" && systemctl stop Connect_to_VPN-155.service && sleep 1 && echo -e "${NC} $(myip)\n ${GREEN}Done ${NC}" ; 
   }
   

