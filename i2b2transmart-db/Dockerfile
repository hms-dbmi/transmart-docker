FROM wnameless/oracle-xe-11g
MAINTAINER Michael McDuffie <Michael_McDuffie@hms.harvard.edu>

RUN rm /bin/sh && ln -s /bin/bash /bin/sh

# Install JRE to run ant later.
RUN apt-get update && apt-get install -y openjdk-8-jdk php ant \
        curl make zip unzip \
        && apt-get clean

# Install groovy
RUN export CYGWIN=winsymlinks:native \
    && curl -s https://get.sdkman.io | bash  && sleep 20 \
    && source /root/.sdkman/bin/sdkman-init.sh \
    && echo "sdkman_auto_answer=true" >> /root/.sdkman/etc/config \
    && sdk install groovy

ENV PATH /root/.sdkman/candidates/groovy/current/bin:$PATH

# Set Java options (see stackoverflow.com/questions/15464963)
ENV JAVA_OPTS "-Duser.timezone=UTC -Djava.security.egd=file:///dev/urandom"

# Install grape
COPY grapeConfig.xml /root/.groovy/

# Way too many times this fails to load during startup scripts. Just download it here.
RUN grape install net.sf.opencsv opencsv 2.3

# Add base i2b2 schema files.
ADD i2b2-data-1.7.07.tar.gz /usr/local/

# Add transmart-data
RUN curl -L https://github.com/hms-dbmi/transmart-data/archive/i2b2-hackathon-oracle-xe.zip -o i2b2-hackathon-oracle-xe.zip \
    && unzip i2b2-hackathon-oracle-xe.zip

# Add schema scripts
COPY scripts/ /usr/local/
RUN chmod 700 /usr/local/*
