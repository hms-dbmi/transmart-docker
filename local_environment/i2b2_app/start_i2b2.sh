#!/bin/bash

docker stop i2b2-wildfly
docker rm i2b2-wildfly
docker run -d -p 8080:8080 -p 9990:9990 --net i2b2-net --name i2b2-wildfly i2b2/i2b2-wildfly:0.1

docker cp crc-ds.xml i2b2-wildfly:/opt/jboss/wildfly/standalone/deployments/crc-ds.xml
docker cp ont-ds.xml i2b2-wildfly:/opt/jboss/wildfly/standalone/deployments/ont-ds.xml
docker cp pm-ds.xml i2b2-wildfly:/opt/jboss/wildfly/standalone/deployments/pm-ds.xml
docker cp work-ds.xml i2b2-wildfly:/opt/jboss/wildfly/standalone/deployments/work-ds.xml

docker exec i2b2-wildfly /bin/sh -c 'for file in /opt/jboss/wildfly/standalone/deployments/*.xml; do cp "$file" "${file}.dodeploy";done'





