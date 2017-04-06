#! /bin/sh
# ----------------------------------------------------------------------
# To use psql on ubuntu your local systems user name must be the same
# as the PostgreSQL user.
#
# For this script you'll probably want the default admin user: postgres
#
# Run this script like so...
#
#   sudo -u postgres create_db.sh
#
# On the plus side this way you won't need to know the database password
# if you have local SUDO privileges
# ----------------------------------------------------------------------
SCRIPTS=`dirname $(readlink -f $0)`;

. $SCRIPTS/common.sh

configure_database

ROOT_PASS=":M0b1l1ty";
ENCODING="UTF8"
WORKING_DIR="/tmp"

cd $WORKING_DIR;

log_action_msg "$NOW Setting 'root' users password...";
`sudo -u postgres psql -e -c "ALTER USER $SUPER_USER WITH ENCRYPTED PASSWORD '$ROOT_PASS'" 1>> /tmp/create_db.log 2>&1`

log_action_msg "$NOW Cleaning existing...";
`sudo -u postgres psql -e -c "DROP DATABASE IF EXISTS $DATABASE" 1>> /tmp/create_db.log 2>&1`

`sudo -u postgres psql -e -c "DROP USER IF EXISTS $APP_USER" 1>> /tmp/create_db.log 2>&1`

log_action_msg "$NOW Creating user: $APP_USER";
`sudo -u postgres psql -e -c "CREATE ROLE $APP_USER WITH LOGIN PASSWORD '$APP_PASS'" 1>> /tmp/create_db.log 2>&1`

log_action_msg "$NOW Forcing user $APP_USER to use UTC timezone as default";
`sudo -u postgres psql -e -c "ALTER ROLE $APP_USER SET timezone TO 'UTC'" 1>> /tmp/create_db.log 2>&1`

log_action_msg "$NOW Creating database: $DATABASE";
`sudo -u postgres psql -e -c "CREATE DATABASE $DATABASE WITH OWNER $APP_USER ENCODING '$ENCODING'" 1>> /tmp/create_db.log 2>&1`

log_action_msg "$NOW Forcing database $DATABASE to use UTC timezone as default";
`sudo -u postgres psql -e -c "ALTER DATABASE $DATABASE SET timezone TO 'UTC'" 1>> /tmp/create_db.log 2>&1`


cd $INITIAL_DIR;

log_action_msg "$NOW done";

