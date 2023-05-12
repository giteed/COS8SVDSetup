# test.sh

#!/bin/bash
# Введение в Bash Shell
# https://habr.com/ru/post/471242/

# Source global definitions
# --> Прочитать настройки из /etc/bashrc
. ~/.bashrc
# --> Прочитать настройки из ~/bin/.varfunc.sh
. ~/bin/utility/.varfunc.sh
# --> Использовать ~/.bash_aliases
. ~/.bash_aliases ;
# --> Использовать . ~/bin/utility/.root (требует для скрипта права root)
. ~/bin/utility/.root


exit 0


for i in {1..254}; do ping –c -f 1 10.0.1.$i >/dev/null && echo 192.168.4.$i is up



exit 0



# проверка или установка пакета
[[ -z $(fzf --version) ]] 2>/dev/null && git clone --depth 1 https://github.com/junegunn/fzf.git ~/.fzf && ~/.fzf/install || echo -e "fzf version $(fzf --version)" >/dev/null ;

exit 0


#!/bin/bash

echo -e $(/sbin/ifconfig enp0s3 | awk '/inet / { print $2 } ' | sed -e s/addr://)
exit 0

# если на вход скрипту подать имя хоста, то он будет его пинговать, если же на вход подать пустое значени то, выполнится условие || будет запрошено имя хоста и затем произойде пинг с этим значением. При наличии ошибок они будут выведены от команды ping

# если условие $1 пустое, выполнить все что за && :
# если $1 чему то равно, выполнить все что за || :
[ -z $1 ] && echo -en "\nВведите ip или имя хоста: " && read i && ping -c 1 $i || ping -c 1 $1 ;
# в данном случае скрипт будет выполняться до первого удачного выполнения или до конца.

exit 0



# тут все тоже самое как сверху только через другую конструкцию if then else fi и без вывода ошибок от программы ping || но с выводом своего сообщения об ошибке echo в случае неудачного пинга.
#!/bin/bash

if [ -z $1 ]
then  echo -en "введите ip или имя хоста:" ;
read i ;
ping -c 1 "$i" 2>/dev/null || echo node is not available
else
ping -c 1 "$1" 2>/dev/null || echo node is not available
fi
exit 0
#!/bin/bash

[ -z $1 ] && echo no argument provided

exit 0

|| и &&

Вместо написания полных операторов if… then вы можете использовать логические операторы || а также &&.

 || является логическим «ИЛИ» и выполнит вторую часть оператора, только если первая часть не верна; 
 && является логическим «И» и выполнит вторую часть оператора только в том случае, если первая часть верна.

Рассмотрим эти две строки:

[ -z $1 ] && echo no argument provided

ping -c 1 8.8.8.8 2>/dev/null || echo node is not available

В первом примере выполняется проверка, чтобы увидеть, пуст ли $1. Если эта проверка верна (что, в основном, означает, что команда завершается с кодом выхода 0), выполняется вторая команда.

Во втором примере команда ping используется для проверки доступности хоста.
В этом примере используется логическое «ИЛИ» для вывода текста «node is not available» в случае неудачной команды ping.

Вы обнаружите, что часто вместо условного оператора if будут использоваться && и ||. В упражнении ниже вы можете попрактиковаться в использовании условных операторов, используя либо if… then… else, либо && и ||.

Упражнение. Использование if… then… else

В этом упражнении вы поработаете над сценарием, который проверяет что является файлом, а что каталогом.

# Листинг 4. Пример с if then else

#!/bin/bash
# run this script with one argument
# the goal is to find out if the argument is a file or a directory
if [ -f $1 ]
then
	echo "$1 is a file"
elif [ -d $1 ]
then
	echo "$1 is a directory"
else
	echo "I do not know what \$1 is"
fi


exit 0 

#!/bin/bash
if [ -z $1 ]; then
	 echo enter a text
	 read TEXT
else
	 TEXT=$1
fi
echo you have entered the text $TEXT
exit 0

В сценарии листинга 3 оператор if… then… else… fi используется для проверки существования аргумента $1. Это делается с помощью test (test — это отдельная команда). Команда test может быть написана двумя способами*: test или [… ]. В примере строка if [ -z $1 ] ... выполняется, чтобы увидеть тест (проверку) -z $1.

-z test проверяет, существует или нет $1. Иначе говоря, строка if [ -z $1 ] проверяет, является ли $1 пустым, что означает, что при запуске этого сценария не было предоставлено никаких аргументов. Если это так, команды после оператора then выполняются.

Обратите внимание, что при написании команды test с квадратными скобками важно использовать пробелы после открывающей скобки и перед закрывающей скобкой, без пробелов команда не будет работать.

Обратите внимание, что оператор then следует сразу за test. Это возможно, потому что используется точка с запятой (;). Точка с запятой является разделителем команд и может заменить новую строку в скрипте.

В операторе then выполняются две команды: команда echo, которая отображает сообщение на экране, и команда read.

Команда read останавливает сценарий, чтобы пользовательский ввод мог быть обработан и сохранен в переменной TEXT. Поэтому read TEXT помещает все введённые пользователем данные в переменную TEXT, которая будет использоваться позже в скрипте.

Следующая часть представлена оператором else. Команды после оператора else выполняются во всех других случаях, что в данном случае означает «иначе, если аргумент был предоставлен». Если это так, то определяется переменная TEXT и ей присваивается текущее значение $1.

Обратите внимание, как определяется переменная: непосредственно после имени переменной стоит знак =, за которым следует $1. Обратите внимание, что вы никогда не должны использовать пробелы при определении переменных.

Затем условия if замыкается с помощью оператора fi. После завершения условия if вы точно знаете, что переменная TEXT определена и имеет значение. Предпоследняя строка скрипта считывает значение переменной TEXT и отображает это значение в STDOUT с помощью команды echo. Обратите внимание, что для запроса текущего значения переменной ссылается на имя переменной, начиная со знака $ перед ним.

Вы можете попрактиковаться на этом примере при работе с вводом.

Откройте редактор и создайте файл с именем text. Введите содержимое кода из листинга 3 в этот файл.
Запишите файл на диск и выполните chmod +x text, чтобы сделать его исполняемым.
Запустите скрипт, выполнив ./text и без дополнительных аргументов. Вы увидите, что он запрашивает ввод.
Запустите скрипт, используя "hello" в качестве аргумента (./text hello). Результат отобразит «you have entered the text hello» в STDOUT.

Использование условий и циклов

Как вы уже видели, в скрипте могут использоваться условные операторы. Эти условные операторы выполняются только в том случае, если определённое условие выполняется. 

В bash есть несколько условных операторов и циклов, которые часто используются.

if… then… else — используется для выполнения кода, если определенное условие выполняется
for — используется для выполнения команд для диапазона значений
while — используется для выполнения кода, если выполняется определенное условие
before — используется для выполнения кода, пока не выполнено определенное условие
case — используется для оценки ограниченного количества конкретных значений

if then else

Конструкция if then else является общей для оценки конкретных условий. Вы уже видели пример с ним. Этот условный оператор часто используется вместе с командой test. Эта команда позволяет вам проверять многие вещи: например, не только, существует ли файл, но и сравнивать файлы, сравнивать целые числа и многое другое.
Подробнее о test можно узнать в справочнике командой man test.

Основная конструкция if есть if… then… fi. 

Она сравнивает одно условие, как показано в следующем примере:
if [ -z $1 ]
then
	 echo no value provided
fi

В листинге 3 вы увидели, как можно оценить два условия, включая else в выражении. В листинге 4 показано, как можно оценить несколько условий от if до else. Это полезно, если нужно проверить много разных значений. 

Обратите внимание, что в этом примере также используются несколько команд test.

exit 0

#!/bin/bash
# run this script with a few arguments 
echo you have entered $# arguments
for i in $@
 do
	   echo $i
 done
exit 0

В Листинге 2 представлены два новых элемента, которые относятся к аргументам:

$# — это счетчик, который показывает, сколько аргументов было использовано при запуске скрипта.
$@ — список всех аргументов, которые использовались при запуске скрипта.

Чтобы перечислить аргументы, которые использовались при запуске этого скрипта, используется цикл for. В циклах for команды выполняются до тех пор, пока условие истинно. В этом сценарии условие for i in $@ означает «для каждого аргумента». Каждый раз, когда сценарий проходит цикл, значение из переменной $@ присваивается переменной $i.

Итак, пока есть аргументы, тело сценария выполняется.

Тело цикла for всегда начинается с do и закрывается done, а между этими двумя ключевыми словами перечисляются команды, которые необходимо выполнить. Таким образом, пример сценария будет использовать echo для отображения значения каждого аргумента и останавливаться, когда больше нет доступных аргументов.

Давайте попробуем воспользоваться скриптом из листинга 2 в этом примере:

Введите vi argument, чтобы создать файл argument и скопируйте содержимое из скрипта листинга 2 в этот файл.
Сохраните файл и сделайте его исполняемым.
Запустите команду ./argument a b c. Вы увидите, что отобразятся три строки.
Запустите команду ./argument a b c d e f. Вы увидите, что помимо a b c отобразятся и d e f.

exit 0
# Сохраните настраиваемый сценарий как файл и запустите его из командной строки.
# Скрипт попросит вас ввести страну. Например, если вы наберете «Литва», он будет соответствовать первому шаблону, и будет выполнена команда echo в этом предложении.
# Если вы введете страну, которая не соответствует никакому другому шаблону, кроме подстановочного знака звездочки по умолчанию, скажем, Аргентины, сценарий выполнит команду echo внутри предложения по умолчанию.
#!/bin/bash

#!/bin/bash
#
#  "The official language of $COUNTRY - без учета регистра символов
#

# отключает чувствительность к регистру
if shopt -q nocasematch; then
  nocase=yes;
else
  nocase=no;
  shopt -s nocasematch;
fi


echo -n "Enter the name of a country: "
read COUNTRY

echo -n "The official language of $COUNTRY is "

case $COUNTRY in

  Lithuania)
	echo -n "Lithuanian"
	;;

  Romania | Moldova)
	echo -n "Romanian"
	;;

  Italy | "San Marino" | Switzerland | "Vatican City")
	echo -n "Italian"
	;;

  *)
	echo -n "unknown"
	;;
esac

# вкключает чувствительность к регистру
if [ nocase = yes ] ; then
		shopt -s nocasematch;
else
		shopt -u nocasematch;
fi

#В некоторых случаях вы можете упростить конструкции из вложенных условных переходов if, воспользовавшись конструкцией case.
#./help
#Какое животное вы видите ? лев
#Лучше всего быстро убегать!
#./help
#Какое животное вы видите ? собака
#Не беспокойтесь, угостите ее печеньем.
#cat help


#!/bin/bash 
# help.sh
#
# Советы по обращению с дикими животными
#
echo -n "Какое животное вы видите ? "
read animal
case $animal in
		"лев" | "тигр" | "Кабан")
				echo "Лучше всего быстро убегать!"
		;;
		"кот")
				echo "Выпустите мышь..."
		;;
		"собака")
				echo "Не беспокойтесь, угостите ее печеньем."
		;;
		"курица" | "гусь" | "утка" )
				echo "Яйца на завтрак!"
		;;
		"лигр")
				echo "Подойдите и скажите: 'Ах ты, большой пушистый котенок...'."
		;;
		"вавилонская рыбка")
				echo "Она выпала из вашего уха ?"
		;;
		*)
				echo "Вы обнаружили неизвестное животное, дайте ему имя!"
		;;
esac


exit 0


#Оператор (( ))

#Оператор (( )) позволяет сравнивать числовые значения.
(( 42 > 33 )) && echo true || echo false
# true

(( 42 > 1201 )) && echo true || echo false
# false

var42=42
(( 42 == var42 )) && echo true || echo false
# true

(( 42 == $var42 )) && echo true || echo false
# true

var42=33
(( 42 == var42 )) && echo true || echo false
# false



# Команда let

#Встроенная команда командной оболочки let инструктирует командную оболочку о необходимости вычисления значений арифметических выражений. Она будет возвращать значение 0, если результат последней арифметической операции не равен 0.

# Функция сценария командной оболочки также может принимать параметры let.

function plus {
let result="$1 + $2"
echo  $1 + $2 = $result
}

plus 3 10
plus 20 13
plus 20 22
plus 1000 1000

exit 0



let x="3 + 4" ; echo $x
# 7

let x="10 + 100/10" ; echo $x
# 20

let x="10-2+100/10" ; echo $x
# 18

let x="10*2+100/10" ; echo $x
# 30

# Команда let также может использоваться для перевода значений в различные системы счисления.
let x="0xFF" ; echo $x
# 255

let x="0xC0" ; echo $x
# 192

let x="0xA8" ; echo $x
# 168

let x="8#70" ; echo $x
# 56

let x="8#77" ; echo $x
# 63

let x="16#c0" ; echo $x
# 192

exit 0

# Существует различие между непосредственным присваиванием значения переменной и использованием команды let для расчета значений арифметических выражений (даже в том случае, если с помощью данной команды осуществляется исключительно присваивание значения переменной).
dec=15 ; oct=017 ; hex=0x0f 
echo $dec $oct $hex 
# 15 017 0x0f 
let dec=15 ; let oct=017 ; let hex=0x0f
echo $dec $oct $hex
# 15 15 15





exit 0

# Варианты назначения переменных eval http://rus-linux.net/MyLDP/BOOKS/Linux_Foundations/24/ch24.html
echo 

# правильный вариант
lastweek=(date --date="1 week ago")
	
	echo -en "$GREEN""1) "
	eval $lastweek
	
	echo -en "$ELLOW""2) "
	$lastweek
	
	echo -en "$ELLOW""3) "
	($lastweek)

echo 


# правильный вариант EVAL
lastweek='date --date="1 week ago"'
	echo -en "$CYAN""4) "
	eval $lastweek


echo 

# ошибочный вариант
	echo -en "$RED""5) "
	($lastweek)

echo 

# ошибочный вариант
	echo -en "$RED""6) "
	$lastweek


exit 0



# eval http://rus-linux.net/MyLDP/BOOKS/Linux_Foundations/24/ch24.html
# Команда eval позволяет интерпретировать переданные аргументы как директивы сценария командной оболочки (результирующие команды исполняются). Данное обстоятельство позволяет использовать значение переменной в качестве переменной.
answer=42
word=answer
eval "x=\$$word" ; echo $x

answer1=$*
word1=$answer1
#eval "y=\$$word1" ; echo $y
y=$word1 ; echo $y

echo -e "$x+$y\nhalt" > bc.txt
bc -q bc.txt && cat bc.txt

exit 0



# Проверка окружения переменной на shell
obolochka="$( env | rg "SHELL=" )"
case $obolochka in
SHELL=/bin/bash) echo -e " "$green" bash "$NC": $obolochka " ;;
SHELL=/usr/share/zsh) echo -e " "$green" zsh "$NC": $obolochka"  ;;
SHELL=/bin/sh) echo -e " "$green" sh "$NC": $obolochka"  ;;
*) ;;
esac

exit 0


