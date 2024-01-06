 
Ce fichier informations.md va nous permettre de vous présenter les différents programmes qui nous ont été utiles pour réaliser notre projet.

Dans ce dossier se trouvent les programmes suivants :
- aspirations.sh (script pour aspirer les liens et les transformer en fichiers html)
- concordances_fr.sh (script pour créer le concordancier du français)
- concordances_ukr.sh (script pour créer le concordancier de l’ukrainien)
- dump.sh (script pour transformer 50 liens html en fichiers du contenu textuel)
- make_itrameur_corpus.sh (script pour créer les fichiers txt à insérer dans iTrameur)
- occurrences.sh (script pour compter les occurrences du mot dans les fichiers)
- script_tableau.sh (première version de script bash)
- tableau_fr.sh (script pour créer le tableau html du français)
- tableau_ukr.sh (script pour créer le tableau html de l’ukrainien)

Au début, nous avons souhaité faire un programme qui permettait de faire les deux langues en même temps, seuls les paramètres changeaient, il nous suffisait d'indiquer par exemple “fr” ou “ukr”.
Dans nos premiers scripts, nous avions créé un script permettant de créer le tableau html. Ce dernier faisait appel à d’autres sous scripts, qui nous ont permis de détailler les étapes et les colonnes du tableau. Ceci nous a permis dans un premier temps de mieux décomposer et comprendre chaque étape. Cependant, utiliser le même script pour deux langues différentes pose un problème et entraîne des conflits.
Ainsi, nous avons pris conseil sur ce qui a été fait en cours, nous avons réuni toutes les étapes (excepté le concordancier) dans un même script. Pour éviter les conflits entre les cibles des deux langues, nous avons créé deux scripts de création de tableau différents : tableau_ukr.sh et tableau_fr.sh.

Les scripts qui ont servis au rendu final de notre projet :
- concordances_fr.sh
- concordances_ukr.sh
- tableau_fr.sh
- tableau_ukr.sh
- make_itrameur_corpus.sh

Les scripts qui ne sont plus utiles :
- aspiration.sh
- script_tableau.sh
- dump.sh
- occurrences.sh

Nous avons décidé de ne pas les supprimer pour voir tout le processus de la création du projet et pouvoir revenir et comprendre les étapes précédentes.
