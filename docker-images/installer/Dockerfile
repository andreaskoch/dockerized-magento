FROM php:5.6

# Configure PHP
RUN buildDeps=" \
        libpng12-dev \
        libjpeg-dev \
        libmcrypt-dev \
        libxml2-dev \
        freetype* \
    "; \
    set -x \
    && apt-get update && apt-get install -y $buildDeps --no-install-recommends && rm -rf /var/lib/apt/lists/* \
    && docker-php-ext-configure \
    gd --with-png-dir=/usr --with-jpeg-dir=/usr --with-freetype-dir \
    && docker-php-ext-install \
    gd \
    mbstring \
    mysqli \
    mcrypt \
    mysql \
    pdo_mysql \
    zip \
    && apt-get purge -y --auto-remove

# Install Tools
RUN apt-get update && \
    apt-get install -y \
    vim \
    telnet \
    netcat \
    git-core \
    zip && \
    apt-get purge -y --auto-remove

# Install magerun
RUN curl -o magerun https://raw.githubusercontent.com/netz98/n98-magerun/master/n98-magerun.phar && \
    chmod +x ./magerun && \
    ./magerun selfupdate && \
    cp ./magerun /usr/local/bin/ && \
    rm ./magerun && \
    apt-get update && \
    apt-get install -qy mysql-client && \
    apt-get purge -y --auto-remove

# Install composer
RUN curl -sS https://getcomposer.org/installer | php -- --filename=composer --install-dir=bin
