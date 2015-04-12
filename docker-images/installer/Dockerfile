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

COPY php/php.ini /usr/local/etc/php/php.ini

ENV INSTALLER_VERSION 1.0.0

# Install Tools
RUN apt-get update && \
    apt-get install -y \
    vim \
    telnet \
    netcat \
    git-core \
    zip && \
    apt-get purge -y --auto-remove

# Add utility scripts
COPY bin/substitute-env-vars.sh /bin/substitute-env-vars.sh
RUN chmod +x /bin/substitute-env-vars.sh

# Add the Installer
COPY bin/install.sh /bin/install.sh
RUN chmod +x /bin/install.sh

# Install magerun
RUN curl -o magerun https://raw.githubusercontent.com/netz98/n98-magerun/master/n98-magerun.phar && \
    chmod +x ./magerun && \
    cp ./magerun /usr/local/bin/ && \
    rm ./magerun && \
    apt-get update && \
    apt-get install -qy mysql-client && \
    apt-get purge -y --auto-remove

# Add a custom magerun configuration
COPY magerun/n98-magerun.yaml.tmpl /etc/n98-magerun.yaml.tmpl

# Add custom Magento configuration files
COPY magento/local.xml.tmpl /etc/local.xml.tmpl
COPY magento/fpc.xml.tmpl /etc/fpc.xml.tmpl

# Install composer
RUN curl -sS https://getcomposer.org/installer | php -- --filename=composer --install-dir=bin

ENTRYPOINT ["/bin/install.sh"]