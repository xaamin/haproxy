#!/bin/bash

HAPROXY="/etc/haproxy"
OVERRIDE="/data"

CONFIG="haproxy.cfg"
ERRORS="errors"

# Symlink errors directory
if [[ -d "$OVERRIDE/$ERRORS" ]]; then
  rm -fr "$ERRORS"
  ln -s "$OVERRIDE/$ERRORS" "$ERRORS"
fi

# Symlink config file
if [[ -f "$OVERRIDE/$CONFIG" ]]; then
  rm -f "$CONFIG"
  ln -s "$OVERRIDE/$CONFIG" "$CONFIG"
fi

# HAProxy PID and sock path
if [[ ! -d "/run/haproxy" ]]; then
  mkdir -p "/run/haproxy"
fi

# Run haproxy through Supervisor
/usr/bin/supervisord -n