#!/bin/bash

src=$1
cd $src

if [ -e "elm-package.json" ]; then
    # install necessary elm packages for project
    elm-package install -y
fi

if [ -e "package.json" ]; then
	# install necessary nodejs packages
	npm i
fi

if [ -e "brunch-config.js" ]; then
	# build project using brunch
	brunch b
fi
