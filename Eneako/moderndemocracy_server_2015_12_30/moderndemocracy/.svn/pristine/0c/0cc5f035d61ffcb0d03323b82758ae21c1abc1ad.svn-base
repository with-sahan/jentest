#! /bin/bash
SCRIPTS=`dirname $(readlink -f $0)`;
NOW=`date '+%Y-%m-%d %H:%M:%S'`;

. $SCRIPTS/common.sh

configure_database
configure_java

log_action_msg "$NOW Executing Job... "

CLASS="com.anaeko.slam.cron.Job";

#=============================================================
#Define Runtime variables
#=============================================================
#OPTS="$OPTS -Xms128m";
#OPTS="$OPTS -Xmx512m";

#=============================================================
#Define Application Command line options (default is none)
#=============================================================
COMMANDLINE="";

#=============================================================
#Fetch tenant list
#=============================================================
TENANTS=`psql -U $APP_USER -h $PG_HOST -p $PG_PORT -d $DATABASE -tEA -c "SELECT DISTINCT T.id FROM tenants T INNER JOIN users U ON U.tenant = T.id WHERE U.status >= 10 AND U.status < 100"`;

for T in $TENANTS
do

  NOW=`date '+%Y-%m-%d %H:%M:%S'`
  log_action_msg "$NOW starting tenant: $T"

  $JAVA_HOME/bin/java -cp $CPATH $OPTS $CLASS $COMMANDLINE tenant=$T ${*}

  NOW=`date '+%Y-%m-%d %H:%M:%S'`
  log_action_msg "$NOW finished tenant: $T"

done

exit 0;
