FROM mysql

COPY startSemaphore.sh /usr/local/bin
COPY waitForTcpPort.sh /usr/local/bin

#update
RUN apt-get clean && \
apt-get update && \
apt-get install -y curl

#install
RUN mkdir -p /home/mysql && \
curl -L https://github.com/ansible-semaphore/semaphore/releases/download/v2.0.4/semaphore_linux_386 > /usr/bin/semaphore && \
chown mysql /home/mysql && \
chown -R mysql /var/lib/mysql && \
chgrp -R mysql /var/lib/mysql && \
chmod +x /usr/bin/semaphore && \
chmod +x /usr/local/bin/startSemaphore.sh && \
chmod +x /usr/local/bin/waitForTcpPort.sh

USER mysql