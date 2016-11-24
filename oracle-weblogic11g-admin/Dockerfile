# LICENSE CDDL 1.0 + GPL 2.0
#
# ORACLE DOCKERFILES PROJECT
# --------------------------
# This Dockerfile extends an Oracle WebLogic image by creating a sample domain.
# Util scripts are copied into the image enabling users to plug NodeManager 
# magically into the AdminServer running on another container as a Machine.

# Pull base image
# ---------------
FROM pmelopereira/oracle-weblogic11g

# Maintainer
# ----------
MAINTAINER Pedro Melo Pereira <pmelopereira@gmail.com>

# WLS Admin Password (change it!)
# -------------------------------
ENV ADMIN_PASSWORD webl0gic

# WLS Ports
# ----------------------------------------------------------
ENV ADMIN_PORT 7001
ENV ADMIN_PORT_SSL 7002
ENV NM_PORT 5556

# Add files required to build this image
RUN mkdir -p /u01/oracle/scripts
COPY scripts/* /u01/oracle/scripts/

# Root commands
USER root
RUN ln -s /u01/oracle/weblogic/wlserver_10.3 /u01/oracle/weblogic/wlserver && \
    echo ". /u01/oracle/weblogic/user_projects/domains/base_domain/bin/setDomainEnv.sh" >> /root/.bashrc && \
    echo "export PATH=$PATH:/u01/oracle/weblogic/wlserver/server/bin:/u01/oracle/weblogic/wlserver/common/bin:/u01/oracle/weblogic/user_projects/domains/base_domain/bin" >> /root/.bashrc && \
    echo "export TERM=xterm" >> /root/.bashrc

# Configuration of WLS Domain
USER oracle
WORKDIR /u01/oracle/weblogic
RUN /u01/oracle/weblogic/wlserver/common/bin/wlst.sh -skipWLSModuleScanning /u01/oracle/scripts/create-wls-domain.py && \
    mkdir -p /u01/oracle/weblogic/user_projects/domains/base_domain/servers/AdminServer/security && \
    echo "username=weblogic" > /u01/oracle/weblogic/user_projects/domains/base_domain/servers/AdminServer/security/boot.properties && \ 
    echo "password=$ADMIN_PASSWORD" >> /u01/oracle/weblogic/user_projects/domains/base_domain/servers/AdminServer/security/boot.properties && \
    echo ". /u01/oracle/weblogic/user_projects/domains/base_domain/bin/setDomainEnv.sh" >> /u01/oracle/.bashrc && \ 
    echo "export PATH=$PATH:/u01/oracle/weblogic/wlserver/server/bin:/u01/oracle/weblogic/wlserver/common/bin:/u01/oracle/weblogic/user_projects/domains/base_domain/bin:/u01/oracle/scripts" >> /u01/oracle/.bashrc

COPY setDomainEnv.sh /u01/oracle/weblogic/user_projects/domains/base_domain/bin
COPY startWebLogic.sh /u01/oracle/weblogic/user_projects/domains/base_domain/bin

USER root
RUN chown oracle:oracle /u01/oracle/weblogic/user_projects/domains/base_domain/bin/setDomainEnv.sh && \
    chown oracle:oracle /u01/oracle/weblogic/user_projects/domains/base_domain/bin/startWebLogic.sh
USER oracle

# Expose Node Manager default port, and also default http/https ports for admin console
EXPOSE $NM_PORT $ADMIN_PORT $ADMIN_PORT_SSL

# Final setup
WORKDIR /u01/oracle

# Define default command to start bash. 
CMD ["startWebLogic.sh"]
