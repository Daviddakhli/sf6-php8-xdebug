FROM php:8.0.13-cli

RUN apt-get update \
    &&  apt-get install -y --no-install-recommends \
        locales apt-utils git libicu-dev g++ libpng-dev libxml2-dev libzip-dev libonig-dev libxslt-dev unzip libpq-dev nodejs npm wget \
        apt-transport-https lsb-release ca-certificates

RUN echo "en_US.UTF-8 UTF-8" > /etc/locale.gen  \
    &&  echo "fr_FR.UTF-8 UTF-8" >> /etc/locale.gen \
    &&  locale-gen

RUN curl -sS https://getcomposer.org/installer | php -- \
    &&  mv composer.phar /usr/local/bin/composer

RUN curl -sS https://get.symfony.com/cli/installer | bash \
    &&  mv /root/.symfony/bin/symfony /usr/local/bin

RUN docker-php-ext-configure \
            intl \
    &&  docker-php-ext-install \
            pdo pdo_mysql pdo_pgsql opcache intl zip calendar dom mbstring gd xsl

RUN pecl install apcu && docker-php-ext-enable apcu

RUN npm install --global yarn

RUN git config --global user.email "dakli.david@gmail.com" \
    &&  git config --global user.name "Daviddakhli"

RUN pecl install xdebug && docker-php-ext-enable xdebug \
&& echo "\n\
xdebug.mode = debug \n\
xdebug.start_with_request = yes \n\
xdebug.client_host = 172.19.0.1 \n\
xdebug.discover_client_host = false \n\
xdebug.client_port = 9003 \n\
xdebug.log = /var/www/xdebug.log \n\
" >> /usr/local/etc/php/conf.d/docker-php-ext-xdebug.ini

CMD tail -f /dev/null

WORKDIR /var/www/