#!/usr/bin/env bash

#lignes permettant la vérifications des arguments : 
if [ $# -ne 2 ]
then
	echo "deux arguments attendus exactement"
	exit
else

langue=$1
URLS=$2
lineno=1

if [ ! -f ../URLs/$2 ]
	then
		echo "le fichier n'existe pas"
		exit
	fi
fi



while read -r URL
do
	dumps=$(lynx -dump -nolist $URL > ../dumps-text/$langue-$lineno.txt)
	lineno=$(expr $lineno + 1)
done < ../URLs/$URLS
