#!/bin/bash

# --> Source global definitions
# --> Прочитать настройки из /root/.bashrc
. /root/.bashrc

lang_x 2>/dev/null ;

# Определение функции run_as_root()
function run_as_root() {
	# Проверка, что скрипт запущен с правами суперпользователя (root)
	if [[ "$EUID" -ne 0 ]]; then
		# Вывод сообщения об ошибке на экран
		echo "Error: Script must be run as root. $(error_exit_MSG)"
	fi
}

# --> Прочитать настройки из:
function read_sty_func() {
# --> загрузить настройки стилей из указанного каталога
	. /root/vdsetup.2/bin/styles/.load_styles.sh 2>/dev/null
# --> загрузить функции из указанного каталога
	. /root/vdsetup.2/bin/functions/.load_function.sh 2>/dev/null
}

# --> вызвать функцию чтения настроек стилей и функций
read_sty_func 2>/dev/null

# --> если язык не определен, установить язык по умолчанию nix
	if  [[ $lang == "" ]] ; then lang="nix" ; fi ;
	
	#------------------------------------
	# bat installed/not_installed
	#------------------------------------ 

# --> определить функцию для вывода терминального текста с помощью bat	
function bpn_p_lang() { 
# --> выводить терминальный текст с помощью bat или без его помощи
	( echo -e "${ttb}" | bat --paging=never -l ${lang} -p 2>/dev/null || echo -e "$ttb" )
# --> очистить переменную ttb 
	ttb="" ;
}

# --> определить функцию для вывода сообщения об отсутствии установленного gh
function gh_not_installed() {
# --> установить текст сообщения в переменную ttb
ttb=$(echo -e "
 ⎧ GitHub (gh) is not installed!
 ⎩ # /root/bin/cos8svdsetup/utility/github.sh 2>/dev/null
 " ) && lang_nix && bpn_p_lang ; ttb=""  ;
# --> вызвать установку gh
	/root/.COS8SVDSetup/bin/cos8svdsetup/utility/github.sh ;
}

# --> определить функцию для вывода сообщения об установленном gh
function gh_installed() {
# --> установить текст сообщения в переменную ttb
	ttb=$(echo -e "
 ⎧ GitHub (gh) is
 ⎩ already installed!
 " ) && lang_nix && bpn_p_lang ; ttb="" ;
}

# --> определить функцию для копирования и удаления файлов
function cp_rm() {
# --> скопировать файлы конфигурации в корневой каталог
	cp -f /root/.COS8SVDSetup/.bashrc /root/ ;
	cp -f /root/.COS8SVDSetup/.bash_profile /root/ ;
	cp -f /root/.COS8SVDSetup/.bash_aliases /root/ ;
# --> удалить определенные каталоги и создать новый
	rm -rf /root/vdsetup.2/bin ;
	mkdir -p /root/vdsetup.2/bin ;
# --> создать пустой файл, если он не существует
	(cat /root/.bash_ali_hosts) 2>/dev/null || touch /root/.bash_ali_hosts ;
# --> скопировать файлы из указанного каталога в новый
	cp -r /root/.COS8SVDSetup/bin/cos8svdsetup/* /root/vdsetup.2/bin ;
	#cp -a /root/.COS8SVDSetup/bin/cos8svdsetup/. /root/vdsetup.2/bin ;
}

# --> функция, которая выполняет все необходимые действия перед загрузкой
function preloader() {
# --> проверить, установлен ли gh и выполнить соответствующие действия	
	( ((gh) &>/dev/null) && gh_installed || gh_not_installed ) ;
# --> копирование настроек и удаление временных файлов
	cp_rm ;
# --> вызвать функцию чтения настроек стилей и функций
	read_sty_func 2>/dev/null ;
# --> перезагружаем файл настроек bash
	source /root/.bashrc ;
# --> удалить временные файлы
	#rm -rf /root/.COS8SVDSetup ;	
}

# --> функция, которая выводит сообщение об успешном завершении загрузки
function preloader_completed() {
# --> выводим сообщение о успешном завершении работы и очищаем переменную $ttb
	ttb=$(echo -e " 
 ⎧ The preloader has 
 ⎩ completed its work!\n") && lang_nix && bpn_p_lang ; ttb=""  ;
 exit 0
}

# --> функция, которая выводит сообщение о завершении загрузки с ошибкой
function preloader_not_completed() {
# --> выводим сообщение о неуспешном завершении работы и очищаем переменную $ttb
	ttb=$(echo -e " 
 ⎧ The Preloader completed!
 ⎩ with an error!\n") && lang_nix && bpn_p_lang ; ttb=""  ;
}

# --> вызываем функцию preloader и проверяем ее результат, если успешно - вызываем preloader_completed, иначе - preloader_not_completed
	( preloader && preloader_completed ) || preloader_not_completed

exit 0 

