#clone the dockerize-php repo and depending on the php-version argument, checkout the corresponding tag
#
PHP_VERSION=$1

if [ -z "$PHP_VERSION" ]; then
    echo "No PHP version specified"
    echo "Using default PHP version 7.4"
    PHP_VERSION=7.4
fi

#if the current directory already has a dockerize-php folder, remove it
if [ -d "dockerize-php" ]; then
    rm -rf dockerize-php
fi

git clone https://github.com/yassine7500/dockerize-php.git
cd dockerize-php


#check that the tag exists
if git tag -l | grep -q "v$PHP_VERSION"; then
    echo "Using PHP version $PHP_VERSION"
    git checkout "v$PHP_VERSION"
else
    echo "PHP version $PHP_VERSION does not exist"
    exit 1
fi

mv docker-compose.yml ../
mv dockerfiles ../
cd ..
docker-compose up -d --build --force-recreate --remove-orphans --no-deps 

rm -rf dockerize-php

#ask the user if he wants to gitignore docker-compose.yml and dockerfiles folder
read -p "Do you want to add docker-compose.yml and dockerfiles folder to .gitignore? [y/n] " -n 1 -r
if [[ $REPLY =~ ^[Yy]$ ]]
then
    echo "docker-compose.yml" >> .gitignore
    echo "dockerfiles" >> .gitignore
fi

