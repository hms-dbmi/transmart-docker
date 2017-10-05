FROM openjdk:8u102-jdk
MAINTAINER Michael McDuffie <Michael_McDuffie@hms.harvard.edu>

ENV JAVA_OPTS "-Xms768m -Xmx1024m -XX:MaxPermSize=512m"

# Install unzip
# ADD automatically decompresses .gzip and .tar files, but not .zip
RUN apt-get -y upgrade
RUN apt-get -y install unzip

# ADD kettle
RUN mkdir -p /opt/etl/src/
RUN curl -L -o /opt/etl/pdi-ce-6.1.0.1-196.zip https://sourceforge.net/projects/pentaho/files/Data%20Integration/6.1/pdi-ce-6.1.0.1-196.zip
RUN unzip /opt/etl/pdi-ce-6.1.0.1-196.zip -d /opt/etl/src/
RUN rm -f /opt/etl/pdi-ce-6.1.0.1-196.zip

# ADD transmart etl
RUN curl -L -o /opt/etl/src/tranSMART-ETL.zip https://github.com/hms-dbmi/tranSMART-ETL/archive/master.zip
RUN unzip /opt/etl/src/tranSMART-ETL.zip -d /opt/etl/src/
RUN mv /opt/etl/src/tranSMART-ETL-master /opt/etl/src/tranSMART-ETL
RUN rm -f /opt/etl/src/tranSMART-ETL.zip

RUN mkdir -p /root/.kettle/
# (for now until we figure out configuration, add kettle.properties after startup)
#ADD kettle.properties /root/.kettle/
ADD ojdbc6.jar /opt/etl/src/data-integration/lib/
