Programme d'envoi d'emails et tweets en masse

Réalisé dans le cadre de The Hacking Project, semaine 3, jour 4 ( projet validant )

Groupe : Bordeaux 1

Participants : Valérian Michelot, Paul Guérin, William Horel, François Flous, David Rangeard

Le but du programme est de récupérer les adresses mails des communes de 3 départements choisis arbitrairement ( dans notre cas, la Gironde [33], les Pyrénées-atlantiques [64], et les Landes [40] ) , envoyer à chacune de ces communes un email, tenter d'associer un compte twitter à chacune de ces communes et les suivre.


Voici le cahier des charges du projet :
- Scrapper :

  . récupère les emails des communes de 3 départements

  . enregistre dans un fichier json/csv pour chaque commune les informations suivantes :

      . email

      . nom de la commune

      . département (numéro ou nom)


- Mailer :

  . reprend chaque colonne du fichier json/csv pour envoyer un mail à la mairie indiquée

- Bot Twitter :

  . contient un programme qui repasse sur chaque élément du json/csv et ajoute une colonne supplémentaire avec le handle twitter

  . contient un programme qui prend la colonne des handles twitter, et follow les users concernés

- Linker :

  .
