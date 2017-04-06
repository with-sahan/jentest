#! /bin/sh
# ----------------------------------------------------------------------
# Configure the back end server (dynamic content) for slammer
# ----------------------------------------------------------------------
SCRIPTS=`dirname $(readlink -f $0)`;

. $SCRIPTS/common.sh

DAEMON="daemon"
DAEMON=`find $APP_HOME -name $DAEMON`;
INIT_NAME="slammer";
log_action_msg "Found site: $DAEMON";

# ----------------------------------------------------------------------
# Link launch script 
# ----------------------------------------------------------------------
if [ -f "$DAEMON" ]; then
	log_action_msg "Installing daemon script $DAEMON into init.d";
	`chmod ugo+x $DAEMON`
	`sudo rm /etc/init.d/$INIT_NAME`
	`sudo ln -s $DAEMON /etc/init.d/$INIT_NAME`
	checkResult "Failed to install $INIT_NAME as a start up script, check symlink /etc/init.d/$INIT_NAME exists"
	
else 
	log_failure_msg "Cannot find daemon script in $APP_HOME";
	exit 1;
	
fi

# ----------------------------------------------------------------------
# Configure rc.d for startup/shutdown
# ----------------------------------------------------------------------

REPLACE="y"
echo "Do you want to start this service when the machine restarts? [Y/n]:"
read ANSWER

if [ -z "$ANSWER" ]; then
	ANSWER='y'
fi

if [ "y" = `echo $ANSWER | tr [:upper:] [:lower:]` ]; then
		REPLACE="y"
fi


if [ "y" = "$REPLACE" ]; then
	log_action_msg "Configuring rc.d...";
	OUTPUT=`sudo update-rc.d -f $INIT_NAME remove `
	OUTPUT=`sudo update-rc.d $INIT_NAME defaults 40 5 | grep S40$INIT_NAME`
	if [ "" = "$OUTPUT" ]; then
		log_failure_msg "Failed to install $INIT_NAME as a start up script";
		exit 1;
	fi

fi
	
log_action_msg "Done!";
