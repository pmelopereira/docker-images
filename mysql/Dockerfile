FROM oraclelinux:7.2

COPY selinux /etc/sysconfig
COPY mysql57-community-release-el7-9.noarch.rpm /tmp
COPY my.cnf /etc
COPY yum.conf /etc

#dependencies
RUN yum update -y

RUN rpm -ivh /tmp/mysql57-community-release-el7-9.noarch.rpm && \
yum install -y mysql mysql-server mysql-devel

COPY yum.original.conf /etc/yum.conf

USER mysql

RUN mysqld --initialize	

#start mysql
ENTRYPOINT ["bash", "-c", "(mysqld &) && tail -f /var/log/mysqld.log"]