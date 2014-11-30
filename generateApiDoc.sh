#!/bin/bash


#Stahne url pro stazeni repozitaru
urls=$(curl -s https://api.github.com/users/skaut/repos | grep git_url | cut -d '"' -f4)

rm -rf api;
mkdir api;

for url in $urls; do

	repName=$(echo "$url" | rev | cut -d/ -f1 | cut -d. -f2- | rev)
	git clone "$url" tmp;

	#Upravi a nakopiruje konfigurak
	cat config.neon | sed "s/title: .*/title: $repName/" > tmp/config.neon

	apigen --source tmp --destination "api/$repName"

	rm -rf tmp;
done;
