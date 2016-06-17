## Useful Docker Commands

```bash
#Build this Docker!
docker build -t dbmi/i2b2transmart-etl ./

#Run this Docker! (Closes instantly as nothing is left running)
docker run -d --name i2b2transmartetl dbmi/i2b2transmart-etl

#You may need more memory to run ETL, this is how to set properties on the Mac docker-machine.
docker-machine stop
VBoxManage modifyvm default --cpus 2
VBoxManage modifyvm default --memory 4096
docker-machine start
```