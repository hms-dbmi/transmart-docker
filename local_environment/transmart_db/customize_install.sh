#!/bin/bash

docker cp customize_install.sql i2b2transmartdb:/usr/local/customize_install.sql
docker exec i2b2transmartdb /bin/sh -c "chmod 770 /usr/local/customize_install.sql"
docker exec i2b2transmartdb /bin/sh -c "export ORACLE_SID=XE;export PATH=/u01/app/oracle/product/11.2.0/xe/bin:/usr/local/sbin:/usr/local/bin:/usr/sbin:/usr/bin:/sbin:/bin;export ORACLE_HOME=/u01/app/oracle/product/11.2.0/xe;sqlplus system/oracle @/usr/local/customize_install.sql"
