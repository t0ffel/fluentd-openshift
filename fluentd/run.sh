#!/bin/bash

if [[ $VERBOSE ]]; then
  set -ex
  fluentdargs="-vv"
else
  set -e
  fluentdargs=
fi

IPADDR4=`/usr/sbin/ip -4 addr show dev eth0 | grep inet | sed -e "s/[ \t]*inet \([0-9.]*\).*/\1/"`
IPADDR6=`/usr/sbin/ip -6 addr show dev eth0 | grep inet6 | sed "s/[ \t]*inet6 \([a-f0-9:]*\).*/\1/"`
export IPADDR4 IPADDR6

exec fluentd $fluentdargs -c /etc/fluent/entrypoint/fluent.conf
