#!/bin/bash

VAGRANT_DIR=/vagrant

createDirs()
{
    echo 'Creating directories'
    indent; echo 'Creating vagrant dir'
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

cloneRepo() {
	ssh-keyscan -H github.com >> ~/.ssh/known_hosts
	git clone git@github.com:dmejer/oca-training.git
}

run() {
	createDirectories
	
	installJDK
	
	sudo apt-get install -y git
	
	cloneRepo
}

# run once
run
