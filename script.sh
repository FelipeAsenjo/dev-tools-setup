#!/usr/bin/bash

# ------------------------------- DEFINITIONS
IOS=darwin
LINUX=linux
NOT_FOUND='not found'
IOS_PACKAGE_MANAGER=brew
LINUX_PACKAGE_MANAGER=apt

function installPackageManager() {
	if [[ $OSTYPE =~ $IOS ]]; then
		if [[ $(which $IOS_PACKAGE_MANAGER) =~ $NOT_FOUND ]]; then
			echo 'Installing package manager...';

			/bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"

			echo $IOS_PACKAGE_MANAGER 'installed'
		else
			echo $IOS_PACKAGE_MANAGER 'package manager already installed';
		fi
	else
		if [[ $(which $LINUX_PACKAGE_MANAGER) =~ $NOT_FOUND  ]]; then
			#echo $LINUX_PACKAGE_MANAGER 'not found, installing now...';
			echo $LINUX_PACKAGE_MANAGER 'not found, code for automatically installed is missing, proceed manually'
		else
			echo $LINUX_PACKAGE_MANAGER 'already installed'
		fi
	fi
}

# ------------------------------ START SCRIPTING
echo 'Current OS' $OSTYPE

installPackageManager

# INSTALL PACKAGE MANAGER
if [[  $OSTYPE =~  $IOS  ]]; then
	echo 'hola mundo soy ' $IOS;
	echo $IOS
else
	echo $IOS
	echo 'no soy ' $IOS
fi

