FROM ubuntu:14.04

ENV TOMCAT_VERSION 8.0.36

# Set locales
RUN locale-gen en_GB.UTF-8
ENV LANG en_GB.UTF-8
ENV LC_CTYPE en_GB.UTF-8

# Fix sh
RUN rm /bin/sh && ln -s /bin/bash /bin/sh

# Install dependencies
RUN apt-get update
RUN apt-get install -y git build-essential curl wget software-properties-common unzip ruby-full

# Install JDK 7
RUN echo oracle-java7-installer shared/accepted-oracle-license-v1-1 select true | debconf-set-selections
RUN add-apt-repository -y ppa:webupd8team/java
RUN apt-get update
RUN apt-get install -y oracle-java7-installer tar
RUN rm -rf /var/lib/apt/lists/*
RUN rm -rf /var/cache/oracle-jdk7-installer

# Define commonly used JAVA_HOME variable
ENV JAVA_HOME /usr/lib/jvm/java-7-oracle

# Get Tomcat
RUN wget --quiet --no-cookies http://apache.rediris.es/tomcat/tomcat-8/v${TOMCAT_VERSION}/bin/apache-tomcat-${TOMCAT_VERSION}.tar.gz -O /tmp/tomcat.tgz

# Uncompress
RUN tar xzvf /tmp/tomcat.tgz -C /usr/local
RUN ln -s /usr/local/apache-tomcat-${TOMCAT_VERSION} /usr/local/tomcat
RUN ln -s /usr/local/apache-tomcat-${TOMCAT_VERSION} /opt/tomcat
RUN rm /tmp/tomcat.tgz

# Remove garbage
RUN rm -rf /usr/local/tomcat/webapps/examples
RUN rm -rf /usr/local/tomcat/webapps/docs
#RUN rm -rf /usr/local/tomcat/webapps/ROOT

# Add admin/admin user
ADD tomcat-users.xml /usr/local/tomcat/conf/

ENV CATALINA_HOME /usr/local/tomcat
ENV PATH $PATH:$CATALINA_HOME/bin
ENV CATALINA_OPTS "$CATALINA_OPTS -XX:MaxPermSize=512m"

EXPOSE 8090
EXPOSE 8009

RUN gem install tiller

ADD data/tiller /etc/tiller

COPY transmart.war /usr/local/tomcat/webapps

RUN DEBIAN_FRONTEND=noninteractive apt-get install -y less

CMD ["/usr/local/bin/tiller" , "-v"]