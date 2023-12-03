#!/usr/bin/env bash

#lignes permettant la vérifications des arguments : 
if [ $# -ne 2 ]
then
	echo "deux arguments attendus exactement"
	exit
else

if [ ! -f ../URLs/$1 ]
	then
		echo "le fichier n'existe pas"
		exit
	fi
fi

#construction des variables utile dans la construction de notre tableau, le premier argument est le fichier texte d'urls:
URLS=$1
lineno=1
langue=$2

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
	<body class=\"has-background-grey-lighter\">" > ../tableaux/$langue.html


echo "		<div class=\"hero-body\">
			<table class=\"table is-striped is-fullwidth\">
				<tr class=\"title is-5\"><th>ligne</th><th>URL</th><th>code HTTP</th><th>encodage</th><th>aspiration</th><th>dump</th><th>occurrences</th></tr> " >> ../tableaux/$langue.html

#remplissage du tableau html :
while read -r URL
do
	reponse=$(curl -s -I -L -w "%{http_code}" -o "./aspirations/${langue}-${lineno}.html" $URL)
	encodage=$(curl -s -I -L -w "%{content_type}" -o /dev/null $URL | grep -P -o "charset=\S+" | cut -d"=" -f2 | tail -n 1)
    occurence=$(cat "../dumps-text/${langue}-${lineno}.txt" | sort | uniq -c | grep -P "здоровʼя|здоров’я?|здоров'я|здоров'я?|Здоровʼя|Здоров'я" | grep -P -o "[[:digit:]]"| paste -sd+ - | bc)

	echo "					<tr>
						<td>$lineno</td>
						<td>$URL</td>
						<td>$reponse</td>
						<td>$encodage</td>
						<td><a href="../aspirations/$langue-$lineno.html">"../aspirations/${langue}-${lineno}.txt"</a></td>
						<td><a href="../dumps-text/$langue-$lineno.txt">"../dumps-text/${langue}-${lineno}.txt"</a></td>
						<td>$occurrence</td>
					</tr>" >> ../tableaux/$langue.html
	lineno=$(expr $lineno + 1)
done < ../URLs/$URLS

#fermetures du tableau avec les balises fermantes html : 
echo " 			</table>
		</div>
	</body>
</html>" >> ../tableaux/$langue.html

