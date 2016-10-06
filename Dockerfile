FROM tomcat:8.0.36
ENV TOMCAT_VERSION 8.0.36

# Fix sh
RUN rm /bin/sh && ln -s /bin/bash /bin/sh

# Remove garbage
RUN rm -rf /usr/local/tomcat/webapps/examples
RUN rm -rf /usr/local/tomcat/webapps/docs
#RUN rm -rf /usr/local/tomcat/webapps/ROOT

# Add admin/admin user
ADD tomcat-users.xml /usr/local/tomcat/conf/

# Update logging file
RUN echo "org.apache.jasper.servlet.TldScanner.level = FINE" >> /usr/local/tomcat/conf/logging.properties
RUN echo "org.apache.catalina.core.ContainerBase.[Catalina].level = INFO" >> /usr/local/tomcat/conf/logging.properties
RUN echo "org.apache.catalina.core.ContainerBase.[Catalina].handlers = java.util.logging.ConsoleHandler" >> /usr/local/tomcat/conf/logging.properties

ENV CATALINA_OPTS "-Xms768m -Xmx1024m -XX:MaxPermSize=512m"
EXPOSE 8090
EXPOSE 8009

COPY transmart.war /usr/local/tomcat/webapps/

#ENTRYPOINT ["/usr/local/tomcat/bin/catalina.sh", "start"]

### OLD ENTRYPOINT
RUN apt-get -y update && apt-get -y install nginx
RUN echo "daemon off;" >> /etc/nginx/nginx.conf

RUN apt-get -y install ruby && gem install tiller

#ADD data/tiller /etc/tiller

#RUN DEBIAN_FRONTEND=noninteractive apt-get install -y less

#ENTRYPOINT ["/usr/local/bin/tiller" , "-v"]
######

# FOLLOWING IS FOR TESTING PURPOSES ONLY
# runit depends on /etc/inittab which is not present in debian:jessie
RUN touch /etc/inittab
RUN apt-get update && DEBIAN_FRONTEND=noninteractive apt-get install -y -q runit

RUN mkdir -p /etc/service/tiller
RUN echo "#!/bin/bash" >> /etc/service/tiller/run
RUN echo "source /etc/envars" >> /etc/service/tiller/run
RUN echo "exec /usr/local/bin/tiller -v" >> /etc/service/tiller/run

RUN echo "#!/bin/bash" >> /usr/sbin/runit_bootstrap
RUN echo "export > /etc/envars" >> /usr/sbin/runit_bootstrap
RUN echo "exec /usr/sbin/runsvdir-start" >> /usr/sbin/runit_bootstrap
RUN chmod 755 /usr/sbin/runit_bootstrap
ENTRYPOINT ["/usr/sbin/runit_bootstrap"]
