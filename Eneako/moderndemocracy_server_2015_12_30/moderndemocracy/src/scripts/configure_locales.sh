#! /bin/sh
# ----------------------------------------------------------------------
# If the target install system is not configured for the default locale
# 'en_GB' then  sym linkks to this locale will need to be created.
# ----------------------------------------------------------------------
SCRIPTS=`dirname $(readlink -f $0)`;

. $SCRIPTS/common.sh


cd $APP_HOME;

DEFAULT_LOCALE="en_GB"

install_locale() {
  local NEW_LOCALE=$1
  
  if [ -d $APP_DATA ]; then
    local EMAIL_LINK=`find $APP_DATA/email -name "$NEW_LOCALE" 2> /dev/null`
    if [ -z $EMAIL_LINK ]; then
        log_action_msg "Creating email templates link $NEW_LOCALE --> $DEFAULT_LOCALE";
        `ln -s $DEFAULT_LOCALE $APP_DATA/email/$NEW_LOCALE`
    else 
        log_action_msg "Email locale $NEW_LOCALE already exists"
    fi
  
  fi
  
  if [ -d $APP_STATIC ]; then
    local STATIC_LINK=`find $APP_STATIC -name "$NEW_LOCALE" 2> /dev/null`
    if [ -z $STATIC_LINK ]; then
        log_action_msg "creating static link $NEW_LOCALE --> $DEFAULT_LOCALE";
        `ln -s $DEFAULT_LOCALE $APP_STATIC/$NEW_LOCALE`
    else 
        log_action_msg "Static locale $NEW_LOCALE already exists"
    fi
    
  fi
  
}


log_action_msg "Checking system locale";
THIS_LOCALE=`locale | grep LANGUAGE | grep -Eo "=.*:" | grep -Eo [a-zA-Z_]+`

if [ "$THIS_LOCALE" != "$DEFAULT_LOCALE" ]; then
  install_locale $THIS_LOCALE

fi


log_action_msg "Configuring common locales";

COMMON_LOCALES="en_US
en_MT
en_NZ
en_PH
en_ZA
en_IE
en_IN
en_AU
en_CA
en_SG"

for L in $COMMON_LOCALES 
do

  install_locale $L

done

cd $INITIAL_DIR;

log_action_msg "Done";

