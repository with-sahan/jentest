#!/bin/bash
NOW=`date '+%Y-%m-%d %H:%M:%S'`;
SCRIPTS=`dirname $(readlink -f $0)`;

. $SCRIPTS/common.sh

configure_database

#---------------------------------------------------------------
# Configuration options
#---------------------------------------------------------------
SQL_SRC=`find $APP_HOME -type d -name sql`;
CSV_BASE=$APP_HOME/data/csv;
LOG_FILE=/tmp/load-base-data.log;

#---------------------------------------------------------------
# Drop all foreign key constraints to enable data load
#---------------------------------------------------------------
log_action_msg "$NOW DROPPING CONTSTRAINTS!"
executeSQLFile "$SQL_SRC/moderndemocracy.slammer.drop-constraints.sql"

log_action_msg "$NOW Loading base tables... "

#---------------------------------------------------------------
# Load all CSV in the $CSV_BASE directory
#---------------------------------------------------------------
FILES=`find $CSV_BASE -type f -name '*.csv'  -printf '%f\n' | sed 's/\..*//'`
for F in $FILES
do
    importCSV $F $CSV_BASE
done

#---------------------------------------------------------------
# set custom auto increment values now the base data is loaded
#---------------------------------------------------------------
log_action_msg "$NOW reseting sequences..."
executeSQLFile "$SQL_SRC/moderndemocracy.slammer.reset-sequences.sql"

#---------------------------------------------------------------
# now bring back the foreign key constraints
#---------------------------------------------------------------
log_action_msg "$NOW REINSTATING CONTSTRAINTS!"
executeSQLFile "$SQL_SRC/moderndemocracy.slammer.add-constraints.sql"


log_action_msg "$NOW Done";
