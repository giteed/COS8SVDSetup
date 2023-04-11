#!/bin/bash

# Source global definitions
# --> Прочитать настройки из /root/.bashrc
. /root/.bashrc

# --> Этот ссылка на функцию проверяет, запущен-ли скрипт с правами суперпользователя (root) в Linux.
. /root/vdsetup.2/bin/functions/run_as_root.sh

ttb=$(echo -e " 

	 Краткое описание того, что делает этот скрипт:
	
 ⎧ 1. Очищает кэшированные метаданные и пакеты.
 | 2. Удаляет неиспользуемые пакеты и зависимости.
 | 3. Проверяет наличие проблем с зависимостями.
 | 4. Обновляет системные пакеты.
 | 5. Удаляет устаревшие пакеты.
 | 6. Очищает кэш пакетов.
 | 7. Обновляет и очищает устаревшие пакеты Flatpak.
 | 8. Удаляет старые журналы.
 ⎩ 9. Оптимизирует базу данных RPM.

 " ) && lang=d && bpn_p_lang ; ttb="" ;
press_enter_to_continue_or_ESC_or_any_key_to_cancel ;

# Clean up cached metadata and packages
ttb=$(echo -e " 
# Команда "dnf clean all" очищает кэш и временные файлы, связанные с dnf-репозиториями на вашей системе. Это может помочь устранить ошибки, связанные с установкой или обновлением пакетов. Кроме того, эта команда может освободить место на диске, если кэш занимает слишком много места.
" ) && lang=d && bpn_p_lang ; ttb="" ;
	sudo dnf clean all ;
press_enter_to_continue_or_ESC_or_any_key_to_cancel ;

# Remove unused packages and dependencies
ttb=$(echo -e " 
# Команда dnf autoremove -y удаляет все пакеты, которые больше не нужны системе, такие как устаревшие зависимости и пакеты, которые были установлены для выполнения определенных задач, но больше не нужны.
" ) && lang=d && bpn_p_lang ; ttb="" ;
	sudo dnf autoremove -y ;
press_enter_to_continue_or_ESC_or_any_key_to_cancel ;

# Check for broken dependencies
ttb=$(echo -e " 
# Команда dnf check позволяет проверить наличие и исправить зависимости пакетов в системе. Если есть какие-то проблемы с зависимостями, то эта команда может помочь их исправить. Вывод команды dnf check содержит список проблем, которые могут быть исправлены, а также подробные инструкции о том, как это сделать.
" ) && lang=d && bpn_p_lang ; ttb="" ;
	sudo dnf check ;
press_enter_to_continue_or_ESC_or_any_key_to_cancel ;

# Update system packages
ttb=$(echo -e " 
# Команда dnf update -y используется для обновления всех установленных пакетов и их зависимостей до последней версии, которая доступна в репозиториях. 
" ) && lang=d && bpn_p_lang ; ttb="" ;
	sudo dnf update -y ;
press_enter_to_continue_or_ESC_or_any_key_to_cancel ;

# Clean up orphaned packages
ttb=$(echo -e " 
# удаляет все пакеты, которые были установлены из репозиториев и больше не используются или не нужны.
" ) && lang=d && bpn_p_lang ; ttb="" ;
	sudo dnf remove $(dnf repoquery --extras --unneeded --installed) ;
press_enter_to_continue_or_ESC_or_any_key_to_cancel ;

# Clean up old kernels
ttb=$(echo -e " 
# Команда dnf remove $(dnf repoquery --installonly --latest-limit=-1 -q) удаляет все старые версии пакетов, которые были сохранены в качестве установочных в директории /var/cache/dnf. Ключ --installonly означает, что будут удалены только пакеты, которые были установлены и сохранены в директории /var/cache/dnf как установочные, но не были установлены непосредственно на систему. Ключ --latest-limit=-1 означает, что будут удалены все установочные пакеты, кроме последней установленной версии.
" ) && lang=d && bpn_p_lang ; ttb="" ;
	sudo dnf remove $(dnf repoquery --installonly --latest-limit=-1 -q) ;
press_enter_to_continue_or_ESC_or_any_key_to_cancel ;

# Remove old packages from the cache
ttb=$(echo -e " 
# Команда "dnf clean packages" удаляет все загруженные ранее RPM-пакеты из кэша DNF. Это может освободить место на диске, которое занимают устаревшие пакеты, и помочь избежать проблем с зависимостями при обновлении системы в будущем.
" ) && lang=d && bpn_p_lang ; ttb="" ;
	sudo dnf clean packages ;
press_enter_to_continue_or_ESC_or_any_key_to_cancel ;

# Update and clean up Flatpak packages
ttb=$(echo -e " 
# Команда flatpak update -y используется для обновления всех установленных Flatpak приложений. Команда проверяет наличие доступных обновлений для установленных приложений и загружает их, если они доступны. Если новые версии приложений были загружены, команда также устанавливает их в системе.
" ) && lang=d && bpn_p_lang ; ttb="" ;
	flatpak update -y ;
press_enter_to_continue_or_ESC_or_any_key_to_cancel ;	

ttb=$(echo -e " 
# Команда flatpak uninstall --unused -y удаляет все неиспользуемые приложения, которые были установлены через Flatpak. Она проверяет, какие приложения не связаны с активными репозиториями или не используются другими приложениями и удаляет их. 
" ) && lang=d && bpn_p_lang ; ttb="" ;
	flatpak uninstall --unused -y ;
press_enter_to_continue_or_ESC_or_any_key_to_cancel ;
ttb=$(echo -e " 
# Команда flatpak uninstall --delete-data --unused -y используется для удаления неиспользуемых приложений в Flatpak и их данных. Параметры --delete-data удаляет все данные приложений, которые также не используются.
" ) && lang=d && bpn_p_lang ; ttb="" ;
	flatpak uninstall --delete-data --unused -y ;
press_enter_to_continue_or_ESC_or_any_key_to_cancel ;

# Remove old logs
ttb=$(echo -e " 
# Команда journalctl --vacuum-time=7d удаляет логи systemd, которые были созданы более 7 дней назад. Это позволяет очистить пространство на жестком диске и уменьшить размер журнальных файлов, сохраняя только актуальную информацию о системных событиях.
" ) && lang=d && bpn_p_lang ; ttb="" ;
	sudo journalctl --vacuum-time=7d ;
press_enter_to_continue_or_ESC_or_any_key_to_cancel ;

# Optimize the database
ttb=$(echo -e " 
# проверяет целостность базы данных RPM, расположенной по пути /var/lib/rpm/rpmdb.sqlite. При выполнении команды SQLite выполняет проверку корректности структуры таблиц и целостности данных в таблицах базы данных RPM. Если база данных RPM содержит ошибки, то при выполнении этой команды будут выведены сообщения об ошибках. Если же все в порядке, то никаких сообщений не будет выведено. Эта команда может быть полезна для выявления проблем в базе данных RPM и предотвращения возможных проблем в будущем.
" ) && lang=d && bpn_p_lang ; ttb="" ;
	sudo sqlite3 /var/lib/rpm/rpmdb.sqlite 'pragma integrity_check' ;
press_enter_to_continue_or_ESC_or_any_key_to_cancel ;

ttb=$(echo -e " 
# Команда rpm --rebuilddb используется для перестроения базы данных пакетов RPM на системе. Это может быть полезно, если база данных пакетов повреждена и требуется восстановление. При выполнении этой команды RPM перестраивает индексы и базу данных, используемую для поиска и управления установленными пакетами на системе. 
" ) && lang=d && bpn_p_lang ; ttb="" ;
	sudo rpm --rebuilddb ;

exit 0 ; 
