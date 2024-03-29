#!/bin/bash

function tor_port_ch_help() {
	

ttb=$(echo -e "

\"tor_port_ch\" - Эта функция, предназначена для определения доступных портов Tor на 
локальной машине и сохранения этой информации в переменной \"tor_port\". 

1. function tor_port_ch() {: Это объявление функции с именем \"tor_port_ch\".
2. for test in 9150 9050 ''; do: Начинается цикл, в котором переменной 
	test последовательно присваиваются значения 9150, 9050 и пустая 
строка (''). Это порты, которые скрипт будет пытаться проверить.
3. { >/dev/tcp/127.0.0.1/$test; } 2>/dev/null: Это команда проверки 
	доступности порта на локальной машине. /dev/tcp/127.0.0.1/$test 
	обращается к порту $test на 127.0.0.1 (localhost). >/dev/tcp/127.0.0.1/$test 
	пытается записать что-либо в этот порт. 2>/dev/null перенаправляет ошибки 
	(стандартный вывод ошибок) в никуда (в \"черную дыру\"), чтобы они не 
	выводились на экран.
4. && { tor_port="$test"; break; }: Если команда проверки порта выполняется 
	успешно (порт открыт), то переменной tor_port присваивается значение $test, 
	а затем цикл завершается с помощью break, так как найден доступный порт.
5. [ -z \"$test\" ] && echo -e \"\n Нет открытого Tor порта (9150 9050).\n\": 
	Если значение переменной test становится пустой строкой 
	(после проверки портов 9150 и 9050), то выводится сообщение о том, что открытых 
	Tor портов не найдено.
6. }: Завершение цикла и функции.
7. tor_port_ch: Вызов функции tor_port_ch, что инициирует ее выполнение.
	
	Итак, эта функция проверяет доступность портов 9150 и 9050 на локальной 
машине для Tor. Если хотя бы один из этих портов доступен, то переменной 
tor_port будет присвоено значение этого порта. Если оба порта недоступны, 
будет выведено сообщение об отсутствии открытых Tor портов.exit 0 ;



: function tor_port_ch() {
:
:	for test in 9150 9050 ''; do
:	  { >/dev/tcp/127.0.0.1/$test; } 2>/dev/null && { tor_port=\"$test\"; break; }
:	  [ -z \"$test\" ] && : echo -e \" Нет открытого Tor порта (9150 9050).\"
:	done
:  }
:
: tor_port_ch


") && lang=bash && bpn_p_lang ;
}
