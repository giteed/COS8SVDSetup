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