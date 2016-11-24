FROM oraclelinux:7.2

MAINTAINER Pedro Melo Pereira <pmelopereira@gmail.com>

# REQUIRED FILES TO BUILD THIS IMAGE
# ----------------------------------
# (1) oracle-xe-11.2.0-1.0.x86_64.rpm.zip from http://www.oracle.com/technetwork/database/database-technologies/express-edition/downloads/index.html
# ----------------------------------
# REFERENCES
# (a) http://blog.grid-it.nl/index.php/2014/05/16/installing-oracle-xe-in-a-docker-image/
# (b) https://github.com/MaksymBilenko/docker-oracle-xe-11g
# ----------------------------------
# Apex url: http://<ip>:49161/apexo
# Workspace: INTERNAL
# Username: ADMIN
# Password: oracle
# ----------------------------------
# Connection
# Username: sys
# Password: oracle
# Connection type: Basic
# Role: SYSDBA
# Hostname: <ip>
# Port: 1521
# Service name: xe

ADD Disk1 /tmp/
ADD init.ora /tmp
ADD initXETemp.ora /tmp
ADD entrypoint.sh /

# Prepare install
RUN yum update -y && \
yum install -y libaio bc net-tools deltarpm && \

# Change oracle password in response file
sed -i -- 's/<value required>/oracle/g' /tmp/response/xe.rsp && \

# Install the Oracle XE RPM
yum localinstall -y /tmp/oracle-xe-11.2.0-1.0.x86_64.rpm && \

# Move the init scripts
mv /tmp/init.ora /u01/app/oracle/product/11.2.0/xe/config/scripts/init.ora && \
mv /tmp/initXETemp.ora /u01/app/oracle/product/11.2.0/xe/config/scripts/initXETemp.ora && \

# Configure the database
/etc/init.d/oracle-xe configure responseFile=/tmp/response/xe.rsp && \

# Create entries for the database in the profile
echo 'export ORACLE_HOME=/u01/app/oracle/product/11.2.0/xe' >> /etc/profile.d/oracle_profile.sh && \
echo 'export PATH=$ORACLE_HOME/bin:$PATH' >> /etc/profile.d/oracle_profile.sh && \
echo 'export ORACLE_SID=XE' >> /etc/profile.d/oracle_profile.sh && \
chmod +x /etc/profile.d/oracle_profile.sh && \

# Change the root and oracle password to oracle
echo root:oracle | chpasswd && \
echo oracle:oracle | chpasswd && \

# Cleanup
yum clean all && \
rm -rf /tmp/*

# Expose ports 22, 1521 and 8080
EXPOSE 1521
EXPOSE 8080

ENTRYPOINT ["/entrypoint.sh"]