#!/usr/bin/env bash

#lignes permettant la vérifications des arguments : 
if [ $# -ne 1 ]
then
	echo "un argument attendu exactement"
	exit
else

if [ ! -f $URLS ]
	then
		echo "le fichier n'existe pas"
		exit
	fi
fi

#construction des variables utile dans la construction de notre tableau, le premier argument est le fichier texte d'urls:
URLS=$1
lineno=1
lang=$(basename $URLS .txt)


# variable qui peut être utilisée si on souhaite complexifié notre mot cible
# si on l'utilise, ajouter l'option -P à grep et mettre $CIBLE à la place de notre mot
CIBLE="(здоровʼя|здоров’я?|здоров'я|здоров'я?|Здоровʼя|Здоров'я)"

#construction du début du fichier html avec les métadonnées : 
echo "<html>
	<head>
		<meta charset=\"UTF-8\"/>
		<link rel=\"stylesheet\" href=\"https://cdn.jsdelivr.net/npm/bulma@0.9.4/css/bulma.min.css\">
		<style>
			body {
				background-color: #f5f5f5;
			}

			.hero-body {
				padding: 2rem;
			}

			.table-container {
				max-height: 500px;
				overflow-y: auto;
			}

			th:hover {
				cursor: pointer;
			}

			tr:hover {
				background-color: #CBFCE7 !important;
				overflow: hidden; /* Hide overflow content */
				text-overflow: ellipsis; /* Display ellipsis (...) for overflow */
			}

			th {
				background-color: #7FFCC6;
				color: #fff;
				transition: background-color 0.3s;
			}

			 td {
				max-width: 300px; /* Set max-width to 300px for the columns */
				overflow: hidden;
				text-overflow: ellipsis;
			}

			td a {
				color: #3273dc;
			}
		</style>
	</head>
	<body class=\"has-background-grey-lighter\">" > ../tableaux/${lang}.html


echo "		<div class=\"hero-body\">
			<table class=\"table is-striped is-fullwidth\">
				<tr class=\"title is-5\"><th>ligne</th><th>URL</th><th>code HTTP</th><th>encodage</th><th>aspiration</th><th>dump</th><th>occurrences</th><th>contextes</th><th>concordances</th></tr> " >> ../tableaux/${lang}.html


#remplissage du tableau html : 
while read -r URL
do 
	response=$(curl -s -L -w "%{http_code}" -o "./aspirations/${lang}-${lineno}.html" $URL)
	encoding=$(curl -s -I -L -w "%{content_type}" -o /dev/null $URL | grep -P -o "charset=\S+" | cut -d"=" -f2 | tail -n 1)

	COUNT=0
	TEXTFILE="NA"
	if [ $response = "200" ]
	then
		#création du dump text
		lynx -dump -nolist ../aspirations/${lang}-${lineno}.html > ../dumps-text/${lang}-${lineno}.txt
		ASPIRATION="../aspirations/${lang}-${lineno}.txt"
		TEXTFILE="../dumps-text/${lang}-${lineno}.txt"
		
		#compter les occurrences du mot, on va compter pour les urls qui fonctionnenent 
		COUNT=$(grep -P -i -o $CIBLE ../dumps-text/${lang}-${lineno}.txt | wc -l)
		
		#chercher le contexte de notre mot 3 lignes dessus et dessous :
		grep -P -i -C 3 $CIBLE ../dumps-text/${lang}-${lineno}.txt > ../contextes/${lang}-${lineno}.txt
		CONTEXTE="../contextes/${lang}-${lineno}.txt"
		
		CONCORDANCES=$(bash ./concordances_ukr.sh ${lang} ${lineno} ${COUNT})
		CONCORDANCEFILE="../concordances/${lang}-${lineno}.html"
	fi
	
	echo "					<tr>
						<td>$lineno</td>
						<td>$URL</td>
						<td>$response</td>
						<td>$encoding</td>
						<td><a href="../aspirations/${lang}-${lineno}.html">$ASPIRATION</a></td>
						<td><a href="../dumps-text/${lang}-${lineno}.txt">$TEXTFILE</a></td>
						<td>$COUNT</td>
						<td><a href="../contextes/${lang}-${lineno}.txt">$CONTEXTE</a></td>
                        <td><a href="../concordances/${lang}-${lineno}.html">$CONCORDANCEFILE</a></td>
					</tr>" >> ../tableaux/${lang}.html
					
	lineno=$(expr $lineno + 1)
	
done < "$URLS"

#fermetures du tableau avec les balises fermantes html : 
echo " 			</table>
		</div>
	</body>
</html>" >> ../tableaux/${lang}.html




