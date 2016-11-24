# This is the Dockerfile for a default installation for Oracle WebLogic Server 11g (10.3.6) Generic Distribution
# 
# IMPORTANT
# -----------------------------------------
# The resulting image of this Dockerfile DOES NOT contain a WLS Domain.
# For that, you must to create a domain on a new inherited image.
#
# REQUIRED FILES TO BUILD THIS IMAGE
# -----------------------------------------
# (1) wls1036_generic.jar (Oracle WebLogic Server 10.3.6 Generic Installer)

# Pull base image
# ---------------
FROM pmelopereira/oracle-jdk7

# Maintainer
# ----------
MAINTAINER Pedro Melo Pereira <pmelopereira@gmail.com>

# Add files required to build this image
RUN mkdir -p /u01/oracle/scripts
COPY scripts/* /u01/oracle/scripts/

# Environment variables required for this build (do NOT change)
# -------------------------------------------------------------
ENV WLS_PKG wls1036_generic.jar
ENV JAVA_HOME /usr/java/default

# Setup required packages (unzip), filesystem, and oracle user
# ------------------------------------------------------------
RUN chmod -R a+xr /u01 && \
    useradd -b /u01 -m -s /bin/bash oracle 

# Copy packages
COPY $WLS_PKG /u01/
COPY wls-silent.xml /u01/

USER root
RUN yum update -y && \
	yum install -y unzip less libXtst libXrender xhost tar

# Change the open file limits in /etc/security/limits.conf
RUN sed -i '/.*EOF/d' /etc/security/limits.conf && \
    echo "* soft nofile 16384" >> /etc/security/limits.conf && \ 
    echo "* hard nofile 16384" >> /etc/security/limits.conf && \ 
    echo "# EOF"  >> /etc/security/limits.conf

# Change the kernel parameters that need changing.
RUN echo "net.core.rmem_max=4192608" > /u01/oracle/.sysctl.conf && \
    echo "net.core.wmem_max=4192608" >> /u01/oracle/.sysctl.conf && \ 
    sysctl -e -p /u01/oracle/.sysctl.conf

# Adjust file permissions, go to /u01 as user 'oracle' to proceed with WLS installation
RUN chown oracle:oracle -R /u01
WORKDIR /u01
USER oracle

# Installation of WebLogic 
RUN java -jar $WLS_PKG -mode=silent -silent_xml=/u01/wls-silent.xml && \ 
	rm $WLS_PKG /u01/wls-silent.xml 

WORKDIR /u01/oracle/

ENV PATH $PATH:/u01/oracle/weblogic/wlserver_10.3/server/bin:/u01/oracle/weblogic/user_projects/domains/base_domain/bin:/u01/oracle/scripts

COPY nodemanager.domains /u01/oracle/weblogic/wlserver_10.3/common/nodemanager/
COPY commEnv.sh /u01/oracle/weblogic/wlserver_10.3/common/bin/
USER root
RUN chown oracle:oracle /u01/oracle/weblogic/wlserver_10.3/common/nodemanager/nodemanager.domains && \
    chown oracle:oracle /u01/oracle/weblogic/wlserver_10.3/common/bin/commEnv.sh
USER oracle

# Define default command to start bash. 
CMD ["bash"]
