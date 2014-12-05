#skaut.github.io

Web pro GitHub [organizaci](https://github.com/skaut)

##Generovani
Místo nastavovaní generatoru pro kazdy repozitar skript [generateApiDoc.sh](./generateApiDoc.sh) stahne vsechny repozitare organizace github.com/skaut a vygeneruje jejich API

###Vyhody
Nikdo nemusí nic konfigurovat, přidavat, vše řeší tento projekt.

###Nevyhody
* Rucni spusteni (urcite pujde zautomatizovat)
* Nepodporuje verzovani
* Nepodporuje vice BRANCHu

##Generovani dokumentace (ukazky, navody)
Pro generovani dokumentace se pouziva [mkdocs](http://www.mkdocs.org/).
Je to nástroj ktery parsuje Markdown soubory ve složce docs nachazejici se v root adresaro repozitare.

##Generovani API
Pro generovani API se používá [apigen](http://apigen.org/)
Je to nastroj který parsuje ``@phpdocs``


