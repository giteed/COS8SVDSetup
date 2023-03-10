#!/bin/bash

# --> Source global definitions
# --> Прочитать настройки из /root/.bashrc
. /root/.bashrc

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
	rm -rf /root/.COS8SVDSetup ;	
}

# --> функция, которая выводит сообщение об успешном завершении загрузки
function preloader_completed() {
# --> выводим сообщение о успешном завершении работы и очищаем переменную $ttb
	ttb=$(echo -e " 
 ⎧ The preloader has 
 ⎩ completed its work!\n") && lang_nix && bpn_p_lang ; ttb=""  ;
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






















#!/bin/bash

# Установите значение переменной token в токен вашего бота Telegram
token="YOUR_BOT_TOKEN"

# Установите значение переменной chat_id в ID чата, куда вы хотите отправить сообщение
chat_id="YOUR_CHAT_ID"

# Установите значение переменной message в текст сообщения, которое вы хотите отправить
message="Hello, World!"

# Отправляем запрос к Telegram API
curl -s -X POST "https://api.telegram.org/bot$token/sendMessage" -d "chat_id=$chat_id&text=$message"










Для того чтобы написать скрипт на Bash для Telegram, вам нужно использовать Telegram Bot API. Вот пример скрипта на Bash для отправки сообщения через Telegram Bot API:

Получите токен вашего бота от BotFather в Telegram.

Создайте файл "telegram_bot.sh" и добавьте следующий код:


#!/bin/bash

# Укажите токен вашего бота
TOKEN="YOUR_BOT_TOKEN"

# Укажите ID чата, в который вы хотите отправить сообщение
CHAT_ID="YOUR_CHAT_ID"

# Текст сообщения, который вы хотите отправить
MESSAGE="Hello, world!"

# Отправить сообщение
curl -s -X POST https://api.telegram.org/bot${TOKEN}/sendMessage -d chat_id=${CHAT_ID} -d text="${MESSAGE}" >/dev/null 2>&1


Сохраните файл и запустите его с помощью команды:

$ bash telegram_bot.sh

Теперь вы должны увидеть сообщение в выбранном вами чате в Telegram.

Обратите внимание, что этот пример скрипта на Bash отправляет только текстовые сообщения. Если вы хотите отправлять другие типы сообщений, такие как фотографии или видео, вам нужно будет использовать другие методы Telegram Bot API. Также, помните о безопасности и не делитесь вашим токеном бота с непроверенными лицами.


где получить CHAT_ID="YOUR_CHAT_ID"
Для получения CHAT_ID вам нужно отправить сообщение в нужный чат с ботом, который вы создали в Telegram Bot API. Затем вы можете использовать следующий метод, чтобы получить CHAT_ID:

Перейдите в следующий URL в вашем веб-браузере, заменив <YOUR_BOT_TOKEN> на токен вашего бота:

https://api.telegram.org/bot<YOUR_BOT_TOKEN>/getUpdates
Вы должны получить ответ в формате JSON с информацией о последних обновлениях для вашего бота. Найдите объект "chat" в JSON-ответе, который соответствует чату, в который вы отправили сообщение. Узнайте "id" этого объекта - это и будет ваш CHAT_ID.

Сохраните этот CHAT_ID и используйте его в вашем скрипте на Bash.

Обратите внимание, что CHAT_ID может измениться, если пользователь покинет чат и затем вернется в него, поэтому вам нужно будет обновлять CHAT_ID соответствующим образом, если происходят какие-либо изменения в вашем чате.
