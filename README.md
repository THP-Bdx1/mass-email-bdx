# THP – Envoi d’emails en masse
Ce README contient toutes les informations liées au projet « Envoi d’emails en masse » du jeudi 18 Octobre 2018 dans le cadre de la formation The Hacking Project.
## Introduction
Voici la liste des participants à la création du programme et les parties sur lesquelles ils ont participé :
- Valérian Michelot ( index.rb, townhalls_mailer.rb, liaison des programmes )
- Paul Guérin ( townhalls_scrapper.rb )
- François Flous ( townhalls_adder_to_db.rb, townhalls_follower.rb )
- William Horel ( townhalls_mailer.rb, townhalls_adder_to_db.rb )
- David Rangeard ( townhalls_scrapper.rb, README.md et liaison des programmes )

Pour faire fonctionner le programme, il vous suffit de vous placer dans /mass-email-bdx ( que vous aurez cloné ) et d’exécuter dans le terminal les commandes suivantes :
```
$ bundle install
ruby app.rb
```
## Arborescence du dossier et utilité des programmes
Voici comment doit se constituer votre dossier /mass-email-bdx :
```
/mass-emails-bdx
	/db
	/lib
		/app
			townhalls_adder_to_db.rb
			townhalls_follower.rb
			townhalls_mailer.rb
			townhalls_scrapper.rb
		/views
			done.rb
			index.rb
	.gitignore
	app.rb
	Gemfile
	Gemfile.lock
	README.md
```

Voici, de plus, une liste des programmes et leur utilité :

- /lib/app/townhalls_adder_to_db.rb : génère une liste de handles Twitter basés sur une recherche de nom de la commune et ajoute au Json la liste des handles trouvés à la mairie correspondante
- /lib/app/townhalls_follower.rb : fait en sorte que le compte Twitter suive tous les comptes correspondants supposément aux mairies des communes trouvées
- /lib/app/townhalls_mailer.rb : envoie un email à chacune des adresses mail des mairies des communes trouvées
- /lib/app/townhalls_scrapper.rb : récupère la liste des mairies des 3 départements de la Gironde, des Pyrénées-atlantiques et de la Réunion et les range dans un fichier Json.
- /lib/views/index.rb : interface utilisateur du terminal qui pose une série de questions afin de savoir quels programmes doivent être exécutés, puis les exécute
- /app.rb : permet de lancer le programme index.rb, et de fait toute l’exécution du projet

Pour fonctionner, le programme nécessitera un Dotenv placé dans la source, contenant les identifiants gmail, les identifiants Twitter et les clefs API.

## Utilisation du programme & gems utilisées
Une fois le programme app.ruby lancé, le programme va vous poser une série de questions vous demandant à chaque fois si vous souhaitez ou non exécuter une action particulière, puis il exécutera les actions demandées.

Afin de faire fonctionner ce programme, les gems suivantes ont été utilisées :
- **google-api-client** ( accéder aux applications de google via API )
- **gmail** ( sert à utiliser gmail )
- **dotenv** ( stocker à part des données sensibles )
- **twitter** ( sert à utiliser twitter )
- **nokogiri** ( nécessaire pour le scrapping )
- **json** ( écrire des fichiers au format json )
- **gmail-api-ruby** ( permet au programme d’accéder à gmail via API )

## Que s’est-il passé ?
Si vous avez répondu « oui » à toutes les actions, le programme a effectué les actions suivantes :

- Envoyé l’email avec le contenu indiqué en bas de page à 1113 mairies de France dans les départements de la Gironde, des Pyrénées-atlantiques et de la Réunion.

Dans notre cas, l’essai a été fait avec le compte gmail suivant :

codeurenherbe33@gmail.com

- Cherché des handles Twitter affichés en tête de liste après une recherche « mairie + nom de la commune » et suivi les comptes correspondants si trouvés.

Dans notre cas, l’essai a été fait avec le compte Twitter suivant :

codeur_en_herbe_33 ( @Codeur3 )

Contenu de l’email :
```
« Apprendre à coder, une nouvelle pédagogie »
Bonjour,
  Je m'appelle William, je suis élève à The Hacking Project, une formation au code gratuite, sans locaux, sans sélection, sans restriction géographique. La pédagogie de notre école est celle du peer-learning, où nous travaillons par petits groupes sur des projets concrets qui font apprendre le code. Le projet du jour est d'envoyer (avec du codage) des emails aux mairies pour qu'ils nous aident à faire de The Hacking Project un nouveau format d'éducation pour tous.
  Déjà 500 personnes sont passées par The Hacking Project. Est-ce que la mairie de #{k["ville"]} veut changer le monde avec nous ?
  Charles, co-fondateur de The Hacking Project pourra répondre à toutes vos questions : 06.95.46.60.80
```
