FROM openjdk:8u102-jdk
MAINTAINER Michael McDuffie <Michael_McDuffie@hms.harvard.edu>

ENV JAVA_OPTS "-Xms768m -Xmx1024m -XX:MaxPermSize=512m"

# Install unzip
RUN apt-get -y upgrade
RUN apt-get -y install unzip

# ADD automatically decompresses .gzip and .tar files, but not .zip
ADD ./pdi-ce-6.1.0.1-196.zip /usr/local/

RUN mkdir -p /opt/etl/src/
RUN unzip /usr/local/pdi-ce-6.1.0.1-196.zip -d /opt/etl/src/
RUN rm -f /usr/local/pdi-ce-6.1.0.1-196.zip

ADD ./tranSMART-ETL.zip /opt/etl/src/
RUN unzip /opt/etl/src/tranSMART-ETL.zip -d /opt/etl/src/
RUN rm -f /opt/etl/src/tranSMART-ETL.zip

RUN mkdir -p /root/.kettle/
# (for now until we figure out configuration, add kettle.properties after startup)
#ADD kettle.properties /root/.kettle/
ADD ojdbc6.jar /opt/etl/src/data-integration/lib/
