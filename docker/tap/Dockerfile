FROM images.opencadc.org/library/cadc-tomcat:1.3

LABEL org.opencontainers.image.source="https://github.com/lsst-sqre/tap-postgres"

RUN dnf update -y && dnf install -y zip unzip \
    && dnf clean all

RUN chmod -R go+rX /etc/tomcat

# Copy start wrapper script
ADD cadc-tomcat-start-readonly /usr/bin/cadc-tomcat-start-readonly
RUN chmod +x /usr/bin/cadc-tomcat-start-readonly

# Create a directory for WAR files
RUN mkdir -p /opt/tomcat-wars
ADD ../*.war /opt/tomcat-wars/

ENTRYPOINT ["/usr/bin/cadc-tomcat-start-readonly"]

