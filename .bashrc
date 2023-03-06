# .bashrc

#-----------------------------------
# Глобальные определения
#-----------------------------------
# Source global definitions
if [ -f /etc/bashrc ]; then
	. /etc/bashrc # --> Прочитать настройки из /root/.bashrc, если таковой имеется.
fi

if [ -f ~/.bash_aliases ]; then
. ~/.bash_aliases # --> Использовать ~/.bash_aliases, если таковой имеется.
fi

[ -f ~/.fzf.bash ] && source ~/.fzf.bash

# --> Прочитать настройки из:
. ~/.COS8SVDSetup/bin/cos8svdsetup/styles/.load_styles.sh
. ~/.COS8SVDSetup/bin/cos8svdsetup/functions/.load_function.sh

#-----------------------------------

chmod +x -R /root/bin/ ;
#-----------------------------------


#-----------------------------------
#  GLOBIGNORE ON/OF for Asterix "*"
#-----------------------------------
function GLIG_ASTRX_OF() { unset GLOBIGNORE ; } ;
function GLIG_ASTRX_ON() { GLOBIGNORE="*" ; } ;
#-----------------------------------

#-----------------------------------
#  History
#-----------------------------------
# хранить историю в указанном файле
export HISTFILE=~/.bash_history

# максимальное число команд, хранимых в сеансе
export HISTSIZE=1000
export SAVEHIST=$HISTSIZE

# убрать повторяющиеся команды, пустые строки и удалить дубликаты.
export HISTCONTROL=ignoredups:ignorespace:erasedups
#-----------------------------------


# Uncomment the following line if you don't like systemctl's auto-paging feature:
# export SYSTEMD_PAGER=


#-----------------------------------
# User specific aliases and functions
#-----------------------------------



#--------------------
# PROMPT_COMMAND
#--------------------

	if 
		[[ "${DISPLAY#$HOST}" != ":0.0" &&  "${DISPLAY}" != ":0" ]]; 
	then
		HILIT=${red}   # на удаленной системе: prompt будет частично красным
	else
		HILIT=${cyan}  # на локальной системе: prompt будет частично циановым
	fi

#  --> Замените \W на \w в функциях ниже
#+ --> чтобы видеть в оболочке полный путь к текущему каталогу.

#-----------------------------------

function fastprompt()
{
	_powerprompt()
		{
			LOAD=" $(uptime|sed -e "s/.*: \([^,]*\).*/\1/" -e "s/ //g")"
		}
		PROMPT_COMMAND=_powerprompt
	unset PROMPT_COMMAND
	case $TERM in
		*term | rxvt )
			PS1="\["$HILT"\][\u@\h]\["$NC"\] \W > \[\033]0;\${TERM} [\u@\h] \w\007\]" ;;
		linux )
			PS1="\n[\["$gray"\]\A\["$ellow"\]\$LOAD\["$white"\]]\n\["$HILT"\][\u@\h]\["$NC"\] \w > " ;;
		*)
			#PS1="$HILIT\u@\h \W \\$ $NC" ;;
			PS1="\n[\[$HILIT\]\u\["$gray"\]@\[$green\]\h \[$cyan\]\# \[$gray\]] \[$ellow\]\W \[$red\]\\$ \[$NC\]" ;;
	esac
}

fastprompt

# _powerprompt     # PROMPT_COMMAND "_powerprompt" по-умолчанию - может работать медленно...
				   # "unset PROMPT_COMMAND" - раскомментировать (если что :-)
				   # При удаленном соединении PROMPT_COMMAND частично красный в переменной ($HILIT)
				   # При запуске терминала на локальном хосте PROMPT_COMMAND цвета cyan в переменной ($HILIT)
				   #
				   # Если где-либо меняли переменную окружения PS1 (вид приглашения комстроки bash и совместимых оболочек) на что-либо и в нее были включены какие-либо неотображаемые символы (например, команды ANSI), то каждую непрерывную группу таких символов нужно обрамлять скобками «\[» в начале и «\]» в конце группы. Тогда bash, подсчитывая длину приглашения, вычтет из реальной длины строки приглашения длину невидимой части, что позволит избежать глюков от неправильного переноса строки по границе окна терминала.
				   #


#--------------------
# END PROMPT_COMMAND
#--------------------


# source ~/.bashrc # обновление/применение настроек .bashrc без разлогинивания 

# Приложение G. Пример файла .bashrc
# https://www.opennet.ru/docs/RUS/bash_scripting_guide/a15124.html 
# Могу я создать такой скрипт, чтобы он загружался каждый раз при выходе из системы?
# - Да, добавьте все команды и алиасы в файлы ~/.bash_logout (bash) или ~/.logout (csh/tcsh).
