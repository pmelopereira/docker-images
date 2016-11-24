FROM oraclelinux:7.2

MAINTAINER Pedro Melo Pereira <pmelopereira@gmail.com>

USER root

ENV LANG=en_US.UTF-8 \
    LANGUAGE=en_US.UTF-8 \
    LC_ALL=C

RUN yum update -y && \
        yum install -y \
        compat-libstdc++-33 \
        cpp \
        gcc \
        gcc-c++ \
        glibc-devel \
        glibc-headers \
        libaio \
        libaio-devel \
        make \
        sysstat \
        unzip \
    && yum clean all \
    && rm -rf /var/cache/yum/*

ARG OHS_VERSION=11.1.1.9.0

COPY ofm_webtier_linux_${OHS_VERSION}_64_disk1_1of1.zip /tmp/

RUN unzip /tmp/ofm_webtier_linux_${OHS_VERSION}_64_disk1_1of1.zip -d /tmp/ohs \
    && rm -f /tmp/ofm_webtier_linux_${OHS_VERSION}_64_disk1_1of1.zip

COPY ohs.rsp /tmp/
COPY oraInst.loc /etc/
COPY sysctl.conf /etc/


RUN mkdir -p /var/SP/weloadm/admin/ohs_inst1 \
    && mkdir -p /opt/SP/weloadm \
    && groupadd welo \
    && useradd -g welo -d /opt/SP/weloadm/home weloadm \
    && echo "weloadm:welo" | chpasswd \
    && chown -R weloadm:welo /tmp/ohs \
    && chown weloadm:welo /tmp/ohs.rsp \
    && chown weloadm:welo /etc/oraInst.loc \
    && chmod 664 /etc/oraInst.loc \
    && touch /etc/profile.d/ohs.sh \
    && chmod 0755 /etc/profile.d/ohs.sh \
    && echo "export ORACLE_INSTANCE=/var/SP/weloadm/admin/ohs_inst1" >> /etc/profile.d/ohs.sh \
    && mkdir -p /opt/SP/weloadm/home/deployment \
    && mkdir -p /opt/SP/weloadm/home/oraInventory \
    && mkdir -p /opt/SP/weloadm/product/fmw \
    && mkdir -p /opt/SP/weloadm/product/fmw/Web

COPY ohs.bashrc.dotfile /opt/SP/weloadm/home/.bashrc

RUN chown -R weloadm:welo /opt/SP \
    && chown -R weloadm:welo /var/SP

USER weloadm

ENV ORACLE_INSTANCE /var/SP/weloadm/admin/ohs_inst1

WORKDIR /tmp/ohs/Disk1

USER weloadm

RUN ./runInstaller -silent -waitforcompletion -force -ignoreSysPrereqs -response /tmp/ohs.rsp

WORKDIR /var/SP/weloadm/admin/ohs_inst1/bin

RUN ./opmnctl stopall

USER root

RUN rm -rf \
    /tmp/ohs \
    /tmp/ohs.rsp \
    /tmp/OraInstall* \
    /tmp/hsperfdata_oracle \
    /tmp/tmpInvPtrLoc*

COPY entrypoint.sh /opt/SP/weloadm/home

RUN chown weloadm:welo /opt/SP/weloadm/home/entrypoint.sh \
    && chmod +x /opt/SP/weloadm/home/entrypoint.sh

EXPOSE 7777

USER weloadm

ENV PATH /var/SP/weloadm/admin/ohs_inst1/bin:$PATH

ENTRYPOINT ["/opt/SP/weloadm/home/entrypoint.sh"]
