#!/bin/bash

function dtfex_help() {
lang=cr ;
ttb=$(echo -e "
 \"dtfex\" - \"качалка файлов\" с файло-обменников. Основным достоинством 
 которой является скачивание этих файлов через сеть TOR. # dtfex и # dtfex_help

 -- После запуска срипта data_processing.sh в дирректории /root/ 
 будет создана папка /temp (если она не существует), а в ней 
 будет создан файл input.txt - в этот файл нужно поместить URL 
 с файло-обменников, с которых вы хотите получилть файлы. 
 -- Список файло-обменников, которые поддерживает скрипт находятся 
 в файле /utility/install/downloader_tor_fex/scriptsd/list_fex.txt
 - список будет дополняться. Эти URL будут проверены на валидность
 и затем поступят в обработку скрипту: 
 /utility/install/downloader_tor_fex/scriptsd/download.sh

 -- Скаченные файлы можно будет забрать из папки /root/temp/download_cdn/

 -- В процессе скачивания скрипты ведут логи и записывают их в 
 /root/temp/ а сразу после завершения логи стираются, чтобы не засорять 
 диск. Если вам нужна отладка скрипта и просмотр логов закомментируйте 
 их удаление в скрипте data_processing.sh в function done_cleared()
 После скачивания весь ненужный мусор удаляется включая содержимое 
 input.txt, по этому храните ваши URL в другом месте.

 -- Скрипт перед запуском проверяет соединение с TOR и только после того, 
 как соединение успешно протестировано начинает скачивание файлов. 
 Если TOR не работает, то скрипт попытается его запустить, 
 если не сможет, - скачивать файлы не будет.

 -- На момент написания скрипта было обнаружено несколько файло-обменников, 
 которые поддерживают данныый скрипт, по всей видимости \"их начинка\" идентична.
 Вот их список, - он будет дополняться в файле:
  " ) && lang="nix" && bpn_p_lang
ttb=$(echo -e "$(cat /root/vdsetup.2/bin/utility/install/downloader_tor_fex/scriptsd/list_fex.txt)" ) && lang="nix" && bpn_p_lang ;

press_anykey ;
dtfex;

}

