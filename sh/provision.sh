#!/bin/bash

VAGRANT_DIR=/vagrant

setEncodings() {
	sudo echo "LANG=en_US.UTF-8" >> /etc/environment
	sudo echo "LANGUAGE=en_US.UTF-8" >> /etc/environment
	sudo echo "LC_ALL=en_US.UTF-8" >> /etc/environment
	sudo echo "LC_CTYPE=en_US.UTF-8" >> /etc/environment
}

createDirs()
{
    echo 'Creating directories'
    indent; echo 'Creating vagrant dir'
    mkdir $VAGRANT_DIR
	
	indent; echo 'Creating project file dir'
	mkdir $VAGRANT_DIR
}

installJDK() {
	sudo add-apt-repository -y ppa:webupd8team/java
	sudo apt-get update
	sudo apt-get -y upgrade
	echo debconf shared/accepted-oracle-license-v1-1 select true | sudo debconf-set-selections
	echo debconf shared/accepted-oracle-license-v1-1 seen true | sudo debconf-set-selections
	sudo apt-get -y install oracle-java8-installer
}

run() {
	setEncodings
	createDirectories

	installJDK
}

if [ ! -f "/var/vagrant_provision" ]; then
	sudo touch /var/vagrant_provision
	run
else
	echo "Nothing"
fi