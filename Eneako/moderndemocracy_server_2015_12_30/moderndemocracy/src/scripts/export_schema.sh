#! /bin/bash
# ----------------------------------------------------------------------
# To use this script without having to type in password create a file
# called .pgpass in your home directory and add the following line:
#
# <hostname|ip>:<port>:*:<username>:<password>
# 
# e.g. localhost:5432:*:slammer:XXXXXXXXX
#
# ----------------------------------------------------------------------
SCRIPTS=`dirname $(readlink -f $0)`;

. $SCRIPTS/common.sh

configure_database

SCHEMA=$APP_USER;
WORKING_DIR="/tmp"
SCHEMA_FILE="$WORKING_DIR/$DATABASE.$SCHEMA.sql"
INDICIES_FILE="$WORKING_DIR/$DATABASE.$SCHEMA.indices.sql"
CONTRAINTS_FILE="$WORKING_DIR/$DATABASE.$SCHEMA.constraints.sql"

cd $WORKING_DIR;

log_action_msg "$NOW exporting base schema...";
`pg_dump -h $PG_HOST -U $APP_USER --quote-all-identifiers -s -O -n $SCHEMA $DATABASE > $SCHEMA_FILE`


cd $INITIAL_DIR;

log_action_msg "$NOW done";

