#!/usr/bin/bash

# ------------------------------- DEFINITIONS
IOS=darwin
LINUX=linux
NOT_FOUND='not found'
IOS_PACKAGE_MANAGER=brew
LINUX_PACKAGE_MANAGER=apt

installIOSPackageManager() {
	if [[ $(which $IOS_PACKAGE_MANAGER) =~ $NOT_FOUND ]]; then
		echo 'Installing package manager...';

		/bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)";
		echo 'Xcode install';
		xcode-select —-install;
		echo 'Evaluating installation';
		(echo; echo 'eval "$(/opt/homebrew/bin/brew shellenv)"') >> /Users/felipe/.zprofile;
		echo 'Checking installation';
		eval "$(/opt/homebrew/bin/brew shellenv)";
		echo 'Final check';
		brew help

		echo $IOS_PACKAGE_MANAGER 'installed';
	else
		echo $IOS_PACKAGE_MANAGER 'package manager already installed';
		which $IOS_PACKAGE_MANAGER
	fi
}

function installLinuxPackageManager() {
	if [[ $(which $LINUX_PACKAGE_MANAGER) =~ $NOT_FOUND  ]]; then
		#echo $LINUX_PACKAGE_MANAGER 'not found, installing now...';
		echo $LINUX_PACKAGE_MANAGER 'not found, code for automatically installed is missing, proceed manually';
	else
		echo $LINUX_PACKAGE_MANAGER 'already installed';
		which $LINUX_PACKAGE_MANAGER
	fi
}

function installZSH() {
	if [[ $(which zsh) =~ $NOT_FOUND ]]; then
		echo 'ZSH not found, installing now...';
		brew install zsh;

		echo 'Installing Oh-My-Zsh'
		sh -c "$(curl -fsSL https://raw.github.com/robbyrussell/oh-my-zsh/master/tools/install.sh)"	
	else
		echo 'ZSH already installed';
		which zsh;
		#check for oh my zsh
		#install if not
	fi

	#echo 'Changin shell to ZSH'
	#chsh -s /usr/local/bin/zsh
	if [[ $SHELL =~ zsh ]]; then
		echo 'Currently using zsh'
	else
		echo 'Changing to zsh'
		#check before change if zsh is installed	
		chsh -s /usr/local/bin/zsh	
	fi
}


function installGHCli() {
	echo 'Installing gh cli';

	if [[ $(which gh) =~ $NOT_FOUND  ]]; then
		echo 'gh cli not found, installing now...';
		brew install gh;
		which gh;
		gh login;
	else
		echo 'gh cli already installed';
	fi
}

function installNvm() {
	echo 'Installing nvm';

	if [[ $(nvm help) =~ $NOT_FOUND  ]]; then
		echo 'nvm not found, installing now...';
		curl -o- https://raw.githubusercontent.com/nvm-sh/nvm/v0.39.5/install.sh | bash
		nvm install 20
		node -v
	else
		echo 'nvm already installed'
	fi	
}

function createSshKey() {
	echo 'creating an ssh key...'
	ssh-keygen -b 4096 -t rsa
}

# ------------------------------ START SCRIPTING
echo 'Current OS' $OSTYPE


mkdir ~/workspace;
mkdir ~/workspace/projects/;
mkdir ~/workspace/tjene/;

if [[  $OSTYPE =~  $IOS  ]]; then

	installIOSPackageManager;
	installZSH;
	installGHCli;
	installNvm;
	createSshKey;

	mkdir ~/workspace;
	mkdir ~/workspace/projects/;
	mkdir ~/workspace/tjene/;
	
	echo 'Executing' $IOS 'scripts';
	echo $IOS
else
	installLinuxPackageManager;
	echo $LINUX
	echo 'no soy ' $IOS
fi

