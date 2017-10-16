# transmart-docker

Deploy i2b2transmat 1.2.4

### Run i2b2transmart 1.2.4 with GSE31773 public data set. 

```
docker-compose pull
docker-compose up -d
```
i2b2transmart is avaialbe at `http://docker-machine IP:8080/transmart`

### Run i2b2transmat 1.2.4 with different datas ets.

1. Update the docker-compose file, and change the i2b2transmartdb image from dbmi/i2b2transmart-db:1.2.4-GSE31773 to dbmi/i2btransmart-db:1.2.4
This is an i2b2transmart database with no datasets added.
2. Use your own ETL process to populate the database. The database is available at the IP of your docker-machine port 1521.
Oracle system default username/passwords are used.
```
docker-compose up -d i2b2transmartdb

username: system
password: oracle
sid: xe
port: 1521

```
3. Once you have populated the database, start up i2b2transmart
```
docker-compose up -d i2b2transmartapp
````

### Use our ETL process (see: load_dataset)
Our ETL process uses kettle.
Start up the ETL process, copy ojdbc6.jar into the ETL lib folder, enter the container's bash shell
```
home> docker-compose up -d i2b2transmartetl
home> docker cp ojdbc6.jar i2b2transmartetl:/opt/etl/src/data-integration/lib/ojdbc6.jar
home> docker exec -it i2b2transmartetl /bin/bash
i2b2transmartetl> # run whatever scripts you need to install the data
i2b2transmartetl> exit
home> docker commit i2b2transmartdb dbmi/i2b2transmart-db:1.2.4-<dataset>
# last command saves a snapshot of the DB which can be later used.
```


