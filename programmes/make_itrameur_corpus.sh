#!/usr/bin/env bash

#création des variables :
#ici indiquer dumps-text ou contextes
dossier=$1

#ici indiquer fr ukr ou ch
lang=$2

#compter le nombre de fichiers de la langue dans le dossier indiqué, utile pour la boucle while plus bas
nb_fichier=$(find ../${dossier} -type f | grep -P "${lang}" | wc -l)

#pour démarrer le boucle while au premier fichier
fichier=1


if [ ! -d ../$dossier ]
	then
		echo "le dossier n'existe pas"
		exit
fi

#écriture du début du fichier base itrameur :
echo "<lang=\"${lang}\">" > ../itrameur/${dossier}-${lang}.txt


#utilisation d'une boucle pour remplir la base avec les contenu de nos fichiers :
while [ $fichier -le $nb_fichier ]
do
	#stocker le contenu texte du fichier et gérer les entités HTML/XML :
	#si on veut garder les entités :
	#contenu=$(cat ../${dossier}/${lang}-${fichier}.txt | sed "s/&/&amp/g" | sed "s/</&lt/g" | sed "s/>/&gt/g" | sed "s/\'/&apos/g" | sed "s/\"/&quot/g")

	#si on veut supprimer les entités :
	contenu=$(cat ../${dossier}/${lang}-${fichier}.txt | tr "&" " " | tr "<" " " | tr ">" " " )
	
	echo "<page=\"${lang}-${fichier}\">
<text>${contenu}</text>
</page> §" >> ../itrameur/${dossier}-${lang}.txt
	
	#ajouter 1 au numéro de fichier pour ne pas avoir de boucle infinie :
	fichier=$(expr $fichier + 1)
done 


#ajouter la balise de fin à notre base itrameur :
echo "</${lang}>" >> ../itrameur/${dossier}-${lang}.txt

