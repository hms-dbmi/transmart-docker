#!/bin/bash

docker stop i2b2transmartapp
docker rm i2b2transmartapp
docker run -d -it --memory="2g" -p 8090:8090 --name i2b2transmartapp -e environment=tm-dev dbmi/i2b2transmart-app
