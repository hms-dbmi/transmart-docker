#!/bin/bash

docker stop i2b2transmartapp
docker rm i2b2transmartapp

docker cp DataSource.groovy i2b2transmartapp:/root/.grails/transmartConfig/DataSource.groovy
docker run -d -it --memory="2g" -p 8090:8090 --net i2b2-net --name i2b2transmartapp --label app.name=transmart-1.2.4 --label app.environment=dev -e environment=tm-dev dbmi/i2b2transmart-app
