#!/bin/bash

function core_grubby_help() {
	
	
	ttb=$(echo -e "\n Список доступных в системе ядер: " ) && lang=d && bpn_p_lang ; ttb="" ;
	ls -l /boot/vmlinuz-* | grep -Po "(?<=vmlinuz-)[^-]+(-\S+)?"
	
ttb=$(echo -e " 
	
 ⎧ Если ядро уже обновлялось и WireGuard уже был установлен 
 | и работал нормально, а теперь перестал, возможно, что 
 | загрузка системы снова переключилась на старое ядро.
 ⎩ В данный момент загрузка происходит с ядра: "$(uname -r)" ?!
 
   Нажмите Enter чтобы получить помощь: 
   Или ESC и введите позднее: core_grubby_help\n
   " ) && lang=d && bpn_p_lang ; ttb="" ;
   
   press_enter_to_continue_or_ESC_or_any_key_to_cancel ;

	
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
 
  Пример вывода:  
  -rwxr-xr-x 1 root root 11M Mar 25 17:07 /boot/vmlinuz-0-rescue-9cddb2dbf6a7307ba28d6565b5d02f0a
  -rwxr-xr-x 1 root root 11M Jul 18  2022 /boot/vmlinuz-4.18.0-408.el8.x86_64
  -rwxr-xr-x 1 root root 11M Jan 18 18:12 /boot/vmlinuz-4.18.0-448.el8.x86_64
  -rwxr-xr-x 1 root root 11M Mar 31 16:31 /boot/vmlinuz-4.18.0-483.el8.x86_64
  -rwxr-xr-x 1 root root 11M Apr  4 21:30 /boot/vmlinuz-6.2.10-1.el8.elrepo.x86_64
  
 ⎧ Каждая строка списка содержит информацию об одном ядре, включая права доступа,
 | владельца и группу, размер, дату изменения и имя файла. 
 | 
 | Обычно, каждый образ ядра имеет уникальное имя, которое включает в себя номер
 | версии ядра, например /boot/vmlinuz-6.2.10-1.el8.elrepo.x86_64. Это позволяет
 | пользователю выбирать, какое ядро загрузить при запуске операционной системы, 
 ⎩ если на компьютере установлено несколько ядер.
 
 ⎧ 2) Введите:  
 | # grubby --info [kernel-filename] | grep index
 | 
 | Это выводит индекс ядра (kernel index) для указанного образа 
 | ядра [kernel-filename].
 | 
 | Пример ввода:
 ⎩ # grubby --info /boot/vmlinuz-6.2.10-1.el8.elrepo.x86_64 | grep index

  Пример вывода: 
  index=1

 ⎧ 3) Теперь, когда вы знаете индекс ядра, с которого хотите загрузиться, 
 | используйте команду: 
 | # grubby --set-default-index=[kernel-entry-index]
 |
 | Эта команда устанавливает в качестве ядра по умолчанию ядро  
 | с индексом 1 в списке доступных ядер на компьютере.
 |
 | Пример ввода: 
 ⎩ # grubby --set-default-index=1
 
  Пример вывода: 
  The default is /boot/loader/entries/9cddb2dbf6a7307ba28d6565b5d02f0a-6.2.10-1.el8.elrepo.x86_64.conf with index 0 and kernel /boot/vmlinuz-6.2.10-1.el8.elrepo.x86_64
 
 ⎧ Еще раз посмотрите версию ядра перед перезагрузкой.
 ⎩ # uname -r
  
 ⎧ 4) Чтобы изменения вступили в силу, необходимо перезагрузить сервер. 
 ⎩ # reboot 

 ⎧ 5) После перезагрузки убедитесь что сервер загружается с нужного ядра.
 ⎩ # uname -r
 
 " ) && lang_nix && bpn_p_lang ; ttb="" ;

}
