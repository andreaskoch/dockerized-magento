#!/bin/bash

set -e

#####################################
# Update the Magento Installation
# Arguments:
#   None
# Returns:
#   None
#####################################
function updateMagento() {
	cd /var/www/html
	composer update
}

#####################################
# Print URLs and Logon Information
# Arguments:
#   None
# Returns:
#   None
#####################################
function printLogonInformation() {
	baseUrl="http://$DOMAIN"
	frontendUrl="$baseUrl/"
	backendUrl="$baseUrl/admin"

	echo ""
	echo "phpMyAdmin: $baseUrl:8080"
	echo " - Username: ${MYSQL_USER}"
	echo " - Password: ${MYSQL_PASSWORD}"
	echo ""
	echo "Backend: $backendUrl"
	echo " - Username: ${ADMIN_USERNAME}"
	echo " - Password: ${ADMIN_PASSWORD}"
	echo ""
	echo "Frontend: $frontendUrl"
}


#####################################
# Fix the filesystem permissions for the magento root.
# Arguments:
#   None
# Returns:
#   None
#####################################
function fixFilesystemPermissions() {
	chmod -R go+rw $MAGENTO_ROOT
}

#####################################
# A never-ending while loop (which keeps the installer container alive)
# Arguments:
#   None
# Returns:
#   None
#####################################
function runForever() {
	while :
	do
		sleep 1
	done
}

# Fix the www-folder permissions
chgrp -R 33 /var/www/html

# Check if the MAGENTO_ROOT direcotry has been specified
if [ -z "$MAGENTO_ROOT" ]
then
	echo "Please specify the root directory of Magento via the environment variable: MAGENTO_ROOT"
	exit 1
fi

# Check if the specified MAGENTO_ROOT direcotry exists
if [ ! -d "$MAGENTO_ROOT" ]
then
	mkdir -p $MAGENTO_ROOT
fi

# Check if there is alreay an index.php. If yes, abort the installation process.
if [ -e "$MAGENTO_ROOT/index.php" ]
then
	echo "Magento is already installed."
	echo "Updating Magento"
	updateMagento

	echo "Fixing filesystem permissions"
	fixFilesystemPermissions

	echo "Update fininished"
	printLogonInformation

	runForever
	exit 0
fi

echo "Preparing the Magerun Configuration"
substitute-env-vars.sh /etc /etc/n98-magerun.yaml.tmpl

echo "Installing Magento"
updateMagento

echo "Preparing the Magento Configuration"
substitute-env-vars.sh /etc /etc/local.xml.tmpl
substitute-env-vars.sh /etc /etc/fpc.xml.tmpl

echo "Overriding Magento Configuration"
cp -v /etc/local.xml /var/www/html/web/app/etc/local.xml
cp -v /etc/fpc.xml /var/www/html/web/app/etc/fpc.xml
chgrp -R 33 $MAGENTO_ROOT/app/etc

echo "Installing Sample Data: Media"
curl -s -L https://raw.githubusercontent.com/Vinai/compressed-magento-sample-data/1.9.1.0/compressed-no-mp3-magento-sample-data-1.9.1.0.tgz | tar xz -C /tmp
cp -av /tmp/magento-sample-data-*/* $MAGENTO_ROOT
rm -rf /tmp/magento-sample-data-*
chgrp -R 33 $MAGENTO_ROOT

echo "Installing Sample Data: Database"
magerun --skip-root-check --root-dir="$MAGENTO_ROOT" db:create
databaseFilePath="$MAGENTO_ROOT/*.sql"
magerun --skip-root-check --root-dir="$MAGENTO_ROOT" db:import $databaseFilePath
rm $databaseFilePath

echo "Installing Sample Data: Reindex"
magerun --skip-root-check --root-dir="$MAGENTO_ROOT" cache:clean
magerun --skip-root-check --root-dir="$MAGENTO_ROOT" index:reindex:all

echo "Installing Sample Data: Admin User"
magerun --skip-root-check --root-dir="$MAGENTO_ROOT" \
		admin:user:create \
		"${ADMIN_USERNAME}" \
		"${ADMIN_EMAIL}" \
		"${ADMIN_PASSWORD}" \
		"${ADMIN_FIRSTNAME}" \
		"${ADMIN_LASTNAME}" \
		"Administrators"

echo "Enable Fullpage Cache"
magerun --skip-root-check --root-dir="$MAGENTO_ROOT" cache:enable fpc

echo "Fixing filesystem permissions"
fixFilesystemPermissions

echo "Installation fininished"
printLogonInformation

runForever
exit 0
