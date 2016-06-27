#!/bin/bash

docker stop i2b2transmartetl
docker rm i2b2transmartetl

docker run -d --net i2b2-net --name i2b2transmartetl dbmi/i2b2transmart-etl tail -f /dev/null

docker cp data-deployments-public.zip i2b2transmartetl:/opt/data-deployments-public.zip

docker exec i2b2transmartetl /bin/sh -c 'unzip /opt/data-deployments-public.zip -d /opt/etl/src/'
docker exec i2b2transmartetl /bin/sh -c 'chmod 770 /opt/etl/src/data-deployments-public/script_files/GSE31773/create_clinical_data.sh'

docker cp ojdbc6.jar i2b2transmartetl:/opt/etl/src/data-deployments-public/script_files/GSE31773/ojdbc6.jar

docker exec i2b2transmartetl /bin/sh -c '/opt/etl/src/data-deployments-public/fetchPublicData.sh'

docker exec i2b2transmartetl /bin/sh -c 'cd /opt/etl/src/data-deployments-public/;/opt/etl/src/data-deployments-public/fetchPublicData.sh'

#docker exec i2b2transmartetl /bin/sh -c '/opt/etl/src/data-deployments-public/script_files/GSE31773/create_clinical_data.sh'





