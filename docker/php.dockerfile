FROM php:8.2-fpm

# RUN apt-get update; \
#     apt-get install -y libmagickwand-dev; \
#     pecl install imagick; \
#     docker-php-ext-enable imagick;

ADD ./docker/custom-php.ini /usr/local/etc/php/conf.d/custom-php.ini

RUN mkdir -p /var/www

WORKDIR /var/www

RUN docker-php-ext-install pdo pdo_mysql pcntl

RUN docker-php-ext-configure pcntl --enable-pcntl

EXPOSE 9000
