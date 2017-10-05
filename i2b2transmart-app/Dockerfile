FROM tomcat:8.0.36
ENV TOMCAT_VERSION 8.0.36

# Fix sh
RUN rm /bin/sh && ln -s /bin/bash /bin/sh

# Remove garbage
RUN rm -rf /usr/local/tomcat/webapps/examples
RUN rm -rf /usr/local/tomcat/webapps/docs
#RUN rm -rf /usr/local/tomcat/webapps/ROOT

ENV CATALINA_OPTS "-Xms512m -Xmx1024m -XX:MaxPermSize=512m"

RUN mkdir /root/.grails
RUN mkdir /root/.grails/transmartConfig

# Add admin/admin user
COPY tomcat-users.xml /usr/local/tomcat/conf/
COPY server.xml /usr/local/tomcat/conf
COPY BuildConfig.groovy /root/.grails/transmartConfig
COPY DataSource.groovy /root/.grails/transmartConfig
COPY Config.groovy /root/.grails/transmartConfig
COPY RModulesConfig.groovy /root/.grails/transmartConfig
COPY transmart.war /usr/local/tomcat/webapps/

ENTRYPOINT ["./bin/catalina.sh", "run"]
