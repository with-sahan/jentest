#! /bin/bash
SCRIPTS=`dirname $(readlink -f $0)`;
NOW=`date '+%Y-%m-%d %H:%M:%S'`;

. $SCRIPTS/common.sh

configure_java

CLASS="com.anaeko.slam.utils.SourceToJSON";

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
#Execute export
#=============================================================
$JAVA_HOME/bin/java -cp $CPATH $OPTS $CLASS $COMMANDLINE ${*}

exit 0;
