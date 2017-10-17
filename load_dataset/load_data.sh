#!/bin/bash
docker cp data-deployments-public.zip i2b2transmartetl:/opt/data-deployments-public.zip
docker exec -it i2b2transmartetl /bin/sh -c 'unzip /opt/data-deployments-public.zip -d /opt/etl/src/'

docker exec -it i2b2transmartetl /bin/sh -c '/opt/etl/src/data-deployments-public/fetchPublicData.sh'
docker exec -it i2b2transmartetl /bin/sh -c 'cd /opt/etl/src/data-deployments-public/;./fetchPublicData.sh'

docker cp ./ojdbc6.jar i2b2transmartetl:/opt/etl/src/data-integration/lib/ojdbc6.jar
docker exec -it i2b2transmartetl /bin/sh -c 'chmod 770 /opt/etl/src/data-deployments-public/script_files/GSE31773/create_clinical_data.sh'
docker exec -it i2b2transmartetl /bin/bash -c '/opt/etl/src/data-deployments-public/script_files/GSE31773/create_clinical_data.sh'

docker commit i2b2transmartdb dbmi/i2b2transmart-db:1.2.4-GSE31773
