#!/bin/sh
set -e
echo "Waiting for service to be ready for host $LISTENING_HOST on port $LISTENING_PORT ..."

while [ `nc -v  $LISTENING_HOST $LISTENING_PORT </dev/null ; echo $?` -eq 1 ]; do echo "waiting"; sleep 1; done

sleep 5

/usr/local/bin/run-all /opt/init/*.sh

