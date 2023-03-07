# Dockerize a laravel application

This is a simple bash script to dockerize a laravel application.
it includes: 
- nginx 
- php-fpm (version can be specified as an argument, defaults to 7.4)
- mariadb 10.6
- nodejs 13.7

## Usage

Run the script in the root of your laravel application.

```bash
bash <(curl -s curl https://raw.githubusercontent.com/yassine7500/dockerize-php/master/run.sh) $PHP_VERSION
```
