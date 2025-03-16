FROM php:8.2-fpm-alpine

RUN mkdir -p /var/www/storage/logs/

WORKDIR /var/www

RUN docker-php-ext-install pdo pdo_mysql

RUN apk update && apk add --no-cache supervisor


COPY ./docker/supervisord.conf /etc/supervisor/supervisord.conf

ADD ./docker/crontab /etc/cron.d/laravel-cron
RUN chmod 0644 /etc/cron.d/laravel-cron \
    && crontab /etc/cron.d/laravel-cron

CMD ["/usr/bin/supervisord", "-n", "-c",  "/etc/supervisor/supervisord.conf"]
