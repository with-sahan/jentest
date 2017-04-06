#! /bin/sh
SCRIPTS=`dirname $(readlink -f $0)`;

. /lib/lsb/init-functions
. $SCRIPTS/common.sh

install(){
	log_action_msg "Installing $1...";
	sudo apt-get -qq -y install $1
	checkResult "Failed to install $1";
}

install "unzip htop vim byobu"

install "openjdk-7-jdk"

install "openssh-server"

install "postgresql"

install "nginx"

if [ ! -d "/var/www" ]; then
  sudo mkdir "/var/www"
fi
