# 22/11/23 DÉBUT DU PROJET EN GROUPE

22/11/23 (Solomiia)
Aujourd’hui on a travaillé sur le projet du groupe. Notre équipe inclut Lise Brisset, Solomiia Korol et Nataliia Kulikova. On a choisi le mot santé en français, ukrainien et chinois.

Précédemment chacune de nous a essaye de créer un site a la base de html (c’est-à-dire, une page d’accueil du projet). Pendant cette séance on a fait telles choses :
1) a crée un dépôt GitHub commun 
2) a ajouté l’arborescence et journal du groupe (celui-ci:)
3) a crée 3 programmes bash : pour définir dump, pour récupérer urls automatiquement et pour mettre script html avec les données récupérées en œuvre.

Le résultat : tout fonctionne, quelques liens donnent la réponse 403/404. On n’a pas commencé encore de récupérer les concordances et les contextes. 
Les difficultés a cet étape :  il fallait unifier les chemins des fichiers dans les dossiers, fusionner le code et éviter la synchronisation chaotique. On n’a pas fait « deploy » de notre site, car on veut finir avec les concordances. 


# 25/11/23 (Lise)
Nous avons à présent l'ensemble des scripts permettant de faire l'aspiration de nos urls, les dumps-text de nos urls et venir compter le nombre d'occurrences de "santé" dans notre texte. Concernant ce dernier, pour le français des problèmes apparaissent. En effet, plutôt que d'avoir un nombre total d'occurrences, dans certains cas plusieurs nombres s'affichent. Par exemple, avec la commande suivante :
cat "$FICHIER" | grep -P -o "\p{Latin}+" | tr "[:upper:]" "[:lower:]" | tr "É" "é" | sort | uniq -c | grep -P "santé" | grep -P -o "[[:digit:]]+"
pour l'url numéro 6 dans le tableau, il est affiché "16 1 1". Le total devrait être "18".
Nous pourrions ajouter des "+" entre chaque nombre dans le cas où il y a en plusieurs mais ce n'est pas un résultat optimal. Il est surement possible d'utiliser expr mais nous ne trouvons pas comment le faire.

Certains liens du français rencontraient encore des erreurs tels qu'un était en ISO ou d'autre avaient des erreurs "000", 400 et 500. Ces liens ont donc été retirés et remplacés. Malgrès cela, le dernier liens du français affiche l'erreur "403", mais le reste de ces colonnes est bien rempli, il trouve même le nombre d'occurrences. Il est possible que malgré l'errreur l'aspiration arrive à acceder au site et cela ne pose pas vraiment de soucis.

4 urls n'affichent aucun encodage, mais ayant vérifié manuellement, ces urls contiennent bien la balise
"meta charset='utf-8'" dans le head. Elles sont donc bien elles aussi encodées en UTF-8. Nous pourrons donc ajouter dans nos script un "if" qui indique que si encodage est vide on peut y indiquer "utf-8".

# 27/11/23 (Solomiia)
Je n'ai pas réussi à faire en sorte que le programme compte les occurrences. Cela peut être dû à l'alphabet cyrillique. En revanche, je suis parvenue à ajouter des styles pour embellir les tableaux et mettre en évidence les lignes au survol.
Voici une description de chaque partie du code :

body Selector: background-color
Définit la couleur de fond du corps de la page à une teinte gris clair (#f5f5f5).

.hero-body Class: padding
Ajoute un remplissage de 2 rem (unité relative à la taille de la police) à tous les côtés de l'élément avec la classe hero-body. Cela peut être une partie d'un framework CSS comme Bulma.

.table-container Class:max-height
Limite la hauteur maximale de l'élément avec la classe table-container à 500 pixels.
overflow-y: Ajoute une barre de défilement verticale si le contenu de l'élément déborde au-delà de la hauteur maximale.

th:hover Selector:cursor
Définit le curseur de la souris en forme de pointeur lorsqu'il survole un élément th (cellule d'en-tête de tableau).

tr:hover Selector
overflow: Masque tout contenu qui déborde de la ligne.
text-overflow: Affiche une ellipse (...) pour indiquer qu'il y a du contenu masqué.

max-width: Limite la largeur maximale des cellules de données du tableau (td) à 300 pixels.
overflow: Masque tout contenu qui déborde de la cellule.

# 02/12/23 (Lise)
Lors de la séance de cette semaine, nous avons fait la correction du script qui permet de construire nos tableaux.
Les professeurs nous ont conseillés de faire des scripts séparés pour chaque langue car des problèmes peuvent survenir dans le cas où nous cherchons notre terme dans des écritures différentes.
De plus, séparer nos scirpts peut permettre d'avoir une meilleure lisibilité. Il nous suffit de reprendre les mêmes scripts entre nous et de les adapter à nos langues. En particulier le mot cible lors du comptage des occurrences, de la création des contextes et des concordanciers.

Concernant les concordanciers du français, le script semble très bien fonctionner. Malgrè cela, dans certains cas minoritaires, le contexte droit ou gauche est accolé à l'occurrence du mot. Quand le mot est cherché seul avec grep, il est trouvé seul mais une fois que nous ajoutons la tabulation, cela ne se fait pas. Nous avons ce cas par exemple dans le fichier "../concordances/fr-9.html". En effet nous trouvons par exemple dans une même case du concordancier "selon Santé Publique France" ou "Le Magazine de la Santé".

Le script pour préparer nos données à iTrameur fonctionne et devrait permettre d'être utiliser par les trois langues.

# 04/12/23 (Solomiia)
J'ai fait 5 tentatives pour que l'application compte les occurrences en ukrainien.
cat "../chemin/fichier.txt" | sort | uniq -c | grep -P "здоровʼя|здоров’я?|здоров'я|здоров'я?|Здоровʼя|Здоров'я" | grep -P -o "[[:digit:]]"| paste -sd+ - | bc
Celui me donne le résultat dans le terminal, mais pas dans les tables. 
Grace à Lise j'ai lancé le script pour itrameur de dump-texts et c'est bien. Malhereusement, je suis bloquée avec les occurences et concordances, je vais demander aux professeurs pendant le cours. 

# 26/12/23 (Lise)
Changement du style de notre index de Bulma vers Bootstrap.

# 29/12/23
Ajout de la page analyses_fr.html qui servira à présenter l'analyse textuelle des nos données avec l'outil iTrameur. Cette page sera accessible depuis la barre de menu.

# 30/12/23
Remplissage de la page analyse_fr.html avec les captures d'écrans des résultats iTrameur + l'analyse. Par la suite, ajout d'un style plus adapté à notre thème qui est la santé (thème orienté couleur vert).
Ajout d'un dossier "assets" qui contient un dossier "img" dans lequel nous pouvons mettre toutes nos captures d'écrans iTrameur. Le nom des images se présente sous la forme par exemple "fr_section_1.png", soit "lang_outil_num.png" .

# 05/01/24
Nous avons ajouter le design à notre site, fini de remplir les analyses des données avec iTrameur, ajouter des nuages de mots.

Objectifs pour demain :
- remplir notre présentation
- remplir la page de conclusion
- remplir la page des difficultés
- régler le problème du menu

# 06/01/24 (Solomiia & Lise)

Aujourd'hui nous avons ajouter l'ensemble des éléments manquants à notre site. C'est-à-dire :
- fini de remplir la page de présentation
- rempli la page des difficultés rencontrées
- remplis la page de Bilan>Résultats
- conclue l'ensemble de notre projet
- améliorer l'organisation de l'accueil
- améliorer le design

Informations concernant le design : nous avons choisi de mettre un width à 80% de la page car autrement les logos de l'image de background géne à la lecture.




