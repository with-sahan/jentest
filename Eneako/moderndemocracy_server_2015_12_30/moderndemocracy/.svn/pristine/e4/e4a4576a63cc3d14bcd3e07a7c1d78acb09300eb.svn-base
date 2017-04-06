#! /bin/sh
NAME="moderndemocracy";                                  #a UNIQUE name for the product/deployment
NOW=`date '+%Y-%m-%d %H:%M:%S'`;                         #timestamp start of script execution
APP_LOG_FILE="console.log"                               #Set the name of the log file (full path)

#---------------------------------------------------------------
# Find the directory of the running script or exit
#---------------------------------------------------------------
CURRENT_SCRIPT_DIR=`dirname $(readlink -f $0)`;
SCRIPT_DIR=${SCRIPT_DIR:-"$CURRENT_SCRIPT_DIR"};

if [ -f /lib/lsb/init-functions ]; then
    . /lib/lsb/init-functions
else
    . $SCRIPT_DIR/lsb_shim.sh
fi


if [ -d "$SCRIPT_DIR" ]; then
    log_action_msg  "Using script directory $SCRIPT_DIR as base for configuration"
else
    log_failure_msg "Failed to find the directory of the script, if this is not a debian based Linux try setting the SCRIPT_DIR environment variable"
fi

#---------------------------------------------------------------
# Find the key directories and configuration files
#---------------------------------------------------------------
INITIAL_DIR=$PWD;
cd $SCRIPT_DIR;
APP_HOME=$SCRIPT_DIR;                            #root path for deployment
APP_CONFIG="$APP_HOME/etc"                       #main configuration directory

while ([ ! -d "$APP_CONFIG" ])
do
    cd "$APP_HOME/../";
    APP_HOME=$PWD;
    if [ "/" = $APP_HOME ] || [ "/home" = $APP_HOME ]; then
        log_failure_msg "Could not find main service configuration directory 'etc'";
        cd $INITIAL_DIR;
        exit 2;
    fi
    APP_CONFIG="$APP_HOME/etc"
done

log_action_msg "Using config directory $APP_CONFIG";

APP_SYSTEM="${APP_HOME}/.runtime"                                #runtime directory
APP_DATA=`find $PWD -type d -name data | grep -v '/static/'`     #data directory
APP_STATIC=`find $PWD -type d -name static | grep -v en_`        #static file directory
APP_LIB=`find $PWD -type d -name lib -not -path "*src/static/*"` #lib directory

if [ ! -d "$APP_LIB" ]; then
 log_failure_msg "Failed to find required java lib directory:  $APP_LIB";
 exit 2;
fi

log_action_msg "Using static file root directory $APP_STATIC";
log_action_msg "Using lib directory $APP_LIB";

cd $INITIAL_DIR;

#---------------------------------------------------------------
# Configure database
#---------------------------------------------------------------
configure_database(){
	JDBC_CONFIG=$APP_CONFIG/jdbc.properties

	if [ -f $JDBC_CONFIG ]; then
	  log_action_msg "Loading database configuration from: $JDBC_CONFIG"
	else
	  JDBC_CONFIG=$APP_CONFIG/$NAME.properties
	  log_action_msg "Loading database configuration from: $JDBC_CONFIG"
	fi

	DATABASE=`grep "jdbc.url" $JDBC_CONFIG | grep -Eo "[0-9]+/[a-zA-Z]+" | grep -Eo "[a-zA-Z]+"`
	PG_PORT=`grep "jdbc.url" $JDBC_CONFIG | grep -Eo ":[0-9]+" | grep -Eo "[^:]+"`
	PG_HOST=`grep "jdbc.url" $JDBC_CONFIG | grep -Eo "//([a-zA-Z]+)[:/]{1}" | grep -Eo "([a-zA-Z]+)"`
	APP_USER=`grep "jdbc.user" $JDBC_CONFIG | grep -Eo "=[a-zA-Z]+" | grep -Eo [a-zA-Z]+`;
	APP_PASS=`grep "jdbc.password" $JDBC_CONFIG | grep -Eo "=.+$" | grep -Eo "[^=]+"`;
	SUPER_USER="postgres";

	if [ ! -n "$APP_USER" ]; then
	  log_failure_msg "Could not read the postgres user name from file $JDBC_CONFIG"
	  exit 1

	else
	  log_action_msg "Using postgres user: $APP_USER on host: $PG_HOST"

	fi
}

#---------------------------------------------------------------
# Bail-out function
#
# @param error message
# @param success message (optional)
#---------------------------------------------------------------
checkResult() {
  local code=$?;
    if [ ! 0 -eq $code ]; then
        log_failure_msg $1
        exit $code;
    else
        log_action_msg ${2:-"[OK]"}
    fi
}

#---------------------------------------------------------------
# Configure application CLASSPATH for java
#---------------------------------------------------------------
configure_classpath(){

	CPATH=./:${APP_CONFIG}:${APP_SYSTEM}

	if [ -d "$APP_STATIC" ]; then
	  CPATH="${CPATH}:${APP_STATIC}";
	fi
	if [ -d "$APP_DATA" ]; then
	  CPATH="${CPATH}:${APP_DATA}";
	fi

	if [ -d "${APP_HOME}/target/classes" ]; then
	  CPATH="${CPATH}:${APP_HOME}/target/classes/";
	fi

	for jar in `find $APP_LIB -name *.jar`;
	do
	  CPATH="${CPATH}:${jar}";
	done

	for src_dir in `find $APP_LIB -type d`;
	do
	  CPATH="${CPATH}:${src_dir}/";
	done

	JAVASCRIPT_DIR=`find $APP_HOME -type d -name javascript | grep "src/javascript"`;
	if [ -d "$JAVASCRIPT_DIR" ]; then
	  CPATH="${CPATH}:${JAVASCRIPT_DIR}";
	fi

	for dir in `find $APP_HOME -type d -name tests`;
	do
	  CPATH="${CPATH}:${dir}";

	  for subdir in `find $dir  -maxdepth 1 -mindepth 1 -type d -name "[a-zA-Z]*"`;
	  do
		 CPATH="${CPATH}:${subdir}";
	  done

	done
}

#---------------------------------------------------------------
# Configure Java PATH
#---------------------------------------------------------------
configure_java() {
    log_action_msg "Configuring Java..."

	configure_classpath

    local LIB_JVM="/usr/lib/jvm"

    if [ ! -d "$JAVA_HOME" ]; then
      for j in `ls -1 $LIB_JVM | grep -v common | grep -E "java-(1.)?7"`
      do

        if [ -d "$LIB_JVM/$j" ]; then
          JAVA_HOME="$LIB_JVM/$j"
          break;
        fi
      done
    fi

    if [ ! -d "$JAVA_HOME" ]; then
      for j in `ls -1 $LIB_JVM | grep -v common | grep -E 'java-(1.)?6'`
      do

        if [ -d "$LIB_JVM/$j" ]; then
          JAVA_HOME="$LIB_JVM/$j"
          break;
        fi
      done
    fi

    if [ ! -d "$JAVA_HOME" ]; then
      t=/opt/java && test -d $t && JAVA_HOME=$t
    fi

    if [ ! -d "$JAVA_HOME" ]; then
        log_failure_msg "Could not find Java, set JAVA_HOME environment variable or install Java if necessary"
        exit 1;
    fi

    local PATH_OK=`echo $PATH | grep -c $JAVA_HOME`

    if [ ! $PATH_OK -eq 1 ]; then
        PATH=$JAVA_HOME/bin:$PATH;
    fi

    COMMAND=`which java`
    log_action_msg "$NOW Using java installation found here: $COMMAND"

    local CURRENT_USER=`id -un`
    if [ "root" = "$CURRENT_USER" ]; then
        touch /tmp
        chmod 01777 /tmp
    fi
}

#---------------------------------------------------------------
# executeSQL function
#---------------------------------------------------------------
executeSQL() {

  if [ -z $APP_USER ]; then
	log_failure_msg "Database not configured, call configure_database() ";
	exit 3;
  fi

  log_action_msg "$NOW executing: psql -U $APP_USER -h $PG_HOST -d $DATABASE -tEA -c \"$1\" " >> $LOG_FILE;
  SQL_OUTPUT=`psql -U $APP_USER -h $PG_HOST -d $DATABASE -tEA -c "$1" 1>> $LOG_FILE 2>&1 `;
  log_action_msg "$SQL_OUTPUT";
  checkResult "$NOW Failed to execute SQL: $1 on database: $DATABASE";
}

#---------------------------------------------------------------
# executeSQLFile function
#---------------------------------------------------------------
executeSQLFile() {

	if [ -z $APP_USER ]; then
	  log_failure_msg "Database not configured, call configure_database() ";
	  exit 3;
	fi

    log_action_msg "$NOW executing: psql -U $SUPER_USER -h $PG_HOST -p $PG_PORT -d $DATABASE -E -f $1 " >> $LOG_FILE;
    SQL_OUTPUT=`psql -U $SUPER_USER -h $PG_HOST -p $PG_PORT -d $DATABASE -E -f $1 1>> $LOG_FILE 2>&1 `;
    log_action_msg "$SQL_OUTPUT";
    checkResult "$NOW Failed to execute SQL file: $1 on database: $DATABASE";
}

#---------------------------------------------------------------
# importCSV function
#
# parameters: sql_source_directory, sql_file_name
#---------------------------------------------------------------
importCSV() {

	if [ -z $APP_USER ]; then
	  log_failure_msg "Database not configured, call configure_database() ";
	  exit 3;
    fi

    cp -f "$2/$1.csv" /tmp/ 2> /dev/null
    CSV="/tmp/$1.csv"
    SQL="/tmp/$1.sql"
    HEADER=`head -1 $CSV`;
    log_action_msg "read header from $1: $HEADER";

    echo "-- --------------------------------" > $SQL
    echo "-- Temporary auto-generated script " >> $SQL
    echo "-- --------------------------------" >> $SQL
    echo "" >> $SQL
    echo "SET search_path = \"slammer\";" >> $SQL
    echo "" >> $SQL
    echo "BEGIN;" >> $SQL
    echo "" >> $SQL
    echo "TRUNCATE \"$1\";" >> $SQL
    echo "" >> $SQL
    echo "COPY \"$1\" ($HEADER) FROM '$CSV' WITH CSV HEADER NULL as 'NULL';"  >> $SQL
    echo ""  >> $SQL
    echo "COMMIT;" >> $SQL
    echo ""  >> $SQL

    cd /tmp;
    log_action_msg "$NOW executing: psql -U $SUPER_USER -h $PG_HOST -p $PG_PORT -d $DATABASE -E -f $SQL " >> $LOG_FILE;
    `psql -U $SUPER_USER -h $PG_HOST -p $PG_PORT -d $DATABASE -E -f $SQL 1>> $LOG_FILE 2>&1`;

    echo $LOG_FILE
    cat $LOG_FILE

    checkResult "$NOW $1 failed. CSV data load from: $CSV using SQL: $SQL unsuccessful, check output file: $LOG_FILE" "$NOW -> $1 [OK]";

    cd $CURRENT_DIR;
}
