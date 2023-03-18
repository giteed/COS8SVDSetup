# .bashrc

#-----------------------------------
# Глобальные определения
#-----------------------------------
# --> Этот блок кода проверяет наличие файла /etc/bashrc и если он существует, то запускает его. Файл /etc/bashrc - это файл настроек оболочки bash, который содержит общие настройки для всех пользователей системы. Запуск этого файла позволяет применить настройки оболочки для текущего пользователя.
# Source global definitions
if [ -f /etc/bashrc ]; then
	. /etc/bashrc # --> Прочитать настройки из /etc/bashrc, если таковой имеется.
fi

# --> Этот блок кода проверяет наличие файла ~/.bash_aliases (создается пользователем и содержит пользовательские алиасы) и если он существует, то запускает его. Файл .bash_aliases содержит пользовательские алиасы, которые можно использовать в командной строке. Алиасы - это короткие имена, которые можно использовать вместо длинных команд для удобства и быстроты ввода.
if [ -f ~/.bash_aliases ]; then
	. ~/.bash_aliases # --> Использовать ~/.bash_aliases, если таковой имеется.
fi

# --> Этот блок кода проверяет наличие файла ~/.fzf.bash и если он существует, то запускает его. Файл .fzf.bash содержит скрипты для Fuzzy Finder (FZF) - утилиты для поиска файлов и строк в файле. Запуск этого файла позволяет настроить FZF для текущего пользователя.
#[ -f ~/.fzf.bash ] && source ~/.fzf.bash
	# --> В целом, эти блоки кода загружают файлы настроек оболочки и пользовательские алиасы, что может упростить и ускорить работу в терминале. Кроме того, они могут содержать дополнительные скрипты и настройки, которые позволяют настроить оболочку и дополнительные утилиты под конкретные нужды пользователя.

	
#-----------------------------------
# --> Прочитать настройки из:
# --> Первая команда загружает стили для командной строки, которые могут изменять цвет и форматирование текста в командной строке, чтобы сделать ее более удобочитаемой и удобной в использовании.
. /root/vdsetup.2/bin/styles/.load_styles.sh 2>/dev/null ;

# --> Вторая команда загружает пользовательские функции, которые могут быть использованы в командной строке для автоматизации определенных задач, например, для создания сокращений для длинных команд или для выполнения сложных задач в несколько шагов.
. /root/vdsetup.2/bin/functions/.load_function.sh  2>/dev/null ;

	# --> Загрузка этих файлов происходит при запуске нового терминального окна, чтобы пользовательские настройки и функции были доступны в командной строке.


#-----------------------------------
# --> Команда "chmod +x -R /root/vdsetup.2/bin" задает права на выполнение (+x) для всех файлов и директорий (-R) внутри директории "/root/vdsetup.2/bin". (это временное решение, блок с которым можно убрать)
chmod +x -R /root/vdsetup.2/bin 2>/dev/null ;
#-----------------------------------


#-----------------------------------
#  GLOBIGNORE ON/OF for Asterix "*"
#-----------------------------------
# --> Эта функция удаляет переменную среды GLOBIGNORE. Переменная GLOBIGNORE указывает на список файловых шаблонов (wildcard patterns), которые должны быть проигнорированы при расширении имен файлов. Если переменная GLOBIGNORE не определена, то расширение имен файлов производится на основе всех файлов в текущей директории. Удаление переменной GLOBIGNORE означает, что будут использоваться все файлы для расширения имен файлов.
function GLIG_ASTRX_OF() { unset GLOBIGNORE ; } ;

# --> Эта функция устанавливает переменную среды GLOBIGNORE равной звездочке (*). Это означает, что при расширении имен файлов будут проигнорированы все файлы и директории в текущей директории. При использовании этой функции, можно производить расширение имен файлов только на основе тех файлов, которые соответствуют заданному шаблону, игнорируя все остальные файлы и директории.
function GLIG_ASTRX_ON() { GLOBIGNORE="*" ; } ;

	# --> Обе эти функции могут быть полезны, когда нужно производить расширение имен файлов на основе определенного шаблона, игнорируя лишние файлы и директории. Например, если нужно выбрать все файлы с расширением ".txt", то можно использовать команду "ls *.txt". Если в текущей директории есть и другие файлы с другими расширениями, то они будут проигнорированы.
#-----------------------------------


#-----------------------------------
#  History
# --> Эти команды используются для управления историей команд в командной оболочке bash.
#
# --> Первая команда указывает, где должен храниться файл с историей команд (обычно это файл ~/.bash_history в домашней директории пользователя).
#
# --> Вторая команда задает максимальное число команд, которые будут храниться в сеансе. Если количество команд в истории превышает этот предел, более старые команды будут автоматически удалены.
#
# --> Третья команда устанавливает параметры управления историей команд. В данном случае, опция ignoredups говорит bash игнорировать повторяющиеся команды при сохранении истории, ignorespace говорит bash игнорировать команды, начинающиеся с пробелов, а erasedups говорит bash удалять дубликаты команд при сохранении истории.
#
# --> Эти команды могут помочь пользователям сохранять историю своих команд и управлять ее хранением, а также помочь избежать ненужного повторения команд.
#-----------------------------------

# хранить историю в указанном файле
export HISTFILE=~/.bash_history

# --> максимальное число команд, хранимых в сеансе
export HISTSIZE=1000
export SAVEHIST=$HISTSIZE

# --> убрать повторяющиеся команды, пустые строки и удалить дубликаты.
export HISTCONTROL=ignoredups:ignorespace:erasedups
#-----------------------------------


# Uncomment the following line if you don't like systemctl's auto-paging feature:
# export SYSTEMD_PAGER=


#-----------------------------------
# User specific aliases and functions
#-----------------------------------



#--------------------
# PROMPT_COMMAND
# --> Эти команды используются для настройки цвета командной строки (prompt) в зависимости от того, находится ли пользователь на локальной или удаленной системе.
# 
# --> Условное выражение (if-then-else) проверяет значение переменной DISPLAY, которая определяет, какой X-сервер используется для отображения графических приложений. Если DISPLAY не содержит строку $HOST и не равно ":0.0" или ":0", то это означает, что пользователь работает на удаленной системе. В этом случае переменная HILIT устанавливается в значение ${red}, что означает, что часть prompt будет красным цветом.
# 
# -->В противном случае, когда пользователь работает на локальной системе, HILIT устанавливается в значение ${cyan}, что означает, что часть prompt будет циановым цветом.
#
# -->Эти команды позволяют пользователю быстро увидеть, находится ли он на локальной или удаленной системе, что может быть полезно для различных задач администрирования или для отладки проблем с сетью.
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


# --> Эти команды используются для определения формата командной строки (prompt) и установки значений для переменных PS1 и PROMPT_COMMAND.
# --> Функция fastprompt определяет новую функцию _powerprompt, которая используется для определения переменной LOAD, содержащей информацию о текущей нагрузке на систему. Затем PROMPT_COMMAND устанавливается в значение _powerprompt, что означает, что при каждом вводе новой команды переменная LOAD будет переопределена.
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

# _powerprompt     # --> PROMPT_COMMAND "_powerprompt" по-умолчанию - может работать медленно...
				   # "unset PROMPT_COMMAND" - раскомментировать (если что :-)
				   # При удаленном соединении PROMPT_COMMAND частично красный в переменной ($HILIT)
				   # --> При запуске терминала на локальном хосте PROMPT_COMMAND цвета cyan в переменной ($HILIT)
				   #
				   # --> Если где-либо меняли переменную окружения PS1 (вид приглашения комстроки bash и совместимых оболочек) на что-либо и в нее были включены какие-либо неотображаемые символы (например, команды ANSI), то каждую непрерывную группу таких символов нужно обрамлять скобками «\[» в начале и «\]» в конце группы. Тогда bash, подсчитывая длину приглашения, вычтет из реальной длины строки приглашения длину невидимой части, что позволит избежать визуальных ошибок от неправильного переноса строки по границе окна терминала.
				   
				   # --> В зависимости от значения переменной TERM, которая определяет тип терминала, устанавливается значение переменной PS1. Для терминалов типа "xterm" и "rxvt" PS1 устанавливается в строку, содержащую имя пользователя, имя хоста и текущую рабочую директорию, а также заголовок окна терминала с указанием имени терминала и имени пользователя и хоста.
				   
				   # --> Для терминалов типа "linux" PS1 устанавливается в строку, содержащую информацию о времени, переменную LOAD, имя пользователя, имя хоста и текущую рабочую директорию.
				   
				   # --> В противном случае, когда TERM не соответствует ни одному из вышеперечисленных типов терминалов, PS1 устанавливается в строку, содержащую имя пользователя, имя хоста, номер текущей команды, текущую рабочую директорию и знак "$".
				   
				   # --> Эти команды позволяют пользователю настроить формат командной строки, чтобы быстро получать необходимую информацию о состоянии системы и текущей сессии.

#--------------------
# END PROMPT_COMMAND
#--------------------

# --> Эта команда запускает скрипт .bashrc в текущем интерактивном bash сеансе. Обычно .bashrc содержит настройки среды и алиасы команд, которые будут использоваться в терминале. Если вы внесли изменения в файл .bashrc, команда "source /root/.bashrc" позволяет применить эти изменения без необходимости перезапуска терминала или компьютера. В результате, любые новые переменные окружения или алиасы, которые были добавлены в .bashrc, станут доступными в текущем терминальном сеансе.
# source /root/.bashrc # обновление/применение настроек .bashrc без разлогинивания 

# Приложение G. Пример файла .bashrc
# https://www.opennet.ru/docs/RUS/bash_scripting_guide/a15124.html 
# Могу я создать такой скрипт, чтобы он загружался каждый раз при выходе из системы?
# - Да, добавьте все команды и алиасы в файлы ~/.bash_logout (bash) или ~/.logout (csh/tcsh).

# --> В этом файле ~/.bash_logout можно поместить команды, которые необходимо выполнить перед завершением работы с терминалом, например, очистку экрана или вывод сообщения об окончании сеанса. Этот файл также может использоваться для сохранения переменных среды или для выполнения других необходимых действий при выходе из терминала.
# --> В целом, использование файла ~/.bash_logout не обязательно, и в большинстве случаев его можно не создавать или оставить пустым.
