#! /bin/sh
# ----------------------------------------------------------------------
# Find plugin directories and install them
# ----------------------------------------------------------------------
SCRIPTS=`dirname $(readlink -f $0)`;

. $SCRIPTS/common.sh

cd $APP_HOME;

USERS_HOME_DIR=~/
PLUGINS_DIR=$1

if [ -z $PLUGINS_DIR ]; then

	log_warning_msg "Path to base plug-ins directory not provided, using the parent directory of the current installation"
	PLUGINS_DIR=$APP_HOME/..
	
fi

if [ ! -d $PLUGINS_DIR ]; then
  log_failure_msg "Cannot find plug-in directory $PLUGIN_DIR";
  exit 1;
fi

# ===================================================================
# run the install script for the plugin
# ===================================================================
install_plugin(){
	if [ -d "$PLUGINS_DIR/$1" ]; then
  
    local PLUGIN_SCRIPT_DIR=`find $PLUGINS_DIR/$1 -type d -name 'scripts' 2> /dev/null`
		if [ -d "$PLUGIN_SCRIPT_DIR" ]; then
      cd "$PLUGIN_SCRIPT_DIR"
		  sh install.sh "$APP_HOME"
		  cd $APP_HOME		
      
    else 
      log_warning_msg "could not find scripts in plugin directory $PLUGINS_DIR/$1"
    
    fi
	fi
}

for PLUGIN in `ls -1 $PLUGINS_DIR | grep -E 'connect-[a-z]+'`;
  do
    install_plugin $PLUGIN
  done
  
  
cd $INITIAL_DIR;

log_action_msg "Done";
exit 0;
