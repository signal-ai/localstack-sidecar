#!/bin/sh

set -e

pattern=$1

for script in ${pattern}; do
  if [ -f ${script} -a -x ${script} ]; then
    . ${script}
  fi
done
