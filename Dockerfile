FROM centos:7
MAINTAINER Michael McDuffie <Michael_McDuffie@hms.harvard.edu>

ENV JAVA_VERSION 8u31
ENV BUILD_VERSION b13

# Upgrading system
RUN yum -y upgrade
RUN yum -y install wget

# Downloading Java
RUN wget --no-cookies --no-check-certificate --header "Cookie: oraclelicense=accept-securebackup-cookie" "http://download.oracle.com/otn-pub/java/jdk/$JAVA_VERSION-$BUILD_VERSION/jdk-$JAVA_VERSION-linux-x64.rpm" -O /tmp/jdk-8-linux-x64.rpm

RUN yum -y install /tmp/jdk-8-linux-x64.rpm

RUN alternatives --install /usr/bin/java jar /usr/java/latest/bin/java 200000
RUN alternatives --install /usr/bin/javaws javaws /usr/java/latest/bin/javaws 200000
RUN alternatives --install /usr/bin/javac javac /usr/java/latest/bin/javac 200000

ENV JAVA_HOME /usr/java/latest

RUN yum -y install unzip

ADD pdi-ce-6.1.0.1-196.zip /usr/local/

RUN mkdir -p /opt/etl/src/
RUN unzip /usr/local/pdi-ce-6.1.0.1-196.zip -d /opt/etl/src/

ADD tranSMART-ETL.zip /opt/etl/src/

RUN unzip /opt/etl/src/tranSMART-ETL.zip -d /opt/etl/src/
RUN mv /opt/etl/src/tranSMART-ETL-master/ /opt/etl/src/tranSMART-ETL/

RUN mkdir -p /.kettle/
ADD kettle.properties /.kettle/