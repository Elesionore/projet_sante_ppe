#!/usr/bin/env bash


lang=$1
lineno=$2
nb_occurrences=$3
ligne=1

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
	<body class=\"has-background-grey-lighter\">" > ../concordances/${lang}-${lineno}.html


echo "		<div class=\"hero-body\">
			<table class=\"table is-striped is-fullwidth\">
				<tr class=\"title is-5\"><th>Contexte gauche</th><th>Occurrence</th><th>Contexte droit</th></tr>" >> ../concordances/${lang}-${lineno}.html


# CONCORDANCEFILE="../concordances/${lang}-${lineno}.html"
TAB=§'\t'
basetext=$(grep -o -i -P  "(\p{Cyrillic}+\W){0,5}(здоровʼя|здоров’я?|здоров'я|здоров'я?|Здоровʼя|Здоров'я)(\W\p{Cyrillic}+){0,5}" ../contextes/${lang}-${lineno}.txt | sed -e "s/\(здоровʼя\)/\t\1${TAB}/g" -e "s/\(здоров’я?\)/\t\1${TAB}/g" -e "s/\(здоров'я\)/\t\1${TAB}/g" -e "s/\(здоров'я?\)/\t\1${TAB}/g" -e "s/\(Здоровʼя\)/\t\1${TAB}/g" -e "s/\(Здоров'я\)/\t\1${TAB}/g")

while [ $ligne -le $nb_occurrences ]
do
    
	contexteGauche=$(echo -e "$basetext" | cut -f 1 | head -n "$ligne" | tail -n 1)
	occurrence=$(echo -e "$basetext" | cut -f 2 | head -n "$ligne" | tail -n 1)
	contexteDroit=$(echo -e "$basetext" | cut -f 3 | head -n "$ligne" | tail -n 1)

	echo "					<tr>
								<td>$contexteGauche</td>
								<td>$occurrence</td>
								<td>$contexteDroit</td>
							</tr>" >> ../concordances/${lang}-${lineno}.html
	ligne=$(expr $ligne + 1)
done 

echo "			</table>
		</div>
	</body>
</html>" >> ../concordances/${lang}-${lineno}.html



