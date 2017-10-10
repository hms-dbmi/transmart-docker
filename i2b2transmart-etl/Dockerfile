FROM openjdk:8u102-jdk
MAINTAINER Michael McDuffie <Michael_McDuffie@hms.harvard.edu>

ENV JAVA_OPTS "-Xms768m -Xmx1024m -XX:MaxPermSize=512m"

# Install unzip
# ADD automatically decompresses .gzip and .tar files, but not .zip
RUN apt-get -y upgrade && apt-get -y install unzip \
    # Add kettle
    && mkdir -p /opt/etl/src/ \
    && curl -L -o /opt/etl/pdi-ce-6.1.0.1-196.zip https://sourceforge.net/projects/pentaho/files/Data%20Integration/6.1/pdi-ce-6.1.0.1-196.zip \
    && unzip /opt/etl/pdi-ce-6.1.0.1-196.zip -d /opt/etl/src/ \
    && rm -f /opt/etl/pdi-ce-6.1.0.1-196.zip \

    # ADD transmart etl
    && curl -L -o /opt/etl/src/tranSMART-ETL.zip https://github.com/hms-dbmi/tranSMART-ETL/archive/master.zip \
    && unzip /opt/etl/src/tranSMART-ETL.zip -d /opt/etl/src/ \
    && mv /opt/etl/src/tranSMART-ETL-master /opt/etl/src/tranSMART-ETL \
    && rm -f /opt/etl/src/tranSMART-ETL.zip \

    # Add kettle properties
    && mkdir -p /root/.kettle/

ADD kettle.properties /root/.kettle/
