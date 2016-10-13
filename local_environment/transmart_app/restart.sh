#!/bin/bash

docker stop i2b2transmartapp
docker rm i2b2transmartapp
docker run -d -it --memory="2g" -p 8090:8090 --net i2b2-net --name i2b2transmartapp --label app.name=transmart-1.2.4 --label app.environment=dev -e environment=tm-dev dbmi/i2b2transmart-app
docker exec -it i2b2transmartapp /bin/sh -c "mkdir /root/.grails/"
docker exec -it i2b2transmartapp /bin/sh -c "mkdir /root/.grails/transmartConfig/"
docker cp DataSource.groovy i2b2transmartapp:/root/.grails/transmartConfig/DataSource.groovy
docker cp Config.groovy i2b2transmartapp:/root/.grails/transmartConfig/Config.groovy
docker cp BuildConfig.groovy i2b2transmartapp:/root/.grails/transmartConfig/BuildConfig.groovy
docker cp RModulesConfig.groovy i2b2transmartapp:/root/.grails/transmartConfig/RModulesConfig.groovy
#sleep 20
docker cp server.xml i2b2transmartapp:/usr/local/tomcat/conf/server.xml
#docker cp transmart.war.1.2.4 i2b2transmartapp:/usr/local/tomcat/webapps/transmart.war
docker exec -it i2b2transmartapp /bin/sh -c './bin/catalina.sh run'
