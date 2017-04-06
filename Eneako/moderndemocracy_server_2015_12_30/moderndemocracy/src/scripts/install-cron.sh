#! /bin/bash
SCRIPTS=`dirname $(readlink -f $0)`;

. $SCRIPTS/common.sh

# =============================================================================
# default to the current user
# =============================================================================
CURRENT_USER=`id -un`;
CRON_USER=${1:-$CURRENT_USER};

# =============================================================================
# Check scripts are executable (can sometimes mess up cron)
# =============================================================================
JOB_SCRIPT=`find $APP_HOME -name run-job.sh`
KPI_SCRIPT=`find $APP_HOME -name load-kpis.sh`

chmod ugo+x $JOB_SCRIPT
chmod ugo+x $KPI_SCRIPT

#==============================================================================
# Clear out existing crontabs for the $USER
#==============================================================================
log_action_msg "Clearing existing cron jobs for user: $CRON_USER";
crontab -u $CRON_USER -r;
checkResult "Failed to clear existing cron jobs for user $CRON_USER" "Cron jobs cleared [OK]"

#==============================================================================
# Add configured crontabs
#==============================================================================
log_action_msg "Installing cron jobs defined in $APP_HOME/etc/crontabs for user: $CRON_USER";
crontab -u $CRON_USER  $APP_CONFIG/crontabs;
checkResult "Failed to install cron jobs for user $CRON_USER" "Cron jobs installed [OK]"

exit 0;
