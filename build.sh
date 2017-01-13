#!/bin/bash

src=$1
cd $src

# clean up previous elm build residues
rm -rf elm-stuff

# install necessary elm packages for project
if [ -e "elm-package.json" ]; then
	elm-package install -y
fi

# install necessary nodejs packages (using yarn)
if [ -e "package.json" ]; then
	yarn install
fi

# build project using brunch
if [ -e "brunch-config.js" ]; then
	brunch b
fi
