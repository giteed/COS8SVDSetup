
#!/bin/bash

# --> Прочитать настройки из /root/.bashrc
. /root/.bashrc

  tstart ;

  WDIR=~/temp
  
  # Путь до рабочей папки
  WORK_DIR=$WDIR
  
  # Имя файла
  INPUT_FILE="input.txt"
  INPUT_FILE_3="$INPUT_FILE"

  # Сохраняем текущую дату и время
  DATETIME=$(date +%Y-%m-%d_%H-%M-%S)
  DATE=$(date +%Y-%m-%d)
  
  # Создаем временный файл
  TMP_FILE=$(mktemp)
  
  # Cоздаем папку для бекапа исходного файла input.txt
  mkdir -p "${WORK_DIR}"/backup_input_"${DATE}" ;
  
  
# Проверяем, существует-ли файл
function check_input_file() {
   
   if [ ! -f "${WORK_DIR}/${INPUT_FILE}" ] ; then
	 ttb=$(echo -e "\n Ошибка: файл ${WORK_DIR}/${INPUT_FILE} не существует!\n Создайте файл с URL: ${WORK_DIR}/${INPUT_FILE}") && lang_nix && bpn_p_lang ; ttb="" ;
	 # Создаю чистый файл "${WORK_DIR}/${INPUT_FILE}"
	 touch "${WORK_DIR}/${INPUT_FILE}" ; tendl ;
	  exit 1
	fi
   
  }

# Проверяем, что файл не пуст
function file_empty() {
	if [ ! -s "${WORK_DIR}/${INPUT_FILE}" ]; then
	  ttb=$(echo "\n Файл: "${WORK_DIR}/${INPUT_FILE}" пуст!\n Наполните файл списком URL для обработки!") && lang_nix && bpn_p_lang ; ttb="" ; tendl ;
	  
	  exit 1
	fi
  }

# Перемещаем обработанный список со всеми URL в "$INPUT_FILE"
function mv_url_to_input_txt() {
   
   INPUT_FILE_6="${1:-$INPUT_FILE_6}"
	echo -e " -+ Назначена переменная для INPUT_FILE_6 - "$INPUT_FILE_6" "
   
	cd "${WORK_DIR}"
	
	function msg_7() { (echo -e " 7) Перемещаем обработанный список со всеми URL "$INPUT_FILE_6" в "$INPUT_FILE" ") } ;
	mv "$INPUT_FILE_6" "$INPUT_FILE" && msg_7 ;
	
  }
  
# Выполняем небольшие исправления в исходном "$INPUT_FILE"
function in_input_file_fixes() {
   
   # Переходим в рабочую папку
	cd "${WORK_DIR}" ;
	
   function msg_0() { (echo -e "\n A) Копируем "$INPUT_FILE" в input_source_$DATETIME.txt ") } ;
   
	cp -a "${INPUT_FILE}" "${WORK_DIR}"/backup_input_"${DATE}"/input_source_"${DATETIME}".txt && msg_0 ;
   
   function msg_0_0() { (echo -e " B) Выполняем небольшие исправления в исходном "$INPUT_FILE" ") } ;
   
	msg_0_0 ;
   
	sed -i "s/\([^\/]*\/\/[^\/]*\)[\" \"]\(.*\)/\1\2/g" "$INPUT_FILE" && sed -i "s/\([^\/]*\/\/[^\/]*\)[\"  \"]\(.*\)/\1\2/g" "$INPUT_FILE" && sed -i "s/\([^\/]*\/\/[^\/]*\)[\" \"]\(.*\)/\1\2/g" "$INPUT_FILE" && echo -e " -- DONE: cut \" \" ";
   
	sed -i "s#:///#://#" "$INPUT_FILE" && echo -e " -+ DONE: replace \":///\" character with \"://\" ";
  }

# Удаляем из "$INPUT_FILE", ВЫРЕЗКА URL заканчивающихся на slash \"/\" И ПЕРЕЗАПИСЬ ФАЙЛА.
function cut_urls_ended_slash() {
   
   # Назначение переменной на входе в функцию для INPUT_FILE
   INPUT_FILE_5="${1:-$INPUT_FILE_5}"
	echo -e " -+ Назначена переменная для INPUT_FILE_5 - "$INPUT_FILE_5" "
   # Назначение переменной на входе в функцию для INPUT_FILE_6
   INPUT_FILE_6="${2:-$INPUT_FILE_6}"
	echo -e " -+ Назначена переменная для INPUT_FILE_6 - "$INPUT_FILE_6" "
   
	cd "${WORK_DIR}"
   
   # Удаляем найденные URL из файла "$INPUT_FILE"
   #sed -i '/\/$/d' "$INPUT_FILE" ; 
	sed '/\/$/d' "${INPUT_FILE_5}" > "${INPUT_FILE_6}" ;
  }

# Убираем URL из "$INPUT_FILE_5" те, которые заканчиваются на slash \"/\" сохраняем в "$INPUT_FILE_6"
function cut_slash() {
   
   # Назначение переменных для обработок:
   INPUT_FILE_5="5_urls.txt"    # Содержит валидные URL из "$INPUT_FILE_4" 
   INPUT_FILE_6="6_urls.txt"    # Содержит URL из "$INPUT_FILE_5" исключая те, которые заканчиваются на slash \"/\" 
   
   function msg_6() { (echo -e " 6) Ищем URL в "$INPUT_FILE_5" заканчивающиеся на \"/\" и сохраняем результаты без таких URL в файле "$INPUT_FILE_6" ") } ;
	
	cut_urls_ended_slash "${INPUT_FILE_5}" "${INPUT_FILE_6}" && msg_6 ;
  }

# Удаляем пустые строки в исходном файле
# Очищаем Только ДОМЕННУЮ часть URL от символов [\"${char}\"] в массиве переменной $special_chars
function only_in_domain_check_error() {
   
   # Назначение переменной на входе в функцию для INPUT_FILE
   INPUT_FILE_2="${1:-$INPUT_FILE_2}"
	echo -e " -+ Назначена переменная для INPUT_FILE_2 - "$INPUT_FILE_2" "
   # Назначение переменной на входе в функцию для INPUT_FILE_3
   INPUT_FILE_3="${2:-$INPUT_FILE_3}"
	echo -e " -+ Назначена переменная для INPUT_FILE_3 - "$INPUT_FILE_3" "
   # Назначение переменной для временного файла
   INPUT_FILE_tmp="INPUT_FILE_tmp.txt"
   
   # Удаляем пустые строки в исходном файле
	sed -i '/^$/d' "${INPUT_FILE_2}" ;
   
   # Создаем временный файл для обработки
	cp "${INPUT_FILE_2}" "${INPUT_FILE_tmp}" ;
   
   # Назначаем переменную массива символов для очистки Только ДОМЕННОЙ части URL
   special_chars=("#" "%" "№" "|" "?" "!" "@" "&" "\\$" "<" ">" "{" "}" "\[" "]" "\`" "\^" "~" "\"" "(" ")" "_" "\*" "±" "+" "=" "," " " "\\\\")
   
   for char in "${special_chars[@]}"
	do
	 # Очищаем Только ДОМЕННУЮ часть URL от символов [\"${char}\"] в массиве переменной $special_chars
	 sed -i "s/\([^\/]*\/\/[^\/]*\)[\"${char}\"]\(.*\)/\1\2/g" "${INPUT_FILE_tmp}" ;
	done
   
   # Перемещаем результаты из временного файла в "$INPUT_FILE_3"
	mv "${INPUT_FILE_tmp}" "${INPUT_FILE_3}" ;
  }

# Функция ОБРАБОТКИ СЫРОГО "${INPUT_FILE}", ВЫРЕЗКА URL, ПРОВЕРКА ВАЛИДНОСТЬ, УНИКАЛЬНОСТЬ И ПЕРЕЗАПИСЬ ФАЙЛА
function files_processing() {
   
   # Назначение переменных для обработок:
	INPUT_FILE_0="${INPUT_FILE}" # Исходный файл "input.txt" "$INPUT_FILE"
	INPUT_FILE_1="1_urls.txt"    # Содержит перемещенные URL из $INPUT_FILE_0
	INPUT_FILE_2="2_urls.txt"    # Содержит список, где каждый URL на отдельной строке
	INPUT_FILE_3="3_urls.txt"    # Содержит очищенную "ТОЛЬКО ДОМЕННУЮ часть URL" от символов [\"${char}\"]
	INPUT_FILE_4="4_urls.txt"    # Содержит отсортированные по домену URL из $INPUT_FILE_3
	INPUT_FILE_5="5_urls.txt"    # Содержит валидные URL из "$INPUT_FILE_4" 
	INPUT_FILE_6="6_urls.txt"    # Содержит URL из "$INPUT_FILE_5" исключая те, которые заканчиваются на slash \"/\" 
   
   # Переходим в рабочую папку
	cd "${WORK_DIR}" ;
   
   function msg_1() { (echo -e "\n 1) Извлекаем все URL из "$INPUT_FILE_0" перемещаем их в "$INPUT_FILE_1" ") } ;
	grep -Eo '(https?|http)://[^\"]+' "${INPUT_FILE}" > "${INPUT_FILE_1}" && msg_1 ;
   
   function msg_2() { (echo -e " 2) Получаем "$INPUT_FILE_2", содержащий все URL в отдельных строках.") } ;
	sed -e 's/https:/\nhttps:/g' -e 's/http:/\nhttp:/g' "${INPUT_FILE_1}" | grep -E '(https?|http)://' > "${INPUT_FILE_2}" && msg_2 ;
   
   function msg_3() { (echo -e " 3) Очищаем ТОЛЬКО ДОМЕННУЮ часть URL от символов [\"\${char}\"] в массиве переменной \$special_chars и пишем в "$INPUT_FILE_3".") } ;
	only_in_domain_check_error "${INPUT_FILE_2}" "${INPUT_FILE_3}" && msg_3 ;
   
   function msg_4() { (echo -e " 4) Сортируем URL из $INPUT_FILE_3 по домену и сохраняем в файл "$INPUT_FILE_4" ") } ;
	sort -t / -k 3 "${INPUT_FILE_3}" | uniq > "${INPUT_FILE_4}" && msg_4 ;
   
   function msg_5() { (echo -e " 5) Ищем валидные URL из "$INPUT_FILE_4" и сохраняем в файле "$INPUT_FILE_5" ") } ;
	grep -Eo "(http|https)://[a-zA-Z0-9.%/?=_-]*" "${INPUT_FILE_4}" > "${INPUT_FILE_5}" && msg_5 ;
	
	# Убираем URL из "$INPUT_FILE_5" те, которые заканчиваются на slash \"/\" сохраняем в "$INPUT_FILE_6"
	cut_slash ;
	
	# Перемещаем обработанный список со всеми URL"$INPUT_FILE_6" в "$INPUT_FILE"
	mv_url_to_input_txt "$INPUT_FILE_6" ;
  }

# Запускаем push с полученными доменами в скрипт download.sh пока они не закончатся в списке $domains
function push_domain_in_download_script() {
   
   # Указываем путь до файла с URL
   url_file="${WORK_DIR}"/"${INPUT_FILE}"
   
   # Получаем список уникальных доменов из файла
   domains=$(awk -F/ '{print $3}' "$url_file" | sort -u)
   (echo -e "\n Список доменов откуда будем загружать контент: \n"$domains" ") | bat --paging=never -l cr --color=always ;
   
   # Перебираем домены и запускаем push с ними в скрипт download.sh пока они не закончатся в списке $domains
   # Таким образом, скрипт download.sh будет запущен для каждого уникального домена из файла input.txt.
   for domain in $domains; do
	 echo -e "\n Передаем скрипту download.sh домен: $domain" | bat --paging=never -l cr --color=always ;
	 echo -e "$domain" | "${WORK_DIR}"/scriptsd/download.sh -d "$(cat)"
   done
  }

# Эту функцию можно отключить, если бекапы и отчеты о загрузках нужны для отладки после загрузки файлов.
# Функция очистки ВКЛЮЧЕНА по умолчанию, чтобы не засорять диск временными файлами.
function done_cleared() {
   
	mvds "*_urls.txt" && ttb=$(echo -e "\n Временные файлы *_urls.txt удалены!\n Чтобы сохранять временные файлы закомментируйте функцию:\n done_cleared, в конце скрипта $0") && lang_nix && bpn_p_lang ; ttb="" ;
	
	# Очищаю содержимое файла
	echo > "$INPUT_FILE" && ttb=$(echo -e "\n Done. "$INPUT_FILE" очищен!") && lang_nix && bpn_p_lang ; ttb="" ;
	
	# Удаляю файл "${WORK_DIR}/${INPUT_FILE}"
	mvds "${WORK_DIR}/${INPUT_FILE}"
	
	# Создаю чистый файл "${WORK_DIR}/${INPUT_FILE}"
	touch "${WORK_DIR}/${INPUT_FILE}"
	
	# Удаляю папку для бекапа исходного файла input.txt
	mvds "${WORK_DIR}"/"backup_input*" ;
	
	# Удаляю список скаченного
	mvds "downloaded_from_cdn.txt"  2>/dev/null
  }

  # Команды запускающие функции выше для проверки TOR соединения, проверки input.txt файла с URL, проверка списка URL на ошибки и запуск download скрипта с передачей ему доменов по списку. Download скрипт получает домены и готовый список input.txt с которым начинает работать в соответствии с очередью переданных ему доменов от этого скрипта. По сути этот скрипт управляет download скриптом, - какие домены брать из списка input.txt. (если download скрипт не получит домен от этого скрипта (function push_domain_in_download_script), то он проигнорирует его в списке input.txt)
  
  function view_d_content() {
   ttb=$(echo -e " Вот что удалось скачть:") && lang=cr && bpn_p_lang ; echo ;
   ( cd $WORK_DIR/downloaded_cdn && (lk-f .) ) 2>/dev/null ;
  }  

  (tor_check_ip_or_restart && clear ) && ( check_input_file && file_empty && (ttb=$(in_input_file_fixes) && lang=nix && bpn_p_lang) && (ttb=$(tstart_f ; files_processing ; tendl_f) && lang=cr && bpn_p_lang) && (push_domain_in_download_script) && (view_d_content) && (done_cleared) || (echo -e " Ошибка выполнения функции push_domain_in_download_script ") && (done_cleared) ; )
  
  # отчет о времени завершения работы скрипта
  tendl ;   

  exit 0 ;
  
  