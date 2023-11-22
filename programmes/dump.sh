#!/usr/bin/env bash

langue=$1
URLS=$2
lineno=1

while read -r URL
do
	dumps=$(lynx -dump -nolist $URL > ../dumps-text/$langue-$lineno.txt)
	lineno=$(expr $lineno + 1)
done < ../URLs/$URLS
