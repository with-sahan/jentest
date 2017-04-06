#! /bin/sh
# ----------------------------------------------------------------------
# Configure the local instance of nginx for the standard service
# ----------------------------------------------------------------------
SCRIPTS=`dirname $(readlink -f $0)`;

. $SCRIPTS/common.sh

SITE_NAME="$NAME.nginx"
SITE=`find $APP_CONFIG -name $SITE_NAME`;
log_action_msg "Found site: $SITE";


# ----------------------------------------------------------------------
# Find the SSL certificates and install them. If not found warn that this
# is a mandatory step but continue with the rest of the configuration.
# Look for SSL cert from the project home directory an assume that there
# is only one... in a live deployment this should be etc/ssl and in a 
# source deployment they will be in tests/ssl    
# ----------------------------------------------------------------------
CERT_NAME="moderndemocracy.crt"
KEY_NAME="moderndemocracy.key";

# ----------------------------------------------------------------------
# Find the SSL directory
# ----------------------------------------------------------------------
SSL_DIR=`find $APP_HOME/tests -type d -name ssl`;
if [ ! -d "$SSL_DIR" ]; then
	log_action_msg "Did not find sample SSL cert, looking for primary SSL cert..."
	SSL_DIR=`find $APP_HOME -type d -name ssl`;
fi

if [ ! -d "$SSL_DIR" ]; then

	log_warning_msg "Failed to find SSL directory, $SSL_DIR nginx will fail to load until SSL is manually configured"
		
else 

	# ----------------------------------------------------------------------
	# Find the public CERT
	# ----------------------------------------------------------------------
	CERT=`find $SSL_DIR -name $CERT_NAME`;
	if [ -f "$CERT" ]; then
		log_action_msg "Found SSL cert: $CERT";
				
	else
		log_warning_msg "Failed to find SSL CERT: $CERT_NAME, nginx will fail to load until SSL is manually configured"
		
	fi
	
	# ----------------------------------------------------------------------
	# Find the private KEY
	# ----------------------------------------------------------------------		
	KEY=`find $SSL_DIR -name $KEY_NAME`;
	if [ -f "$KEY" ]; then	
		log_action_msg "Found SSL key: $KEY";
	else
		log_warning_msg "Failed to find SSL KEY: $KEY_NAME, nginx will fail to load until SSL is manually configured" 
	fi		
		
	# ----------------------------------------------------------------------
	# Make sure that any directory will SSL certificates is readable only
  	# by the owner
	# ----------------------------------------------------------------------
	`chmod 700 $SSL_DIR`;
	`chmod 600 $KEY`;
	`chmod 600 $CERT`;
						
fi			
	

# ----------------------------------------------------------------------
# Configure server root
# ----------------------------------------------------------------------
ROOT="/var/www/$NAME";


if [ -e $ROOT ]; then

    TARGET=`readlink $ROOT`;
    
    if [ "$TARGET" = "$APP_STATIC" ]; then
      log_action_msg "The correct server root '$ROOT' is already installed. [skipping]";
      
    else 

      log_action_msg "Replacing existing server root: $ROOT with $APP_STATIC";
      sudo rm $ROOT;
      sudo ln -s $APP_STATIC $ROOT

    fi

else 

  log_action_msg "Installing server root: $APP_STATIC at $ROOT";
  sudo ln -s $APP_STATIC $ROOT
    
fi


# ----------------------------------------------------------------------
# Configure SSL
# ----------------------------------------------------------------------
if [ -f "$CERT" ] && [ -f "$KEY" ]; then

	INSTALLED_CERTS="/etc/ssl/certs";
	INSTALLED_KEYS="/etc/ssl/private";

	REPLACE="y"
	if [ -e "$INSTALLED_CERTS/$CERT_NAME" ]; then

			REPLACE="n"
			log_warning_msg "Found an existing SSL certificate do you want to replace it? [y/N]:"
			read ANSWER

			if [ -z "$ANSWER" ]; then
				ANSWER='n'
			fi

			if [ "y" = `echo $ANSWER | tr [:upper:] [:lower:]` ]; then
					REPLACE="y"
			fi

	fi
	if [ "y" = "$REPLACE" ]; then
			log_action_msg "Installing SSL certificate in to $INSTALLED_CERTS";
			sudo cp $CERT $INSTALLED_CERTS
			log_action_msg "Installing SSL key in to $INSTALLED_KEYS";
			sudo cp $KEY $INSTALLED_KEYS

	fi
	
fi

# ----------------------------------------------------------------------
# Install nginx site
# ----------------------------------------------------------------------
NGINX_SITES="/etc/nginx/sites-enabled"

log_action_msg "Checking for existing nginx sites";

ENABLED=`find $NGINX_SITES -type l`

for link in $ENABLED
    do
        TARGET=`readlink $link`;
        
        if [ "$TARGET" = "$SITE" ]; then
          log_action_msg "The correct site '$link' is already installed. [skipping]";
          log_action_msg "Done!";
          exit 0;

        else 
          log_warning_msg "Removing existing nginx site: $link -> $TARGET";
          sudo rm $link;
          
        fi
    done

log_action_msg "Enabling new nginx site $NAME -> $SITE";

sudo ln -s $SITE "$NGINX_SITES/$NAME"

log_action_msg "Restarting nginx";

sudo /etc/init.d/nginx restart

log_action_msg "Done!";
