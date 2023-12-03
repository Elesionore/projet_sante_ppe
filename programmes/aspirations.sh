#!/usr/bin/env bash

#lignes permettant la vérifications des arguments : 
if [ $# -ne 2 ]
then
	echo "deux arguments attendus exactement"
	exit
else

if [ ! -f ../URLs/$2 ]
	then
		echo "le fichier n'existe pas"
		exit
	fi
fi

langue=$1
URLS=$2
lineno=1

while read -r URL
do
	aspirations=$(curl $URL -o ../aspirations/$langue-$lineno.html)
	lineno=$(expr $lineno + 1)
done < ../URLs/$URLS
