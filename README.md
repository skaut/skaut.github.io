#skaut.github.io

Web pro GitHub [organizaci](https://github.com/skaut)

##Generovani
Misto nastavovani generatoru pro kazdy repozitar skript [generateApiDoc.sh](./generateApiDoc.sh) stahne vsechny repozitare organizace githu.com/skaut a vygeneruje jeich API

###Vyhody
Nikdo nemusi nic konfigurovat, pridavat, vse resi tento projekt

###Nevyhody
* Rucni spusteni (urcite pujde zautomatizovat)
* Nepodporuje verzovani
* Nepodporuje vice BRANCHu

##Generovani dokumentace (ukazky, navody)
Pro generovani dokumentace se pouziva [mkdocs](http://www.mkdocs.org/).
Je to nastroj ktery parsuje Markdown soubory ve slozce docs nachazejici se v root adresaro repozitare.

##Generovani API
Pro generovani API se pouziva [apigen](http://apigen.org/)
Je to nastroj ktery parsuje ``@phpdocs``


