FROM php:7.4-apache

ENV XDEBUG_PORT 9000

# Adicionar arquivos de configuração
ADD .docker/config/php.ini /usr/local/etc/php/php.ini
ADD .docker/config/magento.conf /etc/apache2/sites-available/magento.conf
ADD .docker/config/custom-xdebug.ini /usr/local/etc/php/conf.d/custom-xdebug.ini
COPY .docker/bin/* /usr/local/bin/
COPY .docker/users/* /var/www/

# Configurar repositórios atualizados
RUN echo 'deb http://deb.debian.org/debian bullseye main' > /etc/apt/sources.list && \
    echo 'deb http://deb.debian.org/debian-security bullseye-security main' >> /etc/apt/sources.list

# Instalar dependências
RUN apt-get update && apt-get install -y \
    cron \
    libpng-dev \
    libjpeg-dev \
    libfreetype6-dev \
    libcurl4-openssl-dev \
    libxml2-dev \
    libzip-dev \
    libonig-dev \  
    git \
    wget \
    zip \
    vim \
    gcc \
    make \
    autoconf \
    libc-dev \
    pkg-config \
    mariadb-client \
    ssl-cert && \
    docker-php-ext-configure gd --with-freetype --with-jpeg && \
    docker-php-ext-install pdo pdo_mysql gd mbstring soap zip && \
    a2enmod rewrite headers ssl && \
    chmod 777 -R /var/www && \
    chown -R www-data:1000 /var/www && \
    usermod -u 1000 www-data && \
    chsh -s /bin/bash www-data

# Configurar cron para o Magento
RUN echo "* * * * * www-data /bin/sh /var/www/html/cron.sh > /dev/null 2>&1" >> /etc/cron.d/magento && \
    chmod 0644 /etc/cron.d/magento

# Instalar XDebug
RUN pecl install xdebug-3.1.5 && docker-php-ext-enable xdebug

# Instalar Composer
RUN curl -sS https://getcomposer.org/installer | php -- --install-dir=/usr/local/bin --filename=composer

# Instalar Magerun
RUN wget https://files.magerun.net/n98-magerun.phar --no-check-certificate && \
    chmod +x ./n98-magerun.phar && mv ./n98-magerun.phar /usr/local/bin/

# Instalar Modman
RUN wget https://raw.githubusercontent.com/colinmollenhour/modman/master/modman -O /usr/local/bin/modman && \
    chmod +x /usr/local/bin/modman

# Garantir que o diretório /var/run/cron existe e tem as permissões corretas
RUN mkdir -p /var/run/cron && \
    chmod 777 /var/run/cron && \
    chown -R www-data:www-data /var/run/cron

# Configurar Apache
RUN ln -s /etc/apache2/sites-available/magento.conf /etc/apache2/sites-enabled/magento.conf

# Configurar diretório de trabalho
VOLUME ["/var/www/html"]
WORKDIR /var/www/html
COPY ./src /var/www/html

CMD service cron start && apache2-foreground