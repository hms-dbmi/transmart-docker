FROM wnameless/oracle-xe-11g
MAINTAINER Michael McDuffie <Michael_McDuffie@hms.harvard.edu>

RUN rm /bin/sh && ln -s /bin/bash /bin/sh

#Install JRE to run ant later.
RUN apt-get update && apt-get install -y openjdk-8-jdk
RUN apt-get install -y php
RUN apt-get install -y ant

RUN apt-get install -y curl
RUN apt-get install -y make
RUN apt-get install -y unzip
RUN apt-get clean

#Install groovy
RUN export CYGWIN=winsymlinks:native
RUN curl -s https://get.sdkman.io | bash  && sleep 20
RUN source /root/.sdkman/bin/sdkman-init.sh && echo "sdkman_auto_answer=true" >> /root/.sdkman/etc/config && sdk install groovy
ENV PATH /root/.sdkman/candidates/groovy/current/bin:$PATH

# Set Java options (see stackoverflow.com/questions/15464963)
ENV JAVA_OPTS -Duser.timezone=UTC -Djava.security.egd=file:///dev/urandom"

#Install grape
COPY grapeConfig.xml /root/.groovy/

# Way too many times this fails to load during startup scripts. Just download it here.
RUN grape install net.sf.opencsv opencsv 2.3

#Add base i2b2 schema files.
ADD i2b2-data-1.7.07.tar.gz /usr/local/

#### TODO ####
# Add scripts
#COPY create_users.sql /usr/local/
#COPY install_i2b2_data.sh /usr/local/
#COPY customize_install.sql /usr/local/

#ADD transmart-data i2b2transmartdb:/root/transmart-data/

#RUN chmod 770 /usr/local/install_i2b2_data.sh
#RUN chmod 770 /usr/local/customize_install.sql

# run scripts
#RUN export ORACLE_SID=XE;export PATH=/u01/app/oracle/product/11.2.0/xe/bin:/usr/local/sbin:/usr/local/bin:/usr/sbin:/usr/bin:/sbin:/bin;export ORACLE_HOME=/u01/app/oracle/product/11.2.0/xe;sqlplus system/oracle @/usr/local/create_users.sql
#RUN export ORACLE_SID=XE;export PATH=/u01/app/oracle/product/11.2.0/xe/bin:/usr/local/sbin:/usr/local/bin:/usr/sbin:/usr/bin:/sbin:/bin;export ORACLE_HOME=/u01/app/oracle/product/11.2.0/xe;/usr/local/install_i2b2_data.sh
#RUN cd /root/transmart-data/; source vars; env && make -j4 oracle
#RUN export ORACLE_SID=XE;export PATH=/u01/app/oracle/product/11.2.0/xe/bin:/usr/local/sbin:/usr/local/bin:/usr/sbin:/usr/bin:/sbin:/bin;export ORACLE_HOME=/u01/app/oracle/product/11.2.0/xe;sqlplus system/oracle @/usr/local/customize_install.sql
