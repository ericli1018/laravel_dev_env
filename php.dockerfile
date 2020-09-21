FROM php:7.4-fpm-alpine

WORKDIR /var/www/html
RUN echo "UTC" > /etc/timezone
RUN docker-php-ext-install pdo pdo_mysql
RUN apk update && apk add --no-cache gcc g++ make autoconf

RUN pecl install xdebug && docker-php-ext-enable xdebug \
    && echo "[xdebug]" > /usr/local/etc/php/conf.d/docker-php-ext-xdebug.ini \
    && echo "zend_extension = \"/usr/local/lib/php/extensions/no-debug-non-zts-20190902/xdebug.so\"" >> /usr/local/etc/php/conf.d/docker-php-ext-xdebug.ini \
    && echo "xdebug.remote_enable = 1" >> /usr/local/etc/php/conf.d/docker-php-ext-xdebug.ini \
    && echo "xdebug.remote_handler = dbgp" >> /usr/local/etc/php/conf.d/docker-php-ext-xdebug.ini \
    && echo "xdebug.remote_host = docker.for.mac.localhost" >> /usr/local/etc/php/conf.d/docker-php-ext-xdebug.ini \
    && echo "xdebug.remote_port = 9001" >> /usr/local/etc/php/conf.d/docker-php-ext-xdebug.ini \
    && echo "xdebug.remote_mode = req" >> /usr/local/etc/php/conf.d/docker-php-ext-xdebug.ini \
    && echo "xdebug.cli_color = 1" >> /usr/local/etc/php/conf.d/docker-php-ext-xdebug.ini \
    && echo "xdebug.remote_log = /var/log/php/xdebug.log" >> /usr/local/etc/php/conf.d/docker-php-ext-xdebug.ini \
    && echo "xdebug.remote_autostart=1" >> /usr/local/etc/php/conf.d/docker-php-ext-xdebug.ini \
    && echo "xdebug.remote_connect_back=0" >> /usr/local/etc/php/conf.d/docker-php-ext-xdebug.ini \
    && echo "xdebug.idekey = VSCODE" >> /usr/local/etc/php/conf.d/docker-php-ext-xdebug.ini

RUN apk del gcc g++ make autoconf
RUN rm /var/cache/apk/*