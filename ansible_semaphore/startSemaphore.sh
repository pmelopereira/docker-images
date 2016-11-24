#!/bin/bash
rm /run/mysqld/mysqld.sock.lock
mysqld --user=mysql &
waitForTcpPort.sh 3306
nohup semaphore -config /home/mysql/semaphore/semaphore_config.json > /tmp/semaphore.log & 2>&1
tail -f /tmp/semaphore.log