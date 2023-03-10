#!/bin/bash

# Source global definitions
# --> Прочитать настройки из /root/.bashrc
. /root/.bashrc

# --> Прочитать настройки из:
function read_sty_func() {
	. /root/vdsetup.2/bin/styles/.load_styles.sh 2>/dev/null
	. /root/vdsetup.2/bin/functions/.load_function.sh 2>/dev/null
}

read_sty_func 2>/dev/null

#------------------------------------
# bat installed/not_installed
#------------------------------------ 
	if  [[ $lang == "" ]] ; then lang="nix" ; fi ;
	
function bpn_p_lang() { 
	( echo -e "${ttb}" | bat --paging=never -l ${lang} -p 2>/dev/null || echo -e "$ttb" ) 
	ttb="" ;
}

function gh_not_installed() {

ttb=$(echo -e "
 ⎧ GitHub (gh) is not installed!
 ⎩ # /root/bin/cos8svdsetup/utility/github.sh 2>/dev/null
 " ) && lang_nix && bpn_p_lang ; ttb=""  ;

	/root/.COS8SVDSetup/bin/cos8svdsetup/utility/github.sh ;
}

function gh_installed() {

ttb=$(echo -e "
 ⎧ GitHub (gh) is
 ⎩ already installed!
 " ) && lang_nix && bpn_p_lang ; ttb="" ;
}

function cp_rm() {
	cp -f /root/.COS8SVDSetup/.bashrc /root/ ;
	cp -f /root/.COS8SVDSetup/.bash_profile /root/ ;
	cp -f /root/.COS8SVDSetup/.bash_aliases /root/ ;
	
	rm -rf /root/vdsetup.2/bin ;
	mkdir -p /root/vdsetup.2/bin ;
	(cat /root/.bash_ali_hosts) 2>/dev/null || touch /root/.bash_ali_hosts ;
	
	cp -r /root/.COS8SVDSetup/bin/cos8svdsetup/* /root/vdsetup.2/bin ;
}

function preloader() {
	
	( ((gh) &>/dev/null) && gh_installed || gh_not_installed ) ;
	cp_rm ;
	read_sty_func 2>/dev/null ;
	source /root/.bashrc ;
	rm -rf /root/.COS8SVDSetup ;
	
}

function preloader_completed() {
	ttb=$(echo -e " 
 ⎧ The preloader has 
 ⎩ completed its work!\n") && lang_nix && bpn_p_lang ; ttb=""  ;
}

function preloader_not_completed() {
ttb=$(echo -e " 
 ⎧ The Preloader completed!
 ⎩ with an error!\n") && lang_nix && bpn_p_lang ; ttb=""  ;
}

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
