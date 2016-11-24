#!/bin/bash
# 
# This script will wait for a tcp port to become available
# There is no timeout!
#
port=$1
echo "Waiting for port $port to become available..."
while :
do
  (echo > /dev/tcp/localhost/$port) >/dev/null 2>&1
  available=$?
  if [[ $available -eq 0 ]]; then
    echo "port $port is now available. Proceeding..."
    break
  fi
  sleep 1
done