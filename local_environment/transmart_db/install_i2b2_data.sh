#!/bin/sh

ant -f /usr/local/i2b2-data-1.7.07/edu.harvard.i2b2.data/Release_1-7/NewInstall/Crcdata/data_build.xml create_crcdata_tables_release_1-7
ant -f /usr/local/i2b2-data-1.7.07/edu.harvard.i2b2.data/Release_1-7/NewInstall/Crcdata/data_build.xml create_procedures_release_1-7

ant -f /usr/local/i2b2-data-1.7.07/edu.harvard.i2b2.data/Release_1-7/NewInstall/Hivedata/data_build.xml create_hivedata_tables_release_1-7
ant -f /usr/local/i2b2-data-1.7.07/edu.harvard.i2b2.data/Release_1-7/NewInstall/Hivedata/data_build.xml db_hivedata_load_data

ant -f /usr/local/i2b2-data-1.7.07/edu.harvard.i2b2.data/Release_1-7/NewInstall/Imdata/data_build.xml create_imdata_tables_release_1-7

ant -f /usr/local/i2b2-data-1.7.07/edu.harvard.i2b2.data/Release_1-7/NewInstall/Metadata/data_build.xml create_metadata_tables_release_1-7

ant -f /usr/local/i2b2-data-1.7.07/edu.harvard.i2b2.data/Release_1-7/NewInstall/Pmdata/data_build.xml create_pmdata_tables_release_1-7
ant -f /usr/local/i2b2-data-1.7.07/edu.harvard.i2b2.data/Release_1-7/NewInstall/Pmdata/data_build.xml create_triggers_release_1-7
ant -f /usr/local/i2b2-data-1.7.07/edu.harvard.i2b2.data/Release_1-7/NewInstall/Pmdata/data_build.xml db_pmdata_load_data

ant -f /usr/local/i2b2-data-1.7.07/edu.harvard.i2b2.data/Release_1-7/NewInstall/Workdata/data_build.xml create_workdata_tables_release_1-7
ant -f /usr/local/i2b2-data-1.7.07/edu.harvard.i2b2.data/Release_1-7/NewInstall/Workdata/data_build.xml db_workdata_load_data
