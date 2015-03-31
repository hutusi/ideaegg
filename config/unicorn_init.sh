#!/bin/sh
set -e
# Example init script, this can be used with nginx, too,
# since nginx and unicorn accept the same signals

# Feel free to change any of the following variables for your app:
TIMEOUT=${TIMEOUT-60}
APP_ROOT=/var/www/ideaegg/current
unicorn_pidfile="$APP_ROOT/tmp/pids/unicorn.pid"
unicorn_config="$APP_ROOT/config/unicorn.rb"
RAILS_ENV="production"
CMD="bundle exec unicorn_rails -D -c $unicorn_config -E $RAILS_ENV"
AS_USER=deploy
#INIT_CONF=$APP_ROOT/config/init.conf
action="$1"
set -u

#test -f "$INIT_CONF" && . $INIT_CONF

cd $APP_ROOT || exit 1

get_unicorn_pid()
{
  local pid=$(cat $unicorn_pidfile)
  if [ -z "$pid" ] ; then
    echo "Could not find a PID in $unicorn_pidfile"
    exit 1
  fi
  unicorn_pid=$pid
}

start()
{
  bundle exec unicorn_rails -D -c $unicorn_config -E $RAILS_ENV
}

stop()
{
  get_unicorn_pid
  kill -QUIT $unicorn_pid
}

reload()
{
  get_unicorn_pid
  kill -USR2 $unicorn_pid
}

case "$1" in
  start)
    start
    ;;
  stop)
    stop
    ;;
  reload)
    reload
    ;;
  *)
    echo "Usage: RAILS_ENV=your_env $0 {start|stop|reload}"
    ;;
esac

#
#
# old_pid="$PID.oldbin"
#
# cd $APP_ROOT || exit 1
#
# sig () {
# 	test -s "$PID" && kill -$1 `cat $PID`
# }
#
# oldsig () {
# 	test -s $old_pid && kill -$1 `cat $old_pid`
# }
#
# run () {
#   if [ "$(id -un)" = "$AS_USER" ]; then
#     eval $1
#   else
#     su -c "$1" - $AS_USER
#   fi
# }
#
# case $action in
# start)
#   echo >&2 "Starting....."
# 	# sig 0 && echo >&2 "Already running" && exit 0
# 	`$CMD`
# 	;;
# stop)
# 	sig QUIT && exit 0
# 	echo >&2 "Not running"
# 	;;
# force-stop)
# 	sig TERM && exit 0
# 	echo >&2 "Not running"
# 	;;
# restart|reload)
# 	sig USR2 && echo reloaded OK && exit 0
# 	echo >&2 "Couldn't reload, starting '$CMD' instead"
# 	`$CMD`
# 	;;
# upgrade)
# 	if sig USR2 && sleep 2 && sig 0 && oldsig QUIT
# 	then
# 		n=$TIMEOUT
# 		while test -s $old_pid && test $n -ge 0
# 		do
# 			printf '.' && sleep 1 && n=$(( $n - 1 ))
# 		done
# 		echo
#
# 		if test $n -lt 0 && test -s $old_pid
# 		then
# 			echo >&2 "$old_pid still exists after $TIMEOUT seconds"
# 			exit 1
# 		fi
# 		exit 0
# 	fi
# 	echo >&2 "Couldn't upgrade, starting '$CMD' instead"
# 	$CMD
# 	;;
# reopen-logs)
# 	sig USR1
# 	;;
# *)
# 	echo >&2 "Usage: $0 <start|stop|restart|upgrade|force-stop|reopen-logs>"
# 	exit 1
# 	;;
# esac
