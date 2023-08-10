#!/bin/bash

. /root/.bashrc

WDIR=~/temp
  
# Путь до рабочей папки
WORK_DIR=$WDIR

# Имя файла
INPUT_FILE="input.txt"
  
options=$(getopt -o d: --long domain: -n 'download.sh' -- "$@")
eval set -- "$options"
domain=''


while true; do
	  case "$1" in
	-d | --domain ) domain="$2"; shift 2 ;;
	-- ) shift; break ;;
	* ) break ;;
	  esac
done

	echo -e "\n Загружаем из: $domain\n" | bat --paging=never -l cr --color=always ;

var_domain=$(echo "$domain" | tr '.' '_')


# Эту функцию можно отключить, если бекапы и отчеты о загрузках нужны для отладки после загрузки файлов.
# Функция очистки ВКЛЮЧЕНА по умолчанию, чтобы не засорять диск временными файлами.
function done_cleared() {

   # Удаляю список скаченного
    mvds "${WORK_DIR}"/"downloaded_from_cdn.txt" 2>/dev/null
	mvds "${WORK_DIR}"/"*_urls.txt" && ttb=$(echo -e "\n Временные файлы *_urls.txt удалены!\n Чтобы сохранять временные файлы закомментируйте функцию:\n done_cleared, в конце скрипта $0") && lang_nix && bpn_p_lang ; ttb="" ;
	
	# Очищаю содержимое файла
	echo > "$INPUT_FILE" && ttb=$(echo -e "\n Done. "$INPUT_FILE" очищен!") && lang_nix && bpn_p_lang ; ttb="" ;
	
	# Удаляю файл "${WORK_DIR}/${INPUT_FILE}"
	mvds "${WORK_DIR}/${INPUT_FILE}" 2>/dev/null
	
	# Создаю чистый файл "${WORK_DIR}/${INPUT_FILE}"
	touch "${WORK_DIR}/${INPUT_FILE}" 2>/dev/null
	
	# Удаляю папку для бекапа исходного файла input.txt
	mvds "${WORK_DIR}"/"backup_input*" 2>/dev/null ;

	 # Удаляю копию скрипта
	 mvds "${WORK_DIR}"/scriptsd 2>/dev/null ;
  }


function make_download_list_for_domain() {
		
			mkdir -p "${WORK_DIR}"/
		input_file="${WORK_DIR}"/"${INPUT_FILE}"
		output_file="${WORK_DIR}"/temp_list_for_download_from_"$domain"_all_urls.txt
		pattern_domain="://${domain}"
			grep "$pattern_domain" "$input_file" > "$output_file"
			echo -e " Список Всех Файлов для загрузки:\n"
			( bat --paging=never -l cr $output_file ) || cat $output_file ; echo ;
	}


function cut_first_line() {
		
			mkdir -p "${WORK_DIR}"/temp_download_dir/
		input_file2="${WORK_DIR}"/temp_list_for_download_from_"$domain"_all_urls.txt
		output_file2="${WORK_DIR}"/cuted_first_line_from_temp_list_for_download_from_"$domain"_all_urls.txt
			sed -n '1p' "$input_file2" >> "$output_file2"
			sed -i '1d' "$input_file2"
	}


function make_wget_url_for_html_with_cdn_url() {
		
		input_file3="${WORK_DIR}"/cuted_first_line_from_temp_list_for_download_from_"$domain"_all_urls.txt
		output_file3="${WORK_DIR}"/make_wget_url_for_html_with_cdn_url.sh
		pattern_domain="://${domain}"
		pattern_sed_add_wget_command='s/^/wget --proxy=on --no-check-certificate -O url_with_cdn.html /; s/$/;/'
			
			grep "$pattern_domain" "$input_file3" | sed "$pattern_sed_add_wget_command" > "$output_file3"
			
			rm /root/temp/cuted_first_line_from_temp_list_for_download_from_"$domain"_all_urls.txt ; # TUT
			chmod +x "${WORK_DIR}"/make_wget_url_for_html_with_cdn_url.sh ;
			mv "${WORK_DIR}"/make_wget_url_for_html_with_cdn_url.sh "${WORK_DIR}"/temp_download_dir/make_wget_url_for_html_with_cdn_url.sh ;
			cd "${WORK_DIR}"/temp_download_dir/ ; 
			"${WORK_DIR}"/temp_download_dir/make_wget_url_for_html_with_cdn_url.sh
			rm "${WORK_DIR}"/temp_download_dir/make_wget_url_for_html_with_cdn_url.sh ;
			
		input_file4="${WORK_DIR}"/temp_download_dir/url_with_cdn.html
		output_file4="${WORK_DIR}"/temp_download_dir/tmp_with_cdn_url_from_html.txt
		output_cdn_download_file="${WORK_DIR}"/temp_download_dir/one_url_with_cdn_download.sh
		pattern_for_find_cdn_url="(http|https)://cdn[a-zA-Z0-9.+%/?=_-]*"
			
			grep -Eo "$pattern_for_find_cdn_url" "$input_file4" > "$output_file4"
			
		pattern_for_find_cdn_url="://cdn"
		pattern_sed_add_wget_command_for_cdn='s/^/wget --proxy=on --no-check-certificate -N -c --tries=3 --waitretry=10 /; s/$/;/'
			
			grep "$pattern_for_find_cdn_url" "$output_file4" | sed "$pattern_sed_add_wget_command_for_cdn" > "$output_cdn_download_file"
			
			echo -e "\n файл one_url_with_cdn_download.sh: один URL перемещенный из tmp_with_cdn_url_from_html.txt с добавлением в начале строки\n "$pattern_sed_add_wget_command_for_cdn" "
			bat -l bash "${WORK_DIR}"/temp_download_dir/one_url_with_cdn_download.sh
			
			mkdir -p "${WORK_DIR}"/downloaded_cdn/ && mv "$output_cdn_download_file" "${WORK_DIR}"/downloaded_cdn/one_url_with_cdn_download.sh && chmod +x "${WORK_DIR}"/downloaded_cdn/one_url_with_cdn_download.sh ;
			rm -rf "${WORK_DIR}"/temp_download_dir/ ;
			
	}


function downloaded_cdn() {
		
		function bat_downloaded_from_cdn() {
			echo -e "\n файл downloaded_from_cdn.txt: содержит только уже успешно скаченные URL"
			( bat --paging=never -l cr "${WORK_DIR}"/downloaded_from_cdn.txt ) ; echo ; echo ;
		}
		
			cd "${WORK_DIR}"/downloaded_cdn/ && delay_1-5_2-7 && "${WORK_DIR}"/downloaded_cdn/one_url_with_cdn_download.sh && ( cat "${WORK_DIR}"/downloaded_cdn/one_url_with_cdn_download.sh >> "${WORK_DIR}"/downloaded_from_cdn.txt ) && bat_downloaded_from_cdn && rm "${WORK_DIR}"/downloaded_cdn/one_url_with_cdn_download.sh || echo downloaded_cdn error
	}


# функция которая будет бесконечно запускать функции:
# cut_first_line && add_wget_proxy_to_var_domain_file2_sh && create_dnl_cdn_txt && rename_cdn_to_sh_and_rm_dnl_dir && downloaded_cdn
# пока файл "${WORK_DIR}"/temp_list_for_download_from_"$domain"_all_urls.txt не окажется пустым, после чего удалит файл "${WORK_DIR}"/temp_list_for_download_from_"$domain"_all_urls.txt и закончит работу.
function start() {
		
		while true; do
		# Проверяем, пуст ли файл "${WORK_DIR}"/temp_list_for_download_from_"$domain"_all_urls.txt
		if [ ! -s "${WORK_DIR}"/temp_list_for_download_from_"$domain"_all_urls.txt ]; 
			
		then
			# Если файл пуст, удаляем его и завершаем скрипт
			rm "${WORK_DIR}"/temp_list_for_download_from_"$domain"_all_urls.txt
			
			exit
		else
			# Если файл не пуст, вызываем функции:
			# cut_first_line, add_wget_proxy_to_var_domain_file2_sh, create_dnl_cdn_txt, rename_cdn_to_sh_and_rm_dnl_dir и downloaded_cdn
			echo ;
			( bat -l cr "${WORK_DIR}"/temp_list_for_download_from_"$domain"_all_urls.txt ) || cat  "${WORK_DIR}"/temp_list_for_download_from_"$domain"_all_urls.txt ; echo ;
			
			( cut_first_line && make_wget_url_for_html_with_cdn_url && downloaded_cdn ; tendl_f ) || echo -e " Global ERROR!"
		fi
		 
		 done
	}


	tstart_f ; make_download_list_for_domain tendl_f  && tstart_f ; start || echo -e " Global ERROR..."

done_cleared ;


exit 0 ;

