#! /bin/bash
SCRIPTS=`dirname $(readlink -f $0)`;
NOW=`date '+%Y-%m-%d %H:%M:%S'`;

. $SCRIPTS/common.sh

configure_java


CLASS="com.anaeko.slam.utils.CreateTenant";

#=============================================================
#Define Runtime variables
#=============================================================
#OPTS="$OPTS -Xms128m";
#OPTS="$OPTS -Xmx512m";

#=============================================================
#Define Application Command line options (default is none)
#=============================================================
COMMANDLINE="jdbc.skip.conn.tests=true";
COMMANDLINE="$COMMANDLINE jdbc.pool.provider=com.anaeko.utils.jdbc.Tomcat";
COMMANDLINE="$COMMANDLINE jdbc.driver=org.postgresql.Driver";
COMMANDLINE="$COMMANDLINE jdbc.url=jdbc:postgresql://localhost:5432/moderndemocracy?autoReconnect=true";
COMMANDLINE="$COMMANDLINE jdbc.user=slammer";
COMMANDLINE="$COMMANDLINE jdbc.password=Smokingu+0020Mustela"

$JAVA_HOME/bin/java -cp $CPATH $OPTS $CLASS $COMMANDLINE ${*}

exit 0;
