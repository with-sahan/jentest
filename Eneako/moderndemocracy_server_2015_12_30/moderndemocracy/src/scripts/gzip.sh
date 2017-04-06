#! /bin/sh
# ----------------------------------------------------------------------
# GZIP all of the files in a static directory, leaving the original file
# intact.
#
# parameter
# ----------------------------------------------------------------------

LOWER_LIMIT=2048
STATIC_DIR=${1:-"../static/en_GB"};
SCRIPT_DIR=`dirname $(readlink -f $0)`;

if [ -f /lib/lsb/init-functions ]; then
    . /lib/lsb/init-functions
else
    . $SCRIPT_DIR/lsb_shim.sh
fi

gzip_all() {
	
	for f in `ls $1/$2`
	do
		
		SIZE=$(stat -c%s "$f");
		
		if [ -d $f ]; then
		
			log_action_msg "skipping directory $f";
		
		elif [ -h $f ]; then
		
			log_action_msg "skipping symlink $f";
		
		elif [ "$SIZE" -gt $LOWER_LIMIT ]; then
		
			log_action_msg "gzip $f";
			gzip -c $f > "$f.gz";
		
		else 
		
			log_action_msg "skipping small file $f";
		
		fi
			
	done
}

if [ -z "$STATIC_DIR" ]; then

	log_error_msg "$NOW could not find static directory: $STATIC_DIR";
	exit 1;

fi

log_action_msg "$NOW gzipping files in $STATIC_DIR";

gzip_all $STATIC_DIR "*.html";

if [ -e "$STATIC_DIR/styles" ]; then
	gzip_all "$STATIC_DIR/styles" "*.css";
fi

if [ -e "$STATIC_DIR/scripts" ]; then
	gzip_all "$STATIC_DIR/scripts" "*.js";
fi

log_action_msg "$NOW done";


exit 0;
