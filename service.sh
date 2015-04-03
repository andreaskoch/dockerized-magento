#!/bin/sh

### BEGIN INIT INFO
# Provides:          scriptname
# Required-Start:    $network $remote_fs $syslog
# Required-Stop:     $network $remote_fs $syslog
# Default-Start:     2 3 4 5
# Default-Stop:      0 1 6
# Short-Description: Start magento-ce-1-9 at boot time
### END INIT INFO

set -e

export PATH=/sbin:/bin:/usr/sbin:/usr/bin:/usr/local/sbin:/usr/local/bin

SCRIPTNAME=`basename $0`
SCRIPTPATH=$(readlink -f "$0")
PROJECTPATH=$(dirname "$SCRIPTPATH")
LOGFILEPATH="/var/log/$SCRIPTNAME.log"

start() {
    echo "$(date) starting" | tee -a $LOGFILEPATH
    (cd $PROJECTPATH; docker-compose up -d) | tee -a $LOGFILEPATH 2>&1
    echo "$(date) started" | tee -a $LOGFILEPATH
}

stop() {
    echo "$(date) stopping" | tee -a $LOGFILEPATH
    (cd $PROJECTPATH; docker-compose stop) | tee -a $LOGFILEPATH 2>&1
    echo "$(date) stopped" | tee -a $LOGFILEPATH
}

status() {
    echo "$(date) status" | tee -a $LOGFILEPATH
    (cd $PROJECTPATH; docker-compose ps) | tee -a $LOGFILEPATH 2>&1
}

restart() {
    echo "$(date) restarting" | tee -a $LOGFILEPATH
    (stop; sleep 2; start)
    echo "$(date) restarted" | tee -a $LOGFILEPATH
}

update() {
    echo "$(date) updating" | tee -a $LOGFILEPATH
	(cd $PROJECTPATH; docker-compose pull) | tee -a $LOGFILEPATH 2>&1
    echo "$(date) up-tp-date" | tee -a $LOGFILEPATH
}

case "$1" in
    start)
    start
    ;;

    restart)
    restart
    ;;

    stop)
    stop
    ;;

    status)
    status
    ;;

    update)
    update
    ;;

    *)
    echo "usage : $0 start|restart|stop|status|update"
    ;;
esac

exit 0
