#! /bin/bash
# ----------------------------------------------------------------------
# To use this script without having to type in password create a file
# called .pgpass in your home directory and add the following line:
#
# <hostname|ip>:<port>:*:<username>:<password>
#
# e.g. localhost:5432:*:slammer:XXXXXXXX
#
# ----------------------------------------------------------------------
SCRIPTS=`dirname $(readlink -f $0)`;

. $SCRIPTS/common.sh

configure_database

SCHEMA=$APP_USER;
SCHEMA_SRC=`find $APP_HOME -name "$DATABASE.$SCHEMA.sql"`

WORKING_DIR="/tmp"
SQL="$WORKING_DIR/$DATABASE.$SCHEMA.sql"

cp $SCHEMA_SRC $WORKING_DIR;

cd $WORKING_DIR;

log_action_msg "$NOW Clearing existing schema...";
`psql -U $APP_USER -h localhost -d $DATABASE -e -c "DROP SCHEMA IF EXISTS $SCHEMA CASCADE" 1>> /tmp/create_schema.log 2>&1`

log_action_msg "$NOW Creating schema: $SCHEMA";
`psql -U $APP_USER -h localhost -d $DATABASE -e -f $SQL 1>> /tmp/create_schema.log 2>&1`;

log_action_msg "$NOW updating search path for user: $APP_USER";
`psql -U $APP_USER -h localhost -d $DATABASE -e -c "ALTER ROLE $APP_USER SET search_path=$SCHEMA" 1>> /tmp/create_schema.log 2>&1`;

log_action_msg "$NOW switching to superuser: $SUPER_USER";
log_action_msg "$NOW dropping 'public' schema, if it exists";
`psql -U $SUPER_USER -h localhost -d $DATABASE -e -c "DROP SCHEMA IF EXISTS public CASCADE" 1>> /tmp/create_schema.log 2>&1`;

cd $INITIAL_DIR;

log_action_msg "$NOW done";

