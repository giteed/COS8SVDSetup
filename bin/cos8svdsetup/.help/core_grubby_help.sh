#!/bin/bash
# Source global definitions


function core_grubby_help() {
	
	
	ttb=$(echo -e "\n Список доступных в системе ядер:" ) && lang=d && bpn_p_lang ; ttb="" ; echo ;
	ls -l /boot/vmlinuz-* | grep -Po "(?<=vmlinuz-)[^-]+(-\S+)?"
	
ttb=$(echo -e " 
 ⎧ Если ядро уже обновлялось и WireGuard уже был установлен 
 | и работал нормально, а теперь перестал, возможно, что 
 | загрузка системы снова переключилась на старое ядро.
 ⎩ В данный момент загрузка происходит с ядра: "$(uname -r)"
 
   Нажмите Enter, чтобы получить помощь: 
   Или введите позднее: core_grubby_help\n
   " ) && lang=d && bpn_p_lang ; ttb="" ;
   
 
 	press_anykey ;
	
	ttb=$(echo -e " 
	
 ⎧ Чтобы переключить загрузку ядра на более свежее выполните 
 | следующие действия вручную:
 |
 | 0) Посмотрите с какого ядра загружена система.
 ⎩ # uname -r
 
  Пример вывода: 
  4.18.0-448.el8.x86_64
 
 ⎧ 1) Перечислите доступные имена файлов ядра, доступные в вашей системе:
 | # ls -l /boot/vmlinuz-*
 | 
 | Вы получите спискок доступных для загрузки ядер операционной системы, которые 
 ⎩ находятся в директории /boot/
 
  Пример вывода:")  && lang_nix && bpn_p_lang ; ttb="" ; echo ;
  
  ls -l /boot/vmlinuz-*
core6=$(ls -l /boot/vmlinuz-* | grep -e 6.2 | awk '{print $9}')

echo ;
  ttb=$(echo -e " 
 ⎧ Каждая строка списка содержит информацию об одном ядре, включая права доступа,
 | владельца и группу, размер, дату изменения и имя файла. 
 | 
 | Обычно, каждый образ ядра имеет уникальное имя, которое включает в себя номер
 | версии ядра, например "$core6". Это позволяет
 | пользователю выбирать, какое ядро загрузить при запуске операционной системы, 
 ⎩ если на компьютере установлено несколько ядер.
 
 ⎧ 2) Введите:  
 | # grubby --info [kernel-filename] | grep index
 | 
 | Это выводит индекс ядра (kernel index) для указанного образа 
 | ядра [kernel-filename].
 | 
 | Пример ввода:
 ⎩ # grubby --info "$core6" | grep index") && lang_nix && bpn_p_lang ; ttb="" ;

 index=$(grubby --info "$core6" | grep index)

echo ;
  ttb=$(echo -en " Пример вывода: "$index"  ") && lang_nix && bpn_p_lang ; ttb="" ;
echo ;

ttb=$(echo -e "
 ⎧ 3) Теперь, когда вы знаете индекс ядра, с которого хотите загрузиться, 
 | используйте команду: 
 | # grubby --set-default-index=[kernel-entry-index]
 |
 | Эта команда устанавливает в качестве ядра по умолчанию ядро  
 | с индексом 1 в списке доступных ядер на компьютере.
 |
 | Пример ввода: 
 ⎩ # grubby --set-default-"$index"
 
  Пример вывода: 
  The default is /boot/loader/entries/9cddb2dbf6a7307ba28d6565b5d02f0a-6.2.11-1.el8.elrepo.x86_64.conf with index 0 and kernel "$core6"
 
 ⎧ Еще раз посмотрите версию ядра перед перезагрузкой.
 ⎩ # uname -r
 
 ⎧ Эта команда обновит конфигурацию загрузчика GRUB 
 | и удалит запись о ядре в меню загрузки.
 ⎩ # sudo grub2-mkconfig -o /boot/grub2/grub.cfg
  
 ⎧ 4) Чтобы изменения вступили в силу, необходимо перезагрузить сервер. 
 ⎩ # reboot 

 ⎧ 5) После перезагрузки убедитесь что сервер загружается с нужного ядра.
 ⎩ # uname -r
 
    Хотите автоматически произвести изменения в загрузчик с ядром "$core6"?
     "$(press_enter_to_continue_or_ESC_or_any_key_to_cancel)"
    Устанавливаю ядро по умолчанию, обновляю конфигурацию загрузчика GRUB 
 
 " ) && lang_nix && bpn_p_lang ; ttb="" ;
 
 grubby --set-default-"$index"
 sudo grub2-mkconfig -o /boot/grub2/grub.cfg
 
exit 0

}
