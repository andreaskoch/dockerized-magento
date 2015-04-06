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

# Switch to the magento root folder
cd $MAGENTO_ROOT