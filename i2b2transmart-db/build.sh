#!/bin/bash
docker stop i2b2transmartdb
docker rm i2b2transmartdb

echo "build base oracle image"
docker build -t dbmi/i2b2transmart-db:base ./

docker run -d -p 49160:22 -p 1521:1521 -e ORACLE_ALLOW_REMOTE=true --net i2b2-net --label app.name=transmart-1.2.4 --label app.environment=dev --name i2b2transmartdb dbmi/i2b2transmart-db:base

docker exec i2b2transmartdb env

# add wait before running scripts. sometimes username input shows up instead of script executing
sleep 30

echo "run create users"
docker exec i2b2transmartdb /bin/sh -c "export ORACLE_SID=XE;export PATH=/u01/app/oracle/product/11.2.0/xe/bin:/usr/local/sbin:/usr/local/bin:/usr/sbin:/usr/bin:/sbin:/bin;export ORACLE_HOME=/u01/app/oracle/product/11.2.0/xe;sqlplus system/oracle @/usr/local/create_users.sql"

echo "run install i2b2"
docker exec i2b2transmartdb /bin/sh -c "export ORACLE_SID=XE;export PATH=/u01/app/oracle/product/11.2.0/xe/bin:/usr/local/sbin:/usr/local/bin:/usr/sbin:/usr/bin:/sbin:/bin;export ORACLE_HOME=/u01/app/oracle/product/11.2.0/xe;/usr/local/install_i2b2_data.sh"


echo "run transmart-data"
sleep 10
docker exec i2b2transmartdb /bin/bash -c "cd /transmart-data-i2b2-hackathon-oracle-xe/;source vars.sample; env && make -j4 oracle"

echo "run custom install"
sleep 10
docker exec i2b2transmartdb /bin/sh -c "export ORACLE_SID=XE;export PATH=/u01/app/oracle/product/11.2.0/xe/bin:/usr/local/sbin:/usr/local/bin:/usr/sbin:/usr/bin:/sbin:/bin;export ORACLE_HOME=/u01/app/oracle/product/11.2.0/xe;sqlplus system/oracle @/usr/local/customize_install.sql"

echo "save i2b2transmartdb state"
sleep 10
docker commit i2b2transmartdb dbmi/i2b2transmart-db:1.2.4

docker stop i2b2transmartdb
docker rm i2b2transmartdb
