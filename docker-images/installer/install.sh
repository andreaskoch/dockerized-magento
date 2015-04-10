#!/bin/bash

# Check if the MAGENTO_ROOT direcotry has been specified
if [ -z "$MAGENTO_ROOT" ]
then
	echo "Please specify the root directory of Magento via the environment variable: MAGENTO_ROOT"
	exit 1
fi

# Check if the specified MAGENTO_ROOT direcotry exists
if [ ! -d "$MAGENTO_ROOT" ]
then
	echo "The specified Magento root directory '$MAGENTO_ROOT' does not exists. Check your volume configuration."
	exit 1
fi

# Check if there is alreay an index.php. If yes, abort the installation process.
if [ -e "$MAGENTO_ROOT/index.php" ]
then
	echo "Magento is already installed."
	exit 0
fi

echo "Installing Magento"

magerun install \
 --dbHost=mysql \
 --dbUser="$MYSQL_USER" \
 --dbPass="$MYSQL_ROOT_PASSWORD" \
 --dbName="$MYSQL_DATABASE" \
 --dbPort="3306" \
 --magentoVersionByName="magento-ce-1.9.1.0-dropbox" \
 --installationFolder="$MAGENTO_ROOT" \
 --installSampleData=yes \
 --baseUrl="http://$DOMAIN/" \
 --skip-root-check

echo "Install modules"
cd /var/www/html
composer update

echo "Installation fininished"

while :
do
	sleep 1
done