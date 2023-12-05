#!/usr/bin/bash

# CHECK OS
IOS=darwin

echo ${CURRENT_OS}
# INSTALL PACKAGE MANAGER
if [[  $OSTYPE =~  IOS*  ]]; then
	echo 'hola mundo soy $IOS';
	echo $IOS
else
	echo $IOS
	echo 'no soy $IOS'
fi

which brew

