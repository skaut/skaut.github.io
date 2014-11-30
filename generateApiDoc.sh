#!/bin/bash


#Stahne url pro stazeni repozitaru
urls=$(curl -s https://api.github.com/users/skaut/repos | grep git_url | cut -d '"' -f4)

rm -rf api;
mkdir api;

rm -rf docs;
mkdir docs;

for repoUrl in $urls; do

	repName=$(echo "$repoUrl" | rev | cut -d/ -f1 | cut -d. -f2- | rev)

	if [ "$repName" == "skaut.github.io" ]; then
		continue;
	fi

	rm -rf tmp;
	git clone "$repoUrl" tmp;

	#Upravi a nakopiruje konfigurak
	cat config.neon | sed "s/title: .*/title: $repName/" > tmp/config.neon

	#Generate API reference
	apigen --source tmp --destination "api/$repName"

	#Generate docs
	docUrl="http:\/\/skaut.github.io\/docs\/$repName"
	mkdir -p "docs/$repName"
	repoUrl="" #TODO escpe / for sed
	cat mkdocs.yml | sed "s/site_name:.*/site_name: $repName/" | sed "s/site_url:.*/site_url: $docUrl/" | sed "s/repo_url:.*/repo_url: $repoUrl/" | sed "s/site_dir:.*/site_dir: ..\/docs\/$repName/" > tmp/mkdocs.yml


	docsNotExist=$(ls -l tmp/docs | grep ".md" | wc -l)
	if [ $docsNotExist -eq 0 ]; then
		mkdir -p tmp/docs;
		echo "#Skript generujici dokumentaci nenasel soubory. Ujistete se ze maji .md priponu a jsou v adresi docs ktery je v rootu git repositare"  > tmp/docs/index.md
	fi

	cd tmp && mkdocs build && cd -;

	rm -rf tmp;
done;
