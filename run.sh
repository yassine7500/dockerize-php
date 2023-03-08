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
mv docker-compose.yml ../
mv -r dockerfiles ../
cd ..

#check that the tag exists
if git ls-remote --exit-code --tags origin "v$PHP_VERSION" > /dev/null 2>&1; then
    echo "Using PHP version $PHP_VERSION"
    git checkout "v$PHP_VERSION"
else
    echo "PHP version $PHP_VERSION does not exist"
    exit 1
fi

docker-compose up -d --build --force-recreate --remove-orphans --no-deps 

echo "PHP version $PHP_VERSION is running on port 8080"
echo "TO use artisan, run: docker-compose run --rm artisan <command>"
echo "To use composer, run: docker-compose run --rm composer <command>"
echo "To use npm, run: docker-compose run --rm npm <command>"

echo "Change your .env file to use the following database configuration:"
echo "DB_CONNECTION=mysql"
echo "DB_HOST=mysql"

rm -rf dockerize-php

#ask the user if he wants to gitignore docker-compose.yml and dockerfiles folder
read -p "Do you want to add docker-compose.yml and dockerfiles folder to .gitignore? [y/n] " -n 1 -r
if [[ $REPLY =~ ^[Yy]$ ]]
then
    echo "docker-compose.yml" >> .gitignore
    echo "dockerfiles" >> .gitignore
fi

