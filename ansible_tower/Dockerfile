# Ansible Tower Dockerfile
# Download ansible-tower-setup-bundle-latest.el7.tar.gz

FROM centos:7

MAINTAINER pedro.melopereira@vodafone.com

ENV ANSIBLE_TOWER_VER 3.1.1
ENV PG_DATA /var/lib/postgresql/9.4/main

ADD https://dl.fedoraproject.org/pub/epel/epel-release-latest-7.noarch.rpm /tmp/
COPY ansible-tower-setup-bundle-latest.el7.tar.gz /tmp/
COPY inventory /tmp/inventory
COPY selinux /etc/sysconfig
#COPY docker-entrypoint.sh /

RUN rpm -ivh /tmp/epel-release-latest-7.noarch.rpm && \
yum update -y && \
yum clean all && \
tar -xvf /tmp/ansible-tower-setup-bundle-latest.el7.tar.gz -C /opt && \
rm -rf /tmp/ansible-tower-setup-bundle-latest.el7.tar.gz && \
cd /opt/ansible-tower-setup-bundle-3.1.1-1.el7 && \
mv /tmp/inventory /opt/ansible-tower-setup-bundle-3.1.1-1.el7
#./setup.sh

VOLUME ${PG_DATA}
VOLUME /certs


#RUN chmod +x /docker-entrypoint.sh

EXPOSE 443 80

#ENTRYPOINT ["/docker-entrypoint.sh"]

#CMD ["ansible-tower"]
