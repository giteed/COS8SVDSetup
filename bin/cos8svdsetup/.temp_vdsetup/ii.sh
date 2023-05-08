# Дополнительные сведения о системе
function ii() 
{
   echo -e "\n${cyan}Вы находитесь на ${green}$(hostname)$NC\n"
   hostnamectl | bat -l nix -p || hostnamectl ;
   echo -e "\nДополнительная информация:$NC " ; 
   echo -e "\n $( red_U0023 ) uname -a " ; 
   uname -a ;
   echo cat /etc/redhat-release ;
   cat /etc/redhat-release ;
   
   echo -e "\n${cyan}Дата:$NC " ; echo -e " $( red_U0023 ) date " ; date | bat  --paging=never -l nix -p
   echo -e "\n${cyan}Время, прошедшее с момента последней перезагрузки :$NC " ; echo -e "\n $( red_U0023 ) uptime " ; uptime | bat  --paging=never -l log -p ;
   echo -e "\n${cyan}В системе работают пользователи:$NC " ; echo -e "\n $( red_U0023 ) who" ; who ; 
    echo -e "\n $( red_U0023 ) lastf " ; lastf ;
   lastf -h ;
   echo -en "\n${cyan}Память:$NC "; mem ; echo -e "\nTop 25 RAM:"; t25r ;
   echo -en "\n\n${cyan}*** ${green}Файловая система: ${cyan}***$NC\n"; df ; echo ; echo ; echo -e " $( red_U0023 ) fdisk -l"; fdisk -l | bat  --paging=never -l nix -p ; echo -e "\n $( red_U0023 ) lsblk -pf " ; lsblk -pf | bat  --paging=never -l nix -p ; echo ; echo -e "\n $( red_U0023 ) mount | column -t" ; mount | column -t | bat  --paging=never -l nix -p ; 
   my_ip 2>&- ;
   echo -e "\n\n${cyan}*** ${green}Сетевые параметры ${cyan}***$NC";
   echo -e "\n${cyan}IP адрес:${green}(локальный)$NC" ; echo ${MY_L_IP:-"Соединение не установлено"}
   echo -e "\n${cyan}IP адрес:${green}(VPN локальный)$NC" ; echo ${MY_L_VPN_IP:-"Соединение не установлено"}
   echo -e "\n${cyan}IP адрес:${green}(VPN внешний)$NC" ; echo ${MY_I_VPN_IP:-"Соединение не установлено"}
   echo -e "\n${cyan}IP адрес:${green}(внешний)$NC" ; echo ${MY_P_IP:-"Соединение не установлено"}
   echo -e "\n${cyan}Адрес провайдера (ISP):$NC" ; echo ${MY_P_ISP:-"Соединение не установлено"}
   mi ;
   echo -e "\n $( red_U0023 ) hostname --all-ip-addresses\n ${cyan}или$NC\n $( red_U0023 ) hostname -I$NC${cyan},\n который делает то же самое (дает вам все IP-адреса хоста) " ; echo -e " $( red_U0023 ) nmcli dev show | grep DNS\n или\n $( red_U0023 ) resolvectl status | rg "DNS Server"\n покажет DNS$NC"
   echo -e "${RED} ------------------------------------------------- ${NC}" ;
   echo -en " " && allip ; echo -en "\n " ; nmcli dev show | grep DNS ;
      ( ( resolvectl status | rg "DNS Server" ) | bat --paging=never -l nix -p ) ;
   echo -e "\n${NC} Чтобы изменить или добавить dns сервера можно\n отредактировать файл /etc/systemd/resolved.conf\n и добавить нужные адреса в секцию Resolve:\n\n $( red_U0023 ) nano /etc/systemd/resolved.conf\n [Resolve]\n DNS=8.8.8.8, 8.8.4.4 ${NC}\n\n Или используете NetworkManager\n Трогать /etc/resolv.conf не желательно, так как\n он будет автоматически обновляться\n после перезагрузки сервера" ;
   echo -e "${RED} ------------------------------------------------- ${NC}\n" ;
   echo -e "\n $( red_U0023 ) ifconfig" ; ifc ;
   echo -e "\n $( red_U0023 ) netstat -in" ; netstat -in | bat --paging=never -l nix -p ;
   echo -e "\n $( red_U0023 ) netstat -tlpn" ; netstat -tlpn | bat --paging=never -l nix -p ;
   echo
   nmcli connection show
   echo
   nmcli device status
   echo -e "\n $( red_U0023 ) "$cyan" nmcli device show "$CYAN"enp0s3 "$NC" \n"
   nmcli device show enp0s3 2>/dev/null | rg "(DEVICE|TYPE|STATE|IP|CONNECTION)" | bat  --paging=never -l nix -p ;
   echo -e "\n $( red_U0023 ) "$cyan" nmcli device show "$CYAN"tun0 "$NC" \n"
   nmcli device show tun0 2>/dev/null | rg "(DEVICE|TYPE|STATE|IP|CONNECTION)" | bat  --paging=never -l nix -p ;
   echo -e "\n $( red_U0023 ) "$cyan" nmcli device show "$CYAN"tun1 "$NC" \n" ;
   nmcli device show tun1 2>/dev/null | rg "(DEVICE|TYPE|STATE|IP|CONNECTION)" | bat  --paging=never -l nix -p ;
   #nmcli -p -m multiline -f all con show
   echo -e "\n $( red_U0023 ) resolvectl status" ;
   ( ( resolvectl status ) &>/dev/null || ( systemctl start systemd-resolved.service && systemctl enable systemd-resolved.service &>/dev/null || echo -e "error starting or enabled systemd-resolved.service" ) ) && ( ( resolvectl status ) | bat --paging=never -l nix -p )
   echo -e "\n $( red_U0023 ) firewall-cmd --list-all"
   firewall-cmd --list-all | bat -p --paging=never -l nix;
   echo -e "\n $( red_U0023 ) lsof -i"
   lsof -i | bat  --paging=never -l nix -p ;
    echo -e "\n $( red_U0023 ) netstat -tup ( netstat -tulanp показать больше...)" ; netstat -tup | bat  --paging=never -l nix -p ;
   #zzz 10 0 1 10 ;
   
}

ii ;