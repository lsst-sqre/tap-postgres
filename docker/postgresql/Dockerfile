FROM centos:7

ADD pgsphere10-1.1.5-2.el7.centos.x86_64.rpm /tmp

# install required software
RUN yum update -y
RUN yum install -y https://dl.fedoraproject.org/pub/epel/epel-release-latest-7.noarch.rpm && rpm --import /etc/pki/rpm-gpg/RPM-GPG-KEY-EPEL-7
RUN yum install -y https://download.postgresql.org/pub/repos/yum/reporpms/EL-7-x86_64/pgdg-redhat-repo-latest.noarch.rpm && rpm --import /etc/pki/rpm-gpg/RPM-GPG-KEY-PGDG

RUN yum -y install postgresql10-server-10.9-1PGDG.rhel7 postgresql10-contrib-10.9-1PGDG.rhel7 postgresql10-devel-10.9-1PGDG.rhel7
RUN yum localinstall -y /tmp/pgsphere10-1.1.5-2.el7.centos.x86_64.rpm
RUN yum clean all

RUN mkdir -p /logs
COPY src/init/* /var/lib/pgsql/10/
ADD ./tap-schema/* /docker-entrypoint-initdb.d/

COPY src/cadc-dev-postgresql-start /usr/bin/
CMD ["/usr/bin/cadc-dev-postgresql-start"]

