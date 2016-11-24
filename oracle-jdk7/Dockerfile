FROM oraclelinux:7.2

MAINTAINER Pedro Melo Pereira <pedro.melo.pereira@celfocus.com>

ENV JAVA_VERSION=7 \
    JAVA_UPDATE=79 \
    JAVA_BUILD=15

RUN curl --silent --location --remote-name --cookie "oraclelicense=a" http://download.oracle.com/otn-pub/java/jdk/${JAVA_VERSION}u${JAVA_UPDATE}-b${JAVA_BUILD}/jdk-${JAVA_VERSION}u${JAVA_UPDATE}-linux-x64.rpm \
    && rpm -ivh jdk-${JAVA_VERSION}u${JAVA_UPDATE}-linux-x64.rpm \
    && rm jdk-${JAVA_VERSION}u${JAVA_UPDATE}-linux-x64.rpm

ENV JAVA_HOME=/usr/java/jdk1.${JAVA_VERSION}.0_${JAVA_UPDATE}/jre/bin/java \
    PATH=${PATH}:${JAVA_HOME}/bin

COPY java.security /usr/java/jdk1.${JAVA_VERSION}.0_${JAVA_UPDATE}/jre/lib/security/

ENV JAVA_VERSION="" \
    JAVA_UPDATE="" \
    JAVA_BUILD=""