#!/bin/bash

HAPROXY="/usr/local/sbin/haproxy"
PIDFILE="/run/haproxy.pid"
CONFIG="/usr/local/etc/haproxy/haproxy.cfg"
if [ ! -f "$PIDFILE" ]
then
echo "waiting haproxy..."
exit 0
fi
read PIDS < /var/run/haproxy.pid; haproxy -f $CONFIG -p $PIDFILE -sf $PIDS && while ps -p $PIDS; do sleep 0.2; done
