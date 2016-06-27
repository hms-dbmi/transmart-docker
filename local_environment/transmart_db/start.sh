#!/bin/bash

docker stop i2b2transmartdb > log.txt
docker rm i2b2transmartdb > log.txt 
docker run -d -p 49160:22 -p 1521:1521 -e ORACLE_ALLOW_REMOTE=true --net i2b2-net --name i2b2transmartdb dbmi/i2b2transmart-db > log.txt

sleep 20 > log.txt

docker cp create_users.sql i2b2transmartdb:/usr/local/create_users.sql
docker cp install_i2b2_data.sh i2b2transmartdb:/usr/local/install_i2b2_data.sh
docker cp customize_install.sql i2b2transmartdb:/usr/local/customize_install.sql

docker exec i2b2transmartdb /bin/sh -c "chmod 770 /usr/local/install_i2b2_data.sh"
docker exec i2b2transmartdb /bin/sh -c "chmod 770 /usr/local/customize_install.sql"

docker exec i2b2transmartdb /bin/sh -c "export ORACLE_SID=XE;export PATH=/u01/app/oracle/product/11.2.0/xe/bin:/usr/local/sbin:/usr/local/bin:/usr/sbin:/usr/bin:/sbin:/bin;export ORACLE_HOME=/u01/app/oracle/product/11.2.0/xe;sqlplus system/oracle @/usr/local/create_users.sql"
docker exec i2b2transmartdb /bin/sh -c "export ORACLE_SID=XE;export PATH=/u01/app/oracle/product/11.2.0/xe/bin:/usr/local/sbin:/usr/local/bin:/usr/sbin:/usr/bin:/sbin:/bin;export ORACLE_HOME=/u01/app/oracle/product/11.2.0/xe;/usr/local/install_i2b2_data.sh"

cd /Users/mmcduffie/src/tranSMART/TMF/transmart-data-liquibase
. ./vars
make -j4 oracle

docker exec i2b2transmartdb /bin/sh -c "export ORACLE_SID=XE;export PATH=/u01/app/oracle/product/11.2.0/xe/bin:/usr/local/sbin:/usr/local/bin:/usr/sbin:/usr/bin:/sbin:/bin;export ORACLE_HOME=/u01/app/oracle/product/11.2.0/xe;sqlplus system/oracle @/usr/local/customize_install.sql"